#include "StdAfx.h"
#include <log.h>
//#include "../../../proj/EffectEditer.h"
//#include <LightEngine.h>
#include "GlobalInc.h"
#include "LEModelEff.h"

#include "LEresmanger.h"
#include "drSysGraphics.h"
#include "LEeffectctrl.h"
#include "drIUtil.h"
#include "ShaderLoad.h"
#include "LERender.h"
#include "LEResourceSet.h"
#include "drExpObj.h"
#include "drPhysique.h"
#include <MyMemory.h>
#include "LETextureSet.h"
#include "LETerrainSet.h"
#include <CPerformance.h>

LIGHTENGINE_API CLEResManger        ResMgr;

CLEResManger::CLEResManger(void)
{
	m_pDev = NULL;
	ZeroMemory(_pszTexPath,MAX_PATH);
	ZeroMemory(_pszMeshPath,MAX_PATH);
	ZeroMemory(_pszEFFectPath,MAX_PATH);

	_iTexNum				= 0;
	_iMeshNum				= 0;
	_iEffectNum				= 0;
	_iVShaderNum			= 0;

	_vecTexName.clear();
	_vecMeshName.clear();
	_mapMesh.clear();

	_vecTexList.clear();
	_vecMeshList.clear();
	_mapTexture.clear();

	//_vecEffTech.clear();
	_vecEffectList.clear();

	_vecVShader.clear();
	_dwShadeMapVS = 0L;
	_dwFontVS	 = 0L;
	_bMagr = false;
	_dwMinimapVS = 0L;
	
	_vecEffectParam.clear();

	_fSaveTime = 0;
	_fDailTime = 0;
	_fCurTime = 0;
	_pMatView = NULL;
	_pMatViewProj = NULL;


	_iPathNum = 0;
	_vecPathName.clear();
	_vecPath.clear();


	_iTobMeshNum = 0;
	_lstTobMeshs.clear();


	ZeroMemory(_psDefault,256);

	WORD iw;
//#ifndef USE_GAME
	_vecMeshList.resize(MAXMESH_COUNT);
	_vecPartCtrl.resize(MAXPART_COUNT);
	_vecPartCtrl.setsize(MAXPART_COUNT);

	for( iw = 0; iw < MAXPART_COUNT; iw++)
	{
		(*_vecPartCtrl[iw]) = NULL;
	}
//#else
//	_vecPartCtrl.clear();
//#endif


	_iPartCtrlNum = 0;

	_vecPartArray.clear();
	_vecPartArray.resize(MAXMSG_COUNT);
	_vecValidID.resize(MAXMSG_COUNT);
	_vecValidID.setsize(MAXMSG_COUNT);
	for(iw = 0; iw <  MAXMSG_COUNT; iw++)
	{
		_vecPartArray[iw] = NULL;
		*_vecValidID[iw] = iw;
	}


	m_bUseSoft = FALSE;

    m_pSys = 0;
    m_pSysGraphics = 0;

	m_bCanFrame = false;
	m_iCurFrame = 0;
}

CLEResManger::~CLEResManger(void)
{
	//ReleaseTotalRes();
	for (size_t i(0); i<_vecMeshList.size(); i++)
	{
		SAFE_DELETE(_vecMeshList[i]);
	}
	_vecMeshList.clear();
#if RESOURCE_SCRIPT == 1
	std::set<string>::iterator iter, end;
	ofstream outfile;

	outfile.open("ParticleSet.txt", ios_base::app);
	end = _mapParticle.end();
	iter= _mapParticle.begin();
	for(; iter!=end; ++iter)
	{
		outfile << *iter << "\t0" << endl;
	}
	outfile.close();

	outfile.open("PathSet.txt", ios_base::app);
	end = _mapPath.end();
	iter = _mapPath.begin();
	for(; iter!=end; ++iter)
	{
		outfile << *iter << "\t1" << endl;
	}
	outfile.close();

	outfile.open("EffectSet.txt", ios_base::app);
	end = _mapEffect.end();
	iter = _mapEffect.begin();
	for(; iter!=end; ++iter)
	{
		outfile << *iter << "\t2" << endl;
	}
	outfile.close();

	outfile.open("MeshSet.txt", ios_base::app);
	end = _mapMesh.end();
	iter = _mapMesh.begin();
	for(; iter!=end; ++iter)
	{
		outfile << *iter << "\t3" << endl;
	}
	outfile.close();

	outfile.open("TextureSet.txt", ios_base::app);
	end = _mapTexture.end();
	iter = _mapTexture.begin();
	for(; iter!=end; ++iter)
	{
		outfile << *iter << "\t3" << endl;
	}
	outfile.close();

	
#endif
}

#define SAFE_DELETE_SET(T)		\
	T* p##T = T::I();		\
	if( p##T )				\
{						\
	p##T->Release();	\
	delete p##T;		\
}

void	CLEResManger::ReleaseTotalRes()
{
#ifndef SCRIPT_TABLE
	CEffectScript::m_cEffScript.ReleaseScript();
#else
	//CEff_ParamSet* pSingleSet = CEff_ParamSet::I();
	//SAFE_DELETE( pSingleSet );
	//CGroup_ParamSet* pGroupSet = CGroup_ParamSet::I();
	//SAFE_DELETE( pGroupSet );
#endif

	int iw;

//#ifndef USE_GAME
	for(iw = 0; iw < _iPartCtrlNum; iw++)
	{
        CLEPartCtrl** C = _vecPartCtrl[iw];
		SAFE_DELETE(*C);
	}
	_vecPartCtrl.resize(0);
//#else
//	_vecPartCtrl.clear();
//#endif
	_iPartCtrlNum = 0;

	if(_vecPartArray.size() > 0)
	{
		for(iw = 0; iw < MAXMSG_COUNT; iw++)
		{
			SAFE_DELETE(_vecPartArray[iw]);
		}
		_vecValidID.resize(0);
		_vecPartArray.clear();
	}
	_vecEffectList.clear();

	_CEffectFile.free();

	_dwShadeMapVS	= 0L;
	_dwFontVS		= 0L;
	_dwMinimapVS = 0L;

	_vecVShader.clear();
	_iVShaderNum = 0;

	_iPathNum = 0;
	_vecPathName.clear();
	_vecPath.clear();


	for(iw = 0; iw < _iTexNum; iw++)
	{
		SAFE_RELEASE(_vecTexList[iw]);
	}

	for( iw = 0; iw < _iMeshNum; iw++)
	{
		SAFE_DELETE(_vecMeshList[iw]);
	}
	std::list<CEffectModel*>::iterator iter = _lstTobMeshs.begin();
	std::list<CEffectModel*>::iterator end  = _lstTobMeshs.end();
	for(; iter != end; ++iter)
	{
		SAFE_DELETE(*iter);
	}
	SAFE_DELETE(_CShadeModel);

	SAFE_DELETE_SET( CGroup_ParamSet );
	SAFE_DELETE_SET( CEff_ParamSet );
	SAFE_DELETE_SET( LETerrainSet );
//	SAFE_DELETE_SET( LETexSet ); //--暂时不明原因

	_iTexNum				= 0;
	_iMeshNum				= 0;
	_iEffectNum				= 0;
	_iTobMeshNum			= 0;

	_vecTexName.clear();
	_vecMeshName.clear();
	_vecEffectName.clear();

	_mapMesh.clear();
	_mapEffect.clear();
	_mapTexture.clear();

	_vecTexList.clear();
	_vecMeshList.clear();
	_lstTobMeshs.clear();

	//_vecEffTech.clear();

	_vecEffectParam.clear();
}

bool CLEResManger::InitRes2()
{
	if(!LoadTotalMesh())
		return false;

	if(!LoadTotalEffect())
		return false;

	//LoadTotalData();

	LoadTotalPath();

	return true;
}

bool CLEResManger::InitRes3()
{
	LoadTotalRes();
	return true;
}

#ifdef USE_RENDER
bool	CLEResManger::InitRes(LERender*		pDev, D3DXMATRIX* pmat, D3DXMATRIX* pMatviewproj)
#else
bool	CLEResManger::InitRes(LPDIRECT3DDEVICE8		pDev, D3DXMATRIX* pmat, D3DXMATRIX* pMatviewproj)
#endif
{
	m_pDev = pDev;

	LPDIRECT3DSURFACE8 pBackBuffer;
#ifdef USE_RENDER
	m_pDev->GetDevice()->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pBackBuffer );
#else
	m_pDev->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pBackBuffer );
#endif
    pBackBuffer->GetDesc( &m_d3dBackBuffer );
    pBackBuffer->Release();

	//_iFontBkWidth = m_d3dBackBuffer.Width/2;
	//_iFontBkHeight= m_d3dBackBuffer.Height/2;
	//_iFontBkWidth = m_pDev->GetScrWidth()/2; //m_d3dBackBuffer.Width/2;
	//_iFontBkHeight= m_pDev->GetScrHeight()/2; //m_d3dBackBuffer.Height/2;
	//_iFontBkWidth = m_pDev->GetScrWidth()/2;//m_d3dBackBuffer.Width/2;
	//_iFontBkHeight= m_pDev->GetScrHeight()/2;//m_d3dBackBuffer.Height/2;
	RECT rc_client;
	m_pDev->GetInterfaceMgr()->dev_obj->GetWindowRect(NULL, &rc_client);
	_iFontBkWidth = (rc_client.right - rc_client.left) / 2;
	_iFontBkHeight= (rc_client.bottom - rc_client.top) / 2;


	D3DXMatrixOrthoLH(&_Mat2dViewProj, float(m_d3dBackBuffer.Width), float(m_d3dBackBuffer.Height), 0.0f, 1.0f);
	
	m_caps = m_pDev->GetOrgCap();
	if(  m_caps.VertexShaderVersion < D3DVS_VERSION(1,1) ) //|| m_caps.PixelShaderVersion < D3DPS_VERSION(1,4) )
		m_bUseSoftOrg = true;
	else
		m_bUseSoftOrg = false;


#ifdef USE_RENDER
	m_pDev->GetDevice()->GetDeviceCaps(&m_caps);
#else
	m_pDev->GetDeviceCaps(&m_caps);       // initialize m_pd3dDevice before using
#endif
	if(  m_caps.VertexShaderVersion < D3DVS_VERSION(1,1) ) //|| m_caps.PixelShaderVersion < D3DPS_VERSION(1,4))
	{	
		//IP("soft vs:%08x, ps:%08x\n", m_caps.VertexShaderVersion, m_caps.PixelShaderVersion);
		m_bUseSoft = true;
		//MessageBox(NULL,"soft","VS:%x PS:%x",0);
	}
	else
	{
		//MessageBox(NULL,"shard","ERROR",0);

		m_bUseSoft = false;
	}


	if(!CScriptFile::m_ctScript.OpenFileRead("effect/model.txt"))
	{
		LG("ERROR","msg缺少 effect/model.txt");
		return false;
	}

	_CEffectFile.InitDev(pDev);
	if(!_CEffectFile.LoadEffectFromFile("shader\\dx8\\eff.fx"))
	{
		MessageBox(NULL,"shader\\eff.fx","ERROR",0);
		return false;
	}

#ifndef SCRIPT_TABLE
	if(!CEffectScript::m_cEffScript.InitScript())
		return false;
#else
	bool	bBinary = false;
	CEff_ParamSet* pEffSet = new CEff_ParamSet(0, 100);
	pEffSet->LoadRawDataInfo("scripts/table/MagicSingleinfo", bBinary);

	CGroup_ParamSet* pGroupSet = new CGroup_ParamSet(0, 10);
	pGroupSet->LoadRawDataInfo("scripts/table/MagicGroupinfo", bBinary);
#endif

	if(!_bMagr)
		if(!LoadTotalVShader())
			return false;

//#ifdef USE_DDS_FILE
	lstrcpy(_pszTexPath,"texture\\effect");
//#else
//	lstrcpy(_pszTexPath,"texture_src\\effect");
//#endif

	lstrcpy(_pszMeshPath,"model");
	lstrcpy(_pszEFFectPath,"effect");

	LoadTotalTexture();

	//LoadDefaultText("effect\\font.txt");

	LoadTotalPartCtrl();

	LoadTotalData();

	_pMatView = pmat;
	D3DXMatrixInverse( &_MatBBoard, NULL, _pMatView );
	_MatBBoard._41 = 0.0f;
    _MatBBoard._42 = 0.0f;
    _MatBBoard._43 = 0.0f;

	_pMatViewProj = pMatviewproj;

	for(int n = 0; n < _iEffectNum; n++)
	{
		for(int m = 0; m < (int)_vecEffectList[n].size(); m++)
		{
			if(_vecEffectList[n][m].IsBillBoard())
			{
				_vecEffectList[n][m].setBillBoardMatrix(&_MatBBoard);
			}
		}
	}

	drRegisterOutputLoseDeviceProc(g_OnLostDevice);
	drRegisterOutputResetDeviceProc(g_OnResetDevice);

	return true;
}

int		CLEResManger::GetTextureID(const s_string &sName)
{
#if RESOURCE_SCRIPT == 1
	// 资源脚本定义时，自动生成文件用
	StrMapIter iter = _mapTexture.find(sName);
	if (iter == _mapTexture.end())
		_mapTexture.insert(sName);
#endif

	TEXTURE_MAP::iterator pos = _mapTexture.find( sName );
	if( pos != _mapTexture.end() )
	{
		return (*pos).second;
	}

	//for (size_t i=0; i<_vecTexName.size(); i++)
	//{
	//	if (stricmp_s(sName.c_str(), _vecTexName[i].c_str()) == 0)
	//		// Success
	//	{
	//		__asm int 3;
	//		return (int)i;
	//	}
	//}
	
#if RESOURCE_SCRIPT == 2
	// 资源脚本使用测试时，报告纹理未填入特效脚本中
	LG("error","msg: CLEResManger::GetTextureID(),TextureName=%s", sName.c_str());
#endif

	// Failure
	char szMsg[64];
	_snprintf_s(szMsg,64,_TRUNCATE, "缺少特效帖图[%s](文件不存在或特效资源配置文件出错)",
		sName.c_str());
	LG("ERROR","msg%s",szMsg);
	return -1;
}
//-----------------------------------------------------------------------------
LPDIRECT3DTEXTURE8	CLEResManger::GetTextureByID( int iID)
{ 
	if(_vecTexList[iID])
		return _vecTexList[iID]->GetTex();
	else
	{
		return NULL;
	}
}
//-----------------------------------------------------------------------------
drITex*		CLEResManger::GetTextureByIDdr( int iID)
{
	if(_vecTexList[iID])
		return _vecTexList[iID];
	else
	{
		char t_pszFile[MAX_PATH];
#ifdef USE_DDS_FILE_EFFECT
		_snprintf_s(t_pszFile, MAX_PATH,_TRUNCATE, "%s\\%s.dds",_pszTexPath,_vecTexName[iID].c_str());
#else
		_snprintf_s(t_pszFile,MAX_PATH,_TRUNCATE, "%s\\%s.tga",_pszTexPath,_vecTexName[iID].c_str());
#endif
		drITex* tex;

		if(DR_FAILED(drLoadTex(&tex, m_pSysGraphics->GetResourceMgr(), t_pszFile, 0, D3DFMT_A4R4G4B4)))
		{
			char szMsg[64];
			_snprintf_s(szMsg, 64, _TRUNCATE, "加载特效贴图[id=%d]出错", iID);
			LG("ERROR","msg%s",szMsg);
			return 0;
		}
		//#endif
		_vecTexList[iID] = tex;

		return _vecTexList[iID];
	}
}
//-----------------------------------------------------------------------------
drITex* CLEResManger::GetTextureByNamedr(const s_string &sName)
{
	int iTexID = GetTextureID(sName);
	if (iTexID == -1)
	{
		return 0;
	}

	return GetTextureByIDdr(iTexID);

}
//-----------------------------------------------------------------------------
int		CLEResManger::GetMeshID(const s_string &sName)
{
#if RESOURCE_SCRIPT == 1
	StrMapIter iter = _mapMesh.find(pszName);
	if (iter == _mapMesh.end())
		_mapMesh.insert(pszName);
#endif

	MESH_MAP::iterator pos = _mapMesh.find( sName );
	if( pos != _mapMesh.end() )
	{
		return (*pos).second;
	}

	//for (size_t i(0); i<_vecMeshName.size(); i++)
	//{
	//	if (stricmp_s(sName.c_str(), _vecMeshName[i].c_str()) == 0)
	//	{
	//		__asm int 3;
	//		// Success 
	//		return (int)i;
	//	}
	//}

#if RESOURCE_SCRIPT == 2
	LG("error","msg: CLEResManger::GetMeshID(),MeshName=%s",sName.c_str());
#endif

	// Failure
	//char szMsg[64];
	//_snprintf_s(szMsg,"缺少特效模型[%s](文件不存在或特效资源配置文件出错)",
	//	sName.c_str());
	//LG("ERROR","msg%s",szMsg);
	return -1;
}

//-----------------------------------------------------------------------------
CEffectModel* CLEResManger::GetMeshByID( int iID)
{

	CEffectModel* pRetMesh(0);

	if(iID >=7)
	{
		if(!_vecMeshList[iID])
		{	// 第一次需要模型对象，创建
			_vecMeshList[iID] = new CEffectModel;

			_vecMeshList[iID]->InitDevice(m_pDev);
			drIPathInfo* path_info;
			m_pSys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );
			char szOldPath[260];
			strncpy_s(szOldPath, path_info->GetPath(PATH_TYPE_MODEL_ITEM), _TRUNCATE );
			path_info->SetPath( PATH_TYPE_MODEL_ITEM, "model\\effect\\" );
			if(!_vecMeshList[iID]->LoadModel((TCHAR*)_vecMeshName[iID].c_str()))
			{
				SAFE_DELETE(_vecMeshList[iID]);
				path_info->SetPath( PATH_TYPE_MODEL_ITEM, szOldPath );

				char szMsg[64];
				_snprintf_s(szMsg,64, _TRUNCATE,"加载特效模型[id=%d]失败", iID);
				LG("ERROR","msg%s",szMsg);
				return 0;
			}
			if(!_vecMeshList[iID]->GetObject() || !_vecMeshList[iID]->GetObject()->GetPrimitive())
			{
				LG("error","msg: effectmesh->GetObject(),effectmesh->GetPrimitive()__ID=%d",iID);
			}else
				_vecMeshList[iID]->GetObject()->GetPrimitive()->SetState(STATE_TRANSPARENT, 0);
			path_info->SetPath( PATH_TYPE_MODEL_ITEM, szOldPath );
			pRetMesh = _vecMeshList[iID];
		}
		else
		{	// 之后需要模型对象，创建
			if (_vecMeshList[iID]->IsUsing())
			{
				int n = _iMeshNum;
				for ( n = _iMeshNum; n < MAXMESH_COUNT; ++n)
				{
					if (_vecMeshList[n] && _vecMeshList[n]->IsUsing())
					{	// 如果列表中这个位置已经有模型了，并且模型正在使用，则查找下一个位置
						continue;
					}
					if(!_vecMeshList[n])	
					{	//如果为空新创建一个模型对象（初始模型为未使用状态）
						_vecMeshList[n] = new CEffectModel;
					}

					// 如果这个位置的模型没有被使用，则使用这个模型对象
					if (_vecMeshList[n]->m_iID != iID)
					{	// 如果这模型与需要的模型不同则拷贝一份
						if (!_vecMeshList[n]->Copy(*_vecMeshList[iID]))
						{
							SAFE_DELETE(_vecMeshList[n]);
							char szMsg[64];
							_snprintf_s(szMsg,64,_TRUNCATE, "缺少特效模型[id=%d]拷贝错误", iID);
							LG("ERROR","msg%s",szMsg);
							return 0;
						}
					}

					//到这里表示已经找到可用的模型对象（这里程序比较诡异，注意考虑与之前相容性）
					break;
				}
				if(n >= MAXMESH_COUNT)
				{
					LG("Error","msg特效模型已满");
					return 0;
				}
				pRetMesh =_vecMeshList[n];
			}
			else
			{
				pRetMesh = _vecMeshList[iID];
			}
		}
	}
	else 
	{
		pRetMesh = _vecMeshList[iID];
	}
	pRetMesh->m_iID = iID;
	pRetMesh->SetUsing(true);
	return pRetMesh;
}

//-----------------------------------------------------------------------------
CEffectModel* CLEResManger::GetMeshByName(const s_string &sName)
{
	int iMeshID = GetMeshID(sName);
	if (iMeshID == -1)
	{
		return 0;
	}
	return GetMeshByID(iMeshID);

}
//-----------------------------------------------------------------------------
void CLEResManger::DeleteMesh(CEffectModel& rEffectModel)
{
	if(rEffectModel.m_iID >=7)
	{
		rEffectModel.SetUsing(false);
	}
}

//int			CLEResManger::GetItemID(s_string pszName)
//{
//	std::vector<s_string>::iterator it = find( _vecItemName.begin(),_vecItemName.end(), pszName );
//	if ( it != _vecItemName.end() )
//	{
//		return (int)(it - _vecItemName.begin());
//	}
//	return -1;
//
//}
//CEffectModel*	CLEResManger::GetItemByID(int iID)
//{
//	return &_vecItemList[iID];
//}
//////////////////////////////////////////////////////////////////////////

int		CLEResManger::GetEffectID(const s_string &pszName)
{
#if RESOURCE_SCRIPT == 1
	StrMapIter iter = _mapEffect.find(pszName);
	if (iter == _mapEffect.end())
		_mapEffect.insert(pszName);
#endif

	//char *pszDataName = _strdrr( _strdup( pszName.c_str() ) );
	//s_string strName = pszDataName;
	//transform(pszName.begin(), pszName.end(), //source
	//		  pszName.begin(), //destination
	//		  tolower);


	EFFECT_MAP::iterator pos = _mapEffect.find( pszName );
	if( pos != _mapEffect.end() )
	{
		return (*pos).second;
	}

	//std::vector<s_string>::iterator it = find( _vecEffectName.begin(), _vecEffectName.end(), pszName );
	//for (size_t i(0); i<_vecEffectName.size(); ++i)
	//{
	//	if (stricmp_s(_vecEffectName[i].c_str(), pszName.c_str()) == 0)
	//	{
	//		__asm int 3;
	//		return (int)i;
	//	}
	//}
	//if ( it != _vecEffectName.end() )
	//{
	//	//SAFE_DELETE_ARRAY(pszDataName);
	//	return (int)(it - _vecEffectName.begin());
	//}
	////SAFE_DELETE_ARRAY(pszDataName);
#if RESOURCE_SCRIPT == 2
	LG("error","msg: CLEResManger::GetEffectID(),EffectName=%s",pszName.c_str());
#endif


	return -1;
}
std::vector<I_Effect>&	CLEResManger::GetEffectByID( int iID)
{
	I_Effect *pEffect = &(_vecEffectList[iID][0]);

	int n = (int)_vecEffectList[iID].size();
	if( n <=0)
	{
		char t_pszFile[MAX_PATH];
		_snprintf_s(t_pszFile, MAX_PATH, _TRUNCATE,"%s\\%s",_pszEFFectPath,_vecEffectName[iID].c_str());

		//__asm int 3;
		if(!LoadEffectFromFile(iID, t_pszFile))
			return _vecEffectList[iID];
		_vecEffectList[iID][0].setEffectName(_vecEffectName[iID]);

	}
	return _vecEffectList[iID];
}

I_Effect*	CLEResManger::GetSubEffectByID(int iID, int iSubIdx)
{
	return &_vecEffectList[iID][iSubIdx];
}

DWORD*	CLEResManger::GetVShaderByID(int iID)
{
	if(!m_bUseSoft)
		return &_vecVShader[iID];
	else
		return &_vecVShader[0];
}
	
DWORD*	CLEResManger::GetShadeVS()
{
	return &_dwShadeMapVS;
}
CEffectModel*	CLEResManger::GetShadeMesh()
{
	return _CShadeModel;
}
DWORD*		CLEResManger::GetFontVS()
{
	return &_dwFontVS;
}

//int		CLEResManger::GetEffectTechByID(int iID)
//{
//	return _vecEffTech[iID];
//}

EffParameter*   CLEResManger::GetEffectParamByID(int iID)
{
	return &_vecEffectParam[iID];
}





//CLEShadeCtrl*	CLEResManger::GetShadeMapIns(s_string strName)
//{
//	std::vector<s_string>::iterator it = find( _vecShadeName.begin(),_vecShadeName.end(),strName );
//	if ( it == _vecShadeName.end() )
//		return NULL;
//	CLEShadeCtrl* pShade = new CLEShadeCtrl;
//
//	FILE* pFile;
//	pFile = fopen(strName.c_str(), "rb");
//	if(!pFile)
//		return false;
//	
//	int itype;
//	fread(&itype, sizeof(int),1,pFile);
//
//	float fRadius;
//	fread(&fRadius,sizeof(float),1,pFile);
//
//	char t_pszName[32];
//	fread(t_pszName, sizeof(char),32,pFile);
//
//	int irow,icol;
//	if(itype == SHADE_ANI)
//	{
//		fread(&irow,sizeof(int),1,pFile);
//		fread(&icol,sizeof(int),1,pFile);
//	}
//
//	pShade->Create(t_pszName,this,fRadius,itype == SHADE_ANI ? true : false, irow,icol);
//
//	if(itype == SHADE_ANI)
//		((CLEShadeEX*)pShade->GetShadeMap())->LoadFromFile(pFile);
//	else
//		pShade->GetShadeMap()->LoadFromFile(pFile);
//
//	fclose(pFile);
//	return pShade;
//}

bool	CLEResManger::LoadTotalTexture()
{
#if RESOURCE_SCRIPT == 0 || RESOURCE_SCRIPT == 1
	{
		char t_Path[MAX_PATH];
		WIN32_FIND_DATA t_sfd;
		HANDLE  t_hFind = NULL;

		lstrcpy(t_Path,_pszTexPath);
#ifdef USE_DDS_FILE_EFFECT
		lstrcat(t_Path,"\\*.dds");
#else
		lstrcat(t_Path,"\\*.tga");
#endif

		//char pszname[32];
		//AfxMessageBox(t_Path);
		//char t_pszFile[MAX_PATH];

		//LPDIRECT3DTEXTURE8  t_lptex = NULL;
		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			return false;
		string sFileName;
		do{
			if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			{
				//_snprintf_s(t_pszFile, "%s\\%s",_pszTexPath,t_sfd.cFileName);
				////全部转换成小写
				//memset(pszname,0,32);
				//char *pszDataName = _strdrr( _strdup( t_sfd.cFileName ) );
				//int len = lstrlen(pszDataName);
				//memcpy(pszname, pszDataName,len - 4); 
				//pszname[len - 4 + 1] = '\0';

				sFileName = t_sfd.cFileName;
				transform(sFileName.begin(), sFileName.end(),
					sFileName.begin(),
					tolower);
				sFileName = sFileName.substr(0, sFileName.rfind('.'));

				{
					//SAFE_RELEASE(t_lptex);
					_mapTexture[sFileName] = (int)_vecTexName.size();
					_vecTexName.push_back(sFileName.c_str());
					//SAFE_DELETE_ARRAY(pszDataName);
				}
			}
		}while(FindNextFile(t_hFind,&t_sfd));
		FindClose(t_hFind);
	}
#else
	{
		LEResourceInfo* pResInfo(0);
		char szName[32];
		memset(szName,0,32);

		for(int i(1); i<LEResourceSet::GetInstance().GetLastID() +1; i++)
		{
			pResInfo = LEResourceSet::GetInstance().GetResourceInfoByID(i);
			if (!pResInfo)
				continue;
			if (pResInfo->GetType() == LEResourceInfo::RT_TEXTURE)
			{
				if((strstr(pResInfo->szDataName,".dds")==NULL)&&strstr(pResInfo->szDataName,".tga")==NULL)
				{
					_mapTexture[pResInfo->szDataName] = (int)_vecTexName.size();
					_vecTexName.push_back(pResInfo->szDataName);
				}
				else
				{
					int len = lstrlen(pResInfo->szDataName);
					memcpy(szName, pResInfo->szDataName,len - 4); 
					_mapTexture[pResInfo->szDataName] = (int)_vecTexName.size();
					_vecTexName.push_back(szName);
					memset(szName,0,32);
				}
			}
		}
	}
#endif

	_iTexNum = (int)_vecTexName.size();
	_vecTexList.resize(_iTexNum);
	for(int iw = 0; iw < _iTexNum; iw++)
	{
		_vecTexList[iw] = NULL;
	}
	return true;
}

void CLEResManger::LoadTotalData()
{
#ifndef _UNLOADRES
	char t_Path[MAX_PATH];
	WIN32_FIND_DATA t_sfd;
	HANDLE  t_hFind = NULL;


	// 装载动作
	lstrcpy(t_Path,"animation\\");
	lstrcat(t_Path,"\\*.lab");

	int count = 0;
	if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
		return;
	do{
		if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
		{
			int length = (int)strlen(t_sfd.cFileName);
			char *sname = &t_sfd.cFileName[length - 4];
			if(strcmp(sname,".lab") != 0)
			{
				continue; 
			}
			char path[ DR_MAX_PATH ];
			_snprintf_s( path, DR_MAX_PATH, _TRUNCATE, "%s%s", "animation\\", t_sfd.cFileName );

			//全部转换成小写
			if( !g_GeomManager.LoadBoneData( t_sfd.cFileName ) )
			{
				LG("error","msg:装载模型动作失败(%s)！", path );
			}
			count ++;
			if( count == 50 )
			{
				break;
				//__asm int 3;
			}
			else if( count == 200 )
			{
				//__asm int 3;
			}
			else if( count == 300 )
			{
				//__asm int 3;
				break;
			}
			else if( count == 400 )
			{
				//__asm int 3;
			}
		}

	}while(FindNextFile(t_hFind,&t_sfd));
	FindClose(t_hFind);
#endif
}

void CLEResManger::LoadTotalRes()
{
	//LoadTotalEffect();
	LoadTotalPartCtrl();

	char t_Path[MAX_PATH];
	WIN32_FIND_DATA t_sfd;
	HANDLE  t_hFind = NULL;

//	lstrcpy(t_Path,"model\\effect");
//	lstrcat(t_Path,"\\*.lgo");
//
//	if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
//		return;
//	string sFileName;
//
//	drIPathInfo* path_info;
//	m_pSys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );
//	char szOldPath[260];
//	strcpy_s(szOldPath, path_info->GetPath(PATH_TYPE_MODEL_ITEM));
//	path_info->SetPath( PATH_TYPE_MODEL_ITEM, "model\\effect\\" );
//
//	do{
//		if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
//		{
//			int length = (int)strlen(t_sfd.cFileName);
//			char *sname = &t_sfd.cFileName[length - 4];
//			if(strcmp(sname,".lgo") != 0)
//			{
//				continue; 
//			}
//			//全部转换成小写
//			sFileName = t_sfd.cFileName;
//			transform(sFileName.begin(), sFileName.end(),
//				sFileName.begin(),
//				tolower);
//
//#ifndef _UNLOADRES
//			_vecMeshList[_iMeshNum] = new CEffectModel;
//			_vecMeshList[_iMeshNum]->InitDevice(m_pDev);
//			_vecMeshList[_iMeshNum]->LoadModel(sFileName.c_str());
//#endif
//
//			_mapMesh[sFileName] = (int)_vecMeshName.size();
//			_vecMeshName.push_back(sFileName.c_str());
//			_iMeshNum++;
//		}
//
//	}while(FindNextFile(t_hFind,&t_sfd));
//	FindClose(t_hFind);
//	path_info->SetPath( PATH_TYPE_MODEL_ITEM, szOldPath );

#ifndef _UNLOADRES
	//// 道具
	//lstrcpy(t_Path,"model\\item");
	//lstrcat(t_Path,"\\*.lgo");

	//if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
	//	return;
	//do{
	//	if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
	//	{
	//		int length = (int)strlen(t_sfd.cFileName);
	//		char *sname = &t_sfd.cFileName[length - 4];
	//		if(strcmp(sname,".lgo") != 0)
	//		{
	//			continue; 
	//		}

	//		//全部转换成小写
	//		if( !g_GeomManager.LoadGeomobj( t_sfd.cFileName ) )
	//		{
	//			//LG("error","msg:装载item模型失败(%s)！", t_sfd.cFileName );
	//		}
	//	}

	//}while(FindNextFile(t_hFind,&t_sfd));
	//FindClose(t_hFind);

	// 角色模型
	lstrcpy(t_Path,"model\\character");
	lstrcat(t_Path,"\\*.lgo");

	static int nNum = 0;
	if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
		return;
	do{
		if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
		{
			int length = (int)strlen(t_sfd.cFileName);
			char *sname = &t_sfd.cFileName[length - 4];
			if(strcmp(sname,".lgo") != 0)
			{
				continue; 
			}
			
			nNum++;
			if( nNum++ >= 900 )
				break;

			//全部转换成小写
			if( !g_GeomManager.LoadGeomobj( t_sfd.cFileName ) )
			{
				//LG("error","msg:装载模型失败(%s)！", t_sfd.cFileName );
			}
		}

	}while(FindNextFile(t_hFind,&t_sfd));
	FindClose(t_hFind);
	//char szData[32];
	//_snprintf_s( szData, "%d", nNum );
	//MessageBox(NULL, szData, "", MB_OK );

#endif
}

bool	CLEResManger::LoadTotalMesh()
{
	_iMeshNum = 7;

	_mapMesh[MESH_TRI] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_TRI);

	_mapMesh[MESH_RECT] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_RECT);

	_mapMesh[MESH_PLANERECT] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_PLANERECT);

	_mapMesh[MESH_PLANETRI] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_PLANETRI);

	_mapMesh[MESH_RECTZ] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_RECTZ);

	_mapMesh[MESH_CONE] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_CONE);

	_mapMesh[MESH_CYLINDER] = (int)_vecMeshName.size();
	_vecMeshName.push_back(MESH_CYLINDER);

	_vecMeshList.resize(MAXMESH_COUNT);
	for (int n = 0; n< MAXMESH_COUNT; n++)
	{
		_vecMeshList[n] = NULL;
	}
	_vecMeshList[0] = new CEffectModel;
	_vecMeshList[0]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[0]->CreateTriangle();

	_vecMeshList[1] = new CEffectModel;
	_vecMeshList[1]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[1]->CreateRect();

	_vecMeshList[2] = new CEffectModel;
	_vecMeshList[2]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[2]->CreatePlaneRect();

	_vecMeshList[3] = new CEffectModel;
	_vecMeshList[3]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[3]->CreatePlaneTriangle();

	_vecMeshList[4] = new CEffectModel;
	_vecMeshList[4]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[4]->CreateRectZ();

	_vecMeshList[5] = new CEffectModel;
	_vecMeshList[5]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[5]->CreateCone(8,3,2);

	_vecMeshList[6] = new CEffectModel;
	_vecMeshList[6]->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_vecMeshList[6]->CreateCylinder(8,3,1,3);

	_CShadeModel= NULL;
	_CShadeModel = new CEffectModel;
	_CShadeModel->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_CShadeModel->CreateShadeModel();
	
#if USE_RESOURCE_SCRIPT == 0 || USE_RESOURCE_SCRIPT == 1
	{
		char t_Path[MAX_PATH];
		WIN32_FIND_DATA t_sfd;
		HANDLE  t_hFind = NULL;

		lstrcpy(t_Path,"model\\effect");
		lstrcat(t_Path,"\\*.lgo");

		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			return true;
		string sFileName;

		drIPathInfo* path_info;
		m_pSys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );
		char szOldPath[260];
		strncpy_s(szOldPath, path_info->GetPath(PATH_TYPE_MODEL_ITEM), _TRUNCATE);
		path_info->SetPath( PATH_TYPE_MODEL_ITEM, "model\\effect\\" );

		do{
			if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			{
				int length = (int)strlen(t_sfd.cFileName);
				char *sname = &t_sfd.cFileName[length - 4];
				if(strcmp(sname,".lgo") != 0)
				{
					continue; 
				}
				//全部转换成小写
				sFileName = t_sfd.cFileName;
				transform(sFileName.begin(), sFileName.end(),
					sFileName.begin(),
					tolower);

				_vecMeshList[_iMeshNum] = new CEffectModel;
				_vecMeshList[_iMeshNum]->InitDevice(m_pDev);
				_vecMeshList[_iMeshNum]->LoadModel(sFileName.c_str());

				_mapMesh[sFileName] = (int)_vecMeshName.size();
				_vecMeshName.push_back(sFileName.c_str());
				_iMeshNum++;
			}

		}while(FindNextFile(t_hFind,&t_sfd));
		FindClose(t_hFind);
		path_info->SetPath( PATH_TYPE_MODEL_ITEM, szOldPath );

		// 道具
		lstrcpy(t_Path,"model\\item");
		lstrcat(t_Path,"\\*.lgo");

		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			return true;
		do{
			if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			{
				int length = (int)strlen(t_sfd.cFileName);
				char *sname = &t_sfd.cFileName[length - 4];
				if(strcmp(sname,".lgo") != 0)
				{
					continue; 
				}

				//全部转换成小写
				if( !g_GeomManager.LoadGeomobj( t_sfd.cFileName ) )
				{
					//LG("error","msg:装载item模型失败(%s)！", t_sfd.cFileName );
				}
			}

		}while(FindNextFile(t_hFind,&t_sfd));
		FindClose(t_hFind);

		//// 角色模型
		//lstrcpy(t_Path,"model\\character");
		//lstrcat(t_Path,"\\*.lgo");

		//if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
		//	return true;
		//do{
		//	if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
		//	{
		//		int length = (int)strlen(t_sfd.cFileName);
		//		char *sname = &t_sfd.cFileName[length - 4];
		//		if(strcmp(sname,".lgo") != 0)
		//		{
		//			continue; 
		//		}

		//		//全部转换成小写
		//		if( !g_GeomManager.LoadGeomobj( t_sfd.cFileName ) )
		//		{
		//			//LG("error","msg:装载模型失败(%s)！", t_sfd.cFileName );
		//		}
		//	}

		//}while(FindNextFile(t_hFind,&t_sfd));
		//FindClose(t_hFind);
	}
#else
	{
		LEResourceInfo* pResInfo(0);
		for(int i(1); i<LEResourceSet::GetInstance().GetLastID() +1; i++)
		{
			pResInfo = LEResourceSet::GetInstance().GetResourceInfoByID(i);
			if (!pResInfo)
				continue;
			if (pResInfo->GetType() == LEResourceInfo::RT_MESH)
			{
				_mapMesh[pResInfo->szDataName] = (int)_vecMeshName.size();
				_vecMeshName.push_back(pResInfo->szDataName);
				_iMeshNum++;
			}
		}
	}
#endif

	return true;
}

I_Effect* 	CLEResManger::AddEffectToMgr(const s_string& strName)
{
	_iEffectNum++;

	_vecEffectList.resize( _iEffectNum );

	_vecEffectName.resize(_iEffectNum );

	_vecEffectParam.resize(_iEffectNum);

	_mapEffect[strName] = _iEffectNum - 1;
	_vecEffectName[_iEffectNum - 1] = strName;

	_vecEffectList[_iEffectNum - 1].resize(1);

	I_Effect *pEffect = &(_vecEffectList[_iEffectNum - 1][0]);
	_vecEffectList[_iEffectNum - 1][0].ReleaseAll();

	//_vecEffectParam[_iEffectNum - 1]

	return &_vecEffectList[_iEffectNum - 1][0];
}

void	CLEResManger::AddUniteEffectToMgr(std::vector<I_Effect>& vecEffArray)
{
	_iEffectNum++;
	_vecEffectList.resize( _iEffectNum );
	_vecEffectName.resize( _iEffectNum );
	_vecEffectParam.resize(_iEffectNum );
	_mapEffect[vecEffArray[0].getEffectName()] = _iEffectNum - 1;
	_vecEffectName[_iEffectNum - 1] = vecEffArray[0].getEffectName();
	_vecEffectList[_iEffectNum - 1] = vecEffArray;
	for (INT n = 0; n < (INT)vecEffArray.size(); n++)
	{
		_vecEffectList[_iEffectNum - 1][n].BoundingRes(this);
	}
}


//!装入组合效果从文件
bool	CLEResManger::LoadEffectFromFile(int idx, char* pszFileName)
{
	FILE* t_pFile;
	fopen_s( &t_pFile, pszFileName, "rb");
	if(!t_pFile)
		return false;
	//!版本
	DWORD t_dwVersion;
	int   t_temp;
	fread(&t_dwVersion,sizeof(t_dwVersion),1,t_pFile);
	//if(t_dwVersion != 1)
	//	return false;

	fread(&t_temp,sizeof(int),1,t_pFile);
	_vecEffectParam[idx].m_iIdxTech = t_temp;
	char t_pszName[32];

	fread(&_vecEffectParam[idx].m_bUsePath, sizeof(bool),1,t_pFile);
	fread(t_pszName, sizeof(char),32,t_pFile);
	_vecEffectParam[idx].m_szPathName = t_pszName;

	fread(&_vecEffectParam[idx].m_bUseSound, sizeof(bool),1,t_pFile);
	fread(t_pszName, sizeof(char),32,t_pFile);
	_vecEffectParam[idx].m_szSoundName = t_pszName;

	fread(&_vecEffectParam[idx].m_bRotating, sizeof(bool),1,t_pFile);
	fread(&_vecEffectParam[idx].m_SVerRota, sizeof(D3DXVECTOR3),1,t_pFile);
	fread(&_vecEffectParam[idx].m_fRotaVel, sizeof(float),1,t_pFile);

	fread(&t_temp,sizeof(int),1,t_pFile);

	_vecEffectList[idx].resize(t_temp);

	for(int n = 0; n < t_temp; n++)
	{
		_vecEffectList[idx][n].LoadFromFile(t_pFile,t_dwVersion);
		_vecEffectList[idx][n].Reset();
		_vecEffectList[idx][n].m_pDev = m_pDev;
	}

	fclose(t_pFile);
	return true;
}
bool	CLEResManger::LoadTotalEffect()
{
#if RESOURCE_SCRIPT == 0 || RESOURCE_SCRIPT == 1
	{
		char t_Path[MAX_PATH];
		WIN32_FIND_DATA t_sfd;
		HANDLE  t_hFind = NULL;

		lstrcpy(t_Path,_pszEFFectPath);
		lstrcat(t_Path,"\\*.eff");

		char t_pszFile[MAX_PATH];

		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			LG("effinfo", "eff文件一个都没有");
		else
		{
			do{
				if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
				{
					int length = (int)strlen(t_sfd.cFileName);
					char *sname = &t_sfd.cFileName[length - 4];
					if(_stricmp(sname,".eff") != 0)
					{
						//LG(t_sfd.cFileName, "不是标准的.eff文件,请从本地目录删除");
						continue;
					}
					////全部转换成小写
					string sFileName;
					sFileName = t_sfd.cFileName;
					transform(sFileName.begin(), sFileName.end(),
						sFileName.begin(),
						tolower);

					_snprintf_s(t_pszFile, MAX_PATH, _TRUNCATE, "%s\\%s",_pszEFFectPath,t_sfd.cFileName);
					_vecEffectList.resize( _iEffectNum + 1);
					_vecEffectList[_iEffectNum].clear();
					_vecEffectParam.resize(_iEffectNum + 1);

					if(!LoadEffectFromFile(_iEffectNum, t_pszFile))
					{
						char szData[1024];
						_snprintf_s( szData,1024, _TRUNCATE, "装载特效文件(%s)失败！", t_pszFile );
						MessageBox( NULL, szData, "Error", MB_OK );
						//return false;
					}

					_vecEffectName.resize(_iEffectNum + 1);

					_mapEffect[t_sfd.cFileName] = _iEffectNum;

					_vecEffectName[_iEffectNum] = t_sfd.cFileName;

					//将组合效果的第一个子效果的名称设为文件名。
					_vecEffectList[_iEffectNum][0].setEffectName(_vecEffectName[_iEffectNum]);

					_iEffectNum++;
				}

			}while(FindNextFile(t_hFind,&t_sfd));
		}
		
		FindClose(t_hFind);
	}
#else
	{
		LEResourceInfo* pResInfo(0);
		char szFile[MAX_PATH];

		for(int i(1); i<LEResourceSet::GetInstance().GetLastID() + 1; i++)
		{
			pResInfo = LEResourceSet::GetInstance().GetResourceInfoByID(i);
			if (!pResInfo)
				continue;
			if (pResInfo->GetType() == LEResourceInfo::RT_EFF)
			{
				_vecEffectList.resize( _iEffectNum + 1);
				_vecEffectList[_iEffectNum].clear();
				_vecEffectParam.resize(_iEffectNum + 1);

				//if(!LoadEffectFromFile(_iEffectNum, t_pszFile))
				//	return false;

				_vecEffectName.resize(_iEffectNum + 1);
				_mapEffect[pResInfo->szDataName] = _iEffectNum;
				_vecEffectName[_iEffectNum] = pResInfo->szDataName;
				//SAFE_DELETE_ARRAY(pszDataName);

				//将组合效果的第一个子效果的名称设为文件名。
				//_vecEffectList[_iEffectNum][0].setEffectName(_vecEffectName[_iEffectNum]);

				_iEffectNum++;
			}
		}
	}
#endif
	return true;
}

//void	CLEResManger::UpdateTotalModel()
//{
//	_vecMeshList[0].CreateTriangle();
//	_vecMeshList[1].CreateRect();
//	_vecMeshList[2].CreatePlaneRect();
//}

bool	CLEResManger::LoadTotalVShader()
{
	char t_Path[MAX_PATH];
		
	LPD3DXBUFFER pCode;   //!指令缓冲
	if(!m_bUseSoft)
	{
		DWORD dwEffVerDecl[] =
		{
			D3DVSD_STREAM( 0 ),
				D3DVSD_REG( D3DVSDE_POSITION , D3DVSDT_FLOAT3 ), // Position of first mesh
				D3DVSD_REG( D3DVSDE_BLENDINDICES,D3DVSDT_FLOAT1),
				D3DVSD_REG( D3DVSDE_DIFFUSE, D3DVSDT_D3DCOLOR ), // diffuse
				D3DVSD_REG( D3DVSDE_TEXCOORD0, D3DVSDT_FLOAT2 ), // Tex coords
				D3DVSD_END()
		};

		_snprintf_s(t_Path,MAX_PATH,_TRUNCATE, "shader\\eff1.vsh");
		while(SUCCEEDED(D3DXAssembleShaderFromFile( t_Path, NULL, 0, &pCode, NULL )))
		{
			_iVShaderNum++;
			_vecVShader.resize(_iVShaderNum);
			//_vecVShader[_iVShaderNum - 1] = new DWORD;
		//_DbgOut( " technique.Name", _iTechNum, S_OK,  (TCHAR*)technique.Name );
#ifdef USE_RENDER
			if( FAILED(m_pDev->GetDevice()->CreateVertexShader( dwEffVerDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_vecVShader[_iVShaderNum - 1] , FALSE ) ) )
#else
			if( FAILED(m_pDev->CreateVertexShader( dwEffVerDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_vecVShader[_iVShaderNum - 1] , FALSE ) ) )
#endif
			 {
				MessageBox(NULL,t_Path,"ERROR",0);
				return false;
			 }

			_snprintf_s(t_Path,MAX_PATH, _TRUNCATE,"shader\\eff%d.vsh",_iVShaderNum + 1);
			pCode->Release();
			pCode = NULL;
		}


		DWORD dwFontDecl[] =
		{
			D3DVSD_STREAM( 0 ),
				D3DVSD_REG( D3DVSDE_POSITION ,		D3DVSDT_FLOAT3 ), // Position of first mesh
				D3DVSD_REG( D3DVSDE_BLENDWEIGHT,	D3DVSDT_FLOAT1),
				D3DVSD_REG( D3DVSDE_DIFFUSE,		D3DVSDT_D3DCOLOR ), // diffuse
				D3DVSD_REG( D3DVSDE_TEXCOORD0,		D3DVSDT_FLOAT2 ), // Tex coords
				D3DVSD_END()
		};
		_snprintf_s(t_Path,MAX_PATH,_TRUNCATE,"shader\\font.vsh");
		//_dwFontVS = new DWORD;
		if(SUCCEEDED(D3DXAssembleShaderFromFile( t_Path, NULL, 0, &pCode, NULL )))
		{

#ifdef USE_RENDER
			if( FAILED(m_pDev->GetDevice()->CreateVertexShader( dwFontDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_dwFontVS , FALSE ) ) )
#else
			if( FAILED(m_pDev->CreateVertexShader( dwFontDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_dwFontVS , FALSE ) ) )
#endif
		 {
			 MessageBox(NULL,"shader\\font.vsh","ERROR",0);
			 return false;
		 }
		 pCode->Release();
		 pCode = NULL;
		}
		else
		{
			MessageBox(NULL,"shader\\font.vsh","ERROR",0);
			return false;
		}

		DWORD dwEffShadeDecl[] =
		{
			D3DVSD_STREAM( 0 ),
				D3DVSD_REG( D3DVSDE_POSITION ,		D3DVSDT_FLOAT3 ), // Position of first mesh
				//D3DVSD_REG( D3DVSDE_BLENDWEIGHT,	D3DVSDT_FLOAT1),
				//D3DVSD_REG( D3DVSDE_NORMAL,			D3DVSDT_FLOAT3),
				D3DVSD_REG( D3DVSDE_DIFFUSE,		D3DVSDT_D3DCOLOR ), // diffuse
				D3DVSD_REG( D3DVSDE_TEXCOORD0,		D3DVSDT_FLOAT2 ), // Tex coords
				D3DVSD_REG( D3DVSDE_TEXCOORD1,		D3DVSDT_FLOAT2 ), // Tex coords
				D3DVSD_END()
		};
		_snprintf_s(t_Path,MAX_PATH,_TRUNCATE,"shader\\shadeeff.vsh");
		//_dwShadeMapVS = new DWORD;
		if(SUCCEEDED(D3DXAssembleShaderFromFile( t_Path, NULL, 0, &pCode, NULL )))
		{

#ifdef USE_RENDER
			if( FAILED(m_pDev->GetDevice()->CreateVertexShader( dwEffShadeDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_dwShadeMapVS , FALSE ) ) )
#else
			if( FAILED(m_pDev->CreateVertexShader( dwEffShadeDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_dwShadeMapVS , FALSE ) ) )
#endif
		 {
			 MessageBox(NULL,"shader\\shadeeff.vsh","ERROR",0);
			 return false;
		 }
		 pCode->Release();
		 pCode = NULL;
		}
		else
		{
			MessageBox(NULL,"shader\\shadeeff.vsh","ERROR",0);
			return false;
		}
	}
	else
	{
		DWORD dwEffVerDecl[] =
		{
			D3DVSD_STREAM( 0 ),
				D3DVSD_REG( D3DVSDE_POSITION , D3DVSDT_FLOAT3 ), // Position of first mesh
				D3DVSD_REG( D3DVSDE_BLENDINDICES,D3DVSDT_FLOAT1),
				D3DVSD_REG( D3DVSDE_DIFFUSE, D3DVSDT_D3DCOLOR ), // diffuse
				D3DVSD_REG( D3DVSDE_TEXCOORD0, D3DVSDT_FLOAT2 ), // Tex coords
				D3DVSD_END()
		};

		_snprintf_s(t_Path,MAX_PATH,_TRUNCATE,"shader\\eff2.vsh");
		if(SUCCEEDED(D3DXAssembleShaderFromFile( t_Path, NULL, 0, &pCode, NULL )))
		{
			_iVShaderNum++;
			_vecVShader.resize(_iVShaderNum);
			//_vecVShader[_iVShaderNum - 1] = new DWORD;
			//_DbgOut( " technique.Name", _iTechNum, S_OK,  (TCHAR*)technique.Name );
#ifdef USE_RENDER
			if( FAILED(m_pDev->GetDevice()->CreateVertexShader( dwEffVerDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_vecVShader[_iVShaderNum - 1] , FALSE ) ) )
			{
				//MessageBox(NULL,"shader\\eff2.vsh","ERROR",0);
				//return false;
				_vecVShader[0] = 0L;
			}
#else
			if( FAILED(m_pDev->CreateVertexShader( dwEffVerDecl, 
				(DWORD*)pCode->GetBufferPointer(),
				&_vecVShader[_iVShaderNum - 1] , FALSE ) ) )
			{
				//MessageBox(NULL,"shader\\eff2.vsh","ERROR",0);
				//return false;
				_vecVShader[0] = 0L;
			}
#endif

			pCode->Release();
			pCode = NULL;
		}
	}



	return true;
}

bool	CLEResManger::LoadTotalVShader(drISysGraphics* sys_graphics)
{
	drISystem* sys = sys_graphics->GetSystem();

	char path[ DR_MAX_PATH ];
	drIPathInfo* path_info = 0;
	sys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );

	drIResourceMgr* res_mgr;
	drIShaderMgr* shader_mgr;

	sys_graphics->GetInterface( (DR_VOID**)&res_mgr, DR_GUID_RESOURCEMGR );
	shader_mgr = res_mgr->GetShaderMgr();

	
	DWORD shader_type[] =
	{
		VSTU_EFFECT_E1,
		VSTU_EFFECT_E2,
		VSTU_EFFECT_E3,
		VSTU_EFFECT_E4,
		VSTU_FONT_E5,
		VSTU_SHADE_E6,
		VSTU_MINIMAP_E6,
	};

#if(defined DR_USE_DX8)
	DWORD dwDecEff[] =
	{
		D3DVSD_STREAM( 0 ),
			D3DVSD_REG( D3DVSDE_POSITION , D3DVSDT_FLOAT3 ), // Position of first mesh
			D3DVSD_REG( D3DVSDE_BLENDINDICES,D3DVSDT_FLOAT1),
			D3DVSD_REG( D3DVSDE_DIFFUSE, D3DVSDT_D3DCOLOR ), // diffuse
			D3DVSD_REG( D3DVSDE_TEXCOORD0, D3DVSDT_FLOAT2 ), // Tex coords
			D3DVSD_END()
	};

	if(m_bUseSoft)
	{
		_snprintf_s(path,DR_MAX_PATH, _TRUNCATE,"%s%s", path_info->GetPath( PATH_TYPE_SHADER ), "eff2.vso" );

		if( DR_FAILED( shader_mgr->RegisterVertexShader( shader_type[1], path, 0, dwDecEff, sizeof(dwDecEff),1 )))
		{
			MessageBox(NULL,"load shader\\eff2.vso","ERROR",0);
			return false;
		}
		_iVShaderNum++;
		_vecVShader.resize(_iVShaderNum);
		_vecVShader[_iVShaderNum - 1] = 0;
		shader_mgr->QueryVertexShader(&_vecVShader[_iVShaderNum - 1],shader_type[1]);

		_bMagr = true;
		return true;
	}

	DWORD dwDecFont[] =
	{
		D3DVSD_STREAM( 0 ),
			D3DVSD_REG( D3DVSDE_POSITION ,		D3DVSDT_FLOAT3 ), // Position of first mesh
			D3DVSD_REG( D3DVSDE_BLENDWEIGHT,	D3DVSDT_FLOAT1),
			D3DVSD_REG( D3DVSDE_DIFFUSE,		D3DVSDT_D3DCOLOR ), // diffuse
			D3DVSD_REG( D3DVSDE_TEXCOORD0,		D3DVSDT_FLOAT2 ), // Tex coords
			D3DVSD_END()
	};

	DWORD dwDecShade[] =
	{
		D3DVSD_STREAM( 0 ),
			D3DVSD_REG( D3DVSDE_POSITION ,		D3DVSDT_FLOAT3 ), // Position of first mesh
			//D3DVSD_REG( D3DVSDE_BLENDWEIGHT,	D3DVSDT_FLOAT1),
			//D3DVSD_REG( D3DVSDE_NORMAL,			D3DVSDT_FLOAT3),
			D3DVSD_REG( D3DVSDE_DIFFUSE,		D3DVSDT_D3DCOLOR ), // diffuse
			D3DVSD_REG( D3DVSDE_TEXCOORD0,		D3DVSDT_FLOAT2 ), // Tex coords
			D3DVSD_REG( D3DVSDE_TEXCOORD1,		D3DVSDT_FLOAT2 ), // Tex coords
			D3DVSD_END()
	};
	DWORD dwMapDecl[] =
	{
		D3DVSD_STREAM( 0 ),
			D3DVSD_REG( D3DVSDE_POSITION ,		D3DVSDT_FLOAT3 ), // Position of first mesh
			D3DVSD_REG( D3DVSDE_BLENDWEIGHT,	D3DVSDT_FLOAT1),
			D3DVSD_REG( D3DVSDE_DIFFUSE,		D3DVSDT_D3DCOLOR ), // diffuse
			D3DVSD_REG( D3DVSDE_TEXCOORD0,		D3DVSDT_FLOAT2 ), // Tex coords
			D3DVSD_END()
	};

	DWORD* decl_tab[] =
	{
		dwDecEff,
		dwDecEff,
		dwDecEff,
		dwDecEff,
		dwDecFont,
		dwDecShade,
		dwMapDecl,
	};
	DWORD decl_size[] =
	{
		sizeof(dwDecEff),
		sizeof(dwDecEff),
		sizeof(dwDecEff),
		sizeof(dwDecEff),
		sizeof(dwDecFont),
		sizeof(dwDecShade),
		sizeof(dwMapDecl),
	};

	const char* shader_file[] = 
	{
		"eff1.vso",
		"eff2.vso",
		"eff3.vso",
		"eff4.vso",
		"font.vso",
		"shadeeff.vso",
		"minimap.vso",
	};
	for( int i = 0; i < 7; i++ )
	{
		_snprintf_s(path,DR_MAX_PATH, _TRUNCATE, "%s%s", path_info->GetPath( PATH_TYPE_SHADER ), shader_file[i] );

		if( DR_FAILED( shader_mgr->RegisterVertexShader( shader_type[i], path, 0, decl_tab[i], decl_size[i],1 )))
		{
			MessageBox(NULL,shader_file[i],"ERROR",0);

			return false;
		}
		if(i< 4)
		{
			_iVShaderNum++;
			_vecVShader.resize(_iVShaderNum);
			_vecVShader[_iVShaderNum - 1] = 0;
			shader_mgr->QueryVertexShader(&_vecVShader[_iVShaderNum - 1],shader_type[i]);
		}else
		{
			if(i==4)
				shader_mgr->QueryVertexShader(&_dwFontVS,shader_type[i]);
			if(i==5)
				shader_mgr->QueryVertexShader(&_dwShadeMapVS,shader_type[i]);
			if(i==6)
				shader_mgr->QueryVertexShader(&_dwMinimapVS,shader_type[i]);
		}

	} 
#endif

#if(defined DR_USE_DX9)

    // decl
	D3DVERTEXELEMENT9 ve_effect[] =
	{
        { 0, 0, D3DDECLTYPE_FLOAT3, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_POSITION, 0 },
		{ 0, 12, D3DDECLTYPE_FLOAT1, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_BLENDINDICES, 0 },
		{ 0, 16, D3DDECLTYPE_D3DCOLOR, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_COLOR,  0 },
		{ 0, 20, D3DDECLTYPE_FLOAT2, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_TEXCOORD,  0 },
		
        { 0xFF, 0, D3DDECLTYPE_UNUSED, 0, 0, 0 },

	};

	const char* shader_file[] = 
	{
		"eff1",
	};

    DWORD decl_type[] =
    {
        VDTU_EFFECT1,

    };

    int decl_num = sizeof(decl_type) / sizeof(decl_type[0]);

    for(int i = 0; i < decl_num; i++)
    {
        IDirect3DVertexDeclarationX* this_decl;
        if(DR_SUCCEEDED(shader_mgr->QueryVertexDeclaration(&this_decl, decl_type[i])))
            continue;

        if(DR_FAILED(shader_mgr->RegisterVertexDeclaration(decl_type[i], ve_buf[i])))
            goto __ret;
    }

    // shader
    const int t = 0;
    const char* ext[2] = 
    {
        ".vsh",
        ".vso",
    };

    for(int i = 0; i < 1; i++)
    {
       _snprintf_s(path,DR_MAX_PATH, _TRUNCATE, "%s%s%s", path_info->GetPath(PATH_TYPE_SHADER), shader_file[i], ext[t]);
        if(DR_FAILED(shader_mgr->RegisterVertexShader(shader_type[i], path, t)))
            goto __ret;
    }

#endif

	_bMagr = true;
	return true;
}

//bool	CLEResManger::LoadTotalShadeMap()
//{
//	char t_Path[MAX_PATH];
//	WIN32_FIND_DATA t_sfd;
//	HANDLE  t_hFind = NULL;
//
//	lstrcpy(t_Path,_pszEFFectPath);
//	lstrcat(t_Path,"\\*.shade");
//
//	char t_pszFile[MAX_PATH];
//
//	if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
//		return false;
//	do{
//		if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
//		{
//			_snprintf_s(t_pszFile, "%s\\%s",_pszEFFectPath,t_sfd.cFileName);
//			_vecShadeName.push_back(t_sfd.cFileName);
//
//			_iShadeCnt++;
//			//_vecShade.resize(_iShadeCnt);
//		}
//
//	}while(FindNextFile(t_hFind,&t_sfd));
//	FindClose(t_hFind);
//	return true;
//}

int		CLEResManger::GetEffPathID(const s_string& pszName)
{
#if RESOURCE_SCRIPT == 1
	StrMapIter iter = _mapPath.find(pszName);
	if (iter == _mapPath.end())
		_mapPath.insert(pszName);
#endif

	for (size_t i(0); i<_vecPathName.size(); ++i)
	{
		if (_stricmp(_vecPathName[i].c_str(), pszName.c_str()) == 0)
			// Success
			return (int)i;
	}

	//std::vector<s_string>::iterator it = find( _vecPathName.begin(), _vecPathName.end(), pszName );
	//if ( it != _vecPathName.end() )
	//{
	//	return (int)(it - _vecPathName.begin());
	//}
#if RESOURCE_SCRIPT == 2
	LG("error","msg: CLEResManger::GetEffPathID(),EffPathName=%s",pszName.c_str());
#endif

	// Failure
	return -1;
}

CEffPath*	CLEResManger::GetEffPath(int iID)
{
	return &_vecPath[iID];
}

bool	CLEResManger::LoadTotalPath()
{
#if RESOURCE_SCRIPT == 0 || RESOURCE_SCRIPT == 1
	{
		char t_Path[MAX_PATH];
		WIN32_FIND_DATA t_sfd;
		HANDLE  t_hFind = NULL;

		lstrcpy(t_Path,_pszEFFectPath);
		lstrcat(t_Path,"\\*.csf");

		char t_pszFile[MAX_PATH];

		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			return false;
		do{
			if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			{
				_snprintf_s(t_pszFile, MAX_PATH, _TRUNCATE,"%s\\%s",_pszEFFectPath,t_sfd.cFileName);
				_vecPathName.push_back(t_sfd.cFileName);

				_iPathNum++;
				_vecPath.resize(_iPathNum);
				_vecPath[_iPathNum - 1].LoadPathFromFile(t_pszFile);
			}

		}while(FindNextFile(t_hFind,&t_sfd));
		FindClose(t_hFind);
	}
#else
	{
		LEResourceInfo* pResInfo(0);
		char szFile[MAX_PATH];

		for(int i(1); i<LEResourceSet::GetInstance().GetLastID() +1; i++)
		{
			pResInfo = LEResourceSet::GetInstance().GetResourceInfoByID(i);
			if (!pResInfo)
				continue;
			if (pResInfo->GetType() == LEResourceInfo::RT_PATH)
			{
				_iPathNum++;
				_vecPathName.push_back(pResInfo->szDataName);

				_snprintf_s(szFile, MAX_PATH, _TRUNCATE,"%s\\%s",_pszEFFectPath,pResInfo->szDataName);
				_vecPath.resize(_iPathNum);
				_vecPath[_iPathNum - 1].LoadPathFromFile(szFile);
			}
		}
	}
#endif
	return true;
}

bool	CLEResManger::LoadDefaultText(char* pszFileName)
{
	FILE* pfile;
	fopen_s( &pfile,pszFileName, "rt" );

	if(!pfile)
	{
		MessageBox(NULL,_psDefault,"ERROR",0);
		return false;
	}
	int idx = 0;
	int rval = fgetc(pfile);
	while( rval != EOF )
	{
		_psDefault[idx] = (char)rval;

		rval = fgetc(pfile);

		idx++;
		if(idx >= 418)
			break;
	}
	//
	fclose(pfile);
	return true;
}

int		CLEResManger::GetPartCtrlID(const s_string& pszName)
{
	// _strdup是用malloc分配内存，而删除用delete,有问题
	//pszName.lo

	//char *pszDataName = _strdrr( _strdup( pszName.c_str() ) );
	//s_string strName = pszDataName;

	//transform (pszName.begin(), pszName.end(), //source
	//		   pszName.begin(), //destination
	//			tolower);

#if RESOURCE_SCRIPT == 1
	StrMapIter iter = _mapParticle.find(pszName);
	if (iter == _mapParticle.end())
		_mapParticle.insert(pszName);
	ofstream outfile("ParticleSet.txt", ios_base::app);
	outfile << pszName << "\t0" << endl;
#endif

	for(size_t n(0); n <_vecPartName.size(); n++ )
	{
		if(_stricmp(_vecPartName[n].c_str(), pszName.c_str()) == 0)
		{
			//SAFE_DELETE_ARRAY(pszDataName);
			return (int)n;
		}
	}
	//SAFE_DELETE_ARRAY(pszDataName);
#if RESOURCE_SCRIPT == 2
	LG("error","msg: CLEResManger::GetPartCtrlID(),PartCtrlName=%s",pszName.c_str());
#endif
	return -1;
}

//#ifdef USE_GAME
//CMemoryBuf*		CLEResManger::GetPartCtrlByID(int iID)
//{
//	if(iID > MAXPART_COUNT)
//	{
//		LG("error", "msg特效数量太多，找lemon");
//		return NULL;
//	}
//	if(iID < 0)
//	{
//		LG("error","msg无效ID[%d]",iID);
//		return NULL;
//	}
//	_vecPartCtrl[iID].mseek(0,SEEK_SET);
//	return &_vecPartCtrl[iID];
//}
//#else
CLEPartCtrl*	CLEResManger::GetPartCtrlByID(int iID)
{
	//if((*_vecPartCtrl[iID])->m_iPartNum<=0 && (*_vecPartCtrl[iID])->m_iStripNum <=0 &&  
	//	(*_vecPartCtrl[iID])->GetModelNum()<=0)
	if(iID > MAXPART_COUNT)
	{
		LG("error", "msg特效数量太多，找lemon");
		return NULL;
	}
	if(iID < 0)
	{
		LG("error","msg无效ID[%d]",iID);
		return NULL;
	}
	if((*_vecPartCtrl[iID]) == NULL)
	{
		char t_Path[MAX_PATH];
		_snprintf_s(t_Path, MAX_PATH, _TRUNCATE,"%s\\%s",_pszEFFectPath,_vecPartName[iID].c_str());

		(*_vecPartCtrl[iID]) = new CLEPartCtrl;
		if(!(*_vecPartCtrl[iID])->LoadFromFile(t_Path))
		{
			//SAFE_DELETE( (*_vecPartCtrl[iID]) ); 
			LG("error","msgLoad %s error",_vecPartName[iID].c_str());
			return NULL;
		}
		else
			(*_vecPartCtrl[iID])->MoveTo(&D3DXVECTOR3(0,0,0));
	}
	return (*_vecPartCtrl[iID]);
}
//#endif

void	CLEResManger::LoadTotalPartCtrl()
{
#if RESOURCE_SCRIPT == 0 || RESOURCE_SCRIPT == 1
	//搜索文件目录加载
	{
		char t_Path[MAX_PATH];
		WIN32_FIND_DATA t_sfd;
		HANDLE  t_hFind = NULL;

		char t_FilePath[MAX_PATH];

		lstrcpy(t_Path,_pszEFFectPath);
		lstrcat(t_Path,"\\*.par");

		_vecPartCtrl.resize(MAXPART_COUNT);

		if((t_hFind=FindFirstFile(t_Path,&t_sfd))==INVALID_HANDLE_VALUE)
			return;
		string sFileName;
		do{
			if(!(t_sfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
			{
				_iPartCtrlNum++;

				sFileName = t_sfd.cFileName;
				transform(sFileName.begin(), sFileName.end(),
					sFileName.begin(),
					tolower);
				_vecPartName.push_back(sFileName.c_str());

				#ifdef USE_GAME
				_snprintf_s(t_pszFile, "%s\\%s",_pszEFFectPath,t_sfd.cFileName);
				_vecPartCtrl[_iPartCtrlNum - 1].LoadFile(t_pszFile);
				#else
							_vecPartCtrl.setsize(_iPartCtrlNum);
				#endif
				_snprintf_s(t_FilePath, MAX_PATH, _TRUNCATE,"%s\\%s",_pszEFFectPath,_vecPartName[_iPartCtrlNum - 1].c_str());

				(*_vecPartCtrl[_iPartCtrlNum - 1]) = new CLEPartCtrl;
				if(!(*_vecPartCtrl[_iPartCtrlNum - 1])->LoadFromFile(t_FilePath))
				{
					SAFE_DELETE( (*_vecPartCtrl[_iPartCtrlNum - 1]) ); 
					LG("error","msgLoad %s error",sFileName.c_str());
				}
			}

		}while(FindNextFile(t_hFind,&t_sfd));
		FindClose(t_hFind);
		//#ifdef USE_GAME
		//	_vecPartCtrl.resize(_iPartCtrlNum);
		//#endif
	}
#else
	//从脚本文件中加载
	{
		LEResourceInfo* pResInfo(0);
		for(int i(1); i<LEResourceSet::GetInstance().GetLastID() +1; i++)
		{
			pResInfo = LEResourceSet::GetInstance().GetResourceInfoByID(i);
			if (!pResInfo)
				continue;
			if (pResInfo->GetType() == LEResourceInfo::RT_PAR)
			{
				_iPartCtrlNum++;
				_vecPartName.push_back(pResInfo->szDataName);
			}
		}
	}
#endif
}

CLEPartCtrl*	CLEResManger::NewPartCtrl(const s_string& strName)
{
//#ifndef USE_GAME
	_iPartCtrlNum++;
	if(_iPartCtrlNum >=MAXPART_COUNT)
	{
		_iPartCtrlNum--;
		return NULL;
	}
	_vecPartCtrl.setsize(_iPartCtrlNum);
	_vecPartName.push_back(strName);

	(*_vecPartCtrl[_iPartCtrlNum - 1]) = new CLEPartCtrl;

	return (*_vecPartCtrl[_iPartCtrlNum - 1]);
//#else
//	return NULL;
//#endif
}

void	CLEResManger::DeletePartCtrl(int iID)
{
//#ifndef USE_GAME
	//_iPartCtrlNum--;
	//if(_iPartCtrlNum <0)
	//{
	//	_iPartCtrlNum = 0;
	//	return;
	//}
	//std::vector<s_string>:: iterator it = find(_vecPartName.begin(),_vecPartName.end(),_vecPartName[iID]);
	//if(it != _vecPartName.end())
	//	_vecPartName.erase(it);

	//SAFE_DELETE((*_vecPartCtrl[iID]));
	//_vecPartCtrl.remove(iID);
//#endif
}

CEffectModel*	CLEResManger::NewTobMesh()
{
	CEffectModel* pModel = new CEffectModel;
	pModel->InitDevice(m_pDev,m_pSysGraphics->GetResourceMgr());
	_lstTobMeshs.push_back(pModel);
	_iTobMeshNum++;
	return pModel;
}
bool CLEResManger::DeleteTobMesh(CEffectModel& rEffectModel)
{
	std::list<CEffectModel*>::iterator iter = find(_lstTobMeshs.begin(), _lstTobMeshs.end(), &rEffectModel);
	if (iter != _lstTobMeshs.end())
	{
		delete &rEffectModel;
		_lstTobMeshs.erase(iter);
		return true;
	}
	return false;
}

BOOL CLEResManger::OnResetDevice()
{
#ifdef USE_RENDER

	if(!_CEffectFile.OnResetDevice())
		return FALSE;
	DWORD shader_type[] =
	{
		VSTU_EFFECT_E1,
			VSTU_EFFECT_E2,
			VSTU_EFFECT_E3,
			VSTU_EFFECT_E4,
			VSTU_FONT_E5,
			VSTU_SHADE_E6,
			VSTU_MINIMAP_E6,
	};
	drIShaderMgr* shader_mgr;
	drIResourceMgr* res_mgr;

	m_pSysGraphics->GetInterface( (DR_VOID**)&res_mgr, DR_GUID_RESOURCEMGR );
	shader_mgr = res_mgr->GetShaderMgr();

	if(m_bUseSoft)
	{
		shader_mgr->QueryVertexShader(&_vecVShader[0],shader_type[1]);
	}else
	{
		for( int i = 0; i < 7; i++ )
		{
			if(i< 4)
			{
				shader_mgr->QueryVertexShader(&_vecVShader[i],shader_type[i]);
			}else
			{
				if(i==4)
					shader_mgr->QueryVertexShader(&_dwFontVS,shader_type[i]);
				if(i==5)
					shader_mgr->QueryVertexShader(&_dwShadeMapVS,shader_type[i]);
				if(i==6)
					shader_mgr->QueryVertexShader(&_dwMinimapVS,shader_type[i]);
			}
		} 
	}

	LPDIRECT3DSURFACE8 pBackBuffer;
#ifdef USE_RENDER
	m_pDev->GetDevice()->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pBackBuffer );
#else
	m_pDev->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pBackBuffer );
#endif
	pBackBuffer->GetDesc( &m_d3dBackBuffer );
	pBackBuffer->Release();

	D3DXMatrixOrthoLH(&_Mat2dViewProj, float(m_d3dBackBuffer.Width), float(m_d3dBackBuffer.Height), 0.0f, 1.0f);

	// 在ResetDevice的call back函数中，g_Render的GetScrWidth 还没有重新设置
    // 这里调用drDeviceObject的接口
	_iFontBkWidth = /*m_pDev->GetScrWidth()/2;//*/m_d3dBackBuffer.Width/2;
	_iFontBkHeight= /*m_pDev->GetScrHeight()/2;//*/m_d3dBackBuffer.Height/2;
    //RECT rc_client;
    //m_pDev->GetInterfaceMgr()->dev_obj->GetWindowRect(NULL, &rc_client);
    //_iFontBkWidth = (rc_client.right - rc_client.left) / 2;
    //_iFontBkHeight= (rc_client.bottom - rc_client.top) / 2;


#endif
	return TRUE;
}
BOOL CLEResManger::OnLostDevice()
{
#ifdef USE_RENDER
	if(!_CEffectFile.OnLostDevice())
		return FALSE;
	
#endif
	return TRUE;
}

DR_RESULT	g_OnLostDevice()
{
//#ifdef USE_RENDER
	return ResMgr.OnLostDevice();
//#endif

}
DR_RESULT	g_OnResetDevice()
{
//#ifdef USE_RENDER
	return ResMgr.OnResetDevice();
//#endif
}


void CLEResManger::RestoreEffect()
{
#ifdef USE_RENDER
	m_pDev->SetRenderStateForced(D3DRS_ZENABLE, TRUE);
	m_pDev->SetRenderStateForced(D3DRS_ZWRITEENABLE, TRUE);
	m_pDev->SetRenderStateForced(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
	m_pDev->SetRenderStateForced(D3DRS_ALPHABLENDENABLE, FALSE);
	m_pDev->SetRenderStateForced(D3DRS_ALPHATESTENABLE, FALSE);
	m_pDev->SetRenderStateForced(D3DRS_DITHERENABLE,FALSE);
	m_pDev->SetRenderStateForced(D3DRS_CULLMODE, D3DCULL_CCW); // 单面渲染
	m_pDev->SetRenderStateForced(D3DRS_SRCBLEND,D3DBLEND_ONE);
	m_pDev->SetRenderStateForced(D3DRS_DESTBLEND,D3DBLEND_ZERO);
	m_pDev->SetRenderStateForced(D3DRS_LIGHTING, TRUE);
	m_pDev->SetRenderStateForced(D3DRS_CLIPPING, TRUE);



    m_pDev->GetInterfaceMgr()->dev_obj->SetTextureForced(0, 0);
    m_pDev->GetInterfaceMgr()->dev_obj->SetTextureForced(1, 0);
	m_pDev->SetTextureStageStateForced(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE); 
	m_pDev->SetTextureStageStateForced(0, D3DTSS_ALPHAARG2, D3DTA_DIFFUSE);
	m_pDev->SetTextureStageStateForced(0, D3DTSS_ALPHAOP,   D3DTOP_MODULATE);
	m_pDev->SetTextureStageStateForced(0, D3DTSS_COLORARG1, D3DTA_TEXTURE); 
	m_pDev->SetTextureStageStateForced(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
	m_pDev->SetTextureStageStateForced(0, D3DTSS_COLOROP,   D3DTOP_MODULATE);  
	m_pDev->SetTextureStageStateForced(0, D3DTSS_ADDRESSU,   D3DTADDRESS_WRAP);  
	m_pDev->SetTextureStageStateForced(0, D3DTSS_ADDRESSV,   D3DTADDRESS_WRAP);  
	m_pDev->SetTextureStageStateForced(0, D3DTSS_MINFILTER, D3DTEXF_POINT);
	m_pDev->SetTextureStageStateForced(0, D3DTSS_MAGFILTER, D3DTEXF_POINT);		
	m_pDev->SetTextureStageStateForced(1, D3DTSS_COLOROP, D3DTOP_DISABLE);
    m_pDev->SetTextureStageStateForced(1, D3DTSS_COLORARG1, D3DTA_TEXTURE);
    m_pDev->SetTextureStageStateForced(1, D3DTSS_COLORARG2, D3DTA_CURRENT);
    m_pDev->SetTextureStageStateForced(1, D3DTSS_ALPHAOP, D3DTOP_DISABLE);
    m_pDev->SetTextureStageStateForced(1, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
    m_pDev->SetTextureStageStateForced(1, D3DTSS_ALPHAARG2, D3DTA_CURRENT);

#endif
}
//-----------------------------------------------------------------------------
void CLEResManger::FrameMove(DWORD dwTime)
{
	m_iCurFrame += 1;
	if(m_iCurFrame > 1)
		return;


	_fCurTime = (float)GetTickCount()/1000;
	if(!_bInitTime)
	{
		_fSaveTime = _fCurTime;
		_bInitTime = true;
	}
	_fDailTime = _fCurTime - _fSaveTime;
	_fSaveTime = _fCurTime;

	D3DXMatrixInverse( &_MatBBoard, NULL, _pMatView );
	_MatBBoard._41 = 0.0f;
	_MatBBoard._42 = 0.0f;
	_MatBBoard._43 = 0.0f;

	D3DXMatrixTranspose(&_MatViewProjPose, _pMatViewProj);
	//Transpose(_MatViewProjPose,*_pMatViewProj);
	if(_vecValidID.size() >= MAXMSG_COUNT)
		return;

	for(WORD iw = 0; iw < MAXMSG_COUNT; ++iw)
	{
		if(_vecPartArray[iw])
		{
			_vecPartArray[iw]->FrameMove(dwTime);
		}
	}
}
//-----------------------------------------------------------------------------
void CLEResManger::Render()
{
	if(m_iCurFrame < 1)
		return;
	m_iCurFrame = 0;
	if(_vecValidID.size() >= MAXMSG_COUNT)
		return;

	for(WORD iw = 0; iw < MAXMSG_COUNT; ++iw)
	{
		if(_vecPartArray[iw])
		{
			if(!_vecPartArray[iw]->IsPlaying())
			{
				SAFE_DELETE(_vecPartArray[iw]);
				_vecValidID.push_front(iw);
				continue;
			}
			_vecPartArray[iw]->Render();
		}
	}
}

#ifdef __MEM_DEBUG__
size_t CLEResManger::GetCurUseMemory()	{ return ::GetCurUseMemory();	}
size_t CLEResManger::GetMaxUseMemory()	{ return ::GetMaxUseMemory();	}
DWORD  CLEResManger::GetCurObject()		{ return ::GetCurObject();		}
DWORD  CLEResManger::GetMaxObject()		{ return ::GetMaxObject();		}
void   CLEResManger::EndMemoryCheck()	{ ::EndMemoryCheck();	}
#endif

void CLEResManger::SetErrorReportFunc(ERR_FUNC pFunc)
{
	::SetErrorReportFunc(pFunc);
}

void CLEResManger::SetErrorLogFunc(ERR_FUNC pFunc)
{
	::SetErrorLogFunc(pFunc);
}
