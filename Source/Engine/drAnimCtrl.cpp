#include "drAnimCtrl.h"
#include "drMath.h"
#include "drPrimitive.h"
#include "drResourceMgr.h"
#include "drRenderImp.h"

//static int g_x = 0;
//FILE* g_fp = 0;

DR_BEGIN

//DR_STD_ILELEMENTATION(drAnimCtrlBone)
//DR_STD_RELEASE(drAnimCtrlBone)
DR_RESULT drAnimCtrlBone::Release()
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _res_mgr->UnregisterAnimCtrl(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlBone::GetInterface(DR_VOID** i, drGUID guid)
{ 
    DR_RESULT ret = DR_RET_FAILED;

    switch(guid)
    {
    case DR_GUID_ANIMDATABONE:
        (*i) = static_cast< drIAnimDataBone* >(&_data);
        ret = DR_RET_OK;
        break;
    case DR_GUID_POSECTRL:
        (*i) = &_pose_ctrl;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

drAnimCtrlBone::drAnimCtrlBone(drIResourceMgr* res_mgr)
: drAnimCtrl(res_mgr),
  _bone_rtmat_seq(0), _dummy_rtmat_seq(0), _rtbuf_seq(0), _rtmat_ptr(0),
  _bone_rtmat_blend_seq(0)
{
    _ctrl_type = ANIM_CTRL_TYPE_BONE;
}

drAnimCtrlBone::~drAnimCtrlBone()
{
    Destroy();
}

DR_RESULT drAnimCtrlBone::_BuildRunTimeBoneMatrix(drMatrix44* out_buf, float frame, DWORD start_frame, DWORD end_frame)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;
    drMatrix44* mat_run;
    DWORD parent_id;

#if(defined __DULE_BRTBM_DATA)
    FILE* fp;
	fopen_s( &fp, "xxx.txt", "wt");
    fprintf(fp, "%d\n", (int)frame);
#endif

    for(i = 0; i < _data._bone_num; i++)
    {
        mat_run = &out_buf[i];

        if(DR_FAILED(ret = _data.GetValue(mat_run, i, (float)frame, start_frame, end_frame)))
            goto __ret;

        drMatrix44* m = mat_run;

#if(defined __DULE_BRTBM_DATA)
        fprintf(fp, "%8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f\n",
            m->_11, m->_12, m->_13, m->_14,
            m->_21, m->_22, m->_23, m->_24,
            m->_31, m->_32, m->_33, m->_34,
            m->_41, m->_42, m->_43, m->_44);
#endif

        parent_id = _data._base_seq[i].parent_id;

        if(parent_id == DR_INVALID_INDEX)
        {
            //drMatrix44Multiply(mat_run, mat_run, mat);
        }
        else
        {
            drMatrix44Multiply(mat_run, mat_run, &out_buf[parent_id]);
        }      

    }

#if(defined __DULE_BRTBM_DATA)
    fclose(fp);
#endif

    for(i = 0; i < _data._bone_num; i++)
    {
        drMatrix44Multiply(&out_buf[i], &_data._invmat_seq[i], &out_buf[i]);
    }


    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drAnimCtrlBone::_UpdateFrameDataBone(drMatrix44** o_mat_ptr, drMatrix44* mat_buf, float frame, DWORD start_frame, DWORD end_frame, BOOL loop_flag)
{
    // 这个版本已经使用线性插值来计算帧数据
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;
    DWORD f;
    DWORD min_f, max_f;
    float t;
    drMatrix44* this_mat_ptr = 0;
    drRTBD* rtbd_f;
    drRTBD* rtbd_min;
    drRTBD* rtbd_max;


    // 这里frame > _data._frame_num 没有用">="是因为我们在考虑PLAY_LOOP的情况时
    // 需要插值第0帧和第_data._frame_num - 1帧的数据
    if(frame < 0.0f || frame > _data._frame_num)
    {
        ret = ERR_INVALID_PARAM;
        goto __ret;
    }
    
    // check run time buffer enable state
    if(_rtbuf_seq)
    {
        t = drFloatDecimal(frame);

        if(drFloatZero(t, 1e-3f))
        {
            f = (DWORD)frame;

            if(f >= _data._frame_num)
                goto __ret;

            rtbd_f = &_rtbuf_seq[f];

            if(rtbd_f->flag == 0)
                goto __rt_get_value;

            if(rtbd_f->data == 0)
            {
                rtbd_f->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_f->data, frame, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_f->data);
                    goto __ret;
                }
            }

            //if(g_x == 1)
            //{
            //    fprintf(g_fp, "Frame: %f\n", frame);
            //}

            //for(i = 0; i < _data._bone_num; i++)
            //{
            //    if(g_x == 1)
            //    {
            //        fprintf(g_fp, "%8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f\n",
            //            rtbd_f->data[i]._11, rtbd_f->data[i]._12, rtbd_f->data[i]._13, rtbd_f->data[i]._14,
            //            rtbd_f->data[i]._21, rtbd_f->data[i]._22, rtbd_f->data[i]._23, rtbd_f->data[i]._24,
            //            rtbd_f->data[i]._31, rtbd_f->data[i]._32, rtbd_f->data[i]._33, rtbd_f->data[i]._34,
            //            rtbd_f->data[i]._41, rtbd_f->data[i]._42, rtbd_f->data[i]._43, rtbd_f->data[i]._44);
            //    }
            //}

            //if(g_x == 1)
            //{
            //    fprintf(g_fp, "\n");
            //}

            this_mat_ptr = rtbd_f->data;
        }
        else
        {
            //goto __rt_get_value;

            min_f = drFloatRoundDec(frame);
            max_f = min_f + 1;

            // mirror the frame of end_frame to start_frame
            // warning: the code was not tested 
            if(loop_flag && (max_f >= end_frame))
            {
                max_f = start_frame;
            }

            rtbd_min = &_rtbuf_seq[min_f];
            rtbd_max = &_rtbuf_seq[max_f];

            if(rtbd_min->flag == 0 || rtbd_max->flag == 0)
                goto __rt_get_value;

            // buf_min
            if(rtbd_min->data == 0)
            {
                rtbd_min->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_min->data, min_f, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_min->data);
                    goto __ret;
                }
            }
            // buf_max
            if(rtbd_max->data == 0)
            {
                rtbd_max->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_max->data, max_f, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_max->data);
                    goto __ret;
                }
            }

            //if(g_x == 1)
            //{
            //    fprintf(g_fp, "Frame: %f\n", frame);
            //}

            for(i = 0; i < _data._bone_num; i++)
            {
                drMat44Slerp(&mat_buf[i], &rtbd_min->data[i], &rtbd_max->data[i], t);
                //drMatrix44Slerp(&rtbd_min->data[i], &rtbd_max->data[i], t, &mat_buf[i]);

                //if(g_x == 1)
                //{
                //    fprintf(g_fp, "%8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f %8.5f\n",
                //        mat_buf[i]._11, mat_buf[i]._12, mat_buf[i]._13, mat_buf[i]._14,
                //        mat_buf[i]._21, mat_buf[i]._22, mat_buf[i]._23, mat_buf[i]._24,
                //        mat_buf[i]._31, mat_buf[i]._32, mat_buf[i]._33, mat_buf[i]._34,
                //        mat_buf[i]._41, mat_buf[i]._42, mat_buf[i]._43, mat_buf[i]._44);
                //}
            }

            //if(g_x == 1)
            //{
            //    fprintf(g_fp, "\n");
            //}

            this_mat_ptr = mat_buf;
        }

    }
    else
    {
__rt_get_value:

        if(DR_FAILED(_BuildRunTimeBoneMatrix(mat_buf, frame, start_frame, end_frame)))
            goto __ret;

        this_mat_ptr = mat_buf;
    }


    *o_mat_ptr = this_mat_ptr;

    ret = DR_RET_OK;

__ret:
    return ret;

}


DR_RESULT drAnimCtrlBone::_UpdateFrameDataBoneDummy()
{
    drBoneDummyInfo* dummy_info;

    for(DWORD i = 0; i < _data._dummy_num; i++)
    {
        dummy_info = &_data._dummy_seq[i];
        if(dummy_info->parent_bone_id != DR_INVALID_INDEX)
        {
            drMatrix44Multiply(&_dummy_rtmat_seq[i].mat, &dummy_info->mat, &_rtmat_ptr[dummy_info->parent_bone_id]);
            //_dummy_rtmat_seq[i].mat = _rtmat_ptr[dummy_info->parent_bone_id];
        }
    }

    return DR_RET_OK;

}

DR_RESULT drAnimCtrlBone::_BlendBoneData(drMatrix44* dst_mat_ptr, drMatrix44* src_mat_ptr0, drMatrix44* src_mat_ptr1, float t)
{
    for(DWORD i = 0; i < _data._bone_num; i++)
    {
        drMat44Slerp(&dst_mat_ptr[i], &src_mat_ptr0[i], &src_mat_ptr1[i], t);
        //drMatrix44Slerp(&src_mat_ptr0[i], &src_mat_ptr1[i], t, &dst_mat_ptr[i]);
    }

    return DR_RET_OK;
}

drMatrix44* drAnimCtrlBone::GetDummyRTM(DWORD id)
{
    for(DWORD i = 0; i < _data._dummy_num; i++)
    {
        if(_dummy_rtmat_seq[i].id == id)
            return &_dummy_rtmat_seq[i].mat;
    }

    return NULL;
}

DR_RESULT drAnimCtrlBone::SetFrame(float frame, DWORD start_frame, DWORD end_frame)
{
    // 这个版本已经使用线性插值来计算帧数据
    DR_RESULT ret = DR_RET_FAILED;

    // 这里frame > _data._frame_num 没有用">="是因为我们在考虑PLAY_LOOP的情况时
    // 需要插值第0帧和第_data._frame_num - 1帧的数据
    if(frame < 0.0f || frame > _data._frame_num)
    {
        ret = ERR_INVALID_PARAM;
        goto __ret;
    }
    
    // check run time buffer enable state
    if(_rtbuf_seq)
    {
        float t = drFloatDecimal(frame);

        if(drFloatZero(t, 1e-3f))
        {
            int f = (int)frame;
            drRTBD* rtbd_f = &_rtbuf_seq[f];

            if(rtbd_f->flag == 0)
                goto __rt_get_value;

            if(rtbd_f->data == 0)
            {
                rtbd_f->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_f->data, frame, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_f->data);
                    goto __ret;
                }
            }

            _rtmat_ptr = rtbd_f->data;
        }
        else
        {
            int min_f = drFloatRoundDec(frame);
            int max_f = min_f + 1;

            drRTBD* rtbd_min = &_rtbuf_seq[min_f];
            drRTBD* rtbd_max = &_rtbuf_seq[max_f];

            if(rtbd_min->flag == 0 || rtbd_max->flag == 0)
                goto __rt_get_value;

            // buf_min
            if(rtbd_min->data == 0)
            {
                rtbd_min->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_min->data, frame, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_min->data);
                    goto __ret;
                }
            }
            // buf_max
            if(rtbd_max->data == 0)
            {
                rtbd_max->data = DR_NEW(drMatrix44[_data._bone_num]);

                if(DR_FAILED(_BuildRunTimeBoneMatrix(rtbd_max->data, frame, start_frame, end_frame)))
                {
                    DR_SAFE_DELETE_A(rtbd_max->data);
                    goto __ret;
                }
            }

            for(DWORD i = 0; i < _data._bone_num; i++)
            {
                drMat44Slerp(&_bone_rtmat_seq[i], &rtbd_min->data[i], &rtbd_max->data[i], t);
                //drMatrix44Slerp(&rtbd_min->data[i], &rtbd_max->data[i], t, &_bone_rtmat_seq[i]);
            }

            _rtmat_ptr = _bone_rtmat_seq;
        }

        goto __addr_set_rtdummy;
    }
    else
    {
__rt_get_value:

#if 1
        if(DR_FAILED(_BuildRunTimeBoneMatrix(_bone_rtmat_seq, frame, start_frame, end_frame)))
            goto __ret;

#else  // 一下代码已经使用_BuildRunTimeBoneMatrix替代
        DWORD i;
        drMatrix44* mat_run;
        DWORD parent_id;

        for(i = 0; i < _data._bone_num; i++)
        {
        mat_run = &_bone_rtmat_seq[i];

        if(DR_FAILED(ret = _data.GetValue(mat_run, i, (float)frame)))
        goto __ret;


        parent_id = _data._base_seq[i].parent_id;

        if(parent_id == DR_INVALID_INDEX)
        {
        //drMatrix44Multiply(mat_run, mat_run, mat);
        }
        else
        {
        drMatrix44Multiply(mat_run, mat_run, &_bone_rtmat_seq[parent_id]);
        }        
        }

        for(i = 0; i < _data._bone_num; i++)
        {
        drMatrix44Multiply(&_bone_rtmat_seq[i], &_data._invmat_seq[i], &_bone_rtmat_seq[i]);
        }
#endif

        _rtmat_ptr = _bone_rtmat_seq;
    }

__addr_set_rtdummy:

    if(DR_FAILED(_UpdateFrameDataBoneDummy()))
        goto __ret;


    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drAnimCtrlBone::LoadData(const void* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    const drAnimDataBone* data_bone = (drAnimDataBone*)data;

    if(DR_FAILED(_data.Copy(data_bone)))
        goto __ret;

    _bone_rtmat_seq = DR_NEW(drMatrix44[_data._bone_num]);
    _dummy_rtmat_seq = DR_NEW(drIndexMatrix44[_data._dummy_num]);

    for(DWORD i = 0; i < _data._dummy_num; i++)
    {
        _dummy_rtmat_seq[i].id = _data._dummy_seq[i].id;
    }

    // insert default pose 0
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _data._frame_num - 1;
    _pose_ctrl.SetFrameNum(_data._frame_num);
    _pose_ctrl.InsertPose(0, &pi, 1);
    
    ret = DR_RET_OK;

__ret:

    return ret;
}

DR_RESULT drAnimCtrlBone::ExtractAnimData(drIAnimDataBone* out_data)
{
    drAnimDataBone* a = (drAnimDataBone*)out_data;
    return a->Copy(&_data);
}

DR_RESULT drAnimCtrlBone::DumpRunTimeBoneData(const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_rtbuf_seq == 0)
        goto __ret;

    FILE* fp;
	fopen_s( &fp, file, "wt");
    if(fp == NULL)
        goto __ret;

    drMatrix44* m;

    for(DWORD i = 0; i < _data._frame_num; i++)
    {
        if(_rtbuf_seq[i].data)
        {
            fprintf(fp, "\n\n%d\n", i);

            for(DWORD j = 0; j < _data._bone_num; j++)
            {
                m = &_rtbuf_seq[i].data[j];

                fprintf(fp, "%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n",
                    m->_11, m->_12, m->_13, m->_14,
                    m->_21, m->_22, m->_23, m->_24,
                    m->_31, m->_32, m->_33, m->_34,
                    m->_41, m->_42, m->_43, m->_44);
            }
        }
    }

    fclose(fp);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlBone::DumpInitInvMat(const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_rtbuf_seq == 0)
        goto __ret;

    FILE* fp;
	fopen_s( &fp, file, "wt");
    if(fp == NULL)
        goto __ret;

    drMatrix44* m;

    for(DWORD i = 0; i < _data._bone_num; i++)
    {
            fprintf(fp, "\n\n%d\n", i);

            m = &_data._invmat_seq[i];

            fprintf(fp, "%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n",
                m->_11, m->_12, m->_13, m->_14,
                m->_21, m->_22, m->_23, m->_24,
                m->_31, m->_32, m->_33, m->_34,
                m->_41, m->_42, m->_43, m->_44);
    }

    fclose(fp);

    ret = DR_RET_OK;
__ret:
    return ret;
}


DR_RESULT drAnimCtrlBone::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

    DR_SAFE_DELETE_A(_bone_rtmat_seq);
    DR_SAFE_DELETE_A(_bone_rtmat_blend_seq);
    DR_SAFE_DELETE_A(_dummy_rtmat_seq);

    if(_rtbuf_seq)
    {
        for(DWORD i = 0; i < _data._frame_num; i++)
        {
            DR_IF_DELETE_A(_rtbuf_seq[i].data);
        }

        DR_DELETE_A(_rtbuf_seq);
        _rtbuf_seq = 0;
    }

    if(DR_FAILED(_data.Destroy()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlBone::CreateRunTimeDataBuffer()
{
    if(_rtbuf_seq)
        return DR_RET_FAILED;

    _rtbuf_seq = DR_NEW(drRTBD[_data._frame_num]);
    memset(_rtbuf_seq, 0, sizeof(drRTBD) * _data._frame_num);

    return DR_RET_OK;
}

DR_RESULT drAnimCtrlBone::EnableRunTimeFrameBuffer(DWORD frame, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_rtbuf_seq == 0)
        goto __ret;

    if(frame >= _data._frame_num)
        goto __ret;

    _rtbuf_seq[frame].flag = flag;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drAnimCtrlBone::UpdatePose(drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_pose_ctrl.PlayPose(info)))
        goto __ret;

    //drPoseInfo* pi = _pose_ctrl.GetPoseInfo(info->pose);

    //if(DR_FAILED(SetFrame(info->ret_frame, pi->start, pi->end)))
    //    goto __ret;
            
	//int x = 0;
    //if(x == 1)
    //{
    //    g_x = 1;
    //    g_fp = fopen("A.txt", "wt");
    //}
    //else if(x == 2)
    //{
    //    g_x = 0;
    //    fclose(g_fp);
    //}

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlBone::UpdateAnimData(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

#if 1
    drPoseInfo* pi = _pose_ctrl.GetPoseInfo(info->pose);
    
    if(DR_FAILED(_UpdateFrameDataBone(&_rtmat_ptr, _bone_rtmat_seq, info->ret_frame, pi->start, pi->end, info->type == PLAY_LOOP ? 1 : 0)))
        goto __ret;

    if(info->blend_info.op_state)
    {
        drMatrix44* rtmat_blend_ptr = 0;

        if(_bone_rtmat_blend_seq == 0)
        {
            _bone_rtmat_blend_seq = DR_NEW(drMatrix44[_data._bone_num]);
        }

        pi = _pose_ctrl.GetPoseInfo(info->blend_info.blend_pose);

        if(DR_FAILED(_UpdateFrameDataBone(&rtmat_blend_ptr, _bone_rtmat_blend_seq, info->blend_info.blend_ret_frame, pi->start, pi->end, info->blend_info.blend_type == PLAY_LOOP ? 1 : 0)))
            goto __ret;

        if(DR_FAILED(_BlendBoneData(_bone_rtmat_seq, rtmat_blend_ptr, _rtmat_ptr, info->blend_info.weight)))
            goto __ret;
        
        _rtmat_ptr = _bone_rtmat_seq;
    }

    if(DR_FAILED(_UpdateFrameDataBoneDummy()))
        goto __ret;
#endif

#if 0
    drPoseInfo* pi = _pose_ctrl.GetPoseInfo(info->pose);

    if(DR_FAILED(SetFrame(info->ret_frame, pi->start, pi->end)))
        goto __ret;
#endif

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlBone::UpdatePoseKeyFrameProc(drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    // frame type cannot invoke CallBack proc
    if(info->type == PLAY_FRAME)
        goto __addr_ret_ok;

    if(DR_FAILED(_pose_ctrl.CallBack(info)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
// drAnimCtrlMatrix
//DR_STD_RELEASE(drAnimCtrlMatrix)
DR_RESULT drAnimCtrlMatrix::Release()
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _res_mgr->UnregisterAnimCtrl(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlMatrix::GetInterface(DR_VOID** i, drGUID guid)
{ 
    DR_RESULT ret = DR_RET_FAILED;

    switch(guid)
    {
    case DR_GUID_ANIMDATAMATRIX:
        (*i) = static_cast< drIAnimDataMatrix* >(this);
        ret = DR_RET_OK;
        break;
    case DR_GUID_POSECTRL:
        (*i) = &_pose_ctrl;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

drAnimCtrlMatrix::drAnimCtrlMatrix(drIResourceMgr* res_mgr)
: drAnimCtrl(res_mgr)
{
}

drAnimCtrlMatrix::~drAnimCtrlMatrix()
{
}

DR_RESULT drAnimCtrlMatrix::LoadData(const void* data)
{
    drAnimDataMatrix* data_mat = (drAnimDataMatrix*)data;

#ifdef USE_ANIMKEY_PRS
    drCopyAnimKeySetPRS(&_data, data_mat);
#else
    Copy(data_mat);
#endif

    // insert default pose 0
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _frame_num - 1;
    _pose_ctrl.SetFrameNum(_frame_num);
    _pose_ctrl.InsertPose(0, &pi, 1);

    return DR_RET_OK;
}

DR_RESULT drAnimCtrlMatrix::ExtractAnimData(drIAnimDataMatrix* out_data)
{
    drAnimDataMatrix* a = (drAnimDataMatrix*)out_data;

#ifdef USE_ANIMKEY_PRS
    return drCopyAnimKeySetPRS(a, this);
#else
    return a->Copy((const drAnimDataMatrix*)this);
#endif

}

DR_RESULT drAnimCtrlMatrix::SetFrame(float frame)
{

    if(frame >= _frame_num)
        return ERR_INVALID_PARAM;

    return GetValue(&_rtmat_seq[0], frame);
}

DR_RESULT drAnimCtrlMatrix::SetFrame(DWORD frame)
{
    if(frame >= _frame_num)
        return ERR_INVALID_PARAM;

    return GetValue(&_rtmat_seq[0], (float)frame);

}

DR_RESULT drAnimCtrlMatrix::UpdatePose(drPlayPoseInfo* info)
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _pose_ctrl.PlayPose(info)))
        return ret;

    if(DR_FAILED(ret = SetFrame(info->ret_frame)))
        return ret;

    return _pose_ctrl.CallBack(info);
}
DR_RESULT drAnimCtrlMatrix::UpdateAnimData(const drPlayPoseInfo* info)
{
    return SetFrame(info->ret_frame);
}

DR_RESULT drAnimCtrlMatrix::GetRTM(drMatrix44* mat)
{
    *mat = _rtmat_seq[0];
    return DR_RET_OK;
}

// drAnimCtrlTexUV
//DR_STD_RELEASE(drAnimCtrlTexUV)
DR_RESULT drAnimCtrlTexUV::Release()
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _res_mgr->UnregisterAnimCtrl(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlTexUV::GetInterface(DR_VOID** i, drGUID guid)
{ 
    DR_RESULT ret = DR_RET_FAILED;

    switch(guid)
    {
    case DR_GUID_ANIMDATATEXUV:
        (*i) = static_cast< drIAnimDataTexUV* >(this);
        ret = DR_RET_OK;
        break;
    case DR_GUID_POSECTRL:
        (*i) = &_pose_ctrl;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

drAnimCtrlTexUV::drAnimCtrlTexUV(drIResourceMgr* res_mgr)
: drAnimCtrl(res_mgr), _keyset_prs(0)
{
}

drAnimCtrlTexUV::~drAnimCtrlTexUV()
{
    DR_IF_RELEASE(_keyset_prs);
}

DR_RESULT drAnimCtrlTexUV::LoadData(const void* data)
{
    Copy((drAnimDataTexUV*)data);

    // insert default pose 0
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _frame_num - 1;
    _pose_ctrl.SetFrameNum(_frame_num);
    _pose_ctrl.InsertPose(0, &pi, 1);

    return DR_RET_OK;
}

DR_RESULT drAnimCtrlTexUV::ExtractAnimData(drIAnimDataTexUV* out_data)
{
    drAnimDataTexUV* a = (drAnimDataTexUV*)out_data;
    return a->Copy((const drAnimDataTexUV*)this);
}

DR_RESULT drAnimCtrlTexUV::LoadData(const drMatrix44* mat_seq, DWORD mat_num)
{
    DR_SAFE_DELETE_A(_mat_seq);
    _frame_num = mat_num;
    _mat_seq = DR_NEW(drMatrix44[_frame_num]);
    memcpy(_mat_seq, mat_seq, sizeof(drMatrix44) * _frame_num);

    // insert default pose 0
    _pose_ctrl.RemoveAll();
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _frame_num - 1;
    _pose_ctrl.SetFrameNum(_frame_num);
    _pose_ctrl.InsertPose(0, &pi, 1);

    return DR_RET_OK;
}

void drAnimCtrlTexUV::SetAnimKeySetPRS(drIAnimKeySetPRS* keyset)
{
    _keyset_prs = keyset;

    // insert default pose 0
    _pose_ctrl.RemoveAll();
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _keyset_prs->GetFrameNum() - 1;
    _pose_ctrl.SetFrameNum(pi.end + 1);
    _pose_ctrl.InsertPose(0, &pi, 1);

}

DR_RESULT drAnimCtrlTexUV::SetFrame(float frame)
{

    DR_RESULT ret = DR_RET_FAILED;

    if(_keyset_prs)
    {
        if(frame >= _keyset_prs->GetFrameNum())
            goto __ret;

        if(DR_FAILED(_keyset_prs->GetValue(&_rtmat_seq[0], frame)))
            goto __ret;

        // because uv translation only use m._31 and m._32
        drMatrix44* mat = &_rtmat_seq[0];
        mat->_31 = mat->_41;
        mat->_32 = mat->_42;
        mat->_41 = mat->_42 = 0.0f;
    }
    else
    {
        if(frame >= _frame_num)
            goto __ret;

        if(DR_FAILED(GetValue(&_rtmat_seq[0], frame)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlTexUV::SetFrame(DWORD frame)
{
    return SetFrame((float)frame);
}

//BOOL g_bMyTest = FALSE;
//void* g_pAnimCtrlTexUV = NULL;
DR_RESULT drAnimCtrlTexUV::UpdatePose(drPlayPoseInfo* info)
{
    DR_RESULT ret;

//	if( _frame_num==31 )
//	{
//		g_bMyTest = TRUE;
// 		if( g_pAnimCtrlTexUV==NULL )
// 			g_pAnimCtrlTexUV = this;
//	}
    if(DR_FAILED(ret = _pose_ctrl.PlayPose(info)))
	{
//		g_bMyTest = FALSE;
        return ret;
	}
//	g_bMyTest = FALSE;

    return _pose_ctrl.CallBack(info);
}
DR_RESULT drAnimCtrlTexUV::UpdateAnimData(const drPlayPoseInfo* info)
{
    return SetFrame(info->ret_frame);
}
DR_RESULT drAnimCtrlTexUV::GetRunTimeMatrix(drMatrix44* mat)
{
    *mat = _rtmat_seq[0];
    return DR_RET_OK;
}

//
//DR_STD_ILELEMENTATION(drAnimCtrlTexImg)
DR_STD_GETINTERFACE(drAnimCtrlTexImg)
DR_RESULT drAnimCtrlTexImg::Release()
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _res_mgr->UnregisterAnimCtrl(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

drAnimCtrlTexImg::drAnimCtrlTexImg(drIResourceMgr* res_mgr)
: drAnimCtrl(res_mgr),
  _tex_seq(0), _tex_num(0), _rttex(DR_INVALID_INDEX)
{
}
drAnimCtrlTexImg::~drAnimCtrlTexImg()
{
    Destroy();
}
DR_RESULT drAnimCtrlTexImg::Destroy()
{
    if(_tex_num > 0)
    {
        for(DWORD i = 0; i < _tex_num; i++)
        {
            if(_tex_seq[i] == 0)
                continue;

            _tex_seq[i]->Release();
        }
        DR_SAFE_DELETE_A(_tex_seq);
        _tex_num = 0;
    }
    return DR_RET_OK;
}
DR_RESULT drAnimCtrlTexImg::LoadData(const void* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimDataTexImg* adti = (drAnimDataTexImg*)data;

    if(DR_FAILED(_data.Copy(adti)))
        goto __ret;

    _tex_num = adti->_data_num;
    _tex_seq = DR_NEW(drITex*[_tex_num]);
    memset(_tex_seq, 0, sizeof(drITex*) * _tex_num);

    drITex* tex;

    for(DWORD i = 0; i < _tex_num; i++)
    {
        if(DR_FAILED(_res_mgr->CreateTex(&tex)))
            goto __ret;

        if(DR_FAILED(tex->LoadTexInfo(&adti->_data_seq[i], adti->_tex_path)))
            goto __ret;

        tex->SetLoadResType(LOADINGRES_TYPE_RUNTIME);
        _tex_seq[i] = tex;
        tex = 0;
    }

    // insert default pose 0
    _pose_ctrl.RemoveAll();
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = 0;
    pi.end = _tex_num - 1;
    _pose_ctrl.SetFrameNum(_tex_num);
    _pose_ctrl.InsertPose(0, &pi, 1);

    ret = DR_RET_OK;

__ret:
    if(DR_FAILED(ret))
    {
        DR_IF_RELEASE(tex);
        Destroy();
    }

    return ret;
}

DR_RESULT drAnimCtrlTexImg::ExtractAnimData(drIAnimDataTexImg* out_data)
{
    drAnimDataTexImg* a = (drAnimDataTexImg*)out_data;
    return a->Copy(&_data);
}

DR_RESULT drAnimCtrlTexImg::UpdatePose(drPlayPoseInfo* info)
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _pose_ctrl.PlayPose(info)))
        return ret;

    return _pose_ctrl.CallBack(info);
}
DR_RESULT drAnimCtrlTexImg::UpdateAnimData(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD f = (DWORD)info->ret_frame;

    if(f >= _tex_num)
        goto __ret;

    if(_tex_seq[f] == NULL)
        goto __ret;

    _rttex = f;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlTexImg::GetRunTimeTex(drITex** tex)
{
    *tex = _tex_seq[_rttex];
    return DR_RET_OK;
}

// drAnimCtrlMtlOpacity
//DR_STD_ILELEMENTATION(drAnimCtrlMtlOpacity)
DR_STD_GETINTERFACE(drAnimCtrlMtlOpacity)
DR_RESULT drAnimCtrlMtlOpacity::Release()
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _res_mgr->UnregisterAnimCtrl(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

drAnimCtrlMtlOpacity::drAnimCtrlMtlOpacity(drIResourceMgr* res_mgr)
: drAnimCtrl(res_mgr), _data(0), _rt_opacity(0.0f)
{
}

drAnimCtrlMtlOpacity::~drAnimCtrlMtlOpacity()
{
    Destroy();
}
DR_RESULT drAnimCtrlMtlOpacity::Destroy()
{
    DR_SAFE_RELEASE(_data);
    return DR_RET_OK;
}
DR_RESULT drAnimCtrlMtlOpacity::LoadData(const void* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(((drIAnimDataMtlOpacity*)data)->Clone(&_data)))
        goto __ret;

    drIAnimKeySetFloat* aks = _data->GetAnimKeySet();
    
    // insert default pose 0
    _pose_ctrl.RemoveAll();
    drPoseInfo pi;
    memset(&pi, 0, sizeof(pi));
    pi.start = aks->GetBeginKey();
    pi.end = aks->GetEndKey();

    if(pi.start >= pi.end)
        goto __ret;

    _pose_ctrl.SetFrameNum(pi.end + 1);
    _pose_ctrl.InsertPose(0, &pi, 1);

    ret = DR_RET_OK;

__ret:

    return ret;
}

DR_RESULT drAnimCtrlMtlOpacity::ExtractAnimData(drIAnimDataMtlOpacity* out_data)
{
    DR_RESULT ret;

    drIAnimKeySetFloat* aksf;
    
    drIAnimKeySetFloat* this_aksf = _data->GetAnimKeySet();

    if(this_aksf == 0 || DR_FAILED(this_aksf->Clone(&aksf)))
        goto __ret;

    out_data->SetAnimKeySet(aksf);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlMtlOpacity::UpdatePose(drPlayPoseInfo* info)
{
    DR_RESULT ret;

    if(DR_FAILED(ret = _pose_ctrl.PlayPose(info)))
        return ret;

    return _pose_ctrl.CallBack(info);
}
DR_RESULT drAnimCtrlMtlOpacity::UpdateAnimData(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_data == 0)
        goto __ret;

    drIAnimKeySetFloat* aksf = _data->GetAnimKeySet();
    if(aksf == 0)
        goto __ret;

    if(DR_FAILED(aksf->GetValue(&_rt_opacity, info->ret_frame)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlMtlOpacity::GetRunTimeOpacity(float* opacity)
{
    *opacity = _rt_opacity;
    return DR_RET_OK;
}

DR_END