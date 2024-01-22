#pragma once

#include "LECamera.h"

#include "i_effect.h"

#include ".\LEparticlesys.h"

#define MAX_PART_SYS	20
class   LERender;

class CLELink;

class  CLEStrip;

class  CLEModelEff;

///************************************************************************/
///* class CLEParticleCtrl*/ 
///************************************************************************/
//class LIGHTENGINE_API CLEParticleCtrl: publ ic CEffectBase
//{
//public:
//	CLEParticleCtrl(void);
//	~CLEParticleCtrl(void);
//
//public:
//	virtual void				BindingRes(CLEResManger* pResMagr) {}
//
//	virtual void				FrameMove(DWORD	dwDailTime)		 {}
//
//	virtual void				Render()						 {}
//	virtual void				RenderVS()						 {}
//	virtual void				RenderSoft()					 {}
//
//	virtual void				Emission(WORD wID, D3DXVECTOR3 vBegin, D3DXVECTOR3 vEnd) {}
//
//public:
//
//	D3DXVECTOR3			m_CPath[2];
//
//	WORD				m_wID;
//
//
//	float*				m_pfDailTime;
//	bool				m_bEmiss;
//};
//
///************************************************************************/
///* class CLEParticleTrace*/
///************************************************************************/
//class LIGHTENGINE_API CLEParticleTrace :public CLEParticleCtrl
//{
//public:
//	CLEParticleTrace(void);
//	~CLEParticleTrace(void);
//
//public:
//	void				BindingRes(CLEResManger* pResMagr);
//
//	void				FrameMove(DWORD	dwDailTime);
//
//	void				Render();
//
//	void				Emission(WORD wID, D3DXVECTOR3 vBegin, D3DXVECTOR3 vEnd);
//
//public:
//	bool				IsPlaying()					{ return (m_bEmiss || m_CBlast->IsPlaying());}
//	bool				IsHit()						{ bool bhit = _bHit; _bHit = false; return bhit;}
//	void				SetTarget(D3DXVECTOR3 vTarget);
//
//	void				Blast();
//
//	void				MoveTo(D3DXVECTOR3 vPos,LEMap* pMap);
//public:
//	bool				_bHit;
//	CLEModelEff*		_pCModelEff;
//
//	CLEShadeMap*		_pCShade;
//
//	CLEFire*			m_CFire;
//
//	CLEBlast*			m_CBlast;
//
//
//	float				m_fTargDist;
//	D3DXVECTOR3			m_vTargDir;
//
//
//	D3DXVECTOR3			m_vPos;
//	float				m_fDist;
//	D3DXVECTOR3			m_vDir;
//
//	float				m_fVel;
//
//	float				m_fRadius;
//};
//
///************************************************************************/
///* class CLEParticleRipple*/
///************************************************************************/
//class LIGHTENGINE_API CLEParticleRipple :public CLEParticleCtrl
//{
//public:
//	CLEParticleRipple(void);
//	~CLEParticleRipple(void);
//
//public:
//	void				BindingRes(CLEResManger* pResMagr);
//
//	void				FrameMove(DWORD	dwDailTime);
//
//	void				Render();
//
//	void				Emission(WORD wID, D3DXVECTOR3 vBegin, D3DXVECTOR3 vEnd);
//
//public:
//	void				SetTarget(D3DXVECTOR3 vTarget, D3DXVECTOR3 vTarget2, float fAngle);
//	void				Walk();
//	void				Stop();
//public:
//	CLERipple*			m_CRippleStop;
//
//	CLERipple*			m_CRippleMove;
//
//	D3DXVECTOR3			m_vPos;
//};
//////////////////////////////////////////////////////////////////////////
#define		LINK_FVF	(D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1)
#define     LINK_FACE	100


class CLELink
{
public:
	struct LinkVer
	{
		D3DXVECTOR3		m_SPos;
		DWORD			m_dwDiffuse;
		D3DXVECTOR2		m_SUV;
	};
	struct LEFrame
	{
		LinkVer	vPos1;
		LinkVer	vPos2;
	};
public:
	CLELink()
	{
		_pChaMain = NULL;
		_pChaTag = NULL;
		_pTex = NULL;

		_pFrame = NULL;
		_pCEffFile = NULL;
		_fDailTime = NULL;

		_iCurTex = 0;
		_fCurTime = 0;
		//_fRadius = 1.0f;

		//_vStart = D3DXVECTOR3(0,0,0);
		//_vEnd = D3DXVECTOR3(0,0,0);
	}
	~CLELink()
	{
	}

	bool	Create(LECharacter *pChaMain,int iDummy1,LECharacter *pChaTag, int iDummy2, \
		char* pszTex, int iTexNum,CLEResManger* pResMgr,D3DXVECTOR3* pEyePos,LERender*	pDev);

	void	FrameMove();

	void	Render();
	
	virtual void	GetPhysique();
protected:
	void	ColArc(float fradius);

public:
	LERender*	m_pDev;

protected:
	CLEEffectFile* _pCEffFile;
	D3DXVECTOR3*  _pEyePos;
	LECharacter *_pChaMain;
	LECharacter *_pChaTag;
	drITex		**_pTex;

	LEFrame*	_pFrame;


	D3DXVECTOR3 _vStart;
	D3DXVECTOR3 _vEnd;

	float		_fRadius;

	int			 _iDummy1;
	int			 _iDummy2;


	float       _fdist;
	D3DXVECTOR3 _vdir;

	int			_iCurTex;
	float       _fCurTime;
	float*		_fDailTime;
};
//////////////////////////////////////////////////////////////////////////


class LIGHTENGINE_API CChaModel : public LECharacter
{
public:
	CChaModel()
	{
		_iID = 0;_fVel = 0.3f; _iPlayType = PLAY_ONCE;_iCurPose = 0;_bPlaying = false;
		_wFrameCount = 0;
		_eSrcBlend		= D3DBLEND_SRCALPHA;
		_eDestBlend		= D3DBLEND_INVSRCALPHA;
		_dwCurColor = 0xffffffff;
		D3DXMatrixIdentity(&_matBone);
		D3DXMatrixIdentity(&_matWorld);
	}
	~CChaModel(){}
	void	SetDivece(LERender*	pDev)	{ m_pDev = pDev; }

	bool	LoadScript(const s_string& strModel);
	void	PlayPose(DWORD id, DWORD type);

	void	SetVel(int iVel)			{ _fVel = (float)iVel / 1000;}
	int		GetVel()					{ return (int)(_fVel * 1000);}

	void	SetPlayType(int iType)		{ _iPlayType = iType;}
	int		GetPlayType()				{ return _iPlayType;}

	void	SetCurPose(int iPose)		{ _iCurPose = iPose;}
	int		GetCurPose()				{ return _iCurPose;}

	void	SetPlaying(bool	bPlay)		{ _bPlaying = bPlay;}
	bool	IsPlaying()					{ return _bPlaying;}

	int		GetID()						{ return _iID;}

	void	Play()						{ _bPlaying = true;PlayPose(_iCurPose,_iPlayType);}

	void	SaveToFile(FILE* file);
	void	LoadFromFile(FILE* file);
	void	LoadFromMemory(CMemoryBuf* pbuf);


	void	Begin();
	void	End();

	void		SetCurColor(DWORD	dwcolor){ _dwCurColor = dwcolor;}
	D3DXCOLOR	GetCurColor()				{ return _dwCurColor;}

	D3DBLEND	GetSrcBlend(){return _eSrcBlend;}
	void		SetSrcBlend(D3DBLEND srcblend){ _eSrcBlend = srcblend;}
	D3DBLEND	GetDestBlend(){return _eDestBlend;}
	void		SetDestBlend(D3DBLEND destblend){ _eDestBlend = destblend;}

	void	BindingBone(D3DXMATRIX* pBone)
	{
		if(pBone)
			_matBone = *pBone;
	}
	void	MoveTo(D3DXVECTOR3* pPos)
	{
		if(pPos)
			D3DXMatrixTranslation(&_matWorld,pPos->x,pPos->y,pPos->z);
	}
	void UpdateMatrix()
	{
		_matResult = _matWorld * _matBone;
		SetMatrix((drMatrix44*)&_matResult);
	}
public:
#ifdef		USE_RENDER
	LERender*					m_pDev;
#else
	LPDIRECT3DDEVICE8			m_pDev;
#endif

protected:
	bool	LoadChaModel(LEChaLoadInfo& info);

	bool	LoadPose(SChaAction& SCharAct);

	D3DXMATRIX								_matBone;
	D3DXMATRIX								_matWorld;
	D3DXMATRIX								_matResult;

protected:
	WORD									_wFrameCount;
	//S_BVECTOR<float>						_vecFrameSize;
	//S_BVECTOR<D3DXCOLOR>					_vecFrameColor;

	D3DBLEND								_eSrcBlend;
	D3DBLEND								_eDestBlend;
	D3DXCOLOR								_dwCurColor;	

private:
	int		_iID;
	float	_fVel;
	int		_iPlayType;
	int		_iCurPose;
	bool	_bPlaying;
};
/************************************************************************/
/* class CLEPartCtrl*/
/************************************************************************/
class LIGHTENGINE_API CLEPartCtrl//: public CEffectBase
{
public:
	static const int ParVersion = 15;
public:
	CLEPartCtrl(void);
	~CLEPartCtrl(void);

public:
	virtual void				BindingRes(CLEResManger* pResMagr);

	virtual void				FrameMove(DWORD	dwDailTime);

	virtual void				Render();
	virtual void				RenderVS()						 {}
	virtual void				RenderSoft()					 {}

	void	SetStripCharacter(LECharacter* pCha);
	void	SetStripItem(LESceneItem* pItem,bool bloop = false);

	void	SetItemDummy(LESceneItem* pItem, int dummy1, int dummy2);

	void	SetPlayType(int nType);

	void	SetSkillCtrl(SkillCtrl* pCtrl)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->SetSkillCtrl(pCtrl);
		}
	}

	void	SetAlpha(float falpha)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->SetAlpha(falpha);
		}
	}

	void						Reset()
	{
		m_fCurTime = 0;
		MoveTo(&D3DXVECTOR3(0,0,0));
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] )
			{
				m_vecPartSys[n]->Reset(false);
				m_vecPartSys[n]->unFontEffCom();
			}
		}
	}
	void						Play(int iTime);
	void						Stop()
	{
		Reset();
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->Stop();
		}
	}
	void						End()
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->End();
		}
	}
	bool						IsPlaying();

	void						MoveTo(D3DXVECTOR3* vPos,LEMap* pmap = NULL)
	{
		int n;
		for ( n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->MoveTo(vPos,pmap);
		}
		for (n = 0; n <m_iModelNum; n++ )
		{
			if(m_vecModel[n]->IsPlaying())
				m_vecModel[n]->MoveTo(vPos);
		}
	}
	void						BindingBone(D3DXMATRIX* pMatBone)
	{
		int n;
		for ( n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->BindingBone(pMatBone);
		}
		for (n = 0; n <m_iModelNum; n++ )
		{
			if(m_vecModel[n]->IsPlaying())
				m_vecModel[n]->BindingBone(pMatBone);
		}
	}

	//void						BindingBoneDir(D3DXMATRIX* pMatBone)
	//{
	//	for(int i(0); i<m_iPartNum; ++i)  
	//		m_vecPartSys[i]->BindingBoneDir(pMatBone);
	//	for(int i(0); i<m_iModelNum; ++i) 
	//		if(m_vecModel[i]->IsPlaying())
	//			m_vecModel[i]->BindingBone(pMatBone);
	//}

	void setYaw(float fYaw)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setYaw( fYaw);
		}
	}
	void setPitch(float fPitch)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setPitch(fPitch);
		}
	}
	void setRoll(float fRoll)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setRoll(fRoll);
		}
	}
	void setScale(float fx,float fy,float fz)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setScale(fx,fy,fz);
		}
	}
	void setFontEffect(char* pszText,CLEFont* pfont)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] )
			{
				m_vecPartSys[n]->setFontEffect(pfont);
				m_vecPartSys[n]->setFontEffText(pszText);
			}
		}
	}
	void setFontEffectCom(VEC_string& vecText, int num,
		CLEResManger *pCResMagr ,D3DXVECTOR3* pvDir,int iTexID,D3DXCOLOR dwColor,bool bUseBack,bool bmain= false)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setFontEffectCom(vecText, num, pCResMagr,pvDir,iTexID,dwColor,bUseBack,bmain);
		}
	}
	void setRenderIdx(int idx)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setRenderIdx(idx);
		}
	}
	void setUseZBuff(bool bUseZ)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setUseZBuff(bUseZ);
		}
	}
	void setDir(D3DXVECTOR3* pvPos)
	{
		for (int n = 0; n < m_iPartNum; ++n)
		{
			if( m_vecPartSys[n] ) m_vecPartSys[n]->setDir(pvPos->x,pvPos->y,pvPos->z);
		}
	}
	void UpdateStrip();
public:
	void						CopyPartCtrl(CLEPartCtrl* pPart);
	CLEPartSys*					AddPartSys(CLEPartSys* part);
	CLEPartSys*					NewPartSys();
	void						DeletePartSys(int iID);
	void						Clear();
	void						SetLength(float fLength){ m_fLength = fLength;}


	CLEStrip*					NewStrip(const s_string& strTex,CLEResManger* pResMagr);
	CLEStrip*					GetStrip(int iIdx);
	int							GetStripNum(){return m_iStripNum;}

	CChaModel*					NewModel(const s_string& strID,CLEResManger* pResMagr);
	CChaModel*					GetModel(int iIdx);
	int							GetModelNum(){return m_iModelNum;}

	void						GetRes(CLEResManger* pResMagr,std::vector<INT>& vecTex,std::vector<INT>& vecModel,
		std::vector<INT>& vecEff);
	void						GetHitRes(CLEResManger* pResMagr,std::vector<s_string>& vecPar);
	//CLEShadeCtrl*				NewShade(s_string strID,CLEResManger* pResMagr);
	//CLEShadeCtrl*				GetShade(int iIdx);
	//int							GetShadeNum(){return m_iShadeNum;}

	//!保存粒子到文件	
	bool		 SaveToFile(char* pszName);
	//!装入粒子从文件
	bool		 LoadFromFile(char* pszName);

	bool		 LoadFromMemory(CMemoryBuf*	pbuf);

public:
	s_string					m_strName;
	int							m_iPartNum;
	S_BVECTOR<CLEPartSys>		m_vecPartSys;

	float*						m_pfDailTime;
	float						m_fLength;
	float						m_fCurTime;

	//武器拖拉出来的条带
	int							m_iStripNum;
	CLEStrip*					m_pcStrip;

	//骨骼动画
	int							m_iModelNum;
	std::vector<CChaModel*>		m_vecModel;

	////骨骼动画
	//int							m_iShadeNum;
	//std::vector<CLEShadeCtrl>	m_vecShade;
};


