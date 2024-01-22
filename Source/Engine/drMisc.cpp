//

#include "drMisc.h"
#include <CPerformance.h>
#include <MyMemory.h>

#define _CASE(x)	\
		case(x):	\
		{			\
		return #x;	\
		}

#ifdef __FPS_DEBUG__
string GetRenderStateName(DWORD state)
{
	switch(state)
	{
	_CASE(D3DRS_ZENABLE)
	_CASE(D3DRS_FILLMODE)
	_CASE(D3DRS_SHADEMODE)
	_CASE(D3DRS_ZWRITEENABLE)
	_CASE(D3DRS_ALPHATESTENABLE)
	_CASE(D3DRS_LASTPIXEL)
	_CASE(D3DRS_SRCBLEND)
	_CASE(D3DRS_DESTBLEND)
	_CASE(D3DRS_CULLMODE)
	_CASE(D3DRS_ZFUNC)
	_CASE(D3DRS_ALPHAREF)
	_CASE(D3DRS_ALPHAFUNC)
	_CASE(D3DRS_DITHERENABLE)
	_CASE(D3DRS_ALPHABLENDENABLE)
	_CASE(D3DRS_FOGENABLE)
	_CASE(D3DRS_SPECULARENABLE)
	_CASE(D3DRS_FOGCOLOR)
	_CASE(D3DRS_FOGTABLEMODE)
	_CASE(D3DRS_FOGSTART)
	_CASE(D3DRS_FOGEND)
	_CASE(D3DRS_FOGDENSITY)
#ifdef DR_USE_DX8
	_CASE(D3DRS_ZBIAS)
#endif
	_CASE(D3DRS_RANGEFOGENABLE)
	_CASE(D3DRS_STENCILENABLE)
	_CASE(D3DRS_STENCILFAIL)
	_CASE(D3DRS_STENCILZFAIL)
	_CASE(D3DRS_STENCILPASS)
	_CASE(D3DRS_STENCILFUNC)
	_CASE(D3DRS_STENCILREF)
	_CASE(D3DRS_STENCILMASK)
	_CASE(D3DRS_STENCILWRITEMASK)
	_CASE(D3DRS_TEXTUREFACTOR)
	_CASE(D3DRS_WRAP0)
	_CASE(D3DRS_WRAP1)
	_CASE(D3DRS_WRAP2)
	_CASE(D3DRS_WRAP3)
	_CASE(D3DRS_WRAP4)
	_CASE(D3DRS_WRAP5)
	_CASE(D3DRS_WRAP6)
	_CASE(D3DRS_WRAP7)
	_CASE(D3DRS_CLIPPING)
	_CASE(D3DRS_LIGHTING)
	_CASE(D3DRS_AMBIENT)
	_CASE(D3DRS_FOGVERTEXMODE)
	_CASE(D3DRS_COLORVERTEX)
	_CASE(D3DRS_LOCALVIEWER)
	_CASE(D3DRS_NORMALIZENORMALS)
	_CASE(D3DRS_DIFFUSEMATERIALSOURCE)
	_CASE(D3DRS_SPECULARMATERIALSOURCE)
	_CASE(D3DRS_AMBIENTMATERIALSOURCE)
	_CASE(D3DRS_EMISSIVEMATERIALSOURCE)
	_CASE(D3DRS_VERTEXBLEND)
	_CASE(D3DRS_CLIPPLANEENABLE)
	_CASE(D3DRS_POINTSIZE)
	_CASE(D3DRS_POINTSIZE_MIN)
	_CASE(D3DRS_POINTSPRITEENABLE)
	_CASE(D3DRS_POINTSCALEENABLE)
	_CASE(D3DRS_POINTSCALE_A)
	_CASE(D3DRS_POINTSCALE_B)
	_CASE(D3DRS_POINTSCALE_C)
	_CASE(D3DRS_MULTISAMPLEANTIALIAS)
	_CASE(D3DRS_MULTISAMPLEMASK)
	_CASE(D3DRS_PATCHEDGESTYLE)
	_CASE(D3DRS_DEBUGMONITORTOKEN)
	_CASE(D3DRS_POINTSIZE_MAX)
	_CASE(D3DRS_INDEXEDVERTEXBLENDENABLE)
	_CASE(D3DRS_COLORWRITEENABLE)
	_CASE(D3DRS_TWEENFACTOR)
	_CASE(D3DRS_BLENDOP)

#ifdef DR_USE_DX8
	_CASE(D3DRS_POSITIONORDER)   // NPatch position interpolation order. D3DORDER_LINEAR or D3DORDER_CUBIC (default)
	_CASE(D3DRS_NORMALORDER)   // NPatch normal interpolation order. D3DORDER_LINEAR (default) or D3DORDER_QUADRATIC
#endif//DR_USE_DX8

#ifdef DR_USE_DX9
	_CASE(D3DRS_POSITIONDEGREE)
	_CASE(D3DRS_NORMALDEGREE)
	_CASE(D3DRS_SCISSORTESTENABLE)
	_CASE(D3DRS_SLOPESCALEDEPTHBIAS)
	_CASE(D3DRS_ANTIALIASEDLINEENABLE)
	_CASE(D3DRS_MINTESSELLATIONLEVEL)
	_CASE(D3DRS_MAXTESSELLATIONLEVEL)
	_CASE(D3DRS_ADAPTIVETESS_X)
	_CASE(D3DRS_ADAPTIVETESS_Y)
	_CASE(D3DRS_ADAPTIVETESS_Z)
	_CASE(D3DRS_ADAPTIVETESS_W)
	_CASE(D3DRS_ENABLEADAPTIVETESSELLATION)
	_CASE(D3DRS_TWOSIDEDSTENCILMODE)
	_CASE(D3DRS_CCW_STENCILFAIL)
	_CASE(D3DRS_CCW_STENCILZFAIL)
	_CASE(D3DRS_CCW_STENCILPASS)
	_CASE(D3DRS_CCW_STENCILFUNC)
	_CASE(D3DRS_COLORWRITEENABLE1)
	_CASE(D3DRS_COLORWRITEENABLE2)
	_CASE(D3DRS_COLORWRITEENABLE3)
	_CASE(D3DRS_BLENDFACTOR)
	_CASE(D3DRS_SRGBWRITEENABLE)
	_CASE(D3DRS_DEPTHBIAS)
	_CASE(D3DRS_WRAP8)
	_CASE(D3DRS_WRAP9)
	_CASE(D3DRS_WRAP10)
	_CASE(D3DRS_WRAP11)
	_CASE(D3DRS_WRAP12)
	_CASE(D3DRS_WRAP13)
	_CASE(D3DRS_WRAP14)
	_CASE(D3DRS_WRAP15)
	_CASE(D3DRS_SEPARATEALPHABLENDENABLE)
	_CASE(D3DRS_SRCBLENDALPHA)
	_CASE(D3DRS_DESTBLENDALPHA)
	_CASE(D3DRS_BLENDOPALPHA)
	_CASE(D3DRS_FORCE_DWORD)
#endif//DR_USE_DX9
	}
	return "";
}
#endif

string GetDxError(HRESULT hr)
{
	switch(hr)
	{
	_CASE(D3DERR_WRONGTEXTUREFORMAT)
	_CASE(D3DERR_UNSUPPORTEDCOLOROPERATION)
	_CASE(D3DERR_UNSUPPORTEDCOLORARG)
	_CASE(D3DERR_UNSUPPORTEDALPHAOPERATION)
	_CASE(D3DERR_UNSUPPORTEDALPHAARG)
	_CASE(D3DERR_TOOMANYOPERATIONS)
	_CASE(D3DERR_CONFLICTINGTEXTUREFILTER)
	_CASE(D3DERR_UNSUPPORTEDFACTORVALUE)
	_CASE(D3DERR_CONFLICTINGRENDERSTATE)
	_CASE(D3DERR_UNSUPPORTEDTEXTUREFILTER)
	_CASE(D3DERR_CONFLICTINGTEXTUREPALETTE)
	_CASE(D3DERR_DRIVERINTERNALERROR)
	_CASE(D3DERR_NOTFOUND)
	_CASE(D3DERR_MOREDATA)
	_CASE(D3DERR_DEVICELOST)
	_CASE(D3DERR_DEVICENOTRESET)
	_CASE(D3DERR_NOTAVAILABLE)
	_CASE(D3DERR_OUTOFVIDEOMEMORY)
	_CASE(D3DERR_INVALIDDEVICE)
	_CASE(D3DERR_INVALIDCALL)
	_CASE(D3DERR_DRIVERINVALIDCALL)
	}
	return "";
}

DR_BEGIN

// drBuffer
DR_STD_ILELEMENTATION(drBuffer)

#ifdef __FPS_DEBUG__
void PrintAllRenderState(drRenderStateAtom* rsa_seq, DWORD num)
{
	if( num==0 )
		return;

	int line = 0;
	drRenderStateAtom* p;
	for(DWORD i = 0; i < num; i++)
	{
		p = &rsa_seq[i];

		if(p->state == DR_INVALID_INDEX)
		{
			break;
		}

		line ++;
		if( line==1 )
		{
			IP("-------------------------------------\n");
		}

		if( ((int)p->value0)<0 || ((int)p->value0)>10 )
		{
			IP("RenderState(%s, 0x%08x)\n", GetRenderStateName(p->state).c_str(), p->value0);
			continue;
		}

		IP("RenderState(%s, %d)\n", GetRenderStateName(p->state).c_str(), p->value0);
	}
}
void PrintRenderState(D3DRENDERSTATETYPE state, DWORD value)
{
	if( ((int)value)<0 || ((int)value)>10 )
	{
		IP("SetRenderState(%s, 0x%08x)\n", GetRenderStateName(state).c_str(), value);
		return;
	}

	IP("SetRenderState(%s, %d)\n", GetRenderStateName(state).c_str(), value);
}
#endif

drBuffer::drBuffer()
: _data(0), _size(0)
{
}

drBuffer::~drBuffer()
{
    Free();
}

DR_RESULT drBuffer::Alloc(DWORD size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_size > 0)
        goto __ret;

    _data = (BYTE*)DR_MALLOC(size);
    if(_data == 0)
        goto __ret;

    _size = size;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drBuffer::Realloc(DWORD size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_data == 0)
        goto __ret;

    _data = (BYTE*)DR_REALLOC(_data, size);
    if(_data == 0)
        goto __ret;

    _size = size;
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drBuffer::Free()
{
    if(_size == 0)
        return DR_RET_FAILED;

    DR_DELETE_A(_data);
    _data = 0;
    _size = 0;

    return DR_RET_OK;
}

DR_RESULT drBuffer::SetSizeArbitrary(DWORD size)
{
    _size = size;
    return DR_RET_OK;
}
// drByteSet
DR_STD_ILELEMENTATION(drByteSet)
DR_RESULT drByteSet::SetValueSeq(DWORD start, BYTE* buf, DWORD num)
{
    if((start + num) >= _size)
        return DR_RET_FAILED;

    memcpy(&_buf[start], buf, sizeof(BYTE) * num);

    return DR_RET_OK;
}

int drHexStrToInt(const char* str)
{
	for( ; (*str == ' ') || (*str == '\t'); ++str )
		;

	if( *(str++) != '0' )
		return 0;

	if( *str != 'x' && *str != 'X' )
		return 0;

	str++;

	int v = 0;

	for( ; *str>='0' && *str<='9'; ++str ) {
		v = v * 16 + (*str - '0');
	}

	return v;

}

DR_RESULT drRenderStateAtomBeginSetRS(drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num)
{
    drRenderStateAtom* p;
#ifdef __FPS_DEBUG__
 	//PrintAllRenderState(rsa_seq, num);
#endif

    for(DWORD i = 0; i < num; i++)
    {
        p = &rsa_seq[i];

        if(p->state == DR_INVALID_INDEX)
            break;

        dev_obj->GetRenderState(p->state, &p->value1);
        if(p->value0 != p->value1)
        {
            dev_obj->SetRenderState((D3DRENDERSTATETYPE)p->state, p->value0);
        }
    }

    return DR_RET_OK;
}
DR_RESULT drRenderStateAtomEndSetRS(drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num)
{
    drRenderStateAtom* p;
    for(DWORD i = 0; i < num; i++)
    {
        p = &rsa_seq[i];

        if(p->state == DR_INVALID_INDEX)
            break;

        if(p->value0 != p->value1)
        {
            dev_obj->SetRenderState((D3DRENDERSTATETYPE)p->state, p->value1);
            p->value1 = p->value0;
        }
    }

    return DR_RET_OK;
}

DR_RESULT drRenderStateAtomBeginSetTSS(DWORD stage, drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num)
{
    drRenderStateAtom* p;
    for(DWORD i = 0; i < num; i++)
    {
        p = &rsa_seq[i];

        if(p->state == DR_INVALID_INDEX)
            break;

        dev_obj->GetTextureStageState(stage, p->state, &p->value1);
        if(p->value0 != p->value1)
        {
            dev_obj->SetTextureStageState(stage, (D3DTEXTURESTAGESTATETYPE)p->state, p->value0);
        }
    }

    return DR_RET_OK;
}
DR_RESULT drRenderStateAtomEndSetTSS(DWORD stage, drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num)
{
    drRenderStateAtom* p;
    for(DWORD i = 0; i < num; i++)
    {
        p = &rsa_seq[i];

        if(p->state == DR_INVALID_INDEX)
            break;

        if(p->value0 != p->value1)
        {
            dev_obj->SetTextureStageState(stage, (D3DTEXTURESTAGESTATETYPE)p->state, p->value1);
            p->value1 = p->value0;
        }
    }

    return DR_RET_OK;
}

// drRenderStateAtomSet
DR_STD_ILELEMENTATION(drRenderStateAtomSet)

drRenderStateAtomSet::drRenderStateAtomSet()
: _rsa_seq(0), _rsa_num(0)
{
}
drRenderStateAtomSet::~drRenderStateAtomSet()
{
    Clear();
}
DR_RESULT drRenderStateAtomSet::Clear()
{
    if(_rsa_num)
    {
        DR_DELETE_A(_rsa_seq);
        _rsa_seq = 0;
        _rsa_num = 0;
    }
    return DR_RET_OK;
}
DR_RESULT drRenderStateAtomSet::Clone(drIRenderStateAtomSet** obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drRenderStateAtomSet* o = DR_NEW(drRenderStateAtomSet);
    
    if(DR_FAILED(o->Load(_rsa_seq, _rsa_num)))
        goto __ret;

    *obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drRenderStateAtomSet::Allocate(DWORD size)
{
    Clear();

    if(size > 0)
    {
        _rsa_seq = DR_NEW(drRenderStateAtom[size]);
        _rsa_num = size;

        for(DWORD i = 0; i < _rsa_num; i++)
        {
            drRenderStateAtom_Construct(&_rsa_seq[i]);
        }
    }

    return DR_RET_OK;
}

DR_RESULT drRenderStateAtomSet::Load(const drRenderStateAtom* rsa_seq, DWORD rsa_num)
{
    if(_rsa_num != rsa_num)
    {
        Allocate(rsa_num);
    }

    memcpy(_rsa_seq, rsa_seq, sizeof(drRenderStateAtom) * rsa_num);

    return DR_RET_OK;
}

DR_RESULT drRenderStateAtomSet::FindState(DWORD* id, DWORD state)
{
    for(DWORD i = 0; i < _rsa_num; i++)
    {
        if(_rsa_seq[i].state == DR_INVALID_INDEX)
        {
            return DR_RET_FAILED;
        }

        if(_rsa_seq[i].state == state)
        {
            if(id)
            {
                *id = i;
            }
            return DR_RET_OK;
        }
    }

    return DR_RET_FAILED;
}

//添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
DR_RESULT drRenderStateAtomSet::AddStateToSet(DWORD state, DWORD value)
{
	drRenderStateAtom* a;

	for(DWORD i = 0; i < _rsa_num; i++)
	{
		a = &_rsa_seq[i]; 

		if(a->state == DR_INVALID_INDEX || a->state==state )
		{
			a->state = state;
			a->value0 = value;
			a->value1 = value;
		}
		return DR_RET_OK;
	}

	return DR_RET_FAILED;
}

DR_RESULT drRenderStateAtomSet::ResetStateValue(DWORD state, DWORD value, DWORD* old_value)
{
    drRenderStateAtom* a;

    for(DWORD i = 0; i < _rsa_num; i++)
    {
        a = &_rsa_seq[i]; 

        if(a->state == DR_INVALID_INDEX)
        {
            return DR_RET_FAILED;
        }

        if(a->state == state)
        {
            if(old_value)
            {
                *old_value = value;
            }
            a->value0 = value;
            a->value1 = value;

            return DR_RET_OK;
        }
    }

    return DR_RET_FAILED;
}
DR_RESULT drRenderStateAtomSet::GetStateAtom(drRenderStateAtom** rsa, DWORD id) 
{ 
    if(id >= _rsa_num || rsa == 0)
        return DR_RET_FAILED;

    *rsa = &_rsa_seq[id];
    return DR_RET_OK;
}



DR_RESULT drIAnimCtrlObj_PlayPose(drIAnimCtrlObj* ctrl_obj, const drPlayPoseInfo* info)
{
    return ctrl_obj->PlayPose(info);
}


drIPoseCtrl* drIAnimCtrlObj_GetPoseCtrl(drIAnimCtrlObj* ctrl_obj)
{
    drIPoseCtrl* ret = 0;
    drIAnimCtrl* ctrl = ctrl_obj->GetAnimCtrl();
    if(ctrl == 0)
        goto __ret;

    ret = ctrl->GetPoseCtrl();
__ret:
    return ret;
}
drPlayPoseInfo* drIAnimCtrlObj_GetPlayPoseInfo(drIAnimCtrlObj* ctrl_obj)
{
    return ctrl_obj->GetPlayPoseInfo();
}

DWORD drGetBlendWeightNum(DWORD fvf)
{
    DWORD blend_num = 0;

    if(fvf & (D3DFVF_XYZ | D3DFVF_LASTBETA_UBYTE4))
    {
        blend_num = 1;
    }
    else if(fvf & (D3DFVF_XYZB2 | D3DFVF_LASTBETA_UBYTE4))
    {
        blend_num = 2;
    }
    else if(fvf & (D3DFVF_XYZB3 | D3DFVF_LASTBETA_UBYTE4))
    {
        blend_num = 3;
    }
    else if(fvf & (D3DFVF_XYZB4 | D3DFVF_LASTBETA_UBYTE4))
    {
        blend_num = 4;
    }

    return blend_num;
}

DR_RESULT LoadFileInMemory(drIBuffer* buf, const char* file, const char* load_flag)
{
    DR_RESULT ret = DR_RET_FAILED;
    BYTE* data = 0;
    DWORD size = 0;

    if(buf == 0)
        goto __ret;

	FILE *fp;
	fopen_s( &fp, file, load_flag);
	if(fp == 0)
        goto __ret;

    fseek(fp, 0, SEEK_END);
	size = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	
    buf->Free();
    buf->Alloc(size);

    fread(buf->GetData(), size, 1, fp);


    ret = DR_RET_OK;
__ret:
    if(fp)
    {
	    fclose(fp);
    }

    return ret;
}

DR_RESULT LoadFileInMemory(BYTE** data_seq, DWORD* data_size, const char* file, const char* load_flag)
{
    DR_RESULT ret = DR_RET_FAILED;
    BYTE* data = 0;
    DWORD size = 0;

	FILE *fp;
	fopen_s( &fp, file, load_flag);
	if(fp == 0)
        goto __ret;

    fseek(fp, 0, SEEK_END);
	size = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	
    data = new BYTE[size];

	fread(data, size, 1, fp);

    *data_seq = data;
    *data_size = size;

    ret = DR_RET_OK;
__ret:
    if(fp)
    {
	    fclose(fp);
    }

    return ret;
}

DR_END