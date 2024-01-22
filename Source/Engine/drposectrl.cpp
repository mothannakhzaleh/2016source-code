//
#include "drPoseCtrl.h"
#include "drErrorCode.h"
#include <CPerformance.h>
#include <string>

#ifdef __MAXEXP__ //Max导出插件
#define RealFps	0	//固定使用每秒30帧
#define g_fFrameRate 1.0f
#else
#include "LERender.h"
extern LIGHTENGINE_API float g_fFrameRate;
#define RealFps g_Render.IsRealFPS()
#endif

DR_BEGIN
////////////////////////////

DR_STD_ILELEMENTATION(drPoseCtrl)

DR_RESULT drPoseCtrl::Load(FILE* fp)
{

	size_t t = fread(&_pose_num, sizeof(_pose_num), 1, fp);

	_pose_seq = DR_NEW(drPoseInfo[_pose_num]);
	t = fread(&_pose_seq[0], sizeof(drPoseInfo), _pose_num, fp);

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::Save(FILE* fp) const
{
	fwrite(&_pose_num, sizeof(_pose_num), 1, fp);
	fwrite(&_pose_seq[0], sizeof(drPoseInfo), _pose_num, fp);

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::Load(const char* file )
{

	FILE* fp;
	fopen_s( &fp, file, "rb");

	if(fp == NULL)
		return ERR_INVALID_PARAM;

	DWORD version;

	fread(&version, sizeof(DWORD), 1, fp);
	assert(version == 1 && "error version code");

	Load(fp);

	fclose(fp);

	return 1;

}

DR_RESULT drPoseCtrl::Save(const char* file) const
{
	FILE* fp;
	fopen_s( &fp, file, "wb");
	if(fp == 0)
		return ERR_INVALID_PARAM;

	DWORD version = 1;
	fwrite(&version, sizeof(DWORD), 1, fp);

	Save(fp);

	fclose(fp);

	return 1;
}

DR_RESULT drPoseCtrl::Clone(drIPoseCtrl** obj)
{
	drPoseCtrl* o = DR_NEW(drPoseCtrl);

	if(_pose_num > 0)
	{
		o->InsertPose(0, _pose_seq, _pose_num);
	}

	*obj = o;

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::Copy(const drPoseCtrl* src)
{
	_pose_num = src->_pose_num;
	_pose_seq = DR_NEW(drPoseInfo[_pose_num]);
	memcpy(&_pose_seq[0], &src->_pose_seq[0], sizeof(drPoseInfo) * _pose_num);

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::GetPoseInfoBuffer(drPoseInfo** buf)
{
	if(buf) { *buf = _pose_seq; }
	return DR_RET_OK;
}

DWORD drPoseCtrl::GetDataSize() const
{
	DWORD size = 0;

	size += sizeof(_pose_num);
	size += sizeof(drPoseInfo) * _pose_num;

	return size;
}

extern BOOL g_bMyTest;
DR_RESULT drPoseCtrl::_Update(DWORD pose, DWORD play_type, float velocity, float* io_frame, float* o_ret_frame)
{
	float l;
	float cur_frame;
	float next_frame;

	cur_frame = *io_frame;

	drPoseInfo* pi = &_pose_seq[pose];

	l = (float)(pi->end - pi->start);
	assert(l > 0);

	if(play_type == PLAY_ONCE)
	{
		if(cur_frame >= l)
		{
			cur_frame = l;
		}
		else if(cur_frame < 0.0f)
		{
			cur_frame = 0.0f;
		}
	}
	else if(play_type == PLAY_LOOP)
	{	
		// Mdr: related to glitchy trees. 
		// Current frame is beyond this pose duration. 
		if(cur_frame > l)
		{
			// We must loop, otherwise the frame will use another pose.
			cur_frame = std::fmodf(cur_frame, l + 1.f/g_Render.GetFPS());
		}
		else if(cur_frame < 0.0f)
		{
			// 			if( g_bMyTest )
			// 				IP("obj(%x) cur_frame=%f\n",(DWORD)this, cur_frame);
			do
			{
				cur_frame += l;
			} 
			while(cur_frame < 0.0f);
		}
	}

	if((play_type == PLAY_ONCE) || (play_type == PLAY_LOOP))
	{
		if( RealFps )
			next_frame = cur_frame + velocity * g_fFrameRate;
		else
			next_frame = cur_frame + velocity;
	}
	else if(play_type == PLAY_FRAME)
	{
		next_frame = cur_frame;
	}


	*o_ret_frame = cur_frame + pi->start;
	*io_frame = next_frame;

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::PlayPose(drPlayPoseInfo* info)
{
	DR_RESULT ret = DR_RET_FAILED;

	if(_pose_num == 0)
		goto __ret;

	if(info->type == PLAY_INVALID)
		goto __ret;

	// 	if( g_bMyTest )
	// 	{
	// 		if( _frame_num!=31 )
	// 			goto __ret;
	// 	}

	if(DR_FAILED(_Update(info->pose, info->type, info->velocity, &info->frame, &info->ret_frame)))
		goto __ret;

	if(info->blend_info.op_state)
	{
		if(DR_FAILED(_Update(info->blend_info.blend_pose, info->blend_info.blend_type, info->velocity, &info->blend_info.blend_frame, &info->blend_info.blend_ret_frame)))
			goto __ret;

		info->blend_info.weight += (info->blend_info.factor * info->velocity);

		info->blend_info.op_frame_length -= info->velocity;

		if(info->blend_info.op_frame_length <= 0.0f)
		{
			info->blend_info.op_state = 0;
		}
	}

#if 0
	float l;
	float cur_frame;
	float next_frame;

	cur_frame = info->frame;

	drPoseInfo* pi = &_pose_seq[info->pose];

	l = (float)(pi->end - pi->start);
	assert(l > 0);

	if(info->type == PLAY_ONCE)
	{
		if(cur_frame >= l)
		{
			cur_frame = l;
		}
		else if(cur_frame < 0.0f)
		{
			cur_frame = 0.0f;
		}
	}
	else if(info->type == PLAY_LOOP)
	{
		if(cur_frame > l)
		{
			cur_frame = fmodf(cur_frame, l + 1);
		}
		else if(cur_frame < 0.0f)
		{
			while(cur_frame < 0.0f)
			{
				cur_frame += l;
			}
		}
	}

	if((info->type == PLAY_ONCE) || (info->type == PLAY_LOOP))
	{
		next_frame = cur_frame + info->velocity;
	}
	else if(info->type == PLAY_FRAME)
	{
		next_frame = cur_frame;
	}


	info->ret_frame = cur_frame + pi->start;
	info->frame = next_frame;
#endif

	ret = DR_RET_OK;
__ret:
	return ret;
}

DR_RESULT drPoseCtrl::CallBack(const drPlayPoseInfo* info)
{
	if(_pose_num == 0)
		return DR_RET_FAILED_3;

	if(info->type == PLAY_INVALID)
		return DR_RET_FAILED_2;

	if(info->proc == 0)
		return DR_RET_OK;

	drPoseInfo* pi = &_pose_seq[info->pose];

	float l = (float)(pi->end - pi->start);
	assert(l > 0);

	float cur_frame;
	float next_frame;

	next_frame = info->frame;
	cur_frame = info->frame;
	if(info->type == PLAY_ONCE)
	{
		if( RealFps )
			cur_frame -= info->velocity * g_fFrameRate;
		else
			cur_frame -= info->velocity;
		cur_frame = max(cur_frame, 0.0f); //避免出現负帧 
	}
	else if(info->type == PLAY_LOOP)
	{
		if( RealFps )
			cur_frame -= info->velocity * g_fFrameRate;
		else
			cur_frame -= info->velocity;
		if(cur_frame < 0.0f)
		{
			cur_frame += l;
			//			IP("Minus Looping\n"); //会出現这种情况吗？ 需要验证
		}
	}


	static int kk = 0;

	const float eps = 1e-4f;

	DWORD key_type = KEYFRAME_TYPE_INVALID;

	if(info->type == PLAY_ONCE)
	{
		if((cur_frame + eps) >= l)
		{
			kk--;
			key_type = KEYFRAME_TYPE_END;
		}
		else if((cur_frame - eps)<= 0.0f)
		{
			kk++;
			key_type = KEYFRAME_TYPE_BEGIN;
		}
	}
	else if(info->type == PLAY_LOOP)
	{
		if( RealFps )
		{
			if((cur_frame > (l - info->velocity * g_fFrameRate)) && (cur_frame <= l))
				key_type = KEYFRAME_TYPE_END;
			else if((cur_frame >= 0.0f) && (cur_frame < info->velocity * g_fFrameRate))
				key_type = KEYFRAME_TYPE_BEGIN;
		}
		else
		{
			if((cur_frame > (l - info->velocity)) && (cur_frame <= l))
				key_type = KEYFRAME_TYPE_END;
			else if((cur_frame >= 0.0f) && (cur_frame < info->velocity))
				key_type = KEYFRAME_TYPE_BEGIN;
		}
	}

	if(key_type != KEYFRAME_TYPE_INVALID)
	{
		info->proc(key_type, info->pose, 0, (DWORD)cur_frame, info->proc_param);

	}

	// check key frame pose
	if(next_frame < cur_frame)
	{
		next_frame += l;
	}

	float k;
	for(DWORD i = 0; i < pi->key_frame_num; i++)
	{
		k = (float)(pi->key_frame_seq[i] - pi->start);

		if((k >= cur_frame) && (k < next_frame))
		{
			info->proc(KEYFRAME_TYPE_KEY, info->pose, i, pi->key_frame_seq[i], info->proc_param);
		}
	} 


	return DR_RET_OK;
}

int drPoseCtrl::IsPosePlaying(const drPlayPoseInfo* info) const 
{ 
	int state = 0;

	if(info->type == PLAY_ONCE)
	{
		state = info->frame < (_pose_seq[info->pose].end - _pose_seq[info->pose].start); 
	}
	else if(info->type == PLAY_LOOP)
	{
		state = 1;
	}

	return state;
}

DR_RESULT drPoseCtrl::InsertPose(DWORD id, const drPoseInfo* pi, int num)
{
	DR_RESULT ret = DR_RET_FAILED;

	int i;
	if(pi == 0 || num <= 0)
		goto __ret;

	if(id > _pose_num)
		goto __ret;

	for(i = 0; i < num; i++)
	{
		if((pi[i].start > pi[i].end) || (pi[i].end >= _frame_num))
		{
			std::string hint;
			if( pi[i].start > pi[i].end )
			{
				hint += std::string( "Diagnosing: Starting frame is greater than ending frame!\n" );
			}
			if( pi[i].end >= _frame_num )
			{
				hint += std::string( "Diagnosing: frame records surpass animation length!\n" );
			}


			char buf[256];
			_snprintf_s(buf, 256,_TRUNCATE, "CharacterAction.tx table error!\n" \
				"Character Type: %d\n" \
				"Action ID: %d\n" \
				"Start: %d\n" \
				"End: %d\n" \
				"Animation Length: %d \n",
				pi[i].charType, i + 1, pi[i].start, pi[i].end, _frame_num );
			std::string result( buf );
			result += hint;
			MessageBox(NULL, result.c_str(), "error", MB_OK);
			goto __ret;
		}
	}
	// it is valid for null pose_seq
	drPoseInfo* buf = DR_NEW(drPoseInfo[_pose_num + num]);

	memcpy(buf, _pose_seq, sizeof(drPoseInfo) * id);
	memcpy(&buf[id], pi, sizeof(drPoseInfo) * num);
	memcpy(&buf[id + num], &_pose_seq[id], sizeof(drPoseInfo) * (_pose_num - id));

	DR_SAFE_DELETE_A(_pose_seq);

	_pose_seq = buf;
	_pose_num += num;

	ret = DR_RET_OK;
__ret:
	return ret;
}
DR_RESULT drPoseCtrl::ReplacePose(DWORD id, const drPoseInfo* pi)
{
	DR_RESULT ret = DR_RET_FAILED;

	if((id >= (DWORD)_pose_num) || (pi == 0))
		goto __ret;

	if(pi->start < pi->end || pi->end >= _frame_num)
		goto __ret;

	_pose_seq[id] = *pi;

	ret = DR_RET_OK;
__ret:
	return ret;
}

DR_RESULT drPoseCtrl::RemovePose(DWORD id)
{
	if(id >= (DWORD)_pose_num)
		return ERR_INVALID_PARAM;

	drPoseInfo* buf = DR_NEW(drPoseInfo[_pose_num - 1]);

	memcpy(buf, _pose_seq, sizeof(drPoseInfo) * id);
	memcpy(&buf[id], &_pose_seq[id + 1], sizeof(drPoseInfo) * (_pose_num - id - 1));


	DR_SAFE_DELETE_A(_pose_seq);

	_pose_seq = buf;
	_pose_num -= 1;

	return DR_RET_OK;
}

DR_RESULT drPoseCtrl::RemoveAll()
{
	if(_pose_num)
	{
		DR_DELETE_A(_pose_seq);
		_pose_seq = 0;
		_pose_num = 0;
	}

	return DR_RET_OK;
}


DR_RESULT drPlayPoseSmooth(drPlayPoseInfo* dst, const drPlayPoseInfo* src, drIPoseCtrl* ctrl)
{
	DR_RESULT ret = DR_RET_FAILED;

	if(src->bit_mask & PPI_MASK_POSE)
	{
		if(src->pose >= ctrl->GetPoseNum())
			goto __ret;
	}

	if(src->bit_mask & PPI_MASK_VELOCITY)
	{
		dst->velocity = src->velocity;
	}
	if(src->bit_mask & PPI_MASK_PROC)
	{
		dst->proc = src->proc;
		dst->proc_param = src->proc_param;
	}
	if(src->bit_mask & PPI_MASK_DATA)
	{
		dst->data = src->data;
	}

	// checked before type
	if((src->bit_mask & PPI_MASK_BLENDINFO) && (dst->type == PLAY_LOOP || dst->type == PLAY_ONCE))
	{
		drPoseInfo* src_pi = ctrl->GetPoseInfo(dst->pose);
		drPoseInfo* dst_pi = ctrl->GetPoseInfo(src->pose);
		float src_frame_num = (src_pi->end - src_pi->start) - dst->frame;
		float dst_frame_num = (dst_pi->end - dst_pi->start) - src->frame;

		// loop animation used full frame size
		if(dst->type == PLAY_LOOP)
		{
			src_frame_num = (float)(src_pi->end - src_pi->start);
		}

		if(src->bit_mask & PPI_MASK_BLENDINFO_SRCFRAMENUM)
		{
			if(src_frame_num > src->blend_info.src_frame_num)
				src_frame_num = src->blend_info.src_frame_num;
		}
		if(src->bit_mask & PPI_MASK_BLENDINFO_DSTFRAMENUM)
		{
			if(dst_frame_num > src->blend_info.dst_frame_num)
				dst_frame_num = src->blend_info.dst_frame_num;
		}

		float op_frame_len = min(src_frame_num, dst_frame_num);

		if(op_frame_len > 0.0f)
		{
			dst->blend_info.op_state = 1;
			dst->blend_info.op_frame_length = op_frame_len;
			dst->blend_info.weight = 0.0f;
			dst->blend_info.factor = 1.0f / dst->blend_info.op_frame_length;

			dst->blend_info.blend_pose = dst->pose;
			dst->blend_info.blend_type = dst->type;
			dst->blend_info.blend_frame = dst->frame;

		}
		else
		{
			dst->blend_info.op_state = 0;
		}
	}

	int smooth_flag = 0;

	if(src->bit_mask & PPI_MASK_TYPE)
	{
		switch(src->type)
		{
		case PLAY_ONCE_SMOOTH:
			dst->type = PLAY_ONCE;
			smooth_flag = 1;
			break;
		case PLAY_LOOP_SMOOTH:
			dst->type = PLAY_LOOP;
			smooth_flag = 1;
			break;
		case PLAY_PAUSE:
			dst->data = dst->type;
			dst->type = PLAY_FRAME;
			break;
		case PLAY_CONTINUE:
			dst->type = dst->data;
			break;
		default:
			dst->type = src->type;
		}
	}

	if(smooth_flag == 1)
	{
		if(src->bit_mask & PPI_MASK_POSE)
		{            
			if(dst->pose != src->pose)                
			{
				dst->pose = src->pose;

				if(src->bit_mask & PPI_MASK_FRAME)
				{
					dst->frame = src->frame;
				}
			}
			else if(dst->ret_frame >= ctrl->GetPoseInfo(dst->pose)->end)
			{
				if(src->bit_mask & PPI_MASK_FRAME)
				{
					dst->frame = src->frame;
				}
				else
				{
					dst->frame = 0;
				}
			}
		}
		// smooth type cannot modify frame variable arbitrarily
		//else
		//{
		//    if(src->bit_mask & PPI_MASK_FRAME)
		//    {
		//        dst->frame = src->frame;
		//    }
		//}

	}
	else
	{
		if(src->bit_mask & PPI_MASK_POSE)
		{
			dst->pose = src->pose;
		}
		if(src->bit_mask & PPI_MASK_FRAME)
		{
			dst->frame = src->frame;
		}
	}

	ret = DR_RET_OK;
__ret:
	return ret;
}

DR_END
