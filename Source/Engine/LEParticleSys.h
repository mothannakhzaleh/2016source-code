#pragma once

#include "i_effect.h"
class   LERender;

inline int Rand(int _imin, int _imax)
{
	if(_imin == 0 && _imax == 0)return 0;
	return _imin + (rand() % (_imax - _imin));
}

inline int Rand(int _ix)
{
	if(_ix == 0)return 0;
	return rand() % _ix;
}
inline float Randf(float _fx, int count)
{
	if(_fx == 0)
		return 0;
	if(count == 0)
		return 0;
	float d = _fx / (float)count;
	return (float)Rand(count) * d;
}
inline float Randf(float _fx)
{
	if(_fx == 0)
		return 0;
	if(_fx == 1)
		return (float)(rand() % 1000)/1000;
	int x =Rand((int) _fx);
	float ft= _fx - (int)_fx;
	if(ft> 0 && ((int)ft) == 0)
		return (float)x + (float)Rand((int)(ft * 1000))/1000;

	return (float)x+(float)(rand() % 1000)/1000;
}
inline float Randf(float _f1,float _f2)
{
	if(_f1 == _f2)return _f2;
	float x = Randf(_f2 - _f1);

	return _f1 + x;
}


inline	 bool	PointInstrPointRange(D3DXVECTOR3* vPoint1, D3DXVECTOR3* vPoint2, float fRange)
{
	return ((fabs(vPoint1->x - vPoint2->x) < fRange) &&
			(fabs(vPoint1->y - vPoint2->y) < fRange))/* &&
			(fabs(vPoint1->z - vPoint2->z) < fRange))*/;
}
inline	 bool	PointPointRange(D3DXVECTOR3* vPoint1, D3DXVECTOR3* vPoint2, float fRange)
{
	return ((fabs(vPoint1->x - vPoint2->x) < fRange) &&
			(fabs(vPoint1->y - vPoint2->y) < fRange) &&
			(fabs(vPoint1->z - vPoint2->z) < fRange));
}
inline D3DXMATRIX * GetMatrixRotation(D3DXMATRIX *pout,D3DXVECTOR3 *Point,\
								D3DXVECTOR3 *aixs,float angle)
{
	D3DXMATRIX r, r2;
	D3DXMATRIX r1 = D3DXMATRIX(1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		-Point->x, -Point->y, -Point->z, 1);
	D3DXMatrixRotationAxis(&r2,aixs,angle);
	r = r1 * r2;
	r1 = D3DXMATRIX(1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		Point->x, Point->y, Point->z, 1);
	r = r * r1;
	*pout = r;
	return pout;
}
inline void	 GetDirRotation(D3DXVECTOR2* pOut, D3DXVECTOR3* pDir)
{
	float fDist = D3DXVec3Length(pDir);
	if(pDir->z == 0)
		pOut->x = 0;
	else
	{
		pOut->x = asinf(D3DXVec3Dot(pDir,
			&D3DXVECTOR3(0.0f, 0.0f, 1.0f))/ fDist);
	}
	//求在X轴方向旋转的角度
	if(pDir->x == 0 && pDir->y == 0)
		pOut->y = 0;
	else
	{
		fDist = D3DXVec3Length(&D3DXVECTOR3(pDir->x, pDir->y, 0.0f));
		pOut->y = acosf(D3DXVec3Dot(&D3DXVECTOR3(pDir->x, pDir->y, 0.0f),
			&D3DXVECTOR3(0.0f, 1.0f, 0.0f))/fDist);
		if( pDir->x >= 0.0f )
			pOut->y	= -pOut->y;
	}
}
/************************************************************************/
/*class CLEParticle*/
/************************************************************************/
class CLEParticle// : public CLEModelEff
{
public:
	CLEParticle(void);
	~CLEParticle(void);

public:
	WORD						GetCurFrame(float	fDailTime, WORD wTotalFrame)
	{
		m_fCurTime += fDailTime;
		if(m_fCurTime >= m_fFrameTime)
		{
			m_wCurFrame++;
			if(m_wCurFrame >= wTotalFrame)
			{
				m_wCurFrame = wTotalFrame;
				m_bLive = false;
			}
			m_fCurTime = 0;
		}
		return m_wCurFrame;
	}

	WORD						GetCurFrame(float	fDailTime, WORD wTotalFrame, float frametime)
	{
		m_fCurTime += fDailTime;
		if(m_fCurTime >= frametime)
		{
			m_wCurFrame++;
			if(m_wCurFrame >= wTotalFrame)
			{
				m_wCurFrame = wTotalFrame;
				m_bLive = false;
			}
			m_fCurTime = 0;
		}
		return m_wCurFrame;
	}
	float						GetLerpValue()
	{
		return m_fCurTime / m_fFrameTime;
	}
	void						Reset(D3DXVECTOR3 &vPos)
	{
		m_fCurTime = 0;
		m_wCurFrame = 0;
		m_vOldPos = m_vPos = vPos;
		D3DXMatrixIdentity(&m_SCurMat);
		D3DXMatrixIdentity(&m_SBoneMat);

		m_fFrameTime = 0;
		m_vCurAngle = D3DXVECTOR3(0,0,0);
		m_fSize = 0;
		m_SCurColor = D3DXCOLOR(0,0,0,0);

		m_fPartTime = 0;
	}
public:
	D3DXVECTOR3					m_vPos;
	D3DXVECTOR3					m_vOldPos;
	D3DXVECTOR3					m_vVel;
	D3DXVECTOR3					m_vAccel;
	bool						m_bLive;
	float						m_fLife;

	float						m_fCurTime;
	WORD						m_wCurFrame;
	D3DXCOLOR					m_SCurColor;
	float						m_fSize;
	D3DXVECTOR3					m_vCurAngle;
	D3DXMATRIX					m_SCurMat;
	float						m_fFrameTime;
	D3DXMATRIX					m_SBoneMat;

	float						m_fPartTime;
};

#define		PARTTICLE_SNOW			1
#define		PARTTICLE_FIRE			2
#define		PARTTICLE_BLAST			3
#define		PARTTICLE_RIPPLE		4
#define		PARTTICLE_MODEL			5
#define		PARTTICLE_STRIP			6
#define		PARTTICLE_WIND			7
#define		PARTTICLE_ARRAW			8
#define		PARTTICLE_ROUND			9
#define		PARTTICLE_BLAST2		10
#define		PARTTICLE_BLAST3		11

#define		PARTTICLE_SHRINK		12

#define		PARTTICLE_SHADE			13

#define		PARTTICLE_RANGE			14
#define		PARTTICLE_RANGE2		15

#define		PARTTICLE_DUMMY			16
#define		PARTTICLE_LINE_SINGLE	17
#define		PARTTICLE_LINE_ROUND	18

struct SkillCtrl
{
	SkillCtrl()
	{
		fDelayTime = -1;
		fPlayTime = -1;
		iParNum = -1;
		fRange[0] = fRange[0] = fRange[0] = -1;
		fSize = -1;	
	}
	float		fDelayTime;//延迟播放的时间
	float		fPlayTime;	//播放时间长度
	int			iParNum;	//数量 
	float		fRange[3];	//!在这个范围之内产生
	float		fSize;		//粒子大小
};


/************************************************************************/
/* class CLEPartSys*///PARTTICLE_BLAST2
/************************************************************************/

#define	 MUD_PART

class			CLEModelEff;
class			CLEFont;
class			CEffectFont;
class			CEffPath;

class			CLEPartSys;
void			CopyPartSys(CLEPartSys* part1,CLEPartSys* part2);

bool			_CreateSnow(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveSnow(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateBlast(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveBlast(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateRipple(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveRipple(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateModel(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveModel(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateStrip(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveStrip(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateWind(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveWind(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateFire(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveFire(CLEPartSys* pPart,DWORD	dwDailTime);

//创建一个带方向的特效，这只是显示一个原地不动的物件，控制方向和运行应该由客户端来做
bool			_CreateArraw(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveArraw(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateRound(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveRound(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateBlast2(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveBlast2(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateBlast3(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveBlast3(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateShade(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveShade(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateRange(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveRange(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateRange2(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveRange2(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateDummy(CLEPartSys* pPart,CLEParticle* pCtrl);
void			_FrameMoveDummy(CLEPartSys* pPart,DWORD	dwDailTime);

bool			_CreateLineSingle(CLEPartSys* pPart, CLEParticle* pCtrl);
void			_FrameMoveLineSingle(CLEPartSys* pPart, DWORD dwDailTime);

bool			_CreateLineRound(CLEPartSys* pPart, CLEParticle* pCtrl);
void			_FrameMoveLineRound(CLEPartSys* pPart, DWORD dwDailTime);

class LIGHTENGINE_API CLEPartSys//: public CEffectBase
{
public:
	CLEPartSys();
	~CLEPartSys();

	bool				Create(int iType, const s_string& strPartName,int iNumPart,
								const s_string& strModelName,const s_string& strTexName,
								D3DXVECTOR3 vRange, WORD wFrameCount,bool bBillBoard,
								CLEResManger	*pCResMagr);

	void				InitParam();

	void				BindingRes(CLEResManger	*pCResMagr);

	void				FrameMove(DWORD dwDailTime);

	void				Render();
	void				RenderVS();
	void				RenderSoft();

public:
	//edit////////////////////////////////////////////////////////////////////////
	void				SetOpertion();
	void				SetSkillCtrl(SkillCtrl* pCtrl);
	int					GetType(){return _iType;}
	void				SetType(int iType,CLEResManger	*pCResMagr);
	
	s_string			GetSysName(){return _strPartName;}
	void				SetSysName(const s_string& strPartName){_strPartName = strPartName;}

	float				GetSysLife(){return _fLife;}
	void				SetSysLife(float fLife){_fLife = fLife;}

	float				GetSysVel(){return _fVecl;}
	void				SetSysVel(float fVecl){_fVecl = fVecl;}

	int					GetSysNum(){return _iParNum;}
	void				SetSysNum(int  iParNum)
	{
		// 粒子数限定在[1, 100]
		if(iParNum> 100)
			_iParNum = 100;
		else if(_iParNum <= 0)
			_iParNum = 1;
		else
			_iParNum = iParNum;

		_vecParticle.setsize(_iParNum);
	}

	float				GetSysStep()		{ return _fStep;}
	void				SetSysStep(float fstep){ _fStep = fstep;}	

	D3DXVECTOR3			GetSysDir(){return _vDir;}
	void				SetSysDirX(float fx){_vDir.x = fx;}
	void				SetSysDirY(float fy){_vDir.y = fy;}
	void				SetSysDirZ(float fz){_vDir.z = fz;}

	D3DXVECTOR3			GetSysAccel(){return _vAccel;}
	void				SetSysAccelX(float fx){_vAccel.x = fx;}
	void				SetSysAccelY(float fy){_vAccel.y = fy;}
	void				SetSysAccelZ(float fz){_vAccel.z = fz;}

	float				GetSysRangeX(){return _fRange[0];}
	float				GetSysRangeY(){return _fRange[1];}
	float				GetSysRangeZ(){return _fRange[2];}
	void				SetSysRangeX(float fx){_fRange[0] = fx;}
	void				SetSysRangeY(float fy){_fRange[1] = fy;}
	void				SetSysRangeZ(float fz){_fRange[2] = fz;}

	WORD				GetFrameCount(){return _wFrameCount;}
	void				SetFrameCount(WORD	wFrameCount);
	float				GetFrameSize(int iFrame)
	{ 
		if(iFrame <_wFrameCount)
			return *_vecFrameSize[iFrame];
		return 0;
	}
	void				SetFrameSize(int iFrame, float fsize,CLEResManger	*pCResMagr)
	{ 		
		if(iFrame <_wFrameCount)
			*_vecFrameSize[iFrame] = fsize;

		if(m_bShade)
			m_cShade.Create(_strTexName,pCResMagr,*_vecFrameSize[0]);
	}

	D3DXVECTOR3			GetFrameAngle(int iFrame)
	{ 
		//if(iFrame <_wFrameCount)
			return *_vecFrameAngle[iFrame];
		//return D3DXVECTOR3(0,0,0);
	}
	void				SetFrameAngle(int iFrame, D3DXVECTOR3 vAngle)
	{ 		
		if(iFrame <_wFrameCount)
			*_vecFrameAngle[iFrame] = vAngle;
	}

	D3DXCOLOR			GetFrameColor(int iFrame)
	{ 
		//if(iFrame <_wFrameCount)
			return *_vecFrameColor[iFrame];
		//return 0x00000000;
	}
	void				SetFrameColor(int iFrame, DWORD dwColor)
	{ 		
		if(iFrame <_wFrameCount)
			*_vecFrameColor[iFrame] = dwColor;

		//if(m_bShade)
		//	m_cShade.setColor(*_vecFrameColor[0]);
	}

	void				SetAlpha(float falpha)
	{
		for(int n = 0; n < _wFrameCount; n++)
		{
			_vecFrameColor[n]->a = falpha;
		}
	}

	bool				IsBillBoard(){return _bBillBoard;}
	void				SetBillBoard(bool bBBoard){ _bBillBoard = bBBoard;}

	s_string			GetTextureName(){return _strTexName;}
	void				SetTextureName(const s_string& strTexName,CLEResManger	*pCResMagr);

	s_string			GetModelName(){return _strModelName;}
	void				SetModelName(const s_string& strModelName,CLEResManger	*pCResMagr);

	//s_string			GetVirualModelName(){return _strVirualModel;}
	void				SetEmissionPath(CEffPath* pcPath);


	D3DBLEND			GetSrcBlend(){return _eSrcBlend;}
	void				SetSrcBlend(D3DBLEND srcblend){ _eSrcBlend = srcblend;	if(m_bShade)
		m_cShade.SetAlphaType(_eSrcBlend,_eDestBlend);}
	D3DBLEND			GetDestBlend(){return _eDestBlend;}
	void				SetDestBlend(D3DBLEND destblend){ _eDestBlend = destblend;if(m_bShade)
		m_cShade.SetAlphaType(_eSrcBlend,_eDestBlend);}

	D3DTEXTUREFILTERTYPE			GetMagFilter(){return _eMagFilter;}
	void				SetMagFilter(D3DTEXTUREFILTERTYPE MagFilter){ _eMagFilter = MagFilter;}
	D3DTEXTUREFILTERTYPE			GetMinFilter(){return _eMinFilter;}
	void				SetMinFilter(D3DTEXTUREFILTERTYPE MinFilter){ _eMinFilter = MinFilter;}

	void				SetPosOffset(float fx,float fy,float fz)
	{
		_vOffset.x = fx;
		_vOffset.y = fy;
		_vOffset.z = fz;
	}
	D3DXVECTOR3&		GetPosOffset(){return _vOffset;}
public:
	void				Reset(bool	bLife);

	void				Play(int iTime);

	void				Stop();

	void				End()					{_bStop = true;}

	bool				IsPlaying();

	void				MoveTo(D3DXVECTOR3* vPos,LEMap* pmap = NULL);
	
	void				BindingBone(D3DXMATRIX* pMatBone);

	void setYaw(float fYaw);
	void setPitch(float fPitch);
	void setRoll(float fRoll);

	void setScale(float fx,float fy, float fz);

	void setDir(float fx, float fy, float fz);

	void setFontEffect(CLEFont*	pFont);
	void setFontEffText(char* pszText);
	void setFontEffectCom(VEC_string& vecText, int num, 
		CLEResManger *pCResMagr,D3DXVECTOR3* pvDir,int iTexID,
		D3DXCOLOR dwColor= 0xffffffff, bool bUseBack = false,bool bmain= false);	
	void unFontEffCom();
	void setRenderIdx(int idx)	{ _iRenderIdx = idx; }
	void setUseZBuff(bool bUseZ);
	//void setTarget(D3DXVECTOR3* vTarget);

	bool IsDelay(){return(_fDelayTime > 0 && _fCurPlayTime < _fDelayTime);}
	bool UpdateDelay();
	bool IsCreatePart();
	void SetDelayTime(float ftime){_fDelayTime = ftime;}
	void SetPlayTime(float ftime){_fPlayTime = ftime;}
	float GetDelayTime(){return _fDelayTime;}
	float GetPlayTime(){return _fPlayTime ;}

	void  SetLoop(bool bLoop);

	void  LoadPathFile(char* pszfile);
	void  LoadPathFileLet(char* pszfile);
	void  SetPathVel(float fvel);
	void  DeletePath();
	float GetPathVel();

	s_string& GetHitEff()				{ return m_strHitEff;}
	void	  SetHitEff(const s_string& streff){  m_strHitEff = streff;}

	bool  GetDummyPosList()
	{
		if(!_pItem ||_iDummy1 == -1 ||_iDummy2 == -1)
		{
			return false;
		}
		D3DMATRIX matDummy1,matDummy2;
		_pItem->GetObjDummyRunTimeMatrix((drMatrix44*)&matDummy1,_iDummy1);
		_pItem->GetObjDummyRunTimeMatrix((drMatrix44*)&matDummy2,_iDummy2);
		//_bModelRange  = true;

		D3DXVECTOR3*	pv1 = (D3DXVECTOR3*)&matDummy1._41;
		D3DXVECTOR3*	pv2 = (D3DXVECTOR3*)&matDummy2._41;
		_vDummyDir = *pv1 - *pv2;
		_fDummyDist = D3DXVec3Length(&_vDummyDir);
		D3DXVec3Normalize(&_vDummyDir,&_vDummyDir);
		_vDummyPos = *pv2;
		return true;
	}
	void	SetItemDummy(LESceneItem* pItem, int idummy1, int idummy2)
	{
		if(_iType != PARTTICLE_DUMMY && _iType != PARTTICLE_LINE_SINGLE )
			return;
		if(!pItem ||idummy1 <  0||idummy2 < 0)
			return;
		_pItem = pItem;

		_iDummy1 = idummy1;
		_iDummy2 = idummy2;
	}

	int		GetRoadom()	{ return _iRoadom;}
	void	SetRoadom(int iRoadom){ _iRoadom = iRoadom;}

	bool	IsModelDir()	{ return _bModelDir;}
	void	SetModelDir(bool bDir){ _bModelDir = bDir;}

	void	SetMediayEff(bool bMediay);
	bool	IsMediay()	{ return _bMediay; }
public:
	//!保存粒子到文件	
	bool		 SaveToFile(FILE* t_pFile);
	//!装入粒子从文件
	bool		 LoadFromFile(FILE* t_pFile, DWORD dwVersion);

	bool		 LoadFromMemory(CMemoryBuf*	pbuf, DWORD dwVersion);
	bool		 IsPartArray();

	void		 GetRes(int& idtex, int& idmodel, int& ideff);
protected:
	friend void				CopyPartSys(CLEPartSys* part1,CLEPartSys* part2);

	void				(*FrameUpdate)(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateSnow(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveSnow(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateBlast(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveBlast(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateRipple(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveRipple(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateModel(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveModel(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateStrip(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveStrip(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateWind(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveWind(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateFire(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveFire(CLEPartSys* pPart,DWORD	dwDailTime);

	//创建一个带方向的特效，
	friend bool			_CreateArraw(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveArraw(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateRound(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveRound(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateBlast2(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveBlast2(CLEPartSys* pPart,DWORD	dwDailTime);
	
	friend bool			_CreateBlast3(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveBlast3(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateShrink(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveShrink(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateShade(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveShade(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateRange(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveRange(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateRange2(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveRange2(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateDummy(CLEPartSys* pPart,CLEParticle* pCtrl);
	friend void			_FrameMoveDummy(CLEPartSys* pPart,DWORD	dwDailTime);

	friend bool			_CreateLineSingle(CLEPartSys* pPart, CLEParticle* pCtrl);
	friend void			_FrameMoveLineSingle(CLEPartSys* pPart, DWORD dwDailTime);

	friend bool			_CreateLineRound(CLEPartSys* pPart, CLEParticle* pCtrl);
	friend void			_FrameMoveLineRound(CLEPartSys* pPart, DWORD dwDailTime);

protected:
	bool				_bPlay;
	bool				_bStop;
	bool				_bLoop;
	WORD				_wDeath;
	bool				_bUseBone;
	D3DXMATRIX			_SBoneMat;

	float								_fLife;
	D3DXVECTOR3							_vDir;
	float								_fVecl;
	D3DXVECTOR3							_vAccel;
	//float								_fInfXY;//在XY轴方向受到的影响

	float								_fStep;//每隔多少时间创建一个粒子
	float								_fCurTime;

	float								_fDelayTime;//延迟播放的时间
	float								_fPlayTime;//播放时间长度
	float								_fCurPlayTime;

	D3DXVECTOR3							_vScale;

	bool				_bFontEff;
	CLEFont*			_pFont;
	s_string			_strText;

	bool				_bFontCom;
	CEffectFont*		_pcEffFont;
	VEC_string			_vecText;
	D3DXVECTOR3			_vFontDir;

	bool				_bUseZ;

protected:
	int					_iType;

	s_string								_strPartName;

	int										_iParNum;
	S_BVECTOR<CLEParticle>					_vecParticle;


	s_string								_strTexName;
	LPDIRECT3DTEXTURE8						_lpCurTex;
	drITex*									_pTex;
	//drITex*									_oldtex;


	s_string								_strModelName;
	CEffectModel*							_pCModel;
	CLEModelEff*							_CPPart;//以CLEModelEff做为粒子

	bool									_bMediay;

	int										_idt;
//#ifdef MUD_PART
//	S_BVECTOR<CLEModelEff>					_vecPart;
//#endif

	D3DXVECTOR3								_vPos;

	D3DXVECTOR3								_vOffset;


	bool									_bModelRange;//使用模型范围来产生粒子
	s_string								_strVirualModel;//用来查找的虚拟模型的名称
	std::vector<D3DXVECTOR3>				_vecPointRange;//用来产生粒子的点
	WORD									_wVecNum;//顶点数量

	float									_fRange[3];	//!粒子在这个范围之内产生

	WORD									_wFrameCount;
	S_BVECTOR<float>						_vecFrameSize;
	S_BVECTOR<D3DXVECTOR3>					_vecFrameAngle;
	S_BVECTOR<D3DXCOLOR>					_vecFrameColor;

	S_BVECTOR<D3DXVECTOR3>					_vecBone;//创建的骨骼节点，粒子在这个节点上排序

	DWORD*									_pdwVShader;
	float*									_pfDailTime;
	D3DXMATRIX*								_pMatViewProj;

	bool									_bBillBoard;
	D3DXMATRIX*								_SpmatBBoard;

	int										_iRenderIdx;
	CLEEffectFile*							_pCEffectFile;

	D3DBLEND								_eSrcBlend;
	D3DBLEND								_eDestBlend;

	D3DTEXTUREFILTERTYPE					_eMinFilter;
	D3DTEXTUREFILTERTYPE					_eMagFilter;

	//运动路径
	CEffPath*								_pcPath;
	D3DXVECTOR3								_vSavePos;

	//shade
	bool									m_bShade;
	CLEShadeCtrl							m_cShade;
	LEMap*									m_pMap;

	CLEResManger*							m_pCResMagr;
	s_string								m_strHitEff;

	//dummy
	int										_iDummy1,_iDummy2;
	LESceneItem*							_pItem;
	D3DXVECTOR3								_vDummyPos,_vDummyDir;
	float									_fDummyDist;

	int										_iRoadom;
	bool									_bModelDir;
	D3DXVECTOR2								_vTemDir;
};

inline void		RotatingXZ(D3DXMATRIX* pmat,float fAngleX, float fAngleZ)
{
	D3DXMATRIX mat;
	D3DXMatrixRotationX(&mat, fAngleX);
	D3DXMatrixRotationZ(pmat, fAngleZ);
	D3DXMatrixMultiply(pmat, &mat, pmat);
}


///************************************************************************/
///* class CLEParticleMagr*/
///************************************************************************/
//
//#define	 PARTTYPE_RAIN		1
//#define	 PARTTYPE_BLAST		2
//#define	 PARTTYPE_LINK		3
//#define	 PARTTYPE_STRIP		4
//
//
//class LIGHTENGINE_API CLEMagrPart: public CEffectBase
//{
//public:
//	CLEMagrPart(void){}
//	~CLEMagrPart(void){}
//
//public:
//	bool				Create(int iType, s_string	strPartName,int iNumPart,s_string strModelName,
//									D3DXVECTOR2 vRange, WORD wFrameCount, CLEResManger	*pCResMagr);
//	//在没有从文件中读取时用这个函数初始化变量
//	void				InitParam(D3DXVECTOR3 vDir,D3DXVECTOR3	vVecl,
//									D3DXVECTOR3 vAccel, int iLife, int iInfXY  =0);
//
//
//	void				MoveTo(D3DXVECTOR3 vPos);
//
//	void				FrameMove(DWORD	dwDailTime);
//
//	void				Render();
//	void				RenderVS();
//	void				RenderSoft();
//
//
//	//void				play(int Time);
//	void				Stop()
//	{
//		_bPlay = false;
//	}
//	
//	bool				IsPlaying()
//	{
//		return _bPlay;
//	}
//
//	void				Emission(int iID, D3DXVECTOR3& vTarget);
//	void				SetTarget(D3DXVECTOR3& vTarget);
//	////////////////////////////////////////////////////////
//	int					GetType()			{ return _iType;}
//
//	///////////////////////////////////////////////////////
//	void				setFrameSizeSame(float	fsize);
//	void				setFrameSizeBig(float	fsize);
//	void				setFrameSizeSmall(float	fsize);
//
//public:
//	//指向算法的函数指针
//	void				(*FrameUpdate)(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//
//	friend bool	_CreateRain(CLEMagrPart* pPart, CLEParticle* pCtrl);
//	friend void	_FrameMoveRain(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//	friend bool	_CreateBlast(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//	friend void	_FrameMoveBlast(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//	friend bool	_CreateLink(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//	friend void	_FrameMoveLink(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//	friend bool	_CreateStrip(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//	friend void	_FrameMoveStrip(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//protected:
//	s_string								_strPartName;
//	s_string								_strModelName;
//
//
//protected:
//	S_BVECTOR<CLEModelEff>				_vecParticle;
//	S_BVECTOR<CLEParticle>				_vecCtrl;
//
//
//	S_BVECTOR<float>					_vecFrameSize;
//	S_BVECTOR<D3DXVECTOR3>				_vecFrameAngle;
//
//	int									_iType;
//	bool								_bPlay;
//	bool								_bLoop;
//
//	int									_iParNum;
//	WORD								_wFrameCount;
//
//	D3DXVECTOR3							_vPos;
//	D3DXVECTOR3							_vOldPos;
//
//	D3DXVECTOR2							_vRange;	//!粒子在这个范围之内产生
//
//
//	float*								_pfDailTime;
///////////////////////////////////////////////////
//	int									_iLife;
//	D3DXVECTOR3							_vDir;
//	D3DXVECTOR3							_vVecl;
//	D3DXVECTOR3							_vAccel;
//	int									_iInfXY;//在XY轴方向受到的影响
//
//	WORD								_wDeath;//有多少粒子已经死亡。
//
//	D3DXVECTOR3							_vTarget;//目标
//	float								_fDirXZ[2];//在XZ方向上的角度
//};
//
//////////////////////控制粒子的算法列表
//bool	_CreateRain(CLEMagrPart* pPart,CLEParticle* pCtrl);
//void	_FrameMoveRain(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//
//bool	_CreateBlast(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//void	_FrameMoveBlast(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//
//bool	_CreateLink(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//void	_FrameMoveLink(CLEMagrPart* pPart,DWORD	dwDailTime);
//
//bool	_CreateStrip(CLEMagrPart* pPart,CLEParticle* pCtrl,CLEModelEff* pEff);
//void	_FrameMoveStrip(CLEMagrPart* pPart,DWORD	dwDailTime);
