//


#include "drResourceMgr.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drDeviceObject.h"
#include "drPathInfo.h"
#include "drITypes.h"
#include "drRenderImp.h"
#include "drRenderCtrlEmb.h"
#include "drItem.h"
#include "drModel.h"
#include "drPhysique.h"
#include "drAnimCtrl.h"
#include "drStreamObj.h"
#include "drD3D.h"
#include "drGraphicsUtil.h"
#include "drMisc.h"
#include "drNodeObject.h"
#include "drDDS.h"
#include "drAnimCtrlObj.h"
#include "drFileEncode.h"
#include "GlobalInc.h"
#include "drThreadPool.h"
#include <CPerformance.h>
DR_BEGIN


unsigned int __stdcall __thread_proc_load_tex(void* param)
{

    drITex* tex = (drITex*)param;

    if(DR_FAILED(tex->LoadSystemMemory()))
    {
        tex->SetLoadResMask(LOADINGRES_MASK_LOADSM_FAILED, 0);
    }

    if(DR_FAILED(tex->LoadVideoMemory()))
    {
        tex->SetLoadResMask(LOADINGRES_MASK_LOADVM_FAILED, 0);
    }

    tex->SetLoadResMask(LOADINGRES_MASK_RTMT1, 0);

    return 0;
}

unsigned int __stdcall __thread_proc_load_mesh(void* param)
{

    drIMesh* mesh = (drIMesh*)param;

    mesh->LoadVideoMemory();

    return 0;
}


// drTex
//DR_STD_ILELEMENTATION(drTex)
DR_STD_GETINTERFACE(drTex)

DR_RESULT drTex::Release()
{
    DR_RESULT ret;

    if(--_ref > 0)
        return DR_RET_OK;
    
    if(_load_type == LOADINGRES_TYPE_RUNTIME_MT)
    {
        while((_load_mask & LOADINGRES_MASK_RTMT0) && !(_load_mask & LOADINGRES_MASK_RTMT1))
        {
            drIThreadPool* tp = _res_mgr->GetThreadPoolMgr()->GetThreadPool(THREAD_POOL_LOADRES);

            if(DR_SUCCEEDED(tp->FindTask(__thread_proc_load_tex, (void*)this)))
            {
                if(_res_mgr->QueryTexRefCnt(this) == 1)
                {
                    if(DR_FAILED(tp->RemoveTask(__thread_proc_load_tex, (void*)this)))
                    {
                        drMessageBox("fatal error when release texture, call jack");
                    }
                }

                break;
            }
            else
            {
                Sleep(1);
            }
        }
    }

    if(DR_FAILED(ret = _res_mgr->UnregisterTex(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
#if(defined USE_TEXLOG_MGR)
        ((drResourceMgr*)_res_mgr)->_texlog_mgr.Log(
            0,
            _file_name,
            _data_info.width,
            _data_info.height,
            (D3DFORMAT)_format,
            _data_info.size);
#endif
        Unload();
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

drTex::drTex(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _reg_id(DR_INVALID_INDEX),
  _stage(DR_INVALID_INDEX), _tex(0), _colorkey_type(COLORKEY_TYPE_NONE),
  _state(RES_STATE_INVALID), _byte_alignment_flag(0),
  _level(0), _usage(0), _format(0), _pool(D3DPOOL_FORCE_DWORD)
{
    _ref = 1;

    _mt_flag = 0;
    _load_flag = 0;

    _load_type = 0;
    _load_mask = 0;

    _data = 0;

    _file_name[0] = '\0';

    _rsa_0.Allocate(DR_TEX_TSS_NUM);

    memset(&_data_info, 0, sizeof(_data_info));
}

drTex::~drTex()
{
}

DR_RESULT drTex::Register()
{
    assert(0 && "invalid proc");
    return _res_mgr->RegisterTex(this);
}
DR_RESULT drTex::Unregister()
{
    return _res_mgr->UnregisterTex(this);
}

DR_RESULT drTex::BeginPass()
{
    DR_RESULT ret = RES_PASS_ERROR;

    if(_load_type == LOADINGRES_TYPE_RUNTIME)
    {
        if(!(_load_mask & LOADINGRES_MASK_RT0))
        {
            SetLoadResMask(LOADINGRES_MASK_RT0, 0);

//#if(defined RESTRICT_LOADING_TEXTURE)
//            drISceneMgr* scn_mgr = _res_mgr->GetSysGraphics()->GetSceneMgr();
//            drSceneFrameInfo* sfi = scn_mgr->GetSceneFrameInfo();
//            if(sfi->_tex_cpf > 4)
//                return DR_RET_OK_1;
//
//            sfi->_tex_cpf++;
//#endif

            if(DR_FAILED(LoadVideoMemory()))
            {
                SetLoadResMask(LOADINGRES_MASK_LOADVM_FAILED, 0);
            }

        }
    }
    else if(_load_type == LOADINGRES_TYPE_RUNTIME_MT)
    {
        if(!(_load_mask & LOADINGRES_MASK_RTMT0))
        {
            SetLoadResMask(LOADINGRES_MASK_RTMT0, 0);

            drIThreadPoolMgr* tp_mgr = _res_mgr->GetThreadPoolMgr();
            drIThreadPool* tp = tp_mgr->GetThreadPool(THREAD_POOL_LOADRES);

            if(DR_FAILED(tp->RegisterTask(__thread_proc_load_tex, (void*)this)))
            {
                SetLoadResMask(LOADINGRES_MASK_RTMTREG_FAILED, 0);
            }
            
            ret = RES_PASS_SKIPTHISDRAW;
            goto __ret;
        }
        if(!(_load_mask &LOADINGRES_MASK_RTMT1))
        {
            ret = RES_PASS_SKIPTHISDRAW;
            goto __ret;
        }
    }


    ret = RES_PASS_DEFAULT;

__ret:
    return ret;
}

DR_RESULT drTex::EndPass()
{
    return DR_RET_OK;
}

void drTex::SetLoadResMask(DWORD add_mask, DWORD remove_mask)
{
    if(add_mask)
    {
        _load_mask |= add_mask;
    }
    if(remove_mask)
    {
        _load_mask &= ~remove_mask;
    }
}

DR_RESULT drTex::BeginSet()
{
    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

//#define USE_MULTI_TEX_COLORKEY
//#ifdef USE_MULTI_TEX_COLORKEY
//    if(_colorkey.color > 0)
//    {
//        dev_obj->SetTexture(0, _tex);
        //dev_obj->SetTexture(1, _tex);
        //dev_obj->SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1);
        //dev_obj->SetTextureStageState(1, D3DTSS_ALPHAARG1, D3DTA_CURRENT);
        //dev_obj->SetTextureStageState(1, D3DTSS_COLOROP, D3DTOP_MODULATE);
        //dev_obj->SetTextureStageState(1, D3DTSS_COLORARG1, D3DTA_DIFFUSE);
        //dev_obj->SetTextureStageState(1, D3DTSS_COLORARG1, D3DTA_TEXTURE);
//    }
//    else
//    {
//        dev_obj->SetTexture(_stage, _tex);
//    }
//#else


    dev_obj->SetTexture(_stage, _tex);


    //if(_stage == 2)
    //{
    //    dev_obj->SetRenderState(D3DRS_TEXTUREFACTOR, D3DCOLOR_ARGB(255,255,255,255));
    //}

    // texture stage state

/*
    _rsa_0.BeginTextureStageState(dev_obj, 0, DR_TEX_TSS_NUM, _stage);
*/

    //for(i = 0; i < _tss_set.SEQUENCE_SIZE; i++)
    //{
    //    rsv = &_tss_set.rsv_seq[0][i];

    //    if(rsv->state == DR_INVALID_INDEX)
    //        break;

    //    dev_obj->SetTextureStageState(_stage, (D3DTEXTURESTAGESTATETYPE)rsv->state, rsv->value);
    //}
//#endif

    return DR_RET_OK;
}
DR_RESULT drTex::EndSet()
{
    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

#ifdef USE_MULTI_TEX_COLORKEY
    if(_colorkey.color > 0)
    {
        dev_obj->SetTexture(0, 0);
        //dev_obj->SetTexture(1, 0);
        //dev_obj->SetTexture(0, _tex);
        //dev_obj->SetTexture(1, _tex);
        //dev_obj->SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
    }
    else
    {
        dev_obj->SetTexture(0, 0);
        dev_obj->SetTexture(1, 0);
    }
#else

    dev_obj->SetTexture(_stage, NULL);

    // texture stage state
    _rsa_0.EndTextureStageState(dev_obj, 0, DR_TEX_TSS_NUM, _stage);
    //for(i = 0; i < _tss_set.SEQUENCE_SIZE; i++)
    //{
    //    rsv = &_tss_set.rsv_seq[1][i];

    //    if(rsv->state == DR_INVALID_INDEX)
    //        break;

    //    dev_obj->SetTextureStageState(_stage, (D3DTEXTURESTAGESTATETYPE)rsv->state, rsv->value);
    //}
#endif
    return DR_RET_OK;

}

void drTex::GetTexInfo(drTexInfo* info)
{
     info->stage = _stage;
     info->type = _tex_type;

     info->level = _level;
     info->usage = _usage;
     info->format = (D3DFORMAT)_format;
     info->pool = _pool;

     info->colorkey_type = _colorkey_type;
     info->colorkey = _colorkey;

     info->byte_alignment_flag = _byte_alignment_flag;
     
     memcpy(info->tss_set, _rsa_0.GetStateSeq(), sizeof(drRenderStateAtom) * DR_TEX_TSS_NUM);

    switch(_tex_type)
    {
    case TEX_TYPE_FILE:
        _tcsncpy_s(info->file_name, _file_name, _TRUNCATE);
        info->width = _data_info.width;
        info->height = _data_info.height;
        break;
    case TEX_TYPE_DATA:

        if(_data_info.data)
        {
             info->data = _data_info.data;
             info->width = _data_info.width;
             info->height = _data_info.height;
        }

        break;
    case TEX_TYPE_SIZE:
        info->width = _data_info.width;
        info->height = _data_info.height;
        break;
    default:
        assert(0 && "invalid tex type");
    }
}

DR_RESULT drTex::LoadTexInfo(const drTexInfo* info, const char* tex_path)
{
    DR_RESULT ret = DR_RET_FAILED;

    _stage = info->stage;
    _tex_type = info->type;

    _level = info->level;
    _usage = info->usage;
    _format = info->format;
    _pool = info->pool;

    _colorkey_type = info->colorkey_type;
    _colorkey = info->colorkey;

    _byte_alignment_flag = info->byte_alignment_flag;
    
    _rsa_0.Load(info->tss_set, DR_TEX_TSS_NUM);

    switch(info->type)
    {
    case TEX_TYPE_FILE:
        if(tex_path)
        {
            _snprintf_s(_file_name, DR_MAX_PATH , _TRUNCATE ,"%s%s", tex_path, info->file_name);
        }
        else
        {
            strncpy_s(_file_name, info->file_name, _TRUNCATE );
        }
        break;
    case TEX_TYPE_DATA:

        if(info->data == 0)
            goto __ret;

        _data = info->data;
        _data_size = info->width;

        _data_info.data = info->data;
        _data_info.width = info->width;
        _data_info.height = info->height;
        _data_info.size = _data_info.width * _data_info.height;
        if(_byte_alignment_flag)
        {
            _data_info.pitch = drGetTexFlexibleSize(_data_info.width) * drGetTexFlexibleSize(_data_info.height);
        }
        else
        {
            _data_info.pitch = _data_info.width * _data_info.height;
        }
        break;
    case TEX_TYPE_SIZE:
        _data_info.width = info->width;
        _data_info.height = info->height;
        break;
    default:
        assert(0 && "invalid tex type");
        goto __ret;
    }

    // 兼容旧版本format
    if(_format == D3DFMT_UNKNOWN)
    {
        _format = D3DFMT_A1R5G5B5;
    }

    _state |= RES_STATE_INIT;

    ret = DR_RET_OK;
__ret:
    return ret;
    
}

DR_RESULT drTex::LoadSystemMemory()
{
    DR_RESULT ret = DR_RET_FAILED;


    if(_state & RES_STATE_SYSTEMMEMORY)
        goto __addr_ret_ok;

    if((_state & RES_STATE_INIT) == 0)
        goto __ret;

    switch(_tex_type)
    {
    case TEX_TYPE_FILE:
        //if(DR_FAILED(drLoadTexDataInfo(&_data_info, _file_name, _format, _colorkey_type, &_colorkey, _byte_alignment_flag)))
        //    goto __ret;
        break;
    case TEX_TYPE_DATA:
        break;
    case TEX_TYPE_SIZE:
        break;
    default:
        goto __ret;
    }

    _state |= RES_STATE_SYSTEMMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drTex::LoadVideoMemory()
{
    if(_load_flag == 1)
    {
        return LoadVideoMemoryDirect();
    }
 
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    if(_state & RES_STATE_VIDEOMEMORY)
        goto __addr_ret_ok;

    if((_state & RES_STATE_SYSTEMMEMORY) == 0)
    {
        if(DR_FAILED(LoadSystemMemory()))
		{
			//IP("LoadSystemMemory failed\n");
            goto __ret;
		}
    }

	_format = D3DFMT_A8R8G8B8;

    if(_tex_type == TEX_TYPE_DATA)
    {
		//IP("TextureData(%s) pool=%d\n", _file_name, _pool);
        if(DR_FAILED(dev_obj->CreateTextureFromFileInMemory(
            &_tex,
            _data,
            _data_size,
            D3DX_DEFAULT,
            D3DX_DEFAULT,
            _level, // mip map levels
            0, // usage
            (D3DFORMAT)_format,
            _pool,
            D3DX_DEFAULT, // filter
            D3DX_DEFAULT, // mipmap filter
            _colorkey.color, // colorkey
            NULL, // D3DXIMAGE_INFO
            NULL // PALETTEENTRY
           )))
        {
			//IP("CreateTextureFromFileInMemory failed\n");
            goto __ret;
        }

        D3DSURFACE_DESC desc;
        if(DR_FAILED(_tex->GetLevelDesc(0, &desc)))
		{
			//IP("GetLevelDesc failed\n");
            goto __ret;
		}

        _data_info.width = desc.Width;
        _data_info.height = desc.Height;
        _data_info.size = drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
#if(defined DR_USE_DX8)
        _data_info.size = desc.Size;
#endif

#if(defined USE_TEXLOG_MGR)
        ((drResourceMgr*)_res_mgr)->_texlog_mgr.Log(
            1,
            "User tex",
            _data_info.width,
            _data_info.height,
            (D3DFORMAT)_format,
            _data_info.size);
#endif
    }
    else if(_tex_type == TEX_TYPE_FILE)
    {
        if(_tcslen(_file_name) == 0)
		{
			//IP("_file_name len=0\n");
			goto __addr_ret_ok;
		}

#if(defined USE_D3DX_LOAD_TEXTURE)

#if(defined USE_RES_BUF_MGR)

        drIResBufMgr* resbuf_mgr = _res_mgr->GetResBufMgr();
        //drSysMemTexInfo info;
        //info.colorkey = _colorkey.color;
        //info.format = (D3DFORMAT)_format;
        //info.level = _level;     
        //info.filter = D3DX_DEFAULT;
        //info.mip_filter = D3DX_DEFAULT;

        //_tcsncpy_s(info.file_name, _file_name);
        drSysMemTexInfo* info;

#if(defined LOAD_RES_BUF_RUNTIME)

//#undef USE_DDS_FILE
#if(defined USE_DDS_FILE)
        // 这个版本是为了兼容非dds文件检查
        drDDSHeader* dds_header = 0;
        BOOL dds_flag = 1;
        char dds_file[DR_MAX_FILE];
        _tcsncpy_s(dds_file, _file_name, _TRUNCATE);
        char* p = _tcsrchr(dds_file, '.');
        if(p && (_tcsicmp(&p[1], "bmp") == 0 || _tcsicmp(&p[1], "tga") == 0))
        {
            p[1] = 'd';
            p[2] = 'd';
            p[3] = 's';
        }

        if(DR_SUCCEEDED(resbuf_mgr->QuerySysMemTex(&info, dds_file)))
		{
			//IP("QuerySysMemTex failed\n");
            goto __load_check_dds;
		}

        drSysMemTexInfo smti;
        smti.colorkey = _colorkey.color;
        smti.format = (D3DFORMAT)_format;
        smti.level = _level;     
        smti.filter = D3DX_DEFAULT;
        smti.mip_filter = D3DX_DEFAULT;
        _tcsncpy_s(smti.file_name, dds_file, _TRUNCATE );

        DR_HANDLE handle;
        if(DR_SUCCEEDED(resbuf_mgr->RegisterSysMemTex(&handle, &smti)))
        {
            if(DR_FAILED(resbuf_mgr->GetSysMemTex(&info, handle)))
			{
				//IP("GetSysMemTex failed\n");
                goto __ret;
			}

            goto __load_check_dds;
        }

        // here we check origin file existing
        {
            dds_flag = 0;

            if(DR_SUCCEEDED(resbuf_mgr->QuerySysMemTex(&info, _file_name)))
                goto __load_check_dds;

            drSysMemTexInfo smti;
            smti.colorkey = _colorkey.color;
            smti.format = (D3DFORMAT)_format;
            smti.level = _level;     
            smti.filter = D3DX_DEFAULT;
            smti.mip_filter = D3DX_DEFAULT;
            _tcsncpy_s(smti.file_name, _file_name, _TRUNCATE );

            if(DR_FAILED(resbuf_mgr->RegisterSysMemTex(&handle, &smti)))
			{
				//IP("RegisterSysMemTex failed\n");
                goto __ret;
			}

            if(DR_FAILED(resbuf_mgr->GetSysMemTex(&info, handle)))
			{
				//IP("GetSysMemTex2 failed\n");
                goto __ret;
			}

        }

__load_check_dds:

        DWORD mip_level;
        D3DFORMAT fmt;
        DWORD colorkey;
        DWORD mip_filter;

        if(dds_flag == 1)
        {
            dds_header = (drDDSHeader*)((BYTE*)info->buf->GetData() + sizeof(DWORD));

            mip_level = dds_header->mipmap_count;
            colorkey = 0;
            mip_filter = D3DX_DEFAULT;

            switch(dds_header->ddspf.four_cc)
            {
            case MAKEFOURCC('D', 'X', 'T', '1'):
                fmt = D3DFMT_DXT1;
                break;
            case MAKEFOURCC('D', 'X', 'T', '3'):
                fmt = D3DFMT_DXT3;
                break;
            case MAKEFOURCC('D', 'X', 'T', '5'):
                fmt = D3DFMT_DXT5;
                break;
            default:
                fmt = D3DFMT_UNKNOWN;
                break;
            }
        }
        else
        {
            mip_level = _level;
            fmt = (D3DFORMAT)_format;
            colorkey = _colorkey.color;
            mip_filter = colorkey ? D3DX_FILTER_POINT : D3DX_DEFAULT;
        }

		//由最低配置512M内存创建贴图失败引申的解决方案 
		//使用D3DPOOL_DEFAULT创建的贴图放在显存，当装置丢失时这些资料会Lost，需要重新加载
		//但是那个啥没有做这方面的工作, 这就解释了为什么进入屏幕保护再切回来时,UI很多东西都不见了, 包括2M内存的机器也会发生
		//改用 D3DPOOL_MANAGED会先在系统内存创建，当需要时复制一份到显存，由D3D Runtime 完成同步
		//当显存不够用, MANAGED最先被移出, 而且因为有同步机制在, MANAGED 不适合用在频繁更新的贴图(例如RenderTarget,Lock)
		//因此如果发现这个修改严重造成客户端效率问题,应找出该贴图,特殊处理
		//IP("CheckDDS(%s) pool=%d\n", _file_name, _pool);
		if( _pool==D3DPOOL_DEFAULT )
			_pool = D3DPOOL_MANAGED; 
        if(DR_FAILED(dev_obj->CreateTextureFromFileInMemory(
            &_tex,
            info->buf->GetData(),
            info->buf->GetSize(),
            D3DX_DEFAULT,
            D3DX_DEFAULT,
            mip_level, // mip map levels
            0, // usage
            (D3DFORMAT)fmt,
            _pool,
            D3DX_DEFAULT, // filter
            mip_filter, // mipmap filter
            colorkey, // colorkey
            NULL, // D3DXIMAGE_INFO
            NULL // PALETTEENTRY
           )))
        {
			//IP("CreateTextureFromFileInMemory2 failed\n");
            goto __ret;
        }

        D3DSURFACE_DESC desc;
        if(DR_FAILED(_tex->GetLevelDesc(0, &desc)))
		{
			//IP("GetLevelDesc3 failed\n");
            goto __ret;
		}

        _data_info.width = desc.Width;
        _data_info.height = desc.Height;
        _data_info.size = drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
#if(defined DR_USE_DX8)
        _data_info.size = desc.Size;
#endif

#if(defined USE_TEXLOG_MGR)
        ((drResourceMgr*)_res_mgr)->_texlog_mgr.Log(
            1,
            info->file_name,
            _data_info.width,
            _data_info.height,
            (D3DFORMAT)_format,
            _data_info.size);
#endif


        goto __use_dds;
#else//not USE_DDS_FILE
        if(DR_FAILED(resbuf_mgr->QuerySysMemTex(&info, _file_name)))
        {
            drSysMemTexInfo smti;
            smti.colorkey = _colorkey.color;
            smti.format = (D3DFORMAT)_format;
            smti.level = _level;     
            smti.filter = D3DX_DEFAULT;
            smti.mip_filter = D3DX_DEFAULT;
            _tcsncpy_s(smti.file_name, _file_name);

            DR_HANDLE handle;

            if(DR_FAILED(resbuf_mgr->RegisterSysMemTex(&handle, &smti)))
                goto __ret;

            if(DR_FAILED(resbuf_mgr->GetSysMemTex(&info, handle)))
                goto __ret;

        }

        goto __load_it;

#endif

#endif
        if(DR_SUCCEEDED(resbuf_mgr->QuerySysMemTex(&info, _file_name)))
        {
#ifndef USE_DDS_FILE
__load_it:
#endif

#if(defined USE_D3DX_LOAD_TEXTURE_UPDATETEXTURE)
            if(DR_FAILED(dev_obj->CreateTexture(&_tex, info->width, info->height, info->level, 0, (D3DFORMAT)info->format, D3DPOOL_DEFAULT)))
                goto __ret;

            if(DR_FAILED(dev_obj->GetDevice()->UpdateTexture(info->sys_mem_tex, _tex)))
                goto __ret;
#endif

#if(defined USE_D3DX_LOAD_TEXTURE_CREATEFROMMEMORY)

			//IP("Query(%s) pool=%d\n", _file_name, _pool);
            if(DR_FAILED(dev_obj->CreateTextureFromFileInMemory(
                &_tex,
                info->buf->GetData(),
                info->buf->GetSize(),
                D3DX_DEFAULT,
                D3DX_DEFAULT,
                _level, // mip map levels
                0, // usage
                (D3DFORMAT)_format,
                _pool,
                D3DX_DEFAULT, // filter
                _colorkey.color ? D3DX_FILTER_POINT : D3DX_DEFAULT, // mipmap filter
                _colorkey.color, // colorkey
                NULL, // D3DXIMAGE_INFO
                NULL // PALETTEENTRY
               )))
            {
				//IP("CreateTextureFromFileInMemory3 failed\n");
                goto __ret;
            }

            D3DSURFACE_DESC desc;
            if(DR_FAILED(_tex->GetLevelDesc(0, &desc)))
			{
				//IP("GetLevelDesc4 failed\n");
                goto __ret;
			}

            _data_info.width = desc.Width;
            _data_info.height = desc.Height;
            _data_info.size = drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
#if(defined DR_USE_DX8)
            _data_info.size = desc.Size;
#endif

#if(defined USE_TEXLOG_MGR)
            ((drResourceMgr*)_res_mgr)->_texlog_mgr.Log(
                1,
                info->file_name,
                _data_info.width,
                _data_info.height,
                (D3DFORMAT)_format,
                _data_info.size);
#endif

#endif
        }
		else
        {
            if(FAILED(D3DXCreateTextureFromFileEx(dev_obj->GetDevice(),
                this->_file_name, //文件名
                0, //文件宽，这里设为自动
                0, //文件高，这里设为自动
                _level, //需要多少级mipmap，这里设为1
                0, //此纹理的用途
                (D3DFORMAT)_format, //自动检测文件格式
                _pool, //D3DPOOL_MANAGED, //由DXGraphics管理
                D3DX_FILTER_LINEAR, //D3DX_FILTER_TRIANGLE|D3DX_FILTER_MIRROR, //纹理过滤方法
                D3DX_DEFAULT,//D3DX_DEFAULT,//D3DX_FILTER_NONE, //mipmap纹理过滤方法
                _colorkey.color,//0xffff00ff, //透明色颜色
                NULL, //读出的图像格式存储在何变量中
                NULL, //读出的调色板存储在何变量中
                &_tex)))//要创建的纹理
            {
				//IP("D3DXCreateTextureFromFileEx failed\n");
                goto __ret;
            }

        }
#if 0
        IDirect3DTextureX* t;
        if(FAILED(D3DXCreateTextureFromFileEx(dev_obj->GetDevice(),
            this->_file_name, //文件名
            0, //文件宽，这里设为自动
            0, //文件高，这里设为自动
            _level, //需要多少级mipmap，这里设为1
            0, //此纹理的用途
            (D3DFORMAT)_format, //自动检测文件格式
             D3DPOOL_SYSTEMMEM, //D3DPOOL_MANAGED, //由DXGraphics管理
            D3DX_DEFAULT, //D3DX_FILTER_TRIANGLE|D3DX_FILTER_MIRROR, //纹理过滤方法
            D3DX_DEFAULT,//D3DX_DEFAULT,//D3DX_FILTER_NONE, //mipmap纹理过滤方法
            _colorkey.color,//0xffff00ff, //透明色颜色
            NULL, //读出的图像格式存储在何变量中
            NULL, //读出的调色板存储在何变量中
            &t)))//要创建的纹理
        {
            goto __ret;
        }

        D3DSURFACE_DESC desc;
        t->GetLevelDesc(0, &desc);
        dev_obj->CreateTexture(&_tex, desc.Width, desc.Height, _level, 0, (D3DFORMAT)_format, D3DPOOL_DEFAULT);
        IDirect3DDeviceX* dev = dev_obj->GetDevice();
        HRESULT hr = dev->UpdateTexture(t, _tex);
        t->Release();
#endif

#else
        if(FAILED(D3DXCreateTextureFromFileEx(dev_obj->GetDevice(),
            this->_file_name, //文件名
            0, //文件宽，这里设为自动
            0, //文件高，这里设为自动
            _level, //需要多少级mipmap，这里设为1
            0, //此纹理的用途
            (D3DFORMAT)_format, //自动检测文件格式
            _pool, //D3DPOOL_MANAGED, //由DXGraphics管理
            D3DX_FILTER_LINEAR, //D3DX_FILTER_TRIANGLE|D3DX_FILTER_MIRROR, //纹理过滤方法
            D3DX_DEFAULT,//D3DX_DEFAULT,//D3DX_FILTER_NONE, //mipmap纹理过滤方法
            _colorkey.color,//0xffff00ff, //透明色颜色
            NULL, //读出的图像格式存储在何变量中
            NULL, //读出的调色板存储在何变量中
            &_tex)))//要创建的纹理
        {
            goto __ret;
        }
#endif

#else
        if(_tex_type == TEX_TYPE_FILE)
        {
            if(DR_FAILED(drLoadTexDataInfo(&_data_info, _file_name, _format, _colorkey_type, &_colorkey, _byte_alignment_flag)))
                goto __ret;
        }

        if(DR_FAILED(dev_obj->CreateTexture(&_tex, &_data_info, _level, _usage, _format, _pool)))
            goto __ret;

#endif

    }
    else if(_tex_type == TEX_TYPE_SIZE)
    {
		//if(DR_FAILED(dev_obj->CreateTexture(&_tex, _data_info.width, _data_info.height, _level, _usage, _format, _pool)))
        if(DR_FAILED(dev_obj->CreateTexture(&_tex, _data_info.width, _data_info.height, _level, _usage, (D3DFORMAT)D3DFMT_A4R4G4B4, _pool)))
		{
			//IP("CreateTexture failed\n");
			goto __ret;
		}
    }

__use_dds:
    _state |= RES_STATE_VIDEOMEMORY;


__addr_ret_ok:
    ret = DR_RET_OK;
	_state |= RES_STATE_LOADTEST;

__ret:
    if(DR_FAILED(ret))
    {
		//if( dev_obj && dev_obj->GetDevice() )
		{
			//IP("TestCooperativeLevel: (%d)\n", dev_obj->GetDevice()->TestCooperativeLevel());
		}
		//IP("load texture file error with: (%d) %s\n", ret, this->_file_name);
        drMessageBox("load texture file error with: (%d) %s\n", ret, this->_file_name);
    }

    return ret;
}

DR_RESULT drTex::LoadVideoMemoryMT()
{


    drIThreadPoolMgr* tp_mgr = _res_mgr->GetThreadPoolMgr();
    drIThreadPool* tp = tp_mgr->GetThreadPool(THREAD_POOL_LOADRES);

    if(DR_FAILED(tp->RegisterTask(__thread_proc_load_tex, (void*)this)))
        return DR_RET_FAILED;

    _mt_flag = 1;

    return DR_RET_OK;
}


DR_RESULT drTex::LoadVideoMemoryEx()
{

    if(_res_mgr->GetByteSet()->GetValue(OPT_RESMGR_LOADTEXTURE_MT) == 1)
    {
        return LoadVideoMemoryMT();
    }
    else
    {
#if(defined LOAD_TEXTURE_RESOURCE_DIRECTLY)
        return LoadVideoMemory();
#else
        return DR_RET_OK;
#endif
    }
}

DR_RESULT drTex::LoadVideoMemoryDirect()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_state & RES_STATE_VIDEOMEMORY)
        goto __addr_ret_ok;

    if((_state & RES_STATE_SYSTEMMEMORY) == 0)
    {
        if(DR_FAILED(LoadSystemMemory()))
            goto __ret;
    }

    _state |= RES_STATE_LOADTEST;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    if(_tex_type != TEX_TYPE_FILE)
        goto __ret;

    if(DR_FAILED(drLoadTexDataInfo(&_data_info, _file_name, _format, _colorkey_type, &_colorkey, _byte_alignment_flag)))
        goto __ret;

    if(DR_FAILED(dev_obj->CreateTexture(&_tex, &_data_info, _level, _usage, _format, _pool)))
        goto __ret;


    _state |= RES_STATE_VIDEOMEMORY;


    D3DSURFACE_DESC desc;
    if(DR_FAILED(_tex->GetLevelDesc(0, &desc)))
        goto __ret;

    _data_info.width = desc.Width;
    _data_info.height = desc.Height;
    _data_info.size = drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
#if(defined DR_USE_DX8)
    _data_info.size = desc.Size;
#endif

#if(defined USE_TEXLOG_MGR)
    ((drResourceMgr*)_res_mgr)->_texlog_mgr.Log(
        1,
        _file_name,
        _data_info.width,
        _data_info.height,
        (D3DFORMAT)_format,
        _data_info.size);
#endif

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;

}

DR_RESULT drTex::UnloadSystemMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    if((_state & RES_STATE_SYSTEMMEMORY) == 0)
        goto __addr_ret_ok;

    switch(_tex_type)
    {
    case TEX_TYPE_FILE:
    case TEX_TYPE_DATA:
        //DR_SAFE_DELETE_A(_data_info.data);
        memset(&_data_info, 0, sizeof(_data_info));
        break;
    case TEX_TYPE_SIZE:
        break;
    default:
        goto __ret;
    }

    _state &= ~RES_STATE_SYSTEMMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drTex::UnloadVideoMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    if((_state & RES_STATE_VIDEOMEMORY) == 0)
        goto __addr_ret_ok;

    if(DR_FAILED(dev_obj->ReleaseTex(_tex)))
    {
        goto __ret;
    }

    _tex = 0;

    _state &= ~(RES_STATE_VIDEOMEMORY | RES_STATE_LOADTEST | RES_STATE_LOADTEST_0);

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT drTex::Unload()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(UnloadVideoMemory()))
        goto __ret;

    if(DR_FAILED(UnloadSystemMemory()))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;

}

DWORD drTex::SetLOD(DWORD level)
{
    if((_tex == NULL) || (_pool != D3DPOOL_MANAGED))
        return 0;

    return _tex->SetLOD(level);
}

BOOL drTex::IsLoadingOK() const
{
    return _state & RES_STATE_LOADTEST;
}

DR_RESULT drTex::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if(_pool == D3DPOOL_DEFAULT)
    {
        if(DR_FAILED(UnloadVideoMemory()))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drTex::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if(_pool == D3DPOOL_DEFAULT)
    {
        if(DR_FAILED(LoadVideoMemory()))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}


// drMesh
//DR_STD_ILELEMENTATION(drMesh)
DR_STD_GETINTERFACE(drMesh)

DR_RESULT drMesh::Release()
{
    DR_RESULT ret;

    if(_mt_flag == 1)
    {
        while(IsLoadingOK() == 0)
        {
            Sleep(1);
        }
    }


    if(DR_FAILED(ret = _res_mgr->UnregisterMesh(this)))
        goto __ret;

    if(_reg_id == DR_INVALID_INDEX)
    {
        Unload();
        DR_DELETE(this);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

drMesh::drMesh(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _state(RES_STATE_INVALID), _reg_id(DR_INVALID_INDEX),
  _vb_id(DR_INVALID_INDEX), _ib_id(DR_INVALID_INDEX), _stream_type(STREAM_STATIC),
  _svb(0), _sib(0)
{
    _mt_flag = 0;
    _colorkey = 0;

    drMeshDataInfo_Construct(&_data_info);

    _mesh_info_ptr = &_mesh_info;
}

drMesh::~drMesh()
{
    drMeshDataInfo_Destruct(&_data_info);
}

DR_RESULT drMesh::Register()
{
    assert(0 && "invlaid call with drMesh::Register");
    return _res_mgr->RegisterMesh(this);
}
DR_RESULT drMesh::Unregister()
{
    return _res_mgr->UnregisterMesh(this);
}

DR_RESULT drMesh::SetResFile(const drResFileMesh* info) 
{     
    _res_file = *info;
    _state |= RES_STATE_INIT;

    return DR_RET_OK;
}

DR_RESULT drMesh::LoadSystemMemory(const drMeshInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;


    if(_state & RES_STATE_SYSTEMMEMORY)
        goto __addr_ret_ok;

    if(DR_FAILED(drMeshInfo_Copy(&_mesh_info, info)))
        goto __ret;

    _mesh_info_ptr = &_mesh_info;

    drMeshDataInfo_Destruct(&_data_info);
    drMeshDataInfo_Construct(&_data_info);

    if(DR_FAILED(drLoadMeshDataInfo(&_data_info, info)))
        goto __ret;

    _rsa_0.Load(info->rs_set, DR_MESH_RS_NUM);

//关于狂野竞技场的调试代码，在这里锁定了模型物件，正式代码已写在 AddStateToSet 函式 
// 	if( *info->vertex_seq==drVector3(-50,-50,0) || *info->vertex_seq==drVector3(-85,85,0) )
// 	{
// 		for(int i=0; i<DR_MESH_RS_NUM; i++)
// 		{
// 			if( info->rs_set[i].state==DR_INVALID_INDEX )
// 			{
// 				RSA_VALUE(&_mesh_info.rs_set[i], D3DRS_ZBIAS, 1);
// 				_rsa_0.SetStateValue(i, D3DRS_ZBIAS, 1);
// 				break;
// 			}
// 		}
// 	}

    _state |= RES_STATE_SYSTEMMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;

}

DR_RESULT drMesh::LoadSystemMemoryMT(const drMeshInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;


    if(_state & RES_STATE_SYSTEMMEMORY)
        goto __addr_ret_ok;

    //if(DR_FAILED(drMeshInfo_Copy(&_mesh_info, info)))
    //    goto __ret;

    _mesh_info_ptr = const_cast<drMeshInfo*>(info);

    _rsa_0.Load(info->rs_set, DR_MESH_RS_NUM);

    _state |= RES_STATE_SYSTEMMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

//__ret:
    return ret;

}

DR_RESULT drMesh::LoadSystemMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_state & RES_STATE_SYSTEMMEMORY)
        goto __addr_ret_ok;

    else if((_state & RES_STATE_INIT) == 0)
        goto __ret;

    __asm { int 3 };

    //if(DR_FAILED(drLoadMeshInfoFromResFile(&_mesh_info, &_res_file)))
    //    goto __ret;
    
__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMesh::LoadVideoMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drIStaticStreamMgr* ssm;
    drILockableStreamMgr* lsm;

    if(_state & RES_STATE_VIDEOMEMORY)
        goto __addr_ret_ok;

    else if((_state & RES_STATE_SYSTEMMEMORY) == 0)
    {
        if(DR_FAILED(LoadSystemMemory()))
            goto __ret;
    }

    switch(_stream_type)
    {
    case STREAM_GENERIC:
        if(_data_info.vb_size > 0)
        {
            if(DR_FAILED(dev_obj->CreateVertexBuffer(&_svb)))
                goto __ret;

            if(DR_FAILED(_svb->Create(_data_info.vb_size, 0, _mesh_info_ptr->fvf, D3DPOOL_DEFAULT, _data_info.vb_stride, NULL)))
                goto __ret;

            if(DR_FAILED(_svb->LoadData(_data_info.vb_data, _data_info.vb_size, 0, 0)))
                goto __ret;
        }
        if(_data_info.ib_size > 0)
        {
            if(DR_FAILED(dev_obj->CreateIndexBuffer(&_sib)))
                goto __ret;

            if(DR_FAILED(_sib->Create(_data_info.ib_size, 0, D3DFMT_INDEX16, D3DPOOL_DEFAULT, NULL)))
                goto __ret;

            if(DR_FAILED(_sib->LoadData(_data_info.ib_data, _data_info.ib_size, 0, 0)))
                goto __ret;
        }

        break;
    case STREAM_STATIC:
        ssm =  _res_mgr->GetStaticStreamMgr();

        if(DR_FAILED(ssm->RegisterVertexBuffer(&_vb_id, _data_info.vb_data, _data_info.vb_size, _data_info.vb_stride)))
            goto __ret;

        if(_data_info.ib_size > 0)
        {
            if(DR_FAILED(ssm->RegisterIndexBuffer(&_ib_id, _data_info.ib_data, _data_info.ib_size, _data_info.ib_stride)))
                goto __ret;
        }
        break;
    case STREAM_LOCKABLE:
        lsm = _res_mgr->GetLockableStreamMgr();

        if(DR_FAILED(lsm->RegisterVertexBuffer(&_vb_id, _data_info.vb_data, _data_info.vb_size, D3DUSAGE_DYNAMIC|D3DUSAGE_WRITEONLY, _mesh_info_ptr->fvf)))
            goto __ret;

        if(_data_info.ib_size > 0)
        {
            if(DR_FAILED(lsm->RegisterIndexBuffer(&_ib_id, _data_info.ib_data, _data_info.ib_size, D3DUSAGE_DYNAMIC|D3DUSAGE_WRITEONLY, D3DFMT_INDEX16)))
                goto __ret;
        }
        break;
    default:
        drMessageBox("invalid stream type called drMesh::LoadVideoMemory");
    }

    _state |= RES_STATE_VIDEOMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    _state |= RES_STATE_LOADTEST;
    return ret;
}

DR_RESULT drMesh::LoadVideoMemoryMT()
{    

    SetStreamType(STREAM_GENERIC);

    drIThreadPoolMgr* tp_mgr = _res_mgr->GetThreadPoolMgr();
    drIThreadPool* tp = tp_mgr->GetThreadPool(THREAD_POOL_LOADRES);

    if(DR_FAILED(tp->RegisterTask(__thread_proc_load_mesh, (void*)this)))
        return DR_RET_FAILED;

    _mt_flag = 1;

    return DR_RET_OK;

}

DR_RESULT drMesh::LoadVideoMemoryEx()
{

    if(_res_mgr->GetByteSet()->GetValue(OPT_RESMGR_LOADMESH_MT) == 1)
    {
        return LoadVideoMemoryMT();
    }
    else
    {
#if(defined LOAD_VERTEX_RESOURCE_DIRECTLY)
        return LoadVideoMemory();
#else
        return DR_RET_OK;
#endif
    }
}

DR_RESULT drMesh::UnloadSystemMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    // warning: mesh data cannot free system memory
    goto __addr_ret_ok;

    if((_state & RES_STATE_SYSTEMMEMORY) == 0)
        goto __addr_ret_ok;

    _state &= ~RES_STATE_SYSTEMMEMORY;

__addr_ret_ok:
    ret = DR_RET_OK;

//__ret:
    return ret;

}
DR_RESULT drMesh::UnloadVideoMemory()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drIStaticStreamMgr* ssm;
    drILockableStreamMgr* lsm;

    if((_state & RES_STATE_VIDEOMEMORY) == 0)
    {
        ret = DR_RET_OK;
        goto __ret;
    }

    switch(_stream_type)
    {
    case STREAM_GENERIC:
        DR_SAFE_RELEASE(_svb);
        DR_SAFE_RELEASE(_sib);
        break;
    case STREAM_STATIC:
        ssm = _res_mgr->GetStaticStreamMgr();

        if(_vb_id != DR_INVALID_INDEX)
        {
            if(DR_FAILED(ssm->UnregisterVertexBuffer(_vb_id)))
                goto __ret;

            _vb_id = DR_INVALID_INDEX;
        }

        if(_ib_id != DR_INVALID_INDEX)
        {
            if(DR_FAILED(ssm->UnregisterIndexBuffer(_ib_id)))
                goto __ret;

            _ib_id = DR_INVALID_INDEX;
        }
        break;
    case STREAM_LOCKABLE:
        lsm = _res_mgr->GetLockableStreamMgr();

        if(_vb_id != DR_INVALID_INDEX)
        {
            if(DR_FAILED(lsm->UnregisterVertexBuffer(_vb_id)))
                goto __ret;

            _vb_id = DR_INVALID_INDEX;
        }

        if(_ib_id != DR_INVALID_INDEX)
        {
            if(DR_FAILED(lsm->UnregisterIndexBuffer(_ib_id)))
                goto __ret;

            _ib_id = DR_INVALID_INDEX;
        }            
        break;
    default:
        drMessageBox("invalid stream type called drMesh::UnloadVideoMemory");
    }


    _state &= ~RES_STATE_VIDEOMEMORY;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drMesh::Unload()
{
    DR_RESULT ret = DR_RET_OK;

    if(DR_FAILED(ret = UnloadVideoMemory()))
        goto __ret;

    if(DR_FAILED(ret = UnloadSystemMemory()))
        goto __ret;

__ret:
    return ret;
}

//添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
DR_RESULT drMesh::AddStateToSet(DWORD state, DWORD value) 
{
	for(int i=0; i<DR_MESH_RS_NUM; i++)
	{
		if( _mesh_info.rs_set[i].state==DR_INVALID_INDEX || _mesh_info.rs_set[i].state==state )
		{
			RSA_VALUE(&_mesh_info.rs_set[i], state, value);
			return _rsa_0.AddStateToSet(state, value);
		}
	}
	return DR_RET_FAILED;
}

DR_RESULT drMesh::BeginSet()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drIStaticStreamMgr* ssm;
    drILockableStreamMgr* lsm;

//#if(defined MULTITHREAD_LOADING_MESH)
    if(IsLoadingOK() == 0)
        goto __ret_ok;
//#endif

    if(!(_state & RES_STATE_VIDEOMEMORY) )
    {
		//IP("Mesh(%08x) file(%s) state=%08x\n", this, _res_file.file_name, _state);
        if(DR_FAILED(LoadVideoMemory()))
            goto __ret;
    }

    switch(_stream_type)
    {
    case STREAM_GENERIC:
        if(_svb)
        {
            if(DR_FAILED(_svb->BindDevice(0, 0)))
                goto __ret;
        }
        if(_sib)
        {
            if(DR_FAILED(_sib->BindDevice()))
                goto __ret;
        }
        break;
    case STREAM_STATIC:
        ssm = _res_mgr->GetStaticStreamMgr();

        if(_vb_id != DR_INVALID_INDEX)
        {
            ssm->BindVertexBuffer(_vb_id, 0);
        }
        if(_ib_id != DR_INVALID_INDEX)
        {
            ssm->BindIndexBuffer(_ib_id);
        }
        break;
    case STREAM_LOCKABLE:
        lsm = _res_mgr->GetLockableStreamMgr();

        if(_vb_id != DR_INVALID_INDEX)
        {
            lsm->BindVertexBuffer(_vb_id, 0, 0, _data_info.vb_stride);
        }
        if(_ib_id != DR_INVALID_INDEX)
        {
            lsm->BindIndexBuffer(_ib_id, 0);
        }
        break;
    default:
        drMessageBox("invalid stream type called drMesh::BeginSet");
    }

    dev_obj->SetFVF(_mesh_info_ptr->fvf);

    _rsa_0.BeginRenderState(dev_obj, 0, DR_MESH_RS_NUM);

__ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drMesh::EndSet()
{
    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    _rsa_0.EndRenderState(dev_obj, 0, DR_MESH_RS_NUM);

    return DR_RET_OK;
}

DR_RESULT drMesh::DrawSubset(DWORD subset)
{
    DR_RESULT ret = DR_RET_FAILED;

    if((_state & RES_STATE_VIDEOMEMORY) == 0)
        goto __ret;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drIStaticStreamMgr* ssm;
    drILockableStreamMgr* lsm;

    drSubsetInfo* i = &_mesh_info_ptr->subset_seq[subset];

    DWORD start_index = 0;
    DWORD base_vert_index = 0;

    switch(_stream_type)
    {
    case STREAM_GENERIC:

        break;
    case STREAM_STATIC:
        ssm = _res_mgr->GetStaticStreamMgr();

        if(_ib_id == DR_INVALID_INDEX)
        {
            start_index = i->start_index + ssm->GetVertexEntityOffset();
        }
        else
        {
#if(defined DR_USE_DX9_STREAMOFFSET)
            base_vert_index = 0;
#else
            base_vert_index = ssm->GetVertexEntityOffset();
#endif
            start_index = i->start_index + ssm->GetIndexEntityOffset();
        }
        break;
    case STREAM_LOCKABLE:
        lsm = _res_mgr->GetLockableStreamMgr();

        if(_ib_id == DR_INVALID_INDEX)
        {
            start_index = i->start_index;
        }
        else
        {
#if(defined DR_USE_DX9_STREAMOFFSET)
            base_vert_index = 0;
#else
            base_vert_index = 0;
#endif
            start_index = i->start_index;
        }
        break;
    default:
        drMessageBox("invalid stream type called drMesh::DrawSubset");
    }


#if(defined USE_STENCILBUFFER_FILTER_COLORKEY)
    if(_colorkey)
    {
        dev_obj->GetDevice()->Clear(0, NULL, D3DCLEAR_STENCIL, 0, 1.0f, 0);

        dev_obj->SetRenderState(D3DRS_STENCILENABLE, TRUE);
        dev_obj->SetRenderState(D3DRS_STENCILFUNC, D3DCLE_ADRAYS);
        dev_obj->SetRenderState(D3DRS_STENCILREF, 1);
        dev_obj->SetRenderState(D3DRS_STENCILMASK, 0xffffffff);
        dev_obj->SetRenderState(D3DRS_STENCIDRRITEMASK, 0xffffffff);

        dev_obj->SetRenderState(D3DRS_STENCILFAIL,  D3DSTENCILOP_KEEP);
        dev_obj->SetRenderState(D3DRS_STENCILZFAIL,  D3DSTENCILOP_KEEP);
        dev_obj->SetRenderState(D3DRS_STENCILPASS,  D3DSTENCILOP_REPLACE);

        //dev_obj->SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
        dev_obj->SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
        dev_obj->SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);

        dev_obj->SetRenderState(D3DRS_ALPHATESTENABLE, TRUE);
        dev_obj->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
        dev_obj->SetRenderState(D3DRS_ALPHAFUNC, D3DCLE_GREATER);
        dev_obj->SetRenderState(D3DRS_ALPHAREF, 0);

        dev_obj->SetRenderState(D3DRS_SRCBLEND,  D3DBLEND_ZERO);
        dev_obj->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ONE);

        if(_ib_id == DR_INVALID_INDEX)
        {
            ret = dev_obj->DrawPrimitive(_mesh_info_ptr->pt_type, start_index, i->primitive_num);
        }
        else
        {
            ret = dev_obj->DrawIndexedPrimitive(_mesh_info_ptr->pt_type, base_vert_index, i->min_index, i->vertex_num, start_index, i->primitive_num);
        }


        dev_obj->SetRenderState(D3DRS_ALPHAFUNC, D3DCLE_GREATER);
        dev_obj->SetRenderState(D3DRS_ALPHAREF, 0);

        dev_obj->SetRenderState(D3DRS_STENCILREF, 0);
        dev_obj->SetRenderState(D3DRS_STENCILMASK, 0xffffffff);
        dev_obj->SetRenderState(D3DRS_STENCILFUNC, D3DCLE_NOTEQUAL);
        dev_obj->SetRenderState(D3DRS_STENCILFAIL,  D3DSTENCILOP_KEEP);
        dev_obj->SetRenderState(D3DRS_STENCILZFAIL,  D3DSTENCILOP_KEEP);
        dev_obj->SetRenderState(D3DRS_STENCILPASS,  D3DSTENCILOP_KEEP);

        dev_obj->SetRenderState(D3DRS_SRCBLEND,  D3DBLEND_SRCALPHA);
        dev_obj->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);

        //dev_obj->SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
        //dev_obj->SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
        //dev_obj->SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);


        if(_ib_id == DR_INVALID_INDEX)
        {
            ret = dev_obj->DrawPrimitive(_mesh_info_ptr->pt_type, start_index, i->primitive_num);
        }
        else
        {
            ret = dev_obj->DrawIndexedPrimitive(_mesh_info_ptr->pt_type, base_vert_index, i->min_index, i->vertex_num, start_index, i->primitive_num);
        }

        dev_obj->SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
        dev_obj->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
        dev_obj->SetRenderState(D3DRS_STENCILENABLE, FALSE);
    }
    else
    {
        if(_ib_id == DR_INVALID_INDEX)
        {
            ret = dev_obj->DrawPrimitive(_mesh_info_ptr->pt_type, start_index, i->primitive_num);
        }
        else
        {
            ret = dev_obj->DrawIndexedPrimitive(_mesh_info_ptr->pt_type, base_vert_index, i->min_index, i->vertex_num, start_index, i->primitive_num);
        }
    }
#else
    if(_stream_type == STREAM_GENERIC)
    {
        if(_sib == 0)
        {
            ret = dev_obj->DrawPrimitive(_mesh_info_ptr->pt_type, 0, i->primitive_num);
        }
        else
        {
            ret = dev_obj->DrawIndexedPrimitive(_mesh_info_ptr->pt_type, 0, i->min_index, i->vertex_num, i->start_index, i->primitive_num);
        }
    }
    else
    {
        if(_ib_id == DR_INVALID_INDEX)
        {
            ret = dev_obj->DrawPrimitive(_mesh_info_ptr->pt_type, start_index, i->primitive_num);
        }
        else
        {
            ret = dev_obj->DrawIndexedPrimitive(_mesh_info_ptr->pt_type, base_vert_index, i->min_index, i->vertex_num, start_index, i->primitive_num);
        }
    }
#endif

__ret:
    return ret;
}

DR_RESULT drMesh::LoseDevice()
{
#if 0
    _vb_id = DR_INVALID_INDEX;
    _ib_id = DR_INVALID_INDEX;
    _state &= ~RES_STATE_VIDEOMEMORY;
    return DR_RET_OK;
#else
    DR_RESULT ret = DR_RET_FAILED;

    switch(_stream_type)
    {
    case STREAM_GENERIC:
    case STREAM_STATIC:
        if(DR_FAILED(UnloadVideoMemory()))
            goto __ret;
        break;
    case STREAM_LOCKABLE:
        break;
    default:
        assert(0);
    }

    ret = DR_RET_OK;
__ret:
    return ret;

#endif

}
DR_RESULT drMesh::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    switch(_stream_type)
    {
    case STREAM_GENERIC:
    case STREAM_STATIC:
        if(DR_FAILED(LoadVideoMemory()))
            goto __ret;
        break;
    case STREAM_LOCKABLE:
        break;
    default:
        assert(0);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

drILockableStreamVB* drMesh::GetLockableStreamVB()
{
    drILockableStreamVB* s = 0;

    if(_stream_type != STREAM_LOCKABLE || _vb_id == DR_INVALID_INDEX)
        goto __ret;

    drILockableStreamMgr* lsm = _res_mgr->GetLockableStreamMgr();

    s = lsm->GetStreamVB(_vb_id);
__ret:
    return s;
}
drILockableStreamIB* drMesh::GetLockableStreamIB()
{
    drILockableStreamIB* s = 0;

    if(_stream_type != STREAM_LOCKABLE || _vb_id == DR_INVALID_INDEX)
        goto __ret;

    drILockableStreamMgr* lsm = _res_mgr->GetLockableStreamMgr();

    s = lsm->GetStreamIB(_ib_id);
__ret:
    return s;
}

BOOL drMesh::IsLoadingOK() const
{
    return (_mt_flag == 0) || (_state & RES_STATE_VIDEOMEMORY);        
}

DR_RESULT drMesh::ExtractMesh(drMeshInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(drExtractMeshData(
        info, 
        _data_info.vb_data, 
        _data_info.ib_data, 
        _data_info.vb_size / _data_info.vb_stride, 
        _data_info.ib_size / _data_info.ib_stride,
        (D3DFORMAT)_mesh_info.fvf,
        D3DFMT_INDEX16
       )))
    {
        goto __ret;
    }

    info->fvf = _mesh_info.fvf;
    info->pt_type = _mesh_info.pt_type;
    info->subset_num = _mesh_info.subset_num;
    info->bone_index_num = _mesh_info.bone_index_num;
    memcpy(info->subset_seq, _mesh_info.subset_seq, sizeof(drSubsetInfo) * info->subset_num);
    memcpy(info->bone_index_seq, _mesh_info.bone_index_seq, sizeof(BYTE) * info->bone_index_num);
    memcpy(&info->rs_set, _rsa_0.GetStateSeq(), sizeof(drRenderStateAtom) * _rsa_0.GetStateNum());
    ret = DR_RET_OK;
__ret:
    return ret;
}

// drMtlTexAgent
DR_STD_ILELEMENTATION(drMtlTexAgent)

drMtlTexAgent::drMtlTexAgent(drIResourceMgr* mgr)
: _res_mgr(mgr), _opacity(1.0f), _transp_type(MTLTEX_TRANSP_FILTER)
{
    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        _tex_seq[i] = NULL;
    }
    memset(_uvmat, 0, sizeof(_uvmat));
    memset(_tt_tex, 0, sizeof(_tt_tex));

    // opacity rsa init
#if(defined MTLTEXAGENT_OPACITY_RSA_FLAG)
    //RSA_VALUE(&_opacity_rsa_seq[0], D3DRS_ZWRITEENABLE, 1);
    //RSA_VALUE(&_opacity_rsa_seq[1], D3DRS_TEXTUREFACTOR, 0xffffffff);
    //RSA_VALUE(&_opacity_rsa_seq[2], D3DTSS_ALPHAOP, D3DTOP_MODULATE);
    //RSA_VALUE(&_opacity_rsa_seq[3], D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
    //RSA_VALUE(&_opacity_rsa_seq[4], D3DTSS_ALPHAARG2, D3DTA_TFACTOR);
    _rsa_opacity.Allocate(5);
    _rsa_opacity.SetStateValue(0, D3DRS_ZWRITEENABLE, 1);
    _rsa_opacity.SetStateValue(1, D3DRS_TEXTUREFACTOR, 0xffffffff);
    _rsa_opacity.SetStateValue(2, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
    _rsa_opacity.SetStateValue(3, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
    _rsa_opacity.SetStateValue(4, D3DTSS_ALPHAARG2, D3DTA_TFACTOR);

#endif

    _opacity_reserve_rs[0] = DR_INVALID_INDEX;
    _opacity_reserve_rs[1] = DR_INVALID_INDEX;

    _rsa_0.Allocate(RSA_SET_SIZE);

    _render_flag = TRUE;

}
drMtlTexAgent::~drMtlTexAgent()
{
    Destroy();
}

DR_RESULT drMtlTexAgent::SetTex(DWORD stage, drITex* obj, drITex** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(stage < 0 || stage >= DR_MAX_MTL_TEX_NUM)
        goto __ret;

    *ret_obj = _tex_seq[stage];
    _tex_seq[stage] = obj;

    ret = DR_RET_OK;
__ret:
    return ret;
}


DR_RESULT drMtlTexAgent::LoadMtlTex(drMtlTexInfo* info, const char* tex_path)
{
    DR_RESULT ret = DR_RET_FAILED;

    drMtlTexInfo* i = (drMtlTexInfo*)info;

    _mtl = i->mtl;
    _opacity = i->opacity;
    _transp_type = i->transp_type;

    //SetMtlRenderState(&info->rs_set);
    _rsa_0.Load(info->rs_set, DR_MTL_RS_NUM);

    for(DWORD j = 0; j < DR_MAX_MTL_TEX_NUM; j++)
    {
        if(i->tex_seq[j].stage == DR_INVALID_INDEX)
            continue;

        if(DR_FAILED(LoadTextureStage(&i->tex_seq[j], tex_path)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMtlTexAgent::ExtractMtlTex(drMtlTexInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    info->mtl = _mtl;
    info->opacity = _opacity;
    info->transp_type = _transp_type;

    memcpy(info->rs_set, _rsa_0.GetStateSeq(), sizeof(drRenderStateAtom) * _rsa_0.GetStateNum());

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if(_tex_seq[i] == 0)
            break;

        _tex_seq[i]->GetTexInfo(&info->tex_seq[i]);

        // here , we discard the path of texture file
        char buf[260];
        _tcsncpy_s(buf, info->tex_seq[i].file_name, _TRUNCATE);
        char* p = _tcsrchr(buf, '\\');
        if(p)
        {
            _tcsncpy_s(info->tex_seq[i].file_name, &p[1], _TRUNCATE );
        }
    }

    return DR_RET_OK;
}


DR_RESULT drMtlTexAgent::LoadTextureStage(const drTexInfo* info, const char* tex_path)
{
    DR_RESULT ret = DR_RET_FAILED;

    drITex* obj;

    DWORD stage = info->stage;

    if(stage < 0 || stage >= DR_MAX_MTL_TEX_NUM)
        goto __ret;

    if(_tex_seq[stage] != NULL)
        goto __ret;

    if(DR_FAILED(_res_mgr->CreateTex(&obj)))
        goto __ret;
    
    if(DR_FAILED(obj->LoadTexInfo(info, tex_path)))
        goto __ret;

    DWORD load_type;

    if(_res_mgr->GetByteSet()->GetValue(OPT_RESMGR_LOADTEXTURE_MT) == 1)
    {
        load_type = LOADINGRES_TYPE_RUNTIME_MT;
    }
    else
    {
        load_type = LOADINGRES_TYPE_RUNTIME;
    }

    obj->SetLoadResType(load_type);

 
    _tex_seq[stage] = obj;


    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drMtlTexAgent::BeginPass()
{
    DR_RESULT r;
    DR_RESULT ret = RES_PASS_DEFAULT;

    drITex* t;
    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if((t = _tex_seq[i]) == NULL)
            break;
        
        if(_tt_tex[i])
        {
            t = _tt_tex[i];
        }

        r = t->BeginPass();

        if(r == RES_PASS_ERROR)
        {
            ret = RES_PASS_ERROR;
        }
        else if((r == RES_PASS_SKIPTHISDRAW) && (ret == RES_PASS_DEFAULT))
        {
            ret = RES_PASS_SKIPTHISDRAW;
        }
    }

    return ret;
}

DR_RESULT drMtlTexAgent::EndPass()
{
    return DR_RET_OK;
}

DR_RESULT drMtlTexAgent::DestroyTextureStage(DWORD stage)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_tex_seq[stage] == 0)
        goto __addr_ok;

    //if(_tex_seq[stage]->GetMTFlag() == 1)
    //{
    //    while(_tex_seq[stage]->IsLoadingOK() == 0)
    //    {
    //        ::Sleep(10);
    //    }
    //}

    if(DR_FAILED(_tex_seq[stage]->Release()))
        goto __ret;

    _tex_seq[stage] = NULL;

__addr_ok:
    ret = DR_RET_OK;

__ret:
    return ret;
}


DR_RESULT drMtlTexAgent::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

#pragma message("[Waiting Note] here crash? ")

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if(DR_FAILED(DestroyTextureStage(i)))
        {
            assert(0 && "call drMtlTexAgent::Destroy error");
            goto __ret;
        }

        DR_SAFE_DELETE(_uvmat[i]);
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}


DR_RESULT drMtlTexAgent::BeginSet()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drITex* tex;    

    dev_obj->SetMaterial(&_mtl);

    //dev_obj->SetTexture(0, NULL);

    if(_transp_type!= MTLTEX_TRANSP_FILTER)
    {
        //drRenderStateAtom* rsa;
        // src, dest
        DWORD id[2] = { DR_INVALID_INDEX, DR_INVALID_INDEX };

        _rsa_0.FindState(&id[0], D3DRS_SRCBLEND);
        _rsa_0.FindState(&id[1], D3DRS_DESTBLEND);

        DWORD v[2] = {D3DBLEND_ONE, D3DBLEND_ONE};
        switch(_transp_type)
        {
        case MTLTEX_TRANSP_ADDITIVE:
            v[0] = D3DBLEND_ONE;
            v[1] = D3DBLEND_ONE;
            break;
        case MTLTEX_TRANSP_ADDITIVE1: // hight
            v[0] = D3DBLEND_SRCCOLOR;
            v[1] = D3DBLEND_ONE;
            break;
        case MTLTEX_TRANSP_ADDITIVE2: // low
            v[0] = D3DBLEND_SRCCOLOR;
            v[1] = D3DBLEND_INVSRCCOLOR;
            break;
        case MTLTEX_TRANSP_ADDITIVE3: // low-high
            v[0] = D3DBLEND_SRCALPHA;
            v[1] = D3DBLEND_DESTALPHA;
            break;
        case MTLTEX_TRANSP_SUBTRACTIVE:
            v[0] = D3DBLEND_ZERO;
            v[1] = D3DBLEND_INVSRCCOLOR;
            break;
        }
        _rsa_0.SetValue(id[0], v[0]);
        _rsa_0.SetValue(id[1], v[1]);
    }

    // check opacity flag
    if(_opacity != 1.0f)
    {
#if(defined MTLTEXAGENT_OPACITY_RSA_FLAG)
        //RSA_VALUE(&_opacity_rsa_seq[1], D3DRS_TEXTUREFACTOR, D3DCOLOR_ARGB((BYTE)(_opacity * 255), 0, 0, 0));
        //drRenderStateAtomBeginSetRS(dev_obj, &_opacity_rsa_seq[0], 2);
        //drRenderStateAtomBeginSetTSS(0, dev_obj, &_opacity_rsa_seq[2], 3);
        _rsa_opacity.SetStateValue(1, D3DRS_TEXTUREFACTOR, D3DCOLOR_ARGB((BYTE)(_opacity * 255), 0, 0, 0));
        _rsa_opacity.BeginRenderState(dev_obj, 0, 2);
        _rsa_opacity.BeginTextureStageState(dev_obj, 2, 3, 0);
#else
        dev_obj->SetRenderState(D3DRS_ZWRITEENABLE, 0);
        dev_obj->SetRenderState(D3DRS_TEXTUREFACTOR, D3DCOLOR_ARGB((BYTE)(_opacity * 255), 0, 0, 0));
        dev_obj->SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
        dev_obj->SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_TFACTOR);
#endif

        if(_transp_type!= MTLTEX_TRANSP_FILTER)
        {
            drRenderStateAtom* rsa;
            // src, dest
            DWORD id[2] = { DR_INVALID_INDEX, DR_INVALID_INDEX };

            _rsa_0.FindState(&id[0], D3DRS_SRCBLEND);
            _rsa_0.FindState(&id[1], D3DRS_DESTBLEND);

            if(_transp_type == MTLTEX_TRANSP_ADDITIVE)
            {
                if(id[0] != DR_INVALID_INDEX)
                {
                    _rsa_0.GetStateAtom(&rsa, id[0]);
                    _opacity_reserve_rs[0] = rsa->value0;
                    rsa->value0 = D3DBLEND_SRCALPHA;
                    rsa->value1 = D3DBLEND_SRCALPHA;                    
                }
            }
            else if(_transp_type == MTLTEX_TRANSP_SUBTRACTIVE)
            {
                // reserved.
            }
        }
    }

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if((tex = _tex_seq[i]) == NULL)
            break;

        // texture transform image sequence
        if(_tt_tex[i])
        {
            tex = _tt_tex[i];
        }

        if(DR_FAILED(tex->BeginSet()))
            goto __ret;

        // texture transform
        //if(_uvmat[i])
        //{
        //    dev_obj->SetTransform((D3DTRANSFORMSTATETYPE)(D3DTS_TEXTURE0 + i), _uvmat[i]);
        //    dev_obj->SetTextureStageState(i, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_COUNT2);
        //}
    }

    DWORD v = 129;
    drRenderStateAtom* rsa;
    for(DWORD i = 0; i < _rsa_0.GetStateNum(); i++)
    {
        rsa = &_rsa_0.GetStateSeq()[i];

        if(rsa->state == DR_INVALID_INDEX)
            break;

        if(rsa->state == D3DRS_ALPHAREF)
        {
            if(_opacity != 1.0f)
            {
                v = (DWORD)(_opacity * 255) - 1;
                if(v < 0)
                    v = 0;
                if(v > 129)
                    v = 129;
            }

            _rsa_0.SetStateValue(i, D3DRS_ALPHAREF, v);
        }
    }
    _rsa_0.BeginRenderState(dev_obj, 0, RSA_SET_SIZE);

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drMtlTexAgent::EndSet()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();
    drITex* tex;

    // check opacity flag
    if(_opacity != 1.0f)
    {
#if(defined MTLTEXAGENT_OPACITY_RSA_FLAG)
        //drRenderStateAtomEndSetRS(dev_obj, &_opacity_rsa_seq[0], 2);
        //drRenderStateAtomEndSetTSS(0, dev_obj, &_opacity_rsa_seq[2], 3);
        _rsa_opacity.EndRenderState(dev_obj, 0, 2);
        _rsa_opacity.EndTextureStageState(dev_obj, 2, 3, 0);
#else
        dev_obj->SetRenderState(D3DRS_ZWRITEENABLE, 1);
        dev_obj->SetRenderState(D3DRS_TEXTUREFACTOR, D3DCOLOR_ARGB(0xff, 0, 0, 0));
        dev_obj->SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_CURRENT);
        //dev_obj->SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
#endif

        if(_transp_type!= MTLTEX_TRANSP_FILTER)
        {
            if(_opacity_reserve_rs[0] != DR_INVALID_INDEX)
            {
                _rsa_0.ResetStateValue(D3DRS_SRCBLEND, _opacity_reserve_rs[0], 0);
                _opacity_reserve_rs[0] = DR_INVALID_INDEX;
            }
            if(_opacity_reserve_rs[1] != DR_INVALID_INDEX)
            {
                _rsa_0.ResetStateValue(D3DRS_DESTBLEND, _opacity_reserve_rs[1], 0);
                _opacity_reserve_rs[1] = DR_INVALID_INDEX;
            }
        }
    }

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if((tex = _tex_seq[i]) == NULL)
            break;

        if(DR_FAILED(tex->EndSet()))
            goto __ret;

        // texture transform
        //if(_uvmat[i])
        //{
        //    dev_obj->SetTextureStageState(i, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_DISABLE);
        //}

    }

    _rsa_0.EndRenderState(dev_obj, 0, RSA_SET_SIZE);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMtlTexAgent::Clone(drIMtlTexAgent** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drMtlTexAgent* o;

    if(DR_FAILED(_res_mgr->CreateMtlTexAgent(reinterpret_cast< drIMtlTexAgent** >(&o))))
        goto __ret;

    o->_opacity = _opacity;
    o->_transp_type = _transp_type;
    o->_mtl = _mtl;
    o->_rsa_0.Load(_rsa_0.GetStateSeq(), _rsa_0.GetStateNum());

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if(_tex_seq[i])
        {
            o->_tex_seq[i] = _tex_seq[i];
            _res_mgr->AddRefTex(_tex_seq[i], 1);
        }
        if(_uvmat[i])
        {
            o->_uvmat[i] = DR_NEW(drMatrix44);
            *o->_uvmat[i] = *_uvmat[i];
        }
    }
    
    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMtlTexAgent::SetTextureTransformMatrix(DWORD stage, const drMatrix44* mat)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(stage < 0 || stage >= DR_MAX_MTL_TEX_NUM)
        goto __ret;

    if(mat)
    {
        if(_uvmat[stage] == NULL)
        {
            _uvmat[stage] = DR_NEW(drMatrix44);
        }
        *_uvmat[stage] = *mat;
    }
    else
    {
        DR_SAFE_DELETE(_uvmat[stage]);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drMtlTexAgent::SetTextureTransformImage(DWORD stage, drITex* tex)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(stage < 0 || stage >= DR_MAX_MTL_TEX_NUM)
        goto __ret;

    _tt_tex[stage] = tex;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMtlTexAgent::SetTextureLOD(DWORD level)
{
    drITex* tex;

    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if((tex = _tex_seq[i]) == NULL)
            break;
        
        tex->SetLOD(level);
    }

    return DR_RET_OK;
}

BOOL drMtlTexAgent::IsTextureLoadingOK() const
{
    BOOL ret = 1;

    drITex* t;
    for(DWORD i = 0; i < DR_MAX_MTL_TEX_NUM; i++)
    {
        if((t = _tex_seq[i]) == NULL)
            break;
        
        if(_tt_tex[i])
        {
            t = _tt_tex[i];
        }

        if((t->GetMTFlag() == 1) && (t->IsLoadingOK() == 0))
            return 0;
    }

    return 1;
}

// drMeshAgent
DR_STD_ILELEMENTATION(drMeshAgent)

drMeshAgent::drMeshAgent(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _mesh_obj(0)
{
    _mt_flag = 0;
    drRenderStateSetTemplate_Construct(&_rs_set);
}
drMeshAgent::~drMeshAgent()
{
    Destroy();
}

// @@
extern DR_RESULT drDumpMeshInfo(const char* file, const drMeshInfo* info);

DR_RESULT drMeshAgent::LoadMesh(const drMeshInfo* info)
{
    //drDumpMeshInfo("ok.txt", info);

    DR_RESULT ret = DR_RET_FAILED;

    drIMesh* obj = 0;
    
    if(DR_FAILED(_res_mgr->CreateMesh(&obj)))
        goto __ret;

    if(_mt_flag == 1)
    {
        if(DR_FAILED(obj->LoadSystemMemoryMT(info)))
            goto __ret;
    }
    else
    {
        if(DR_FAILED(obj->LoadSystemMemory(info)))
            goto __ret;
    }



    if(DR_FAILED(obj->LoadVideoMemoryEx()))
        goto __ret;

    _mesh_obj = obj;

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT drMeshAgent::LoadMesh(const drResFileMesh* info)
{
    __asm { int 3 }

    DR_RESULT ret = DR_RET_FAILED;

    drMeshInfo i;

    if(DR_FAILED(LoadMesh(&i)))
        goto __ret;

    if(DR_FAILED(_mesh_obj->SetResFile(info)))
        goto __ret;


    ret = DR_RET_OK;

__ret:
    return ret;

}

DR_RESULT drMeshAgent::DestroyMesh()
{
    DR_RESULT ret = DR_RET_FAILED;
//
//#if(defined MULTITHREAD_LOADING_MESH)
//
//    while(_mesh_obj->IsLoadingOK() == 0)
//    {
//        ::Sleep(10);
//    }
//#endif

    if(_mesh_obj == 0)
        goto __addr_ret_ok;

    if(DR_FAILED(_mesh_obj->Release()))
        goto __ret;

    _mesh_obj = 0;

__addr_ret_ok:
    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drMeshAgent::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if(DR_FAILED(DestroyMesh()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMeshAgent::Clone(drIMeshAgent** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIMeshAgent* o = NULL;
    
    if(DR_FAILED(_res_mgr->CreateMeshAgent(&o)))
        goto __ret;

    if(_mesh_obj)
    {
        _res_mgr->AddRefMesh(_mesh_obj, 1);
        o->SetMesh(_mesh_obj);
    }

    o->SetRenderState(&_rs_set);

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drMeshAgent::BeginSet()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_mesh_obj->BeginSet()))
        goto __ret;

    drRenderStateValue* rsv;
    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    // render state
    for(DWORD i = 0; i < _rs_set.SEQUENCE_SIZE; i++)
    {
        rsv = &_rs_set.rsv_seq[0][i];

        if(rsv->state == DR_INVALID_INDEX)
            break;

        dev_obj->SetRenderState((D3DRENDERSTATETYPE)rsv->state, rsv->value);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drMeshAgent::EndSet()
{
    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    _mesh_obj->EndSet();

    drRenderStateValue* rsv;

    // render state
    for(DWORD i = 0; i < _rs_set.SEQUENCE_SIZE; i++)
    {
        rsv = &_rs_set.rsv_seq[1][i];

        if(rsv->state == DR_INVALID_INDEX)
            break;

        dev_obj->SetRenderState((D3DRENDERSTATETYPE)rsv->state, rsv->value);
    }

    return DR_RET_OK;
}

DR_RESULT drMeshAgent::DrawSubset(DWORD subset)
{
    return _mesh_obj->DrawSubset(subset);
}



// drResBufMgr
DR_STD_ILELEMENTATION(drResBufMgr)

drResBufMgr::drResBufMgr(drIResourceMgr* res_mgr)
:_res_mgr(res_mgr)
{
    _lock_sysmemtex.Create();

    _modelobj_data_size = 0;
    _sysmemtex_data_size = 0;

    _lmt_modelobj_data_size = 0xffffffff;
    _lmt_modelobj_data_time = 0;
}
drResBufMgr::~drResBufMgr()
{
    Destroy();

    _lock_sysmemtex.Destroy();
}

DR_RESULT drResBufMgr::Destroy()
{
    DWORD obj_num;

    // sys_mem_tex
    obj_num = _pool_sysmemtex.POOL_SIZE;
    for(DWORD i = 0; i < obj_num; i++)
    {
        UnregisterSysMemTex(i);
    }
    _pool_sysmemtex.Clear();

    // model_obj
    obj_num = _pool_modelobj.POOL_SIZE;
    for(DWORD i = 0; i < obj_num; i++)
    {
        UnregisterModelObjInfo(i);
    }
    _pool_modelobj.Clear();


    return DR_RET_OK;
}
DR_RESULT drResBufMgr::RegisterSysMemTex(DR_HANDLE* handle, const drSysMemTexInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _res_mgr->GetDeviceObject();

    drSysMemTexInfo* o = DR_NEW(drSysMemTexInfo);
    memset(o, 0, sizeof(drSysMemTexInfo));

#if(defined USE_D3DX_LOAD_TEXTURE_UPDATETEXTURE)

    IDirect3DTextureX* tex;

    if(FAILED(D3DXCreateTextureFromFileEx(dev_obj->GetDevice(),
        info->file_name, //文件名
        0, //文件宽，这里设为自动
        0, //文件高，这里设为自动
        info->level, //需要多少级mipmap，这里设为1
        0, //此纹理的用途
        (D3DFORMAT)info->format, //自动检测文件格式
        D3DPOOL_SYSTEMMEM,//forced
        info->filter, //D3DX_FILTER_TRIANGLE|D3DX_FILTER_MIRROR, //纹理过滤方法
        info->mip_filter,//D3DX_DEFAULT,//D3DX_FILTER_NONE, //mipmap纹理过滤方法
        info->colorkey,//0xffff00ff, //透明色颜色
        NULL, //读出的图像格式存储在何变量中
        NULL, //读出的调色板存储在何变量中
        &tex)))//要创建的纹理
    {
        goto __ret;
    }

    D3DSURFACE_DESC desc;
    tex->GetLevelDesc(0, &desc);

    o->colorkey = info->colorkey;
    o->format = info->format;
    o->filter = info->filter;
    o->mip_filter = info->mip_filter;
    o->level = info->level;
    _tcsncpy_s(o->file_name, info->file_name);
    o->usage = 0;
    o->sys_mem_tex = tex;
    o->width = desc.Width;
    o->height = desc.Height;
#endif

#if(defined USE_D3DX_LOAD_TEXTURE_CREATEFROMMEMORY)


    drGUIDCreateObject((DR_VOID**)&o->buf, DR_GUID_BUFFER);
    if(DR_FAILED(LoadFileInMemory(o->buf, info->file_name, "rb")))
        goto __ret;

    if(_res_mgr->GetByteSet()->GetValue(OPT_RESMGR_TEXENCODE))
    {
        drTexEncode te;
        te.Decode(o->buf);
    }

    o->colorkey = info->colorkey;
    o->format = info->format;
    o->filter = info->filter;
    o->mip_filter = info->mip_filter;
    o->level = info->level;
    _tcsncpy_s(o->file_name, info->file_name, _TRUNCATE);
    o->usage = 0;

#endif

//#if(defined MULTITHREAD_LOADING_TEXTURE)
//    // critical section
//    drIThreadPoolMgr* tp_mgr = _res_mgr->GetThreadPoolMgr();
//    tp_mgr->LockCriticalSection(CRITICALSECTION_LOCK_SYSMEMTEX);
//
//    if(DR_FAILED(_pool_sysmemtex.Register(handle, o)))
//    {
//        tp_mgr->UnlockCriticalSection(CRITICALSECTION_LOCK_SYSMEMTEX);
//        goto __ret;
//    }
//
//    tp_mgr->UnlockCriticalSection(CRITICALSECTION_LOCK_SYSMEMTEX);
//#else
//    if(DR_FAILED(_pool_sysmemtex.Register(handle, o)))
//        goto __ret;
//#endif

    {
        _lock_sysmemtex.Lock();

        if(DR_FAILED(_pool_sysmemtex.Register(handle, o)))
        {
            _lock_sysmemtex.Unlock();
            goto __ret;
        }

        _lock_sysmemtex.Unlock();
    }

    o = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(o);
    return ret;

}
DR_RESULT drResBufMgr::QuerySysMemTex(drSysMemTexInfo** info, const char* file)
{
    drSysMemTexInfo* obj = 0;
    DWORD obj_num = _pool_sysmemtex.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_sysmemtex.GetObj((void**)&obj, i)))
            continue;

        obj_num -= 1;

        if(_tcscmp(obj->file_name, file) == 0)
        {
            *info = obj;
            return DR_RET_OK;
        }

    }

    return DR_RET_FAILED;

}

DR_RESULT drResBufMgr::QuerySysMemTex(drSysMemTexInfo* info)
{
    drSysMemTexInfo* obj = 0;
    DWORD obj_num = _pool_sysmemtex.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_sysmemtex.GetObj((void**)&obj, i)))
            continue;

        obj_num -= 1;

        if(_tcscmp(obj->file_name, info->file_name) == 0
            && obj->format == info->format
            && obj->level == info->level
            && obj->colorkey == info->colorkey)
        {
            *info = *obj;
            return DR_RET_OK;
        }

    }

    return DR_RET_FAILED;
}
DR_RESULT drResBufMgr::GetSysMemTex(drSysMemTexInfo** info, DR_HANDLE handle)
{
    return _pool_sysmemtex.GetObj((void**)info, handle);
}
DR_RESULT drResBufMgr::UnregisterSysMemTex(DR_HANDLE handle)
{
    drSysMemTexInfo* obj = 0;
    if(DR_FAILED(_pool_sysmemtex.Unregister((void**)&obj, handle)))
        return DR_RET_FAILED;

    DR_IF_RELEASE(obj->sys_mem_tex);

    DR_IF_RELEASE(obj->buf);
    DR_DELETE(obj);

    return DR_RET_OK;
}

DR_RESULT drResBufMgr::RegisterModelObjInfo(DR_HANDLE* handle, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    drModelObjInfoMap* moim = DR_NEW(drModelObjInfoMap);
    
    if(DR_FAILED(moim->info.Load(file)))
        goto __ret;

    //int x = sizeof(moim->info.helper_data);
    //x = sizeof(moim->info.geom_obj_seq[0]->anim_data);
    //x = sizeof(moim->info.geom_obj_seq[0]->mtl_seq);
    //x = sizeof(moim->info.geom_obj_seq[0]->mesh);
    //x = sizeof(drAnimDataTexUV);
    //x = sizeof(drAnimDataBone);
    //x = sizeof(moim->info.geom_obj_seq[0]->anim_data.anim_img);
    //x = sizeof(moim->info.geom_obj_seq[0]->anim_data.anim_tex);

    if(DR_FAILED(_pool_modelobj.Register(handle, moim)))
        goto __ret;

    drITimer* tm = 0;
    _res_mgr->GetSysGraphics()->GetSystem()->GetInterface((DR_VOID**)&tm, DR_GUID_TIMER);    
    moim->hit_time = tm->GetTickCount();

    moim->size = moim->info.GetDataSize();
    _tcsncpy_s(moim->file, file, _TRUNCATE );

    _modelobj_data_size += moim->size;

    moim = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(moim);
    return ret;
}
DR_RESULT drResBufMgr::RegisterModelObjInfo(DR_HANDLE handle, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    drModelObjInfoMap* moim = DR_NEW(drModelObjInfoMap);
    
    if(DR_FAILED(moim->info.Load(file)))
        goto __ret;

    if(DR_FAILED(_pool_modelobj.Register(moim, handle)))
        goto __ret;

    drITimer* tm = 0;
    _res_mgr->GetSysGraphics()->GetSystem()->GetInterface((DR_VOID**)&tm, DR_GUID_TIMER);    
    moim->hit_time = tm->GetTickCount();

    moim->size = moim->info.GetDataSize();
    _tcsncpy_s(moim->file, file, _TRUNCATE );

    _modelobj_data_size += moim->size;

    moim = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(moim);
    return ret;

}

DR_RESULT drResBufMgr::QueryModelObjInfo(drIModelObjInfo** info, const char* file)
{
    drModelObjInfoMap* obj = 0;
    DWORD obj_num = _pool_modelobj.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_modelobj.GetObj((void**)&obj, i)))
            continue;

        obj_num -= 1;

        if(_tcscmp(obj->file, file) == 0)
        {
            *info = &obj->info;
            return DR_RET_OK;
        }

    }

    return DR_RET_FAILED;

}
DR_RESULT drResBufMgr::GetModelObjInfo(drIModelObjInfo** info, DR_HANDLE handle)
{
    drModelObjInfoMap* obj = 0;
    DR_RESULT ret = _pool_modelobj.GetObj((void**)&obj, handle);
    if(DR_SUCCEEDED(ret))
    {
        *info = &obj->info;
    }
    return ret;
}
DR_RESULT drResBufMgr::UnregisterModelObjInfo(DR_HANDLE handle)
{
    drModelObjInfoMap* obj = 0;
    if(DR_FAILED(_pool_modelobj.Unregister((void**)&obj, handle)))
        return DR_RET_FAILED;

    _modelobj_data_size -= obj->size;

    DR_DELETE(obj);
    return DR_RET_OK;
}

DR_RESULT drResBufMgr::FilterModelObjInfoSize()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_lmt_modelobj_data_size >= _modelobj_data_size)
        goto __ret_ok;

    drITimer* tm = 0;
    _res_mgr->GetSysGraphics()->GetSystem()->GetInterface((DR_VOID**)&tm, DR_GUID_TIMER);    

    DWORD this_time = tm->GetTickCount();

    drModelObjInfoMap* obj;
    DWORD num = _pool_modelobj.GetObjNum();
    for(DWORD i = 0; num > 0; i++)
    {
        if(DR_FAILED(_pool_modelobj.GetObj((void**)&obj, i)))
            continue;

        if((this_time - obj->hit_time) > _lmt_modelobj_data_time)
        {
            if(DR_FAILED(UnregisterModelObjInfo(i)))
                goto __ret;
        }

        num -= 1;
    }
    
__ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

// drThreadPoolMgr
DR_STD_ILELEMENTATION(drThreadPoolMgr)

drThreadPoolMgr::drThreadPoolMgr()
{
    memset(_pool_seq, 0, sizeof(_pool_seq));
}

drThreadPoolMgr::~drThreadPoolMgr()
{
    Destroy();
}

DR_RESULT drThreadPoolMgr::Create()
{
    DR_RESULT ret = DR_RET_FAILED;


    DWORD ci[THREAD_POOL_SIZE][2] =
    {
        { 2, 1024 },
		//{ 2, 1024 },
    };

    for(DWORD i = 0; i < THREAD_POOL_SIZE; i++)
    {
        if(DR_FAILED(drGUIDCreateObject((DR_VOID**)&_pool_seq[i], DR_GUID_THREADPOOL)))
            goto __ret;

        if(DR_FAILED(_pool_seq[i]->Create(ci[i][0], ci[i][1], 0)))
            goto __ret;

        for(DWORD j = 0; j < ci[i][0]; j++)
        {
            DWORD id = ((drThreadPool*)_pool_seq[i])->GetThreadId(j);
//          LG("threadid", "%d:%s\n", id, "LightEngine::LoadResource Thread");
        }
    }

    _pool_seq[THREAD_POOL_LOADRES]->SetPriority(THREAD_PRIORITY_NORMAL);

    for(DWORD i = 0; i < CRITICALSECTION_SEQ_SIZE; i++)
    {
        ::InitializeCriticalSection(&_cs_seq[i]);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drThreadPoolMgr::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < THREAD_POOL_SIZE; i++)
    {
        if(_pool_seq[i] == 0)
            continue;

        if(DR_FAILED(_pool_seq[i]->Destroy()))
            goto __ret;

        _pool_seq[i]->Release();
    }

    for(DWORD i = 0; i < CRITICALSECTION_SEQ_SIZE; i++)
    {
        ::DeleteCriticalSection(&_cs_seq[i]);
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}

// drResourceMgr
DR_STD_ILELEMENTATION(drResourceMgr)

drResourceMgr::drResourceMgr(drISysGraphics* sys)
: _sys_graphics(sys), _mesh_size_sm(0), _mesh_size_vm(0), _tex_size_sm(0), _tex_size_vm(0),
  _shader_mgr(0), _thread_pool_mgr(0)
{

    _dev_obj = _sys_graphics->GetDeviceObject();

    _static_stream_mgr = DR_NEW(drStaticStreamMgr(_dev_obj));
    _dynamic_stream_mgr = DR_NEW(drDynamicStreamMgr(_dev_obj));
    _lockable_stream_mgr = DR_NEW(drLockableStreamMgr(this));
    _surface_stream_mgr = DR_NEW(drSurfaceStreamMgr(this));

    _shader_mgr = DR_NEW(drShaderMgr(_dev_obj));

#if(defined DR_USE_DX8)
    _shader_mgr->Init(1024, 0);
#elif(defined DR_USE_DX9)
    _shader_mgr->Init(1024, 1024, 0);
#endif

    _resbuf_mgr = DR_NEW(drResBufMgr(this));

//#if(defined MULTITHREAD_LOADING_TEXTURE || defined MULTITHREAD_LOADING_MESH)
    _thread_pool_mgr = DR_NEW(drThreadPoolMgr());
    _thread_pool_mgr->Create();
//#endif

    {
        memset(_render_ctrl_proc_seq, 0, sizeof(_render_ctrl_proc_seq));
        drInitInternalRenderCtrlVSProc(this);
    }

    _texture_path[0] = '\0';

    { // mutithread loading res option flag
        _byte_set.Alloc(OPT_RESMGR_BYTESET_SIZE);
        _byte_set.SetValue(OPT_RESMGR_LOADTEXTURE_MT, 0);
        _byte_set.SetValue(OPT_RESMGR_LOADMESH_MT, 0);
        _byte_set.SetValue(OPT_RESMGR_TEXENCODE, 0);        
        _byte_set.SetValue(OPT_CREATE_ASSISTANTOBJECT, 0);
    }

    { // init assistant object info data
        _assobj_info.color = 0xffffffff;
        _assobj_info.size = drVector3(1.0f, 1.0f, 1.0f);
    }

#if(defined USE_TEXLOG_MGR)
    _texlog_mgr.OpenLogFile(".\\log\\tex.log");
    _texlog_mgr.AddTexType("scene");
    _texlog_mgr.AddTexType("character");
    _texlog_mgr.AddTexType("item");
    _texlog_mgr.AddTexType("ui");
    _texlog_mgr.AddTexType("terrain");
    _texlog_mgr.AddTexType("effect");
    _texlog_mgr.AddTexType("minimap");
	//_texlog_mgr.AddTexType("bone");
#endif

}

drResourceMgr::~drResourceMgr()
{
    ReleaseObject();

    ClearAllMesh();
    ClearAllTex();
    ClearAllAnimCtrl();

    DR_IF_RELEASE(_static_stream_mgr);
    DR_IF_RELEASE(_dynamic_stream_mgr);
    DR_IF_RELEASE(_lockable_stream_mgr);
    DR_IF_RELEASE(_surface_stream_mgr);
    DR_IF_RELEASE(_shader_mgr);
    DR_IF_RELEASE(_resbuf_mgr);
    DR_IF_RELEASE(_thread_pool_mgr);

	for( ColorFilterPairTextureList::iterator i = mColorFilterTextureList.begin();
		 i != mColorFilterTextureList.end(); ++i )
	{
		if( i->second )
		{
			i->second->Release();
		}
	}
    //
}

// attributes method
DR_RESULT drResourceMgr::GetAssObjInfo(drAssObjInfo* info) 
{ 
    if(info)
    {
        *info = _assobj_info;
    }
    return DR_RET_OK;
}

DR_RESULT drResourceMgr::SetAssObjInfo(DWORD mask, const drAssObjInfo* info)
{
    if(info)
    {
        if(mask & ASSOBJ_MASK_SIZE)
        {
            _assobj_info.size = info->size;
        }
        if(mask & ASSOBJ_MASK_COLOR)
        {
            _assobj_info.color = info->color;
        }
    }
    return DR_RET_OK;
}

DR_RESULT drResourceMgr::ClearAllMesh()
{
    DWORD obj_num = _pool_mesh.GetObjNum();

    drIMesh* obj;

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(_pool_mesh.GetRef(i) > 0)
        {            
            _pool_mesh.GetObj((void**)&obj, i);
            DR_RELEASE(obj);
            //UnregisterMesh(obj);
            obj_num -= 1;
        }
    }

    return DR_RET_OK;
}
DR_RESULT drResourceMgr::ClearAllTex()
{
    DWORD obj_num = _pool_tex.GetObjNum();

    drITex* obj;
    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(_pool_tex.GetRef(i) > 0)
        {
            _pool_tex.GetObj((void**)&obj, i);
            DR_RELEASE(obj);
            //UnregisterTex(obj);
            obj_num -= 1;
        }
    }

    return DR_RET_OK;
}

DR_RESULT drResourceMgr::ClearAllAnimCtrl()
{
    DWORD obj_num = _pool_animctrl.GetObjNum();

    drIAnimCtrl* obj;
    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(_pool_animctrl.GetRef(i) > 0)
        {
            _pool_animctrl.GetObj((void**)&obj, i);
            obj->Release();
            //UnregisterAnimCtrl(obj);
            obj_num -= 1;
        }
    }

    return DR_RET_OK;
}

DR_RESULT drResourceMgr::CreateMesh(drIMesh** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIMesh* o = NULL;
    
    if((o = DR_NEW(drMesh(this))) == NULL)
        goto __ret;

    if(DR_FAILED(RegisterMesh(o)))
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drResourceMgr::CreateTex(drITex** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drITex* o = NULL;
    
    if((o = DR_NEW(drTex(this))) == NULL)
        goto __ret;

    if(DR_FAILED(RegisterTex(o)))
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drResourceMgr::CreateAnimCtrl(drIAnimCtrl** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrl* c;

    switch(type)
    {
    case ANIM_CTRL_TYPE_BONE:
        c = DR_NEW(drAnimCtrlBone(this));
        break;
    case ANIM_CTRL_TYPE_MAT:
        c = DR_NEW(drAnimCtrlMatrix(this));
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        c = DR_NEW(drAnimCtrlTexUV(this));
        break;
    case ANIM_CTRL_TYPE_TEXIMG:
        c = DR_NEW(drAnimCtrlTexImg(this));
        break;
    case ANIM_CTRL_TYPE_MTLOPACITY:
        c = DR_NEW(drAnimCtrlMtlOpacity(this));
        break;
    default:
        assert(0 && "invalid ctrl type in call RegisterAnimData");
    }

     if(DR_FAILED(RegisterAnimCtrl(c)))
         goto __ret;

    *ret_obj = c;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateAnimCtrlObj(drIAnimCtrlObj** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    //drIAnimCtrl* c = NULL;
    drIAnimCtrlObj* o = NULL;
    
    //if(DR_FAILED(CreateAnimCtrl(&c, type)))
    //    goto __ret;

    switch(type)
    {
    case ANIM_CTRL_TYPE_MAT:
        o = DR_NEW(drAnimCtrlObjMat(this));
        break;
    case ANIM_CTRL_TYPE_BONE:
        o = DR_NEW(drAnimCtrlObjBone(this));
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        o = DR_NEW(drAnimCtrlObjTexUV(this));
        break;
    case ANIM_CTRL_TYPE_TEXIMG:
        o = DR_NEW(drAnimCtrlObjTexImg(this));
        break;
    case ANIM_CTRL_TYPE_MTLOPACITY:
        o = DR_NEW(drAnimCtrlObjMtlOpacity(this));
        break;
    default:
        assert(0 && "invalid ctrl type in call RegisterAnimData");
        goto __ret;
    }

    //o->SetAnimCtrl(c);
    *ret_obj = o;
    
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateMeshAgent(drIMeshAgent** ret_obj)
{
    *ret_obj = DR_NEW(drMeshAgent(this));
	return (*ret_obj)==NULL ? DR_RET_FAILED : DR_RET_OK;
}
/*---------------------------------------------------------------------------
   下面3个函数修改后，能产生更快速的汇编代码 by Waiting
   但实际上，仍然不满意，如果这些函数是inline，可以省去开堆栈的时间
---------------------------------------------------------------------------*/
DR_RESULT drResourceMgr::CreateMtlTexAgent(drIMtlTexAgent** ret_obj)
{
	*ret_obj = DR_NEW(drMtlTexAgent(this));
    return (*ret_obj)==NULL ? DR_RET_FAILED : DR_RET_OK;
}
DR_RESULT drResourceMgr::CreateRenderCtrlAgent(drIRenderCtrlAgent** ret_obj)
{
    *ret_obj = DR_NEW(drRenderCtrlAgent(this));
    return (*ret_obj)==NULL ? DR_RET_FAILED : DR_RET_OK;
}

DR_RESULT drResourceMgr::CreateAnimCtrlAgent(drIAnimCtrlAgent** ret_obj)
{
    *ret_obj = DR_NEW(drAnimCtrlAgent(this));
	return (*ret_obj)==NULL ? DR_RET_FAILED : DR_RET_OK;
}

DR_RESULT drResourceMgr::CreateRenderCtrlVS(drIRenderCtrlVS** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrlVS* o = 0;

    if(_render_ctrl_proc_seq[type] == NULL)
        goto __ret;

    o = _render_ctrl_proc_seq[type]();
    if(o == 0)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreatePrimitive(drIPrimitive** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drPrimitive* o = NULL;
    
    if((o = DR_NEW(drPrimitive(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;


}
DR_RESULT drResourceMgr::CreateHelperObject(drIHelperObject** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drHelperObject* o = NULL;
    
    if((o = DR_NEW(drHelperObject(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drResourceMgr::CreatePhysique(drIPhysique** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIPhysique* o = NULL;
    
    if((o = DR_NEW(drPhysique(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateModel(drIModel** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIModel* o = NULL;
    
    if((o = DR_NEW(drModel(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateItem(drIItem** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIItem* o = NULL;
    
    if((o = DR_NEW(drItem(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateNode(drINode** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    drINode* o = 0;

    switch(type)
    {
    case NODE_PRIMITIVE:
        o = DR_NEW(drNodePrimitive(this));
        break;
    case NODE_BONECTRL:
        o = DR_NEW(drNodeBoneCtrl(this));
        break;
    case NODE_DUMMY:
        o = DR_NEW(drNodeDummy(this));
        break;
    case NODE_HELPER:
        o = DR_NEW(drNodeHelper(this));
    default:
        goto __ret;
    }

    if(o == 0)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateNodeObject(drINodeObject** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drINodeObject* o = NULL;
    
    if((o = DR_NEW(drNodeObject(this))) == NULL)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drResourceMgr::CreateStaticStreamMgr(drIStaticStreamMgr** mgr)
{
    *mgr = DR_NEW(drStaticStreamMgr(_dev_obj));
    return DR_RET_OK;
}
DR_RESULT drResourceMgr::CreateDynamicStreamMgr(drIDynamicStreamMgr** mgr)
{
    *mgr = DR_NEW(drDynamicStreamMgr(_dev_obj));
    return DR_RET_OK;
}

DR_RESULT drResourceMgr::RegisterMesh(drIMesh* obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD ret_id;

    if(DR_FAILED(_pool_mesh.Register(&ret_id, obj)))
        goto __ret;

    obj->SetRegisterID(ret_id);

    ret = DR_RET_OK;

__ret:

    return ret;

}

DR_RESULT drResourceMgr::RegisterTex(drITex* obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD ret_id;

    if(DR_FAILED(_pool_tex.Register(&ret_id, obj)))
        goto __ret;

    obj->SetRegisterID(ret_id);

    _tex_size_vm += obj->GetDataInfo()->size;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drResourceMgr::RegisterAnimCtrl(drIAnimCtrl* obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD ret_id;

    if(DR_FAILED(_pool_animctrl.Register(&ret_id, obj)))
        goto __ret;

    obj->SetRegisterID(ret_id);

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drResourceMgr::RegisterRenderCtrlProc(DWORD id, drRenderCtrlVSCreateProc proc)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id < 0 || id >= DR_RENDER_CTRL_PROC_NUM)
        goto __ret;

    if(_render_ctrl_proc_seq[id])
        goto __ret;

    _render_ctrl_proc_seq[id] = proc;

    ret = DR_RET_OK;

__ret:
    return ret;
}

//DR_RESULT drResourceMgr::RegisterAnimData(DWORD* ret_id, const void* data, DWORD anim_type)
//{
//    DR_RESULT ret = DR_RET_FAILED;
//
//    drAnimCtrl* ctrl;
//
//    switch(anim_type)
//    {
//    case ANIM_CTRL_TYPE_BONE:
//        ctrl = DR_NEW(drAnimCtrlBone);
//        ((drAnimCtrlBone*)ctrl)->Create((drAnimDataBone*)data);
//        break;
//    case ANIM_CTRL_TYPE_MATRIX:
//        ctrl = DR_NEW(drAnimCtrlMatrix);
//        ((drAnimCtrlMatrix*)ctrl)->Create((drAnimDataMatrix*)data);
//        break;
//    case ANIM_CTRL_TYPE_TEXTURE0:
//    case ANIM_CTRL_TYPE_TEXTURE1:
//    case ANIM_CTRL_TYPE_TEXTURE2:
//    case ANIM_CTRL_TYPE_TEXTURE3:
//        ctrl = DR_NEW(drAnimCtrlTexUV);
//        ((drAnimCtrlTexUV*)ctrl)->Create((drAnimDataTexUV*)data);
//        break;
//    case ANIM_CTRL_TYPE_IMAGE0:
//        break;
//    default:
//        assert(0 && "invalid ctrl type in call RegisterAnimData");
//    }
//
//    ret = _pool_animctrl.Register(ret_id, (void*)ctrl);
// 
//    return ret;
//
//}
//
//DR_RESULT drResourceMgr::RegisterAnimData(DWORD* ret_id, const drResFileAnimData* info)
//{
//    DR_RESULT ret = DR_RET_FAILED;
//
//    drAnimCtrl* ctrl;
//
//    switch(info->anim_type)
//    {
//    case ANIM_CTRL_TYPE_BONE:
//        ctrl = DR_NEW(drAnimCtrlBone);
//        break;
//    case ANIM_CTRL_TYPE_MATRIX:
//        ctrl = DR_NEW(drAnimCtrlMatrix);
//        break;
//    case ANIM_CTRL_TYPE_TEXTURE0:
//        ctrl = DR_NEW(drAnimCtrlTexUV);
//        break;
//    case ANIM_CTRL_TYPE_IMAGE0:
//        break;
//    default:
//        assert(0 && "invalid ctrl type in call RegisterAnimData");
//    }
//
//    ctrl->SetResFile(info);
//    
//    if(DR_FAILED(ctrl->LoadResFileData()))
//        goto __ret;
//
//    ret = _pool_animctrl.Register(ret_id, (void*)ctrl);
// 
//__ret:
//    return ret;
//}
//
DR_RESULT drResourceMgr::QueryTex(DWORD* ret_id, const char* file_name)
{
    DWORD i;
    DWORD obj_num;
    drTex* obj_tex;

    obj_num = _pool_tex.GetObjNum();

    for(i = 0;  obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_tex.GetObj((void**)&obj_tex, i)))
        {
            if(_tcscmp(obj_tex->GetFileName(), file_name) == 0)
                break;

            obj_num -= 1;
        }
    }

    if(obj_num > 0)
    {
        *ret_id = i;
        return DR_RET_OK;
    }

    return DR_RET_FAILED;
}

DR_RESULT drResourceMgr::QueryMesh(DWORD* ret_id, const drResFileMesh* rfm)
{
    DWORD i;
    DWORD obj_num;
    drMesh* obj;
    
    obj_num = _pool_mesh.GetObjNum();

    for(i = 0;  obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_mesh.GetObj((void**)&obj, i)))
        {
			try
			{
            if((obj->GetState() & RES_STATE_INIT) && (obj->GetResFileMesh()->Compare(rfm) == 1))
                break;
			}
			catch(...)
			{
				__asm int 3;
			}
            obj_num -= 1;
        }
    }

    if(obj_num > 0)
    {
        *ret_id = i;
        return DR_RET_OK;
    }

    return DR_RET_FAILED;
}

DR_RESULT drResourceMgr::QueryAnimCtrl(DWORD* ret_id, const drResFileAnimData* info)
{
    DWORD i;
    DWORD obj_num;
    drIAnimCtrl* obj;
    drResFileAnimData* r;

    obj_num = _pool_animctrl.GetObjNum();

    for(i = 0;  obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_animctrl.GetObj((void**)&obj, i)))
        {
            obj_num -= 1;

            r = obj->GetResFileInfo();
            if(r->res_type == RES_FILE_TYPE_INVALID)
                continue;

            if(r->Compare(info) == 1)
                break;

        }
    }

    if(obj_num > 0)
    {
        *ret_id = i;
        return DR_RET_OK;
    }

    return DR_RET_FAILED;
}

DR_RESULT drResourceMgr::UnregisterMesh(drIMesh* obj)
{
    DR_RESULT ret = DR_RET_FAILED;
    drMesh* o;

    if(DR_FAILED(ret = _pool_mesh.Unregister((void**)&o, obj->GetRegisterID())))
        goto __ret;

    if(ret == DR_RET_OK_1)
    {
        obj->SetRegisterID(DR_INVALID_INDEX);
    }

    //if(ret == DR_RET_OK_1)
    //{
    //    obj->Unload();
    //    obj->Release();
    //}

__ret:
    return ret;
}
DR_RESULT drResourceMgr::UnregisterTex(drITex* obj)
{
    DR_RESULT ret = DR_RET_FAILED;
    drITex* o;

    if(DR_FAILED(ret = _pool_tex.Unregister((void**)&o, obj->GetRegisterID())))
        goto __ret;

    if(ret == DR_RET_OK_1)
    {
        obj->SetRegisterID(DR_INVALID_INDEX);
    }

    //if(ret == DR_RET_OK_1)
    //{
    //    _tex_size_vm -= (obj->GetDataInfo()->size);

    //    obj->Unload();
    //    obj->Release();
    //}

__ret:
    return ret;
}
DR_RESULT drResourceMgr::UnregisterAnimCtrl(drIAnimCtrl* obj)
{
    DR_RESULT ret = DR_RET_FAILED;
    drAnimCtrl* o;

    if(DR_FAILED(ret =_pool_animctrl.Unregister((void**)&o, obj->GetRegisterID())))
        goto __ret;

    if(ret == DR_RET_OK_1)
    {
        obj->SetRegisterID(DR_INVALID_INDEX);
    }

    //if(ret == DR_RET_OK_1)
    //{               
    //    obj->Release();
    //}

__ret:
    return ret;
}


DR_RESULT drResourceMgr::AddRefMesh(drIMesh* obj, DWORD ref_cnt)
{
    return _pool_mesh.AddRef(obj->GetRegisterID(), ref_cnt);
}
DR_RESULT drResourceMgr::AddRefTex(drITex* obj, DWORD ref_cnt)
{
    return _pool_tex.AddRef(obj->GetRegisterID(), ref_cnt);
}
DR_RESULT drResourceMgr::AddRefAnimCtrl(drIAnimCtrl* obj, DWORD ref_cnt)
{
    return _pool_animctrl.AddRef(obj->GetRegisterID(), ref_cnt);
}

DR_ULONG drResourceMgr::QueryTexRefCnt(drITex* obj)
{
    DWORD id = obj->GetRegisterID();
    if(id == DR_INVALID_INDEX)
        return 0;

    return _pool_tex.GetRef(id);
}

DR_RESULT drResourceMgr::GetMesh(drIMesh** ret_obj, DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;
    drMesh* o;

    if(DR_FAILED(ret = _pool_mesh.GetObj((void**)&o, id)))
        goto __ret;

    *ret_obj = static_cast< drIMesh* >(o);

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT drResourceMgr::GetTex(drITex** ret_obj, DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;
    drTex* o;

    if(DR_FAILED(ret = _pool_tex.GetObj((void**)&o, id)))
        goto __ret;

    *ret_obj = static_cast< drITex* >(o);

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drResourceMgr::GetAnimCtrl(drIAnimCtrl** ret_obj, DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;
    drIAnimCtrl* o;

    if(DR_FAILED(ret = _pool_animctrl.GetObj((void**)&o, id)))
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;

__ret:
    return ret;
}

void drResourceMgr::ReleaseObject()
{
    DWORD i;
    DWORD obj_num;

    // model object
    drModel* obj_model;
    obj_num = _pool_model.GetObjNum();

    for(i = 0;  obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_model.GetObj((void**)&obj_model, i)))
        {
            obj_model->Release();
            obj_num -= 1;
        }
    }
}

DR_RESULT drResourceMgr::RegisterObject(DWORD* ret_id, void* obj, DWORD type)
{

    drObjectPoolVoidPtr1024* pool_obj;
    
    switch(type)
    {
    case OBJ_TYPE_MODEL:
        return _pool_model.Register(ret_id, obj);
        break;
    case OBJ_TYPE_CHARACTER:
        pool_obj = &_pool_physique;
        break;
    case OBJ_TYPE_ITEM:
        pool_obj = &_pool_item;
        break;
    default:
        assert(0 && "invaild type");
    }

    return pool_obj->Register(ret_id, obj);
}

DR_RESULT drResourceMgr::UnregisterObject(void** ret_obj, DWORD id, DWORD type)
{
    drObjectPoolVoidPtr1024* pool_obj;
    
    switch(type)
    {
    case OBJ_TYPE_MODEL:
        return _pool_model.Unregister(ret_obj, id);
        break;
    case OBJ_TYPE_CHARACTER:
        pool_obj = &_pool_physique;
        break;
    case OBJ_TYPE_ITEM:
        pool_obj = &_pool_item;
        break;
    default:
        assert(0 && "invaild type");
    }

    return pool_obj->Unregister(ret_obj, id);
}

DR_RESULT drResourceMgr::QueryModelObject(void** ret_obj, DWORD model_id)
{
    DWORD i;
    DWORD obj_num;
    drModel* obj_model;    
    

    obj_num = _pool_model.GetObjNum();

    for(i = 0;  obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_model.GetObj((void**)&obj_model, i)))
        {
            if(obj_model->GetModelID() == model_id)
                break;

            obj_num -= 1;
        }
    }

    if(obj_num > 0)
    {
        *ret_obj = (void*)obj_model;
    }


    return DR_RET_OK;

}

DR_RESULT drResourceMgr::QueryObject(void** ret_obj, DWORD type, const char* file_name)
{
    DWORD i;
    DWORD obj_num;
    drModel* obj_model;    
    
    switch(type)
    {
    case OBJ_TYPE_MODEL:

        obj_num = _pool_model.GetObjNum();

        for(i = 0;  obj_num > 0; i++)
        {
            if(DR_SUCCEEDED(_pool_model.GetObj((void**)&obj_model, i)))
            {
                if(_tcscmp(obj_model->GetFileName(), file_name) == 0)
                    break;

                obj_num -= 1;
            }
        }

        if(obj_num > 0)
        {
            *ret_obj = (void*)obj_model;
        }

        break;
    case OBJ_TYPE_CHARACTER:

        break;
    case OBJ_TYPE_ITEM:

        break;
    default:
        assert(0 && "invaild type");
    }

    return DR_RET_OK;
}

DR_RESULT drResourceMgr::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;
    DWORD obj_num;
    drIMesh* mesh_obj;
    drITex* tex_obj;
    
    // mesh object
    obj_num = _pool_mesh.GetObjNum();
    for(i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_mesh.GetObj((void**)&mesh_obj, i)))
            continue;

        mesh_obj->LoseDevice();
        obj_num -= 1;
    }

    // texture object
    obj_num = _pool_tex.GetObjNum();
    for(i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_tex.GetObj((void**)&tex_obj, i)))
            continue;

        tex_obj->LoseDevice();
        obj_num -= 1;
    }

    // stream manager object
    if(DR_FAILED(_static_stream_mgr->LoseDevice()))
        goto __ret;

    if(DR_FAILED(_dynamic_stream_mgr->LoseDevice()))
        goto __ret;

    if(DR_FAILED(_lockable_stream_mgr->LoseDevice()))
        goto __ret;

    if(DR_FAILED(_surface_stream_mgr->LoseDevice()))
        goto __ret;

    // shader manager object
    if(DR_FAILED(_shader_mgr->LoseDevice()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drResourceMgr::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;
    DWORD obj_num;
    drIMesh* mesh_obj;
    drITex* tex_obj;
    
    // stream manager object
    if(DR_FAILED(_static_stream_mgr->ResetDevice()))
        goto __ret;

    if(DR_FAILED(_dynamic_stream_mgr->ResetDevice()))
        goto __ret;

    if(DR_FAILED(_lockable_stream_mgr->ResetDevice()))
        goto __ret;

    if(DR_FAILED(_surface_stream_mgr->ResetDevice()))
        goto __ret;

    // shader manager object
    if(DR_FAILED(_shader_mgr->ResetDevice()))
        goto __ret;

    // mesh object
    obj_num = _pool_mesh.GetObjNum();
    for(i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_mesh.GetObj((void**)&mesh_obj, i)))
            continue;

        mesh_obj->ResetDevice();
        obj_num -= 1;
    }

    // texture object
    obj_num = _pool_tex.GetObjNum();
    for(i = 0; obj_num > 0; i++)
    {
        if(DR_FAILED(_pool_tex.GetObj((void**)&tex_obj, i)))
            continue;

        tex_obj->ResetDevice();
        obj_num -= 1;
    }

    //
    ret = DR_RET_OK;
__ret:
    return ret;
}

IDirect3DTexture8* drResourceMgr::getMonochromaticTexture( D3DCOLOR colour, const std::string& filterTexture )
{
	if( mColorFilterTextureList.find( ColourFilterPair( colour, filterTexture ) ) != mColorFilterTextureList.end() )
	{
		return mColorFilterTextureList[ ColourFilterPair( colour, filterTexture ) ];
	}
	IDirect3DTexture8* texture = _createMonochromaticTexture( colour, filterTexture, 1, 1 );
	return texture;
}

IDirect3DTexture8* drResourceMgr::_createMonochromaticTexture(
	D3DCOLOR colour,
	const std::string& filterTexture,
	UINT width, UINT height )
{
	if( filterTexture.empty() )
	{
		IDirect3DTexture8* texture = 0;
		IDirect3DDevice8* device = _dev_obj->GetDevice();

		HRESULT hr = device->CreateTexture(
			width, height,
			0, D3DUSAGE_DYNAMIC,
			D3DFMT_A8R8G8B8,
			D3DPOOL_DEFAULT, 
			&texture );

		if( FAILED( hr ) )
		{
			return 0;
		}

		D3DLOCKED_RECT lockedRect;
		hr = texture->LockRect( 0, &lockedRect, 0, D3DLOCK_DISCARD );
		if( FAILED( hr ) )
		{
			texture->Release();
			return 0;
		}

		UINT* writer = reinterpret_cast < UINT* > ( lockedRect.pBits );
		for( UINT y = 0; y < height; ++y )
		{
			UINT offset = y * width;

			for( UINT x = 0; x < width; ++x )
			{
				writer[ offset + x ] = colour;
			}
		}
		texture->UnlockRect( 0 );

		mColorFilterTextureList[ ColourFilterPair( colour, filterTexture ) ] = texture;

		return texture;
	}
	else
	{
		IDirect3DTexture8* texture = 0;
		IDirect3DDevice8* device = _dev_obj->GetDevice();

		HRESULT hr = D3DXCreateTextureFromFile(
			device,
			filterTexture.c_str(),
			&texture );

		if( FAILED( hr ) )
		{
			return 0;
		}

		D3DSURFACE_DESC description;
		hr = texture->GetLevelDesc( 0, &description );
		if( FAILED( hr ) )
		{
			return 0;
		}

		width = description.Width;
		height = description.Height;

		D3DLOCKED_RECT lockedRect;
		hr = texture->LockRect( 0, &lockedRect, 0, D3DLOCK_DISCARD );
		if( FAILED( hr ) )
		{
			texture->Release();
			return 0;
		}

		UINT* writer = reinterpret_cast < UINT* > ( lockedRect.pBits );
		for( UINT y = 0; y < height; ++y )
		{
			UINT offset = y * width;

			for( UINT x = 0; x < width; ++x )
			{
				if( ( writer[ offset + x ] >> 24 ) )
				{
					writer[ offset + x ] = colour;
				}
				else
				{
					writer[ offset + x ] |= 0xFF000000;
					//writer[ offset + x ] = trasparent;
					//writer[ offset + x ] = 0xFF000000;
				}
			}
		}
		texture->UnlockRect( 0 );

		mColorFilterTextureList[ ColourFilterPair( colour, filterTexture ) ] = texture;

		return texture;
	}
}

const char* drResourceMgr::getTextureOperationDescription( size_t operation )
{
	switch( D3DTEXTUREOP( operation ) )
	{
	case D3DTOP_DISABLE:
		return ( "D3DTOP_DISABLE" );
	case D3DTOP_SELECTARG1:
		return ( "D3DTOP_SELECTARG1" );
	case D3DTOP_SELECTARG2:
		return ( "D3DTOP_SELECTARG2" );
	case D3DTOP_MODULATE:
		return ( "D3DTOP_MODULATE" );
	case D3DTOP_MODULATE2X:
		return ( "D3DTOP_MODULATE2X" );
	case D3DTOP_MODULATE4X:
		return ( "D3DTOP_MODULATE4X" );
	case D3DTOP_ADD:
		return ( "D3DTOP_ADD" );
	case D3DTOP_ADDSIGNED:
		return ( "D3DTOP_ADDSIGNED" );
	case D3DTOP_ADDSIGNED2X:
		return ( "D3DTOP_ADDSIGNED2X" );
	case D3DTOP_SUBTRACT:
		return ( "D3DTOP_SUBTRACT" );
	case D3DTOP_ADDSMOOTH:
		return ( "D3DTOP_ADDSMOOTH" );
	case D3DTOP_BLENDDIFFUSEALPHA:
		return ( "D3DTOP_BLENDDIFFUSEALPHA" );
	case D3DTOP_BLENDTEXTUREALPHA:
		return ( "D3DTOP_BLENDTEXTUREALPHA" );
	case D3DTOP_BLENDFACTORALPHA:
		return ( "D3DTOP_BLENDFACTORALPHA" );
	case D3DTOP_BLENDTEXTUREALPHAPM:
		return ( "D3DTOP_BLENDTEXTUREALPHAPM" );
	case D3DTOP_BLENDCURRENTALPHA:
		return ( "D3DTOP_BLENDCURRENTALPHA" );
	case D3DTOP_PREMODULATE:
		return ( "D3DTOP_PREMODULATE" );
	case D3DTOP_MODULATEALPHA_ADDCOLOR:
		return ( "D3DTOP_MODULATEALPHA_ADDCOLOR" );
	case D3DTOP_MODULATECOLOR_ADDALPHA:
		return ( "D3DTOP_MODULATECOLOR_ADDALPHA" );
	case D3DTOP_MODULATEINVALPHA_ADDCOLOR:
		return ( "D3DTOP_MODULATEINVALPHA_ADDCOLOR" );
	case D3DTOP_MODULATEINVCOLOR_ADDALPHA:
		return ( "D3DTOP_MODULATEINVCOLOR_ADDALPHA" );
	case D3DTOP_BUMPENVMAP:
		return ( "D3DTOP_BUMPENVMAP" );
	case D3DTOP_BUMPENVMAPLUMINANCE:
		return ( "D3DTOP_BUMPENVMAPLUMINANCE" );
	case D3DTOP_DOTPRODUCT3:
		return ( "D3DTOP_DOTPRODUCT3" );
	case D3DTOP_MULTIPLYADD:
		return ( "D3DTOP_MULTIPLYADD" );
	case D3DTOP_LERP:
		return ( "D3DTOP_LERP" );
	}
	return "";
}

DR_END
