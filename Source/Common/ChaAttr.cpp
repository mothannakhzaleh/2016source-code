//=============================================================================
// FileName: ChaAttr.cpp
// Creater: ZhangXuedong
// Date: 2004.09.01
// Comment: CChaAttr class
//=============================================================================

#include "ChaAttr.h"
#include "CharacterRecord.h"
#include "CompCommand.h"

LONG64 g_lMaxChaAttr[ATTR_MAX_NUM];

CChaAttr::CChaAttr()
{
  T_B Clear();
  memset(m_szName, 0, sizeof(m_szName));
  T_E
}

CChaAttr::~CChaAttr()
{
  T_B
	  T_E
}

void CChaAttr::Clear()
{
  memset(m_lAttribute, 0, sizeof(LONG64) * ATTR_MAX_NUM);
}

void CChaAttr::Init(long lID, bool bFromFile)
{
  T_B ResetChangeFlag();

  int i = 0;
  for(i = ATTR_ITEMC_STR; i <= ATTR_ITEMC_PDEF; i++)
	m_lAttribute[i] = 1000;
  for(i = ATTR_STATEC_STR; i <= ATTR_STATEC_PDEF; i++)
	m_lAttribute[i] = 1000;
  for(i = ATTR_ITEMV_STR; i <= ATTR_ITEMV_PDEF; i++)
	m_lAttribute[i] = 0;
  for(i = ATTR_STATEV_STR; i <= ATTR_STATEV_PDEF; i++)
	m_lAttribute[i] = 0;
  for(i = ATTR_BOAT_SKILLC_MNATK; i <= ATTR_BOAT_SKILLC_MXSPLY; i++)
	m_lAttribute[i] = 1000;
  for(i = ATTR_BOAT_SKILLV_MNATK; i <= ATTR_BOAT_SKILLV_MXSPLY; i++)
	m_lAttribute[i] = 0;

  // Add by lark.li 20080723 begin
  // 不能初始化，这些属性需要保存到数据库里
  //for (i = ATTR_EXTEND0; i <= ATTR_EXTEND9; i++)
  //	m_lAttribute[i] = 0;
  // End

  CChaRecord* pCChaRecord = GetChaRecordInfo(lID);
  if(!pCChaRecord)
	return;

  m_lID = lID;
  if(bFromFile)
  {
	m_lAttribute[ATTR_LV]	 = (LONG64)pCChaRecord->lLv;
	m_lAttribute[ATTR_HP]	 = (LONG64)pCChaRecord->lMxHp;
	m_lAttribute[ATTR_SP]	 = (LONG64)pCChaRecord->lMxSp;
	m_lAttribute[ATTR_CEXP]	 = pCChaRecord->lCExp;
	m_lAttribute[ATTR_NLEXP] = pCChaRecord->lNExp;
	m_lAttribute[ATTR_FAME]	 = (LONG64)pCChaRecord->lFame;
	m_lAttribute[ATTR_AP]	 = (LONG64)pCChaRecord->lAp;
	m_lAttribute[ATTR_TP]	 = (LONG64)pCChaRecord->lTp;
	m_lAttribute[ATTR_GD]	 = (LONG64)pCChaRecord->lGd;
  }
  m_lAttribute[ATTR_SPRI]		 = (LONG64)pCChaRecord->lSpri;
  m_lAttribute[ATTR_CHATYPE]	 = (LONG64)pCChaRecord->chCtrlType;
  m_lAttribute[ATTR_STR]		 = (LONG64)pCChaRecord->lStr;
  m_lAttribute[ATTR_DEX]		 = (LONG64)pCChaRecord->lDex;
  m_lAttribute[ATTR_AGI]		 = (LONG64)pCChaRecord->lAgi;
  m_lAttribute[ATTR_CON]		 = (LONG64)pCChaRecord->lCon;
  m_lAttribute[ATTR_STA]		 = (LONG64)pCChaRecord->lSta;
  m_lAttribute[ATTR_LUK]		 = (LONG64)pCChaRecord->lLuk;
  m_lAttribute[ATTR_LHAND_ITEMV] = (LONG64)pCChaRecord->lLHandVal;
  m_lAttribute[ATTR_MXHP]		 = (LONG64)pCChaRecord->lMxHp;
  m_lAttribute[ATTR_MXSP]		 = (LONG64)pCChaRecord->lMxSp;
  m_lAttribute[ATTR_MNATK]		 = (LONG64)pCChaRecord->lMnAtk;
  m_lAttribute[ATTR_MXATK]		 = (LONG64)pCChaRecord->lMxAtk;
  m_lAttribute[ATTR_DEF]		 = (LONG64)pCChaRecord->lDef;
  m_lAttribute[ATTR_HIT]		 = (LONG64)pCChaRecord->lHit;
  m_lAttribute[ATTR_FLEE]		 = (LONG64)pCChaRecord->lFlee;
  m_lAttribute[ATTR_MF]			 = (LONG64)pCChaRecord->lMf;
  m_lAttribute[ATTR_CRT]		 = (LONG64)pCChaRecord->lCrt;
  m_lAttribute[ATTR_HREC]		 = (LONG64)pCChaRecord->lHRec;
  m_lAttribute[ATTR_SREC]		 = (LONG64)pCChaRecord->lSRec;
  m_lAttribute[ATTR_ASPD]		 = (LONG64)pCChaRecord->lASpd;
  m_lAttribute[ATTR_ADIS]		 = (LONG64)pCChaRecord->lADis;
  m_lAttribute[ATTR_MSPD]		 = (LONG64)pCChaRecord->lMSpd;
  m_lAttribute[ATTR_COL]		 = (LONG64)pCChaRecord->lCol;
  m_lAttribute[ATTR_PDEF]		 = (LONG64)pCChaRecord->lPDef;

  if(bFromFile)
  {
	m_lAttribute[ATTR_BSTR] = (LONG64)pCChaRecord->lStr;
	m_lAttribute[ATTR_BDEX] = (LONG64)pCChaRecord->lDex;
	m_lAttribute[ATTR_BAGI] = (LONG64)pCChaRecord->lAgi;
	m_lAttribute[ATTR_BCON] = (LONG64)pCChaRecord->lCon;
	m_lAttribute[ATTR_BSTA] = (LONG64)pCChaRecord->lSta;
	m_lAttribute[ATTR_BLUK] = (LONG64)pCChaRecord->lLuk;

	m_lAttribute[ATTR_BMXHP] = (LONG64)pCChaRecord->lMxHp;
	m_lAttribute[ATTR_BMXSP] = (LONG64)pCChaRecord->lMxSp;
  }
  m_lAttribute[ATTR_BMNATK] = (LONG64)pCChaRecord->lMnAtk;
  m_lAttribute[ATTR_BMXATK] = (LONG64)pCChaRecord->lMxAtk;
  m_lAttribute[ATTR_BDEF]	= (LONG64)pCChaRecord->lDef;
  m_lAttribute[ATTR_BHIT]	= (LONG64)pCChaRecord->lHit;
  m_lAttribute[ATTR_BFLEE]	= (LONG64)pCChaRecord->lFlee;
  m_lAttribute[ATTR_BMF]	= (LONG64)pCChaRecord->lMf;
  m_lAttribute[ATTR_BCRT]	= (LONG64)pCChaRecord->lCrt;
  m_lAttribute[ATTR_BHREC]	= (LONG64)pCChaRecord->lHRec;
  m_lAttribute[ATTR_BSREC]	= (LONG64)pCChaRecord->lSRec;
  m_lAttribute[ATTR_BASPD]	= (LONG64)pCChaRecord->lASpd;
  m_lAttribute[ATTR_BADIS]	= (LONG64)pCChaRecord->lADis;
  m_lAttribute[ATTR_BMSPD]	= (LONG64)pCChaRecord->lMSpd;
  m_lAttribute[ATTR_BCOL]	= (LONG64)pCChaRecord->lCol;
  m_lAttribute[ATTR_BPDEF]	= (LONG64)pCChaRecord->lPDef;
  T_E
}
