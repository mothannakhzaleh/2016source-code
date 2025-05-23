#include "StdAfx.h"
//#include <LightEngine.h>
#include "GlobalInc.h"
#include "LEModelEff.h"
#include "LERender.h"
#include ".\LEparticlectrl.h"

///************************************************************************/
///*                                                                      */
///************************************************************************/
//CLEParticleCtrl::CLEParticleCtrl(void)
//{
//}
//
//CLEParticleCtrl::~CLEParticleCtrl(void)
//{
//}
///************************************************************************/
///*                                                                      */
///************************************************************************/
//
//CLEParticleTrace::CLEParticleTrace(void)
//{
//	_pCModelEff = NULL;
//	_pCShade	= NULL;
//	m_CFire = NULL;
//	m_CBlast = NULL;
//}
//
//CLEParticleTrace::~CLEParticleTrace(void)
//{
//	SAFE_DELETE(_pCModelEff);
//	SAFE_DELETE(_pCShade);
//
//	SAFE_DELETE(m_CFire);
//	SAFE_DELETE(m_CBlast);
//
//}
////float f = 0;
//
//void	CLEParticleTrace::BindingRes(CLEResManger* pResMagr)
//{
//	m_CFire = new CLEFire;
//
//	m_CFire->Init("火球",5,"Flare.tga",MESH_PLANERECT,D3DXVECTOR2(0,0),5,true);
//	m_CFire->BindingRes(pResMagr);
//	m_CFire->setParticleVel(10);
//	m_CFire->setParticleLife(10);
//	m_CFire->setParticleSizeSmall(1.0f);
//	m_CFire->SetAlphaType(D3DBLEND_SRCALPHA,D3DBLEND_ONE);
//	m_CFire->setParticleColor(0xfffff080);
//	//m_CFire->setParticleFrameColor(m_CFire->getFrameCount() - 1,0x00000000);
//
//
//	m_CBlast = new CLEBlast;
//	m_CBlast->Init("爆炸",10,"Flare.tga",MESH_PLANERECT,D3DXVECTOR2(1.0f,1.0f),5,true);
//	m_CBlast->BindingRes(pResMagr);
//	m_CBlast->setParticleColor(0xffff7000);
//
//	m_bEmiss	= false;
//	m_pfDailTime = pResMagr->GetDailTime();
//	m_vPos		= D3DXVECTOR3(0,0,0);
//	m_vDir		= D3DXVECTOR3(0,0,0);
//	m_fVel		= 7.0f;
//	m_fRadius = 0.2f;
//
//	_pCModelEff = new CLEModelEff;
//	s_string str = "ballfire.eff";
//	int id = pResMagr->GetEffectID(str);
//	_pCModelEff->BindingEffect(pResMagr->GetEffectByID(id));
//	_pCModelEff->BindingRes(pResMagr);
//	_pCModelEff->Scaling(2.f,2.f,2.f);
//
//	//影子
//	_pCShade	= new CLEShadeMap;
//	_pCShade->setTextureName("boxlight2.tga");
//	_pCShade->BoundingRes(pResMagr);
//	_pCShade->CreateShadeMap(4.0f);
//	//_pCShade->CreateSpliteTexture(4,1);
//	_pCShade->SetAlphaType(D3DBLEND_SRCALPHA,D3DBLEND_ONE);
//	_pCShade->SetColor(0xffff8000);
//	//_pCShade->Play();
//
//}
//void	CLEParticleTrace::MoveTo(D3DXVECTOR3 vPos,LEMap* pMap)
//{
//	if(m_bEmiss)
//	{
//		_pCModelEff->MoveTo(m_vPos.x,m_vPos.y,m_vPos.z);
//
//		_pCShade->MoveTo(m_vPos,pMap);
//	}
//}
//
//void	CLEParticleTrace::FrameMove(DWORD	dwDailTime)
//{
//	if(m_bEmiss)
//	{
//
//		//! 在这里得到目标ID的位置，判断目标的新位置是否和目标点是一致的。
//
//		//SetTarget(D3DXVECTOR3(f,20,0));
//
//		m_CFire->MoveTo(m_vPos);
//
//		m_CFire->FrameMove(dwDailTime);
//
//
//		_pCModelEff->FrameMove(dwDailTime);
//	
//		_pCShade->FrameMove(dwDailTime);
//
//	}
//	m_CBlast->FrameMove(dwDailTime);
//
//}
//
//void	CLEParticleTrace::Render()
//{
//
//	if(m_bEmiss)
//	{
//		m_CFire->Render();
//		_pCModelEff->Render();
//		_pCShade->Render();
//
//	}
//	m_CBlast->Render();
//}
//
//void	CLEParticleTrace::Emission(WORD wID, D3DXVECTOR3 vBegin, D3DXVECTOR3 vEnd)
//{
//	if(m_bEmiss)
//		return;
//	m_wID = wID;
//
//	m_CPath[0] = vBegin;
//	m_CPath[1] = vEnd;
//	m_vPos		= vBegin;

//
//	m_CFire->Reset(false);
//	m_CFire->MoveTo(vBegin);
//
//	m_vDir = vEnd - vBegin;
//	m_fDist = D3DXVec3LengthSq(&m_vDir);
//
//	D3DXVec3Normalize(&m_vDir,&m_vDir);
//	m_bEmiss	= true;
//
//	_pCModelEff->Play();
//	_pCShade->Show(TRUE);
//
//	_bHit = false;
//	//f = 0;
//}
//void	CLEParticleTrace::Blast()
//{
//		m_bEmiss	= false;
//		m_CBlast->MoveTo(m_vPos);
//		m_CBlast->Play();
//
//		_pCModelEff->Stop();
//		_pCShade->Show(FALSE);
//
//		_bHit =  true;
//}
//
//void	CLEParticleTrace::SetTarget(D3DXVECTOR3 vTarget)
//{
//	float fDist  = m_fVel * *m_pfDailTime;
//	m_vPos	 += m_vDir * fDist;
//	if(PointInstrPointRange(&m_vPos,&m_CPath[1] ,m_fRadius))
//	{
//		//m_vPos.z -= 0.9f;
//		Blast();
//		return;
//	}
//	//!如果目标的新位置和老位置相同，返回！
//	if(vTarget  == m_CPath[1])
//		return;
//	//!得到目标的老位置向新位置移动的方向
//	m_vTargDir = vTarget - m_CPath[1];
//	//!得到目标的老位置和新位置之间的距离
//	m_fTargDist = D3DXVec3LengthSq(&m_vTargDir);
//	D3DXVec3Normalize(&m_vTargDir, &m_vTargDir);
//
//	//!得到粒子的位置需要向目标移动的方向移动的距离.
//	//	公式为：距离 = 目标移动的距离 / 最初计算出的源和目标的距离 * 粒子当前位置和上一帧位置的距离
//	float flerp = (m_fTargDist / m_fDist) * fDist;
//	//m_fDist = fDist;//D3DXVec3Length(&(m_vPos - m_vOldPos));
//
//	//!按照目标移动的方向去移动粒子
//	m_vPos	 += m_vTargDir * flerp;
//	//!重新计算当前粒子需要移动的方向和距离。
//	m_CPath[1] = vTarget;
//	m_vDir = vTarget - m_vPos;
//	m_fDist = D3DXVec3LengthSq(&m_vDir);
//	D3DXVec3Normalize(&m_vDir,&m_vDir);
//}
//
///************************************************************************/
///*                                                                      */
///************************************************************************/
//
//CLEParticleRipple::CLEParticleRipple(void)
//{
//}
//
//CLEParticleRipple::~CLEParticleRipple(void)
//{
//	SAFE_DELETE(m_CRippleStop);
//	SAFE_DELETE(m_CRippleMove);
//}
//
//void	CLEParticleRipple::BindingRes(CLEResManger* pResMagr)
//{
//
//	m_CRippleStop = new CLERipple;
//	m_CRippleStop->Init("波纹",5,"Ripple.tga",MESH_PLANERECT,D3DXVECTOR2(0.f,0.f),4,false);
//	m_CRippleStop->BindingRes(pResMagr);
//	m_CRippleStop->setParticleLife(100);
//	m_CRippleStop->SetAlphaType(D3DBLEND_SRCALPHA,D3DBLEND_INVSRCALPHA);
//	m_CRippleStop->setParticleSize(1.0f);
//	//m_CRipple->Play();
//
//	m_CRippleMove = new CLERipple;
//	m_CRippleMove->Init("波纹2",13,"Ripple2.tga",MESH_PLANERECT,D3DXVECTOR2(0.f,0.f),4,false);
//	m_CRippleMove->BindingRes(pResMagr);
//	m_CRippleMove->SetAlphaType(D3DBLEND_SRCALPHA,D3DBLEND_INVSRCALPHA);
//	m_CRippleMove->setParticleLife(200);
//	m_CRippleMove->setParticleSize(2.0f);
//
//
//	//m_CRipple.Play();
//
//	m_pfDailTime = pResMagr->GetDailTime();
//	//m_vPos		= D3DXVECTOR3(0,0,0);
//}
//
//void	CLEParticleRipple::FrameMove(DWORD	dwDailTime)
//{
//
//		//! 在这里得到目标ID的位置，判断目标的新位置是否和目标点是一致的。
//
//
//		//SetTarget(D3DXVECTOR3(0,20,0));
//
//	m_CRippleStop->FrameMove(dwDailTime);
//
//	m_CRippleMove->FrameMove(dwDailTime);
//}
//
//void	CLEParticleRipple::Render()
//{
//	m_CRippleStop->Render();
//	m_CRippleMove->Render();
//}
//
//void	CLEParticleRipple::Emission(WORD wID, D3DXVECTOR3 vBegin, D3DXVECTOR3 vEnd)
//{
//	//m_wID = wID;
//	Walk();
//}
//
//void	CLEParticleRipple::SetTarget(D3DXVECTOR3 vTarget, D3DXVECTOR3 vTarget2,float fAngle)
//{	
//	m_CRippleMove->SetAngle(fAngle);
//	m_CRippleStop->SetAngle(fAngle);
//	if(m_vPos == vTarget)
//		return;
//	m_vPos = vTarget;
//	m_CRippleMove->MoveTo(vTarget2);
//	m_CRippleStop->MoveTo(vTarget);
//}
//void	CLEParticleRipple::Walk()
//{
//	//if(!m_CRippleMove->IsPlaying())
//		m_CRippleMove->Play();
//	m_CRippleStop->Stop();
//	//m_CRippleStop->Reset(m_vPos);
//
//}
//void	CLEParticleRipple::Stop()
//{
//	m_CRippleMove->Stop();
//	//m_CRippleMove->Reset(m_vPos);
//
//	//if(!m_CRippleStop->IsPlaying())
//		m_CRippleStop->Play();
//}


/************************************************************************/
/* class CLEPartCtrl*/
/************************************************************************/
CLEPartCtrl::CLEPartCtrl(void)
{
	m_strName = "无名";
	m_iPartNum = 0;
#ifndef USE_GAME
	//m_vecPartSys.resize(MAX_PART_SYS);//最大粒子系统的数目不能大于6
#endif
	m_fLength = 0;//如果长度为0，则循环播放
	m_fCurTime = 0;

	m_iStripNum = 0;
	m_pcStrip = NULL;

	m_iModelNum = 0;
	//m_iShadeNum = 0;;
}
CLEPartCtrl::~CLEPartCtrl(void)
{
	SAFE_DELETE_ARRAY(m_pcStrip);
	for (int n = 0; n <m_iModelNum; n++ )
	{
		SAFE_DELETE(m_vecModel[n]);
	}
	m_vecModel.clear();
	//m_vecShade.clear();
}

void	CLEPartCtrl::SetStripCharacter(LECharacter* pCha)
{
	for ( int n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].AttachCharacter(pCha);
	}
}
void	CLEPartCtrl::SetStripItem(LESceneItem* pItem,bool bloop)
{
	for ( int n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].AttachItem(pItem);
		m_pcStrip[n].SetLoop(bloop);
	}
}

void	CLEPartCtrl::SetItemDummy(LESceneItem* pItem, int dummy1, int dummy2)
{
	for (int n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->SetItemDummy(pItem,dummy1,dummy2);
	}
}


CChaModel*	CLEPartCtrl::NewModel(const s_string& strID,CLEResManger* pResMagr)
{
	m_iModelNum++;
	if( m_iModelNum > 1)
	{
		m_iModelNum = 1;
		return NULL;
	}
	m_vecModel.resize(m_iModelNum);

	m_vecModel[m_iModelNum-1] = new CChaModel;
	m_vecModel[m_iModelNum-1]->m_pDev = pResMagr->m_pDev;

	m_vecModel[m_iModelNum-1]->LoadScript(strID);
	m_vecModel[m_iModelNum-1]->SetVel(120);
	m_vecModel[m_iModelNum-1]->SetPlayType(PLAY_LOOP);
	m_vecModel[m_iModelNum-1]->SetCurPose(1);
	m_vecModel[m_iModelNum-1]->PlayPose(0,PLAY_PAUSE);

	return m_vecModel[m_iModelNum-1];
}
CChaModel*	CLEPartCtrl::GetModel(int iIdx)
{
	return m_vecModel[iIdx];
}

CLEStrip*	CLEPartCtrl::NewStrip(const s_string& strTex,CLEResManger* pResMagr)
{
	SAFE_DELETE_ARRAY(m_pcStrip);

	m_iStripNum = 1;
	m_pcStrip = new CLEStrip[m_iStripNum];
	m_pcStrip[0].CreateStrip(pResMagr->m_pDev,strTex,pResMagr);
	return &m_pcStrip[0];
}

CLEStrip*	CLEPartCtrl::GetStrip(int iIdx)
{ 
	return &m_pcStrip[iIdx];
}

void	CLEPartCtrl::SetPlayType(int nType)
{
	if(nType == 0)//循环播放
	{
		int n = 0;
		for ( n = 0; n < m_iPartNum; ++n)
		{
			m_vecPartSys[n]->SetPlayTime(0);
			//m_vecPartSys[n]->SetDelayTime(0);
			m_vecPartSys[n]->SetLoop(true);
		}
		for (n = 0; n <m_iModelNum; n++ )
		{
			m_vecModel[n]->SetPlayType(PLAY_LOOP);
			m_vecModel[n]->Play();
		}
	//}else if(nType == 1)//按帧数播放
	//{
	//	for (int n = 0; n < m_iPartNum; ++n)
	//	{
	//		m_vecPartSys[n]->SetPlayTime(0);
	//		m_vecPartSys[n]->SetDelayTime(0); 
	//		m_vecPartSys[n]->SetLoop(false);
	//	}
	//}else if(nType == 2)//按时间播放
	//{
	//	for (int n = 0; n < m_iPartNum; ++n)
	//	{
	//		m_vecPartSys[n]->SetLoop(true);
	//	}
	}
}


void	CLEPartCtrl::Play(int iTime)
{
	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->Play(iTime);
	}
	for ( n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].Play();
	}
	for (n = 0; n <m_iModelNum; n++ )
	{
		m_vecModel[n]->Play();
	}
}
bool	CLEPartCtrl::IsPlaying()
{
	if(m_iPartNum>0)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if(m_vecPartSys[n]->IsPlaying())
				return true;
		}
		//Reset();
	}else if(m_iStripNum>0)
	{
		for (int n = 0; n < m_iStripNum; ++n)
		{
			if(m_pcStrip[n].IsPlaying())
				return true;
		}
	}else
	{
		for (int n = 0;n <m_iModelNum; n++)
		{
			if(m_vecModel[n]->IsPlaying())
				return true;
		}
	}
	return false;
}
void	CLEPartCtrl::CopyPartCtrl(CLEPartCtrl* pPart)
{
	m_strName = pPart->m_strName;

	m_vecPartSys.resize(pPart->m_iPartNum);
 
	int n = 0;
	for ( n = 0; n < pPart->m_iPartNum; ++n)
	{
		AddPartSys(pPart->m_vecPartSys[n]);
	}
	SAFE_DELETE_ARRAY(m_pcStrip);
	m_iStripNum = pPart->m_iStripNum;
	if(m_iStripNum)
	{
		m_pcStrip = new CLEStrip[m_iStripNum];
		for ( n = 0; n < m_iStripNum; ++n)
		{
			m_pcStrip[n].CopyStrip(&pPart->m_pcStrip[n]);
		}
	}
	for (n = 0; n <m_iModelNum; n++ )
	{
		SAFE_DELETE(m_vecModel[n]);
	}
	m_iModelNum = pPart->m_iModelNum;
	CChaModel* pModel;
	char psID[32];
	m_vecModel.resize(m_iModelNum);
	for (n = 0; n <m_iModelNum; n++ )
	{
		pModel = pPart->m_vecModel[n];
		m_vecModel[n] = new CChaModel;
		_snprintf_s(psID,32, _TRUNCATE,"%d",pModel->GetID());
		if(!m_vecModel[n]->LoadScript(psID))
		{
			LG("error","msgLoadScript %s",psID);
		}
		m_vecModel[n]->SetVel(pModel->GetVel());
		m_vecModel[n]->SetPlayType(pModel->GetPlayType());
		m_vecModel[n]->SetCurPose(pModel->GetCurPose());
		m_vecModel[n]->SetCurColor(pModel->GetCurColor());
		m_vecModel[n]->SetSrcBlend(pModel->GetSrcBlend());
		m_vecModel[n]->SetDestBlend(pModel->GetDestBlend());
		m_vecModel[n]->PlayPose(0,PLAY_PAUSE);
	}
}

void	CLEPartCtrl::BindingRes(CLEResManger* pResMagr)
{
	m_pfDailTime = pResMagr->GetDailTime();

	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->BindingRes(pResMagr);
	}
	for ( n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].BindingRes(pResMagr);
	}
	for (n = 0; n <m_iModelNum; n++ )
	{
		m_vecModel[n]->m_pDev = pResMagr->m_pDev;
	}
}

CLEPartSys*		CLEPartCtrl::AddPartSys(CLEPartSys* part)
{
	m_iPartNum++;
	if( m_iPartNum > MAX_PART_SYS)
	{
		m_iPartNum = MAX_PART_SYS;
		return NULL;
	}
	m_vecPartSys.setsize(m_iPartNum);
	CopyPartSys(m_vecPartSys[m_iPartNum-1],part);

	//Reset();
	return m_vecPartSys[m_iPartNum-1];
}

CLEPartSys*	CLEPartCtrl::NewPartSys()
{
	m_iPartNum++;
	if( m_iPartNum > MAX_PART_SYS)
	{
		m_iPartNum = MAX_PART_SYS;
		return NULL;
	}
	m_vecPartSys.setsize(m_iPartNum);
	return m_vecPartSys[m_iPartNum-1];
}
void	CLEPartCtrl::DeletePartSys(int iID)
{
	if(iID < 0)
		return;
	if(m_iPartNum == 0)
		return;
	m_iPartNum--;
	m_vecPartSys.remove(iID);
}

void	CLEPartCtrl::Clear()
{
	m_iPartNum = 0;
	m_vecPartSys.clear();
}
void CLEPartCtrl::UpdateStrip()
{
	for ( int n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].UpdateFrame();
	}
}
void	CLEPartCtrl::FrameMove(DWORD	dwDailTime)
{
	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->FrameMove(dwDailTime);
	}
	for ( n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].FrameMove();
	}
	for (n = 0; n <m_iModelNum; n++ )
	{
		if(m_vecModel[n]->IsPlaying())
		{
			m_vecModel[n]->UpdateMatrix();
			m_vecModel[n]->FrameMove();
		}
	}
}
void	CLEPartCtrl::Render()
{
	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->Render();
	}
	for ( n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].Render();
	}
	for (n = 0; n <m_iModelNum; n++ )
	{
		if(m_vecModel[n]->IsPlaying())
		{
			m_vecModel[n]->Begin();
			m_vecModel[n]->Render();
			m_vecModel[n]->End();
		}
	}
}

bool	CLEPartCtrl::SaveToFile(char* pszName)
{
	if (strcmp(pszName, "no") == 0 || strcmp(pszName, "yes") == 0)
	{
		int i;
		i=1;
	}

	FILE* t_pFile;
	fopen_s( &t_pFile, pszName, "wb");
	if(!t_pFile)
	{
		LG("error","msg %s,只读文件，打开失败",pszName);
		return false;
	}

	//!版本
	DWORD t_dwVersion = CLEPartCtrl::ParVersion;
	fwrite(&t_dwVersion,sizeof(t_dwVersion),1,t_pFile);

	char pszPartName[32];
	lstrcpy(pszPartName,m_strName.c_str());
	fwrite(pszPartName,sizeof(char),32,t_pFile);

	fwrite(&m_iPartNum,sizeof(int),1,t_pFile);

	fwrite(&m_fLength,sizeof(float),1,t_pFile);

	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->SaveToFile(t_pFile);
	}
	//////////////////////////////////////////////////////////////////////////
	fwrite(&m_iStripNum,sizeof(int),1,t_pFile);
	for ( n = 0; n < m_iStripNum; ++n)
	{
		m_pcStrip[n].SaveToFile(t_pFile);
	}
	fwrite(&m_iModelNum,sizeof(int),1,t_pFile);
	for ( n = 0; n < m_iModelNum; ++n)
	{
		m_vecModel[n]->SaveToFile(t_pFile);
	}
	fclose(t_pFile);
	return true;
}
bool	CLEPartCtrl::LoadFromFile(char* pszName)
{
	FILE* t_pFile;
	fopen_s( &t_pFile, pszName, "rb");
	
	if (t_pFile == NULL)
	{
		LG("error", "msg[%s] was not opened.(CLEPartCtrl::LoadFromFile)\n", pszName);
		return false;
	}
	if (strcmp(pszName, "no") == 0 || strcmp(pszName, "yes") == 0)
	{
		int i;
		i=1;
	}
	string sName = pszName;

	//!版本
	DWORD t_dwVersion;
	fread(&t_dwVersion,sizeof(t_dwVersion),1,t_pFile);
	if ( t_dwVersion > CLEPartCtrl::ParVersion)
	{
		LG("error", "msg[%s]的版本[%d]高于系统的版本[%d] (CLEPartCtrl::LoadFromFile)\n",pszName,t_dwVersion,CLEPartCtrl::ParVersion);
		return false;
	}
	if(t_dwVersion < 2)
	{
		LG("error", "msg[%s]的版本[%d]低于系统能处理的版本[%d] (CLEPartCtrl::LoadFromFile)\n",pszName,t_dwVersion,2);
		return false;
	}

	char pszPartName[32];
	fread(pszPartName,sizeof(char),32,t_pFile);
	m_strName = pszPartName;

	fread(&m_iPartNum,sizeof(int),1,t_pFile);
#ifdef USE_GAME
	m_vecPartSys.resize(m_iPartNum);
#endif
	m_vecPartSys.setsize(m_iPartNum);

	if(t_dwVersion >= 3)
	{
		fread(&m_fLength,sizeof(float),1,t_pFile);
	}
	else
	{
		m_fLength = 0;
	}

	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		if (!m_vecPartSys[n]->LoadFromFile(t_pFile,t_dwVersion))
		{
			LG("error", "msg[%s]的第[%d]个子系统加载失败.(CLEPartCtrl::LoadFromFile)\n", pszName, n);
			return false;
		}
		if(t_dwVersion < 6)
		{
			m_vecPartSys[n]->SetPlayTime(m_fLength);
		}
	}
	//////////////////////////////////////////////////////////////////////////
	if(t_dwVersion >= 7)
	{
		SAFE_DELETE_ARRAY(m_pcStrip);

		fread(&m_iStripNum,sizeof(int),1,t_pFile);

		m_pcStrip = new CLEStrip[m_iStripNum];

		for ( n = 0; n < m_iStripNum; ++n)
		{
			if (!m_pcStrip[n].LoadFromFile(t_pFile,t_dwVersion))
			{
				LG("error", "msg[%s]的第[%d]个Strip加载失败.(CLEPartCtrl::LoadFromFile)\n", pszName, n);
				delete m_pcStrip;
				return false;
			}
		}
	}
	if(t_dwVersion >= 8)
	{
		fread(&m_iModelNum,sizeof(int),1,t_pFile);
		m_vecModel.resize(m_iModelNum);
		for ( n = 0; n < m_iModelNum; ++n)
		{
			m_vecModel[n] = new CChaModel;
			m_vecModel[n]->LoadFromFile(t_pFile);
		}
	}
	fclose(t_pFile);
	return true;
}

bool	CLEPartCtrl::LoadFromMemory(CMemoryBuf*	pbuf)
{
	//!版本
	DWORD t_dwVersion;
	pbuf->mread(&t_dwVersion,sizeof(t_dwVersion),1);
	if ( t_dwVersion > CLEPartCtrl::ParVersion)
	{
		LG("error", "msg版本[%d]高于系统的版本[%d] (CLEPartCtrl::LoadFromFile)\n",t_dwVersion,CLEPartCtrl::ParVersion);
		return false;
	}
	if(t_dwVersion < 2)
	{
		LG("error", "msg版本[%d]低于系统能处理的版本[%d] (CLEPartCtrl::LoadFromFile)\n",t_dwVersion,2);
		return false;
	}

	char pszPartName[32];
	pbuf->mread(pszPartName,sizeof(char),32);
	m_strName = pszPartName;

	pbuf->mread(&m_iPartNum,sizeof(int),1);
#ifdef USE_GAME
	m_vecPartSys.resize(m_iPartNum);
#endif
	m_vecPartSys.setsize(m_iPartNum);

	if(t_dwVersion >= 3)
	{
		pbuf->mread(&m_fLength,sizeof(float),1);
	}
	else
	{
		m_fLength = 0;
	}
	int n = 0;
	for ( n = 0; n < m_iPartNum; ++n)
	{
		m_vecPartSys[n]->LoadFromMemory(pbuf,t_dwVersion);
		if(t_dwVersion < 6)
		{
			m_vecPartSys[n]->SetPlayTime(m_fLength);
		}
	}
	//////////////////////////////////////////////////////////////////////////
	if(t_dwVersion >= 7)
	{
		SAFE_DELETE_ARRAY(m_pcStrip);

		pbuf->mread(&m_iStripNum,sizeof(int),1);

		if(m_iStripNum > 0)
		{
			m_pcStrip = new CLEStrip[m_iStripNum];

			for ( n = 0; n < m_iStripNum; ++n)
			{
				m_pcStrip[n].LoadFromMemory(pbuf,t_dwVersion);
			}
		}
	}

	if(t_dwVersion >= 8)
	{
		pbuf->mread(&m_iModelNum,sizeof(int),1);
		m_vecModel.resize(m_iModelNum);
		for ( n = 0; n < m_iModelNum; ++n)
		{
			m_vecModel[n] = new CChaModel;
			m_vecModel[n]->LoadFromMemory(pbuf);
		}
	}
	return true;
}

void	CLEPartCtrl::GetRes(CLEResManger* pResMagr,std::vector<INT>& vecTex,std::vector<INT>& vecModel,
								   std::vector<INT>& vecEff)
{
	char pszPath[MAX_PATH];
	char pszNewPath[MAX_PATH];
	std::vector<INT>::	iterator it;
	int id = -1;

	int n;
	int idtex, idmodel,ideff;
	s_string strName;
	if(m_iStripNum > 0)
	{
		for ( n = 0; n < m_iStripNum; ++n)
		{
			strName = m_pcStrip[n].GetTexName();
			id = pResMagr->GetTextureID(strName);
			if(id >= 0)
			{
				it = std::find( vecTex.begin(), vecTex.end(), id );
				if(it == vecTex.end())
				{
					vecTex.push_back(id);
					_snprintf_s(pszPath,MAX_PATH, _TRUNCATE,"texture/effect/%s",strName.c_str());
					_snprintf_s(pszNewPath,MAX_PATH, _TRUNCATE,"effect/new/texture/%s",strName.c_str());
					if(!::CopyFile(pszPath,pszNewPath,FALSE))
					{
					}
				}
			}
		}
	}else if(m_iPartNum > 0)
	{
		for ( n = 0; n < m_iPartNum; ++n)
		{
			m_vecPartSys[n]->GetRes(idtex,  idmodel,  ideff);
			if(idtex >= 0)
			{
				it = std::find( vecTex.begin(), vecTex.end(), idtex );
				if(it == vecTex.end())
				{
					vecTex.push_back(idtex);
				}
			}
			if(idmodel >= 0)
			{
				it = std::find( vecModel.begin(), vecModel.end(), idmodel );
				if(it == vecModel.end())
				{
					vecModel.push_back(idmodel);
				}
			}
			if(ideff >= 0)
			{
				it = std::find( vecEff.begin(), vecEff.end(), ideff );
				if(it == vecEff.end())
				{
					vecEff.push_back(ideff);
				}
			}
		}
	}
}

void	CLEPartCtrl::GetHitRes(CLEResManger* pResMagr,std::vector<s_string>& vecPar)
{
	if(m_iStripNum > 0)
	{
		return;
	}else if(m_iPartNum > 0)
	{
		s_string strname;
		int id,n;
		for ( n = 0; n < m_iPartNum; ++n)
		{
			strname = m_vecPartSys[n]->GetHitEff();
			
			id = pResMagr->GetPartCtrlID(strname);
			if(id >= 0)
			{
				vecPar.push_back(strname);
			}
		}
	}
}

/************************************************************************/
/*                                                                      */
/************************************************************************/

static void keyframe_proc( DWORD type, DWORD pose_id, DWORD key_id, DWORD key_frame, void* param )
{
	CChaModel* pCha = ((CChaModel*)param);
	switch( type )
	{
	case KEYFRAME_TYPE_BEGIN:
		{//if(pCha->GetStrip())
		//	pCha->GetStrip()->Play(0);
			pCha->SetPlaying(true);
		break;
		}
	case KEYFRAME_TYPE_KEY:
		{
			//if(pCha->GetStrip())
			//	pCha->GetStrip()->UpdateStrip();
			break;
		}
	case KEYFRAME_TYPE_END:
		//if(pCha->GetStrip())
		//	pCha->GetStrip()->UpdateStrip();
		if(pCha->GetPlayType()!= PLAY_LOOP)
		{
			pCha->SetPlaying(false);
		}
		break;
	}
}

bool	CChaModel::LoadScript(const s_string& strModel)
{
	LEChaLoadInfo	sModel;
	SChaAction	sAction;

	if(!CScriptFile::m_ctScript.ReadSection((char*)(LPCSTR)strModel.c_str()))
		return false;
	if( !CScriptFile::m_ctScript.ReadLine( "骨骼",sModel.bone,64 ) )
		return false;

	_iID = atoi((char*)(LPCSTR)strModel.c_str());

	char str[64];
	for( short i = 0; i < 5; i++ )
	{
		_snprintf_s(str,64, _TRUNCATE,"皮肤%d",i+1);
		if( !CScriptFile::m_ctScript.ReadLine( str,sModel.part[i],64 ) )
			return false;
	}
	if(!LoadChaModel(sModel))
		return false;
	if(!CScriptFile::m_ctScript.GetCharAction(atoi((char*)(LPCSTR)strModel.c_str()), &sAction))
		return false;
	if(!LoadPose(sAction))
		return false;
	SetPoseKeyFrameProc( keyframe_proc, (void*)this );

	return true;
}


bool	CChaModel::LoadChaModel(LEChaLoadInfo& info)
{
	if(strlen( info.bone ) <= 0)
		return false;
	if( FAILED( LECharacter::Load( &info ) ) )
	{
		return false;
	}
	return true;
}
bool	CChaModel::LoadPose(SChaAction& SCharAct)
{
	drPoseInfo pi;
	memset( &pi, 0, sizeof(pi) );
	for (int iActCount = 0; iActCount < SCharAct.m_iMaxActionNum; iActCount ++)
	{
		if (SCharAct.m_SActionInfo[iActCount].m_sActionNO < 1)
			continue;
		pi.start = SCharAct.m_SActionInfo[iActCount].m_sStartFrame;
		pi.end = SCharAct.m_SActionInfo[iActCount].m_sEndFrame;
		pi.key_frame_num =
			SCharAct.m_SActionInfo[iActCount].m_sKeyFrameNum < MAX_KEY_FRAME_NUM ? SCharAct.m_SActionInfo[iActCount].m_sKeyFrameNum : MAX_KEY_FRAME_NUM;
		for (int iKeyFrameCount = 0; iKeyFrameCount < (short)pi.key_frame_num; iKeyFrameCount ++)
			pi.key_frame_seq[iKeyFrameCount] = SCharAct.m_SActionInfo[iActCount].m_sKeyFrame[iKeyFrameCount];

		if( GetPoseCtrl() )
		{
			GetPoseCtrl()->InsertPose( SCharAct.m_SActionInfo[iActCount].m_sActionNO, &pi, 1 );
		}
	}
	return true;
}
void	CChaModel::PlayPose(DWORD id, DWORD type)
{
	LECharacter::PlayPose( id, type, 0.0f, _fVel );
}

void	CChaModel::Begin()
{
	m_pDev->GetDevice()->SetRenderState( D3DRS_LIGHTING, TRUE );
	m_pDev->SetRenderState( D3DRS_AMBIENT, 0xffffffff );

	m_pDev->GetDevice()->SetRenderState(D3DRS_ZENABLE, TRUE);
	m_pDev->GetDevice()->SetRenderState(D3DRS_ZWRITEENABLE, TRUE);
	m_pDev->GetDevice()->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
	m_pDev->GetDevice()->SetRenderState(D3DRS_SRCBLEND,  _eSrcBlend);	 
	m_pDev->GetDevice()->SetRenderState(D3DRS_DESTBLEND, _eDestBlend);
#ifdef USE_RENDER
	D3DMATERIALX mtl;
	mtl.Ambient = (D3DCOLORVALUE)_dwCurColor;
	mtl.Diffuse = (D3DCOLORVALUE)_dwCurColor;
	SetMaterial(&mtl);
	SetOpacity(_dwCurColor.a);
#else
	m_pDev->SetRenderState(D3DRS_DITHERENABLE,FALSE);
	m_pDev->SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW); // 单面渲染

	m_pDev->SetRenderState(D3DRS_TEXTUREFACTOR, _dwCurColor );

	m_pDev->SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE); 
	m_pDev->SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_TFACTOR);
	m_pDev->SetTextureStageState(0, D3DTSS_ALPHAOP,   D3DTOP_MODULATE);

	m_pDev->SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE); 
	m_pDev->SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_TFACTOR);
	m_pDev->SetTextureStageState(0, D3DTSS_COLOROP,   D3DTOP_MODULATE);  

	m_pDev->SetTextureStageState( 0, D3DTSS_MAGFILTER, D3DTEXF_POINT);		
	m_pDev->SetTextureStageState( 0, D3DTSS_MINFILTER, D3DTEXF_POINT);
#endif

}
void	CChaModel::End()
{
	m_pDev->GetDevice()->SetRenderState( D3DRS_LIGHTING, FALSE);

	m_pDev->GetDevice()->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
	m_pDev->GetDevice()->SetRenderState(D3DRS_ZWRITEENABLE, FALSE);

	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE); 
	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_DIFFUSE);
	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_ALPHAOP,   D3DTOP_MODULATE);

	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE); 
	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
	m_pDev->GetDevice()->SetTextureStageState(0, D3DTSS_COLOROP,   D3DTOP_MODULATE);  
}

void	CChaModel::SaveToFile(FILE* file)
{
	fwrite(&_iID,sizeof(int),1,file);
	fwrite(&_fVel,sizeof(float),1,file);
	fwrite(&_iPlayType,sizeof(int),1,file);
	fwrite(&_iCurPose,sizeof(int),1,file);

	int eblend = (int)_eSrcBlend;
	fwrite(&eblend,sizeof(int),1,file);
	eblend = (int)_eDestBlend;
	fwrite(&eblend,sizeof(int),1,file);
	fwrite(&_dwCurColor,sizeof(D3DXCOLOR),1,file);

}
void	CChaModel::LoadFromFile(FILE* file)
{
	fread(&_iID,sizeof(int),1,file);
	fread(&_fVel,sizeof(float),1,file);
	fread(&_iPlayType,sizeof(int),1,file);
	fread(&_iCurPose,sizeof(int),1,file);

	int eblend;
	fread(&eblend,sizeof(int),1,file);
	_eSrcBlend = (D3DBLEND)eblend;
	fread(&eblend,sizeof(int),1,file);
	_eDestBlend = (D3DBLEND)eblend;
	fread(&_dwCurColor,sizeof(D3DXCOLOR),1,file);

	char psID[32];
	_snprintf_s(psID,32,_TRUNCATE, "%d",_iID);
	LoadScript(psID);
	SetVel((int)(_fVel * 1000));
	SetPlayType(_iPlayType);
	SetCurPose(_iCurPose);
	PlayPose(_iCurPose,PLAY_PAUSE);
}

void	CChaModel::LoadFromMemory(CMemoryBuf* pbuf)
{
	pbuf->mread(&_iID,sizeof(int),1);
	pbuf->mread(&_fVel,sizeof(float),1);
	pbuf->mread(&_iPlayType,sizeof(int),1);
	pbuf->mread(&_iCurPose,sizeof(int),1);

	int eblend;
	pbuf->mread(&eblend,sizeof(int),1);
	_eSrcBlend = (D3DBLEND)eblend;
	pbuf->mread(&eblend,sizeof(int),1);
	_eDestBlend = (D3DBLEND)eblend;
	pbuf->mread(&_dwCurColor,sizeof(D3DXCOLOR),1);

	char psID[32];
	_snprintf_s(psID,32, _TRUNCATE,"%d",_iID);
	LoadScript(psID);
	SetVel((int)(_fVel * 1000));
	SetPlayType(_iPlayType);
	SetCurPose(_iCurPose);
	PlayPose(_iCurPose,PLAY_PAUSE);
}

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

bool	CLELink::Create(LECharacter *pChaMain,int iDummy1,LECharacter *pChaTag, int iDummy2, \
			   char* pszTex, int iTexNum,CLEResManger* pResMgr,D3DXVECTOR3* pEyePos,LERender*	pDev)
{
	m_pDev = pDev;
	_pCEffFile = pResMgr->GetEffectFile();
	_fDailTime = pResMgr->GetDailTime();
	_pEyePos = pEyePos;

#if 0
	drMatrix44 mat1,mat2;
	if(pChaMain->GetObjDummyRunTimeMatrix(&mat1,iDummy1) != 0)
		return false;
	if(pChaTag->GetObjDummyRunTimeMatrix(&mat2,iDummy2) != 0)
		return false;

	_vStart = (*(D3DXVECTOR3*)&mat1._41);
	_vEnd = (*(D3DXVECTOR3*)&mat2._41);
#else
	_vStart = D3DXVECTOR3(0,0,0);
	_vEnd = D3DXVECTOR3(10,0,0);
#endif
	_vdir =  _vEnd - _vStart;
	_fdist = D3DXVec3Length( &_vdir );
	D3DXVec3Normalize(&_vdir,&_vdir);

	//D3DXVec3Cross(&_vcross,&D3DXVECTOR3(0,0,-1), &_vdir);

	int n;

	_pFrame = new LEFrame[LINK_FACE];
	for (n = 0; n < LINK_FACE; n++)
	{
		_pFrame[n].vPos1.m_dwDiffuse = 0xffffffff;
		_pFrame[n].vPos2.m_dwDiffuse =  0xffffffff;
	}

	_pChaMain = pChaMain;
	_pChaTag = pChaTag;
	_iDummy1 = iDummy1;
	_iDummy2 = iDummy2;

	char pszName[32];
	_pTex = new drITex*[iTexNum];
	s_string strName;
	int id;
	for ( n = 0; n < iTexNum; n++)
	{
		_pTex[n] = NULL;
		_snprintf_s(pszName,32,_TRUNCATE, "%s%d",pszTex,n);
		strName = pszName;
		id = pResMgr->GetTextureID(strName);
		if(id < 0)
			return false;
		_pTex[n] = pResMgr->GetTextureByIDdr(id);
	}
	return true;
}

void	CLELink::ColArc(float fradius)
{
	//if(!_pPath)
	//	_pPath = new D3DXVECTOR3[LINK_FACE];

	D3DXVECTOR3 veyedir,vcross;
	D3DXVec3Normalize(&veyedir,&(*_pEyePos - _vStart));
	D3DXVec3Cross(&vcross,&_vdir,&veyedir);
	D3DXVec3Normalize(&vcross,&vcross);
	//D3DXVec3Cross(&vcross,&veyedir,&vcross);

	//vcross = D3DXVECTOR3(0,0,1);

	D3DXVECTOR3 vOrg(-fradius,0,0);
	D3DXVECTOR3 vTemp;


	D3DXMATRIX mat;
	int n;
	int num = 10;
	float fstep = (D3DX_PI / 2.0f) / float(num);
	float fhei;
	float ft;
	for (n = 0; n < num; ++n)
	{
		D3DXMatrixRotationY(&mat,n * fstep);
		D3DXVec3TransformCoord(&vTemp,&vOrg,&mat);
		fhei = vTemp.z;

		ft = fradius + vTemp.x;
		if(ft < 0.00001f)
		{
			ft = 0.0f;
		}
		vTemp = _vStart + _vdir * ft;
		vTemp.z = fhei;

		ft = ft / _fdist;

		//vTemp = _vStart + _vdir * (n * 1.0f);

		_pFrame[n].vPos1.m_SPos = vTemp + (-vcross * 1.0f);
		_pFrame[n].vPos2.m_SPos = vTemp + (vcross * 1.0f);

		if(n ==0)
		{
			_pFrame[n].vPos1.m_SUV.x = 0;
			_pFrame[n].vPos1.m_SUV.y = 1;

			_pFrame[n].vPos2.m_SUV.x = 0;
			_pFrame[n].vPos2.m_SUV.y = 0;
		}else
		{
			_pFrame[n].vPos1.m_SUV.x = ft;
			_pFrame[n].vPos1.m_SUV.y = 1;

			_pFrame[n].vPos2.m_SUV.x = ft;
			_pFrame[n].vPos2.m_SUV.y = 0;
		}
	}
	_pFrame[num].vPos1.m_SPos = _vEnd + (-vcross * 1.0f);
	_pFrame[num].vPos2.m_SPos = _vEnd + (vcross * 1.0f);

	_pFrame[num].vPos1.m_SUV.x = 1;
	_pFrame[num].vPos1.m_SUV.y = 1;

	_pFrame[num].vPos2.m_SUV.x = 1;
	_pFrame[num].vPos2.m_SUV.y = 0;
}

void	CLELink::GetPhysique()
{
#if 0
	drMatrix44 mat1,mat2;
	if(_pChaMain->GetObjDummyRunTimeMatrix(&mat1,_iDummy1) != 0)
		return false;
	if(_pChaTag->GetObjDummyRunTimeMatrix(&mat2,_iDummy2) != 0)
		return false;

	_vStart = (*(D3DXVECTOR3*)&mat1._41);
	_vEnd = (*(D3DXVECTOR3*)&mat2._41);
#else
	_vStart = D3DXVECTOR3(0,0,0);
	_vEnd = D3DXVECTOR3(10,0,0);
#endif

	_vdir =  _vEnd - _vStart;
	_fdist = D3DXVec3Length( &_vdir );
	D3DXVec3Normalize(&_vdir,&_vdir);

	//D3DXVec3Cross(&_vcross,&D3DXVECTOR3(0,0,-1), &_vdir);

	//取半径最大值
	float frad = 3.0f;
	if(_fdist > frad * 2)
	{
		_fRadius = frad - (frad * ((_fdist / frad - 1.0f) /10.0f) );
	}else
	{
		_fRadius = frad + ( (frad - _fdist) /10.0f);
	}
	ColArc(_fRadius);
}


void	CLELink::FrameMove()
{
	GetPhysique();

	_fCurTime += *_fDailTime;
	if(_fCurTime > 0.15f)
	{
		_iCurTex++;
		if(_iCurTex >= 4)
			_iCurTex = 0;
		_fCurTime = 0;
	}
}

void	CLELink::Render()
{

	_pCEffFile->SetTechnique(0);
	_pCEffFile->Begin();
	_pCEffFile->Pass(0);

	//m_pDev->SetRenderStateForced( D3DRS_ALPHABLENDENABLE,FALSE );

	m_pDev->SetRenderState( D3DRS_SRCBLEND,D3DBLEND_SRCALPHA );
	m_pDev->SetRenderState( D3DRS_DESTBLEND,D3DBLEND_ONE);

	D3DXMATRIX mat;
	D3DXMatrixIdentity(&mat);

	m_pDev->SetTransformWorld(&mat);
	m_pDev->SetTexture(0,_pTex[_iCurTex]->GetTex());
	m_pDev->SetVertexShader(LINK_FVF);
	m_pDev->GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP,
		20, _pFrame, sizeof(LinkVer));

	_pCEffFile->End();
}

