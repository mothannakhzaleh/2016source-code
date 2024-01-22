//=============================================================================
// FileName: Kitbag.h
// Creater: ZhangXuedong
// Date: 2004.12.17
// Comment: Kitbag
//=============================================================================

#ifndef KITBAG_H
#define KITBAG_H

#include <memory.h>
#include "ItemRecord.h"
#include "CompCommand.h"
//#include "KitbagEnCode.h"
#include "StringPoolL.h"

extern char g_key[9];
extern int	Decrypt(char* buf, int len, const char* enc, int elen);

extern int Encrypt(char* buf, int len, const char* pwd, int plen);

extern int EncryptEx(char* buf, int len);
extern int EncryptExEx(int start, StringPoolL& stringPool, int index);

enum ITEM_STATE
{
  ITEM_DISENABLE = 1 << 0, // 该物品栏位物品被禁止活动
};

enum EKbActRet
{
  enumKBACT_SUCCESS = 0, // 背包操作成功
  // 以下是背包操作失败值
  enumKBACT_ERROR_LOCK		 = -1, // 包处于锁定状态
  enumKBACT_ERROR_RANGE		 = -2, // 操作越界
  enumKBACT_ERROR_PUSHITEMID = -3, // 压入非法的道具编号
  enumKBACT_ERROR_FULL		 = -4, // 背包已满
  enumKBACT_ERROR_NULLGRID	 = -5, // 空栏位
  enumKBACT_ERROR_POPNUM	 = -6, // 弹出的数目非法
};

#define defKITBAG_DEFPUSH_POS -1 // 背包的缺省压入位置（自动寻找位置）

class CKitbag
{
  public:
  CKitbag()
  {
	Init(24);
	m_bPwdLocked = 0;
  }

  struct SItemUnit
  {
	BYTE	  byState; // 物品栏是否被禁
	SItemGrid SContent;

	short sPosID;	  // 道具栏位置编号
	short sReverseID; // 用于反索引
  };

  void	Init(short sCapacity = defMAX_KBITEM_NUM_PER_TYPE);
  void	Reset(void);
  void	SetCapacity(short sCapacity);
  short GetCapacity() const { return m_sCapacity; }
  bool	AddCapacity(short sAddVal);
  short GetUseGridNum() const { return m_sUseNum; }

  // 以下2函数将会改变传入的参数1的物品计数值(注释:by knight.gong)
  short CanPush(SItemGrid* pGrid, short& sPosID);
  short CanPop(SItemGrid* pGrid, short sPosID);

  short		 Push(SItemGrid* pGrid, short& sPosID, bool bCommit = true, bool bSureOpr = false);
  short		 Pop(SItemGrid* pGrid, short sPosID, bool bCommit = true);
  short		 Clear(short sPosID);
  short		 Clear(SItemGrid* pGrid, short sNum = 0, short* psPosID = NULL);
  short		 Switch(short sSrcPosID, short sTarPosID);
  short		 Regroup(short sSrcPosID, short sSrcNum, short sTarPosID);
  short		 Refresh(short sPosID);
  bool		 IsFull() const;
  SItemGrid* GetGridContByID(short sPosID);
  SItemGrid* GetGridContByNum(short sPosNum);
  short		 GetPosIDByNum(short sPosNum) const;
  bool		 GetPosIDByGrid(SItemGrid* pGrid, short* psPosID = 0);
  short		 GetID(short sPosID) const;
  short		 GetNum(short sPosID) const;
  long		 GetDBParam(short sParamID, short sPosID);
  short		 SetDBParam(short sParamID, long lParamVal, short sPosID);
  short		 GetEnergy(bool bMax, short sPosID) const;
  short		 SetEnergy(bool bMax, short sEnergy, short sPosID);
  BOOL		 HasItem(short sPosID) const;
  BOOL		 IsEnable(short sPosID) const;
  void		 Enable(short sPosID);
  void		 Disable(short sPosID);
  BOOL		 IsLock(void) const { return m_bLock; }

  void	SetChangeFlag(bool bChange = true);
  void	SetSingleChangeFlag(short sPosID);
  bool	IsSingleChange(short sPosID);
  bool	IsChange();
  short GetChangeNum();

  // 安全锁(玩家之间交易时锁定其他的背包操作
  void Lock() { m_bLock = TRUE; }
  void UnLock() { m_bLock = FALSE; }

  //密码锁
  void PwdLock() { m_bPwdLocked |= 0x01; }
  void PwdUnlock() { m_bPwdLocked &= 0xfe; }
  BOOL IsPwdLocked() const
  {
	if(m_bPwdLocked & 0x01)
	  return true;
	else
	  return false;
  }
  BOOL IsPwdAutoLocked() const
  {
	if(m_bPwdLocked & 0x02)
	  return true;
	else
	  return false;
  }
  void PwdAutoLock(char cAuto)
  {
	if(cAuto == 0)
	  m_bPwdLocked &= 0xfd;
	else
	  m_bPwdLocked |= 0x02;
  }
  int  GetPwdLockState() const { return m_bPwdLocked; }
  void SetPwdLockState(int nLock) { m_bPwdLocked = nLock; }

  void	SetVer(short sVers) { sVer = sVers; }
  short GetVer(void) const { return sVer; }

  CKitbag& operator=(CKitbag& bag);

  protected:
  bool CheckValid(void); // for test

  private:
  short sVer;
  BOOL	m_bLock;

  //密码锁定状态
  int m_bPwdLocked;

  SItemUnit* m_pSItem[defMAX_KBITEM_NUM_PER_TYPE];
  short		 m_sCapacity; // 每页的容量
  short		 m_sUseNum;	  // 页已经使用的格子数
  SItemUnit	 m_SItem[defMAX_KBITEM_NUM_PER_TYPE];

  short m_sChangeNum;
  bool	m_bChangeFlag[defMAX_KBITEM_NUM_PER_TYPE];
};

inline void CKitbag::Init(short sCapacity)
{
  sVer	  = 0;
  m_bLock = FALSE;
  SetCapacity(sCapacity);

  m_sUseNum = 0;
  for(auto i = 0; i < defMAX_KBITEM_NUM_PER_TYPE; i++)
  {
	m_pSItem[i]				= m_SItem + i;
	m_SItem[i].sPosID		= i;
	m_SItem[i].sReverseID	= i;
	m_SItem[i].SContent.sID = 0;
	Enable(i);
  }
  SetChangeFlag(false);
}

inline void CKitbag::Reset(void)
{
  m_bLock = FALSE;

  m_sUseNum = 0;
  for(auto i = 0; i < defMAX_KBITEM_NUM_PER_TYPE; i++)
  {
	m_pSItem[i]				= m_SItem + i;
	m_SItem[i].sPosID		= i;
	m_SItem[i].sReverseID	= i;
	m_SItem[i].SContent.sID = 0;
	Enable(i);
  }
  SetChangeFlag(false);
}

inline CKitbag& CKitbag::operator=(CKitbag& bag)
{
  sVer		   = bag.sVer;
  m_bLock	   = bag.m_bLock;
  m_bPwdLocked = bag.m_bPwdLocked;
  m_sCapacity  = bag.m_sCapacity;
  m_sUseNum	   = bag.m_sUseNum;
  m_sChangeNum = bag.m_sChangeNum;
  memcpy(m_pSItem, bag.m_pSItem, sizeof(SItemUnit*) * defMAX_KBITEM_NUM_PER_TYPE);
  memcpy(m_SItem, bag.m_SItem, sizeof(SItemUnit) * defMAX_KBITEM_NUM_PER_TYPE);
  memcpy(m_bChangeFlag, bag.m_bChangeFlag, sizeof(bool) * defMAX_KBITEM_NUM_PER_TYPE);

  return *this;
}

inline void CKitbag::SetChangeFlag(bool bChange)
{
  SItemGrid* pSGrid;

  for(auto i = 0; i < m_sCapacity; i++)
	m_bChangeFlag[i] = bChange;
  if(bChange)
	m_sChangeNum = m_sCapacity;
  else
	m_sChangeNum = 0;

  for(auto i = 0; i < m_sUseNum; i++)
  {
	pSGrid = GetGridContByNum(i);
	if(pSGrid)
	  pSGrid->SetChange(bChange);
  }
}

inline void CKitbag::SetSingleChangeFlag(short sPosID)
{
  m_bChangeFlag[sPosID] = true;
  m_sChangeNum++;
}

inline bool CKitbag::IsSingleChange(short sPosID)
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return false;

  if(m_bChangeFlag[sPosID])
	return true;
  bool		 bGridAttrChg = false;
  SItemGrid* pSGrid		  = GetGridContByID(sPosID);
  if(pSGrid)
	bGridAttrChg = pSGrid->IsChange();
  if(bGridAttrChg)
	SetSingleChangeFlag(sPosID);
  return bGridAttrChg;
}

inline bool CKitbag::IsChange()
{
  if(m_sChangeNum > 0)
	return true;

  SItemGrid* pSGrid;
  for(short i = 0; i < m_sUseNum; i++)
  {
	pSGrid = GetGridContByNum(i);
	if(pSGrid && pSGrid->IsChange())
	  return true;
  }

  return false;
}

inline short CKitbag::GetChangeNum()
{
  m_sChangeNum = 0;
  for(short i = 0; i < m_sUseNum; i++)
  {
	if(IsSingleChange(GetPosIDByNum(i)))
	  ++m_sChangeNum;
  }

  return m_sChangeNum;
}

//=============================================================================
// 设置背包容量
//=============================================================================
inline void CKitbag::SetCapacity(short sCapacity)
{
  if(sCapacity < 0)
	sCapacity = 0;
  if(sCapacity > defMAX_KBITEM_NUM_PER_TYPE)
	sCapacity = defMAX_KBITEM_NUM_PER_TYPE;

  m_sCapacity = sCapacity;
}

//=============================================================================
// 增加背包容量
//=============================================================================
inline bool CKitbag::AddCapacity(short sAddVal)
{
  if(sAddVal < 0)
	return false;

  short sStartP = m_sCapacity;
  if(sAddVal > defMAX_KBITEM_NUM_PER_TYPE - m_sCapacity)
	m_sCapacity = defMAX_KBITEM_NUM_PER_TYPE;
  else
	m_sCapacity += sAddVal;

  for(auto i = sStartP; i < m_sCapacity; i++)
	m_bChangeFlag[i] = false;

  return true;
}

//=============================================================================
// *******************注意该函数可能改变pGrid->sNum的值
//=============================================================================
inline short CKitbag::CanPush(SItemGrid* pGrid, short& sPosID)
{
  return Push(pGrid, sPosID, false);
}

//=============================================================================
// *******************注意该函数可能改变pGrid->sNum的值
//
// 向背包中放入物品：如果指定位置为-1，则自动放入相关或空闲位置，
// 如果指定位置是背包位置，则放入对应栏位，如果放不下，再放入相关或空闲位置。
// 如果背包已满，则剩余数目由pGrid->sNum返回
// 如果操作成功，则pGrid->sNum被设置为0
// sPosID返回第一次放入的位置
//=============================================================================
inline short CKitbag::Push(SItemGrid* pGrid, short& sPosID, bool bCommit, bool bSureOpr)
{
  short sRet;
  short sPushPos = sPosID;
  short sSearchPos = 0;
  short sLeftNum   = pGrid->sNum;
  short sFreeNum   = 0;
  short sPileNum   = pGrid->sNum;
  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}

  if(pGrid->sNum <= 0) // 数目非法
  {
	sRet = enumKBACT_ERROR_POPNUM;
	goto Error;
  }

  
  if(!bSureOpr)
  {
	CItemRecord* pCItem;
	pCItem = GetItemRecordInfo(pGrid->sID);
	if(!pCItem)
	{
	  sRet = enumKBACT_ERROR_PUSHITEMID;
	  goto Error;
	}
	sPileNum = (short)pCItem->nPileMax;
  }


  if(sPileNum < 1) // 叠加个数最少为1
  {
	sRet = enumKBACT_ERROR_PUSHITEMID;
	goto Error;
  }

  if(sPosID >= 0 && sPosID < m_sCapacity) // 指定位置
  {
	if(bCommit)
	{
	  if(m_SItem[sPosID].SContent.sID == 0)
	  {
		memcpy(&m_SItem[sPosID].SContent, pGrid, sizeof(SItemGrid));
		m_SItem[sPosID].SContent.sNum = 0;

		SItemUnit* pTempUnit						= &m_SItem[sPosID];
		m_pSItem[pTempUnit->sReverseID]				= m_pSItem[m_sUseNum];
		m_pSItem[pTempUnit->sReverseID]->sReverseID = pTempUnit->sReverseID;
		m_pSItem[m_sUseNum]							= pTempUnit;
		m_pSItem[m_sUseNum]->sReverseID				= m_sUseNum;
		m_sUseNum++;
	  }
	  if(m_SItem[sPosID].SContent.sID == pGrid->sID)
	  {
		sFreeNum = sPileNum - m_SItem[sPosID].SContent.sNum;
		if(sFreeNum == 0)
		  sPushPos = -1;
		else if(sFreeNum > 0)
		{
		  sLeftNum -= sFreeNum;
		  if(sLeftNum <= 0)
		  {
			m_SItem[sPosID].SContent.sNum = sPileNum + sLeftNum;
			SetSingleChangeFlag(sPosID);

			pGrid->sNum = 0;
			sRet		= enumKBACT_SUCCESS;
			goto Error;
		  } else
		  {
			m_SItem[sPosID].SContent.sNum = sPileNum;
			SetSingleChangeFlag(sPosID);
		  }
		}
	  }
	} else
	{
	  if(m_SItem[sPosID].SContent.sID == 0)
		sLeftNum -= sPileNum;
	  if(m_SItem[sPosID].SContent.sID == pGrid->sID)
	  {
		sFreeNum = sPileNum - m_SItem[sPosID].SContent.sNum;
		if(sFreeNum == 0)
		  sPushPos = -1;
		else if(sFreeNum > 0)
		{
		  sLeftNum -= sFreeNum;
		}
	  }
	  if(sLeftNum <= 0)
	  {
		pGrid->sNum = 0;
		sRet		= enumKBACT_SUCCESS;
		goto Error;
	  }
	}
  }

  if(sPileNum > 1) // 可以合并，则搜索相同道具的栏位
  {
	for(short i = 0; i < m_sCapacity; i++)
	{
	  if(m_SItem[i].SContent.sID == pGrid->sID) // 找到相同的道具
	  {
		sFreeNum = sPileNum - m_SItem[i].SContent.sNum;
		if(sFreeNum > 0)
		{
		  if(sPushPos < 0 || sPushPos >= m_sCapacity)
			sPushPos = i;
		  sLeftNum -= sFreeNum;
		  if(bCommit)
		  {
			if(sLeftNum <= 0)
			{
			  m_SItem[i].SContent.sNum = sPileNum + sLeftNum;
			  SetSingleChangeFlag(i);

			  pGrid->sNum = 0;
			  sRet		  = enumKBACT_SUCCESS;
			  goto Error;
			} else
			{
			  m_SItem[i].SContent.sNum = sPileNum;
			  SetSingleChangeFlag(i);
			}
		  } else
		  {
			if(sLeftNum <= 0)
			{
			  pGrid->sNum = 0;
			  sRet		  = enumKBACT_SUCCESS;
			  goto Error;
			}
		  }
		}
	  }
	}
  }

  
  while(sLeftNum > 0) // 还有道具没有放下，则放在空闲栏位
  {
	if(sSearchPos >= m_sCapacity)
	{
	  pGrid->sNum = sLeftNum;

	  sRet = enumKBACT_ERROR_FULL;
	  goto Error;
	}
	if(m_SItem[sSearchPos].SContent.sID == 0)
	{
	  //if (sPushPos < 0 || sPushPos >= m_sCapacity)
	  sPushPos = sSearchPos;

	  sLeftNum -= sPileNum;
	  if(bCommit)
	  {
		SetSingleChangeFlag(sSearchPos);
		memcpy(&m_SItem[sSearchPos].SContent, pGrid, sizeof(SItemGrid));
		SItemUnit* pTempUnit						= &m_SItem[sSearchPos];
		m_pSItem[pTempUnit->sReverseID]				= m_pSItem[m_sUseNum];
		m_pSItem[pTempUnit->sReverseID]->sReverseID = pTempUnit->sReverseID;
		m_pSItem[m_sUseNum]							= pTempUnit;
		m_pSItem[m_sUseNum]->sReverseID				= m_sUseNum;
		++m_sUseNum;

		if(sLeftNum <= 0)
		{
		  m_SItem[sSearchPos].SContent.sNum = sPileNum + sLeftNum;
		  pGrid->sNum						= 0;
		  sRet								= enumKBACT_SUCCESS;
		  goto Error;
		} else
		{
		  m_SItem[sSearchPos].SContent.sNum = sPileNum;
		}
	  } else
	  {
		if(sLeftNum <= 0)
		{
		  pGrid->sNum = 0;
		  sRet		  = enumKBACT_SUCCESS;
		  goto Error;
		}
	  }
	}
	sSearchPos++;
  }

  sRet = enumKBACT_SUCCESS;

Error:
  CheckValid();
  sPosID = sPushPos;
  return sRet;
}

inline short CKitbag::CanPop(SItemGrid* pGrid, short sPosID)
{
  return Pop(pGrid, sPosID, false);
}

//=============================================================================
// 从背包中取出pGrid->sNum个物品，如果位置非法，或物品的数目非法，则操作失败。
// 若要求弹出的道具数目是0，则全部弹出
// 若操作成功，则物品信息从pGrid中返回。
//=============================================================================
inline short CKitbag::Pop(SItemGrid* pGrid, short sPosID, bool bCommit)
{
  short sRet;
  short sPopNum = pGrid->sNum;
  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }

  if(sPosID < 0 || sPosID >= m_sCapacity)
  {
	sRet = enumKBACT_ERROR_RANGE;
	goto Error;
  }

  if(m_SItem[sPosID].SContent.sID <= 0) // 空栏位
  {
	sRet = enumKBACT_ERROR_NULLGRID;
	goto Error;
  }

  if(pGrid->sNum < 0 || pGrid->sNum > m_SItem[sPosID].SContent.sNum) // 数目非法
  {
	sRet = enumKBACT_ERROR_POPNUM;
	goto Error;
  }

  
  memcpy(pGrid, &m_SItem[sPosID].SContent, sizeof(SItemGrid));

  if(sPopNum == 0 || sPopNum == m_SItem[sPosID].SContent.sNum)
  {
	pGrid->sNum = m_SItem[sPosID].SContent.sNum;
	if(bCommit)
	  m_SItem[sPosID].SContent.sID = 0;
  } else
  {
	pGrid->sNum = sPopNum;
	if(bCommit)
	  m_SItem[sPosID].SContent.sNum -= sPopNum;
  }

  if(bCommit)
  {
	SetSingleChangeFlag(sPosID);
	if(m_SItem[sPosID].SContent.sID == 0)
	{
	  --m_sUseNum;
	  SItemUnit* pTempUnit						  = &m_SItem[sPosID];
	  m_pSItem[pTempUnit->sReverseID]			  = m_pSItem[m_sUseNum];
	  m_pSItem[pTempUnit->sReverseID]->sReverseID = pTempUnit->sReverseID;
	  m_pSItem[m_sUseNum]						  = pTempUnit;
	  m_pSItem[m_sUseNum]->sReverseID			  = m_sUseNum;
	}
  }

  sRet = enumKBACT_SUCCESS;

Error:
  CheckValid();
  return sRet;
}

//=============================================================================
// 清除栏位内容
//=============================================================================
inline short CKitbag::Clear(short sPosID)
{
  short sRet;

  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}
  // 	if (sPosID < 0 || sPosID >= m_sCapacity)
  // 		sRet = enumKBACT_ERROR_RANGE;

  // 数值合理性判断，如果出界则写LOG -Waiting Add 2009.3.24
  if(sPosID < 0 || sPosID >= defMAX_KBITEM_NUM_PER_TYPE || sPosID >= m_sCapacity)
  {
	sRet = enumKBACT_ERROR_RANGE;
	LG("exception3", "Kit bag clear(%d) capacity(%d)", sPosID, m_sCapacity);
	goto Error;
  }

  // 清除栏位物品信息
  if(m_SItem[sPosID].SContent.sID != 0)
  {
	SetSingleChangeFlag(sPosID);
	m_SItem[sPosID].SContent.sID = 0;

	--m_sUseNum;
	SItemUnit* pTempUnit							   = &m_SItem[sPosID];
	m_pSItem[pTempUnit->sReverseID]			   = m_pSItem[m_sUseNum];
	m_pSItem[pTempUnit->sReverseID]->sReverseID = pTempUnit->sReverseID;
	m_pSItem[m_sUseNum]				   = pTempUnit;
	m_pSItem[m_sUseNum]->sReverseID	   = m_sUseNum;
  }

  sRet = enumKBACT_SUCCESS;

Error:
  CheckValid();
  return sRet;
}

//=============================================================================
// 清除栏位内容
//=============================================================================
inline short CKitbag::Clear(SItemGrid* pGrid, short sNum, short* psPosID)
{
  short sRet;

  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}
  if(!pGrid)
  {
	sRet = enumKBACT_ERROR_NULLGRID;
	goto Error;
  }
  if(sNum == 0)
	sNum = pGrid->sNum;
  if(sNum > pGrid->sNum)
  {
	sRet = enumKBACT_ERROR_POPNUM;
	goto Error;
  }

  for(short k = 0; k < m_sUseNum; k++)
  {
	if(pGrid == GetGridContByNum(k))
	{
	  if(psPosID)
		*psPosID = GetPosIDByNum(k);
	  if(sNum == pGrid->sNum)
	  {
		sRet = Clear(GetPosIDByNum(k));
		goto Error;
	  } else
	  {
		sRet = enumKBACT_SUCCESS;
		pGrid->sNum -= sNum;
		SetSingleChangeFlag(GetPosIDByNum(k));
		goto Error;
	  }
	}
  }

  sRet = enumKBACT_ERROR_NULLGRID;

Error:
  return sRet;
}

//=============================================================================
// 刷新栏位内容
//=============================================================================
inline short CKitbag::Refresh(short sPosID)
{
  short sRet;

  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}
  if(sPosID < 0 || sPosID >= m_sCapacity)
	sRet = enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID != 0 && m_SItem[sPosID].SContent.sNum == 0)
  {
	SetSingleChangeFlag(sPosID);
	m_SItem[sPosID].SContent.sID = 0;

	--m_sUseNum;
	SItemUnit* pTempUnit							   = &m_SItem[sPosID];
	m_pSItem[pTempUnit->sReverseID]			   = m_pSItem[m_sUseNum];
	m_pSItem[pTempUnit->sReverseID]->sReverseID = pTempUnit->sReverseID;
	m_pSItem[m_sUseNum]				   = pTempUnit;
	m_pSItem[m_sUseNum]->sReverseID	   = m_sUseNum;
  }

  sRet = enumKBACT_SUCCESS;

Error:
  CheckValid();
  return sRet;
}

//=============================================================================
// 互换道具格内容及其指针，若位置非法，则不能交换
//=============================================================================
inline short CKitbag::Switch(short sSrcPosID, short sTarPosID)
{
  short		sRet;
  SItemGrid SGridCont;

  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}
  if(sSrcPosID < 0 || sSrcPosID >= m_sCapacity || sTarPosID < 0 || sTarPosID >= m_sCapacity)
  {
	sRet = enumKBACT_ERROR_RANGE;
	goto Error;
  }

  if(m_SItem[sSrcPosID].SContent.sID == 0 && m_SItem[sTarPosID].SContent.sID == 0)
  {
	sRet = enumKBACT_SUCCESS;
	goto Error;
  }

  SGridCont							 = m_SItem[sTarPosID].SContent;
  m_SItem[sTarPosID].SContent = m_SItem[sSrcPosID].SContent;
  m_SItem[sSrcPosID].SContent = SGridCont;

  short sSrcRevs, sTarRevs;
  sSrcRevs							   = m_SItem[sSrcPosID].sReverseID;
  sTarRevs							   = m_SItem[sTarPosID].sReverseID;
  m_pSItem[sSrcRevs]			   = &m_SItem[sTarPosID];
  m_SItem[sTarPosID].sReverseID = sSrcRevs;
  m_pSItem[sTarRevs]			   = &m_SItem[sSrcPosID];
  m_SItem[sSrcPosID].sReverseID = sTarRevs;

  SetSingleChangeFlag(sSrcPosID);
  SetSingleChangeFlag(sTarPosID);

  sRet = enumKBACT_SUCCESS;

Error:
  CheckValid();
  return sRet;
}

//=============================================================================
// 重组道具格内容（如果可合并，sSrcNum=0时，表示合并源格上的全部数目）
//=============================================================================
inline short CKitbag::Regroup(short sSrcPosID, short sSrcNum, short sTarPosID)
{
  short		sRet;
  SItemGrid SGridCont;
  SItemGrid *pSSrcCont, *pSTarCont = nullptr;
  //密码锁定状态
  //if(IsPwdLocked())
  //{
  //sRet = enumKBACT_ERROR_LOCK;
  //goto Error;
  //}

  if(m_bLock)
  {
	sRet = enumKBACT_ERROR_LOCK;
	goto Error;
  }
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //{
  //	sRet = enumKBACT_ERROR_RANGE;
  //	goto Error;
  //}
  if(sSrcPosID < 0 || sSrcPosID >= m_sCapacity || sTarPosID < 0 || sTarPosID >= m_sCapacity)
  {
	sRet = enumKBACT_ERROR_RANGE;
	goto Error;
  }

  pSSrcCont = &m_SItem[sSrcPosID].SContent;
  pSTarCont = &m_SItem[sTarPosID].SContent;
  if(pSSrcCont->sID == 0)
  {
	sRet = enumKBACT_ERROR_NULLGRID;
	goto Error;
  }

  if(pSSrcCont->sID == pSTarCont->sID) // 相同道具
  {
	CItemRecord* pCItem;
	pCItem = GetItemRecordInfo(pSSrcCont->sID);
	if(!pCItem)
	{
	  sRet = enumKBACT_ERROR_PUSHITEMID;
	  goto Error;
	}
	short sPileNum = (short)pCItem->nPileMax;
	if(sPileNum < 1) // 叠加个数最少为1
	{
	  sRet = enumKBACT_ERROR_PUSHITEMID;
	  goto Error;
	}

	short sFreeNum = sPileNum - pSTarCont->sNum;
	if(sFreeNum > 0) // 可以合并，则合并
	{
	  SetSingleChangeFlag(sSrcPosID);
	  SetSingleChangeFlag(sTarPosID);

	  if(sSrcNum < 0)
		sSrcNum = 0;
	  else if(sSrcNum == 0 || sSrcNum > pSSrcCont->sNum)
		sSrcNum = pSSrcCont->sNum;
	  if(sSrcNum > sFreeNum) sSrcNum = sFreeNum;

	  pSSrcCont->sNum -= sSrcNum;
	  pSTarCont->sNum += sSrcNum;
	  if(pSSrcCont->sNum == 0)
		sRet = Clear(sSrcPosID);
	  else
		sRet = enumKBACT_SUCCESS;
	} else // 不可合并，则换位
	  sRet = Switch(sSrcPosID, sTarPosID);
  } else if(pSTarCont->sID == 0)
  {
	if(sSrcNum < 0)
	  sSrcNum = 0;
	else if(sSrcNum == 0 || sSrcNum > pSSrcCont->sNum)
	  sSrcNum = pSSrcCont->sNum;

	if(sSrcNum > 0)
	{
	  SetSingleChangeFlag(sSrcPosID);
	  SetSingleChangeFlag(sTarPosID);

	  SItemGrid SSrcCont = *pSSrcCont;
	  SSrcCont.sNum		 = sSrcNum;
	  sRet				 = Push(&SSrcCont, sTarPosID);
	  pSSrcCont->sNum -= (sSrcNum - SSrcCont.sNum);
	  if(sRet != enumKBACT_SUCCESS)
		goto Error;
	  if(pSSrcCont->sNum == 0)
		sRet = Clear(sSrcPosID);
	  else
		sRet = enumKBACT_SUCCESS;
	}
  } else // 不同道具，则换位
  {
	sRet = Switch(sSrcPosID, sTarPosID);
  }

Error:
  CheckValid();
  return sRet;
}

inline bool CKitbag::IsFull() const
{
  return m_sUseNum >= m_sCapacity;
}

//=============================================================================
// 通过道具栏位置，取道具信息
//=============================================================================
inline SItemGrid* CKitbag::GetGridContByID(short sPosID)
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return NULL;

  if(m_SItem[sPosID].SContent.sID <= 0)
	return NULL;

  return &m_SItem[sPosID].SContent;
}

//=============================================================================
// 通过道具栏位置的反索引，取道具信息
//=============================================================================
inline SItemGrid* CKitbag::GetGridContByNum(short sPosNum)
{
  if(sPosNum < 0 || sPosNum >= m_sUseNum)
	return NULL;

  if(m_pSItem[sPosNum]->SContent.sID <= 0)
	return NULL;

  return &m_pSItem[sPosNum]->SContent;
}

//=============================================================================
// 由道具栏位置的反索引，取道具栏位置
//=============================================================================
inline short CKitbag::GetPosIDByNum(short sPosNum) const 
{
  if(sPosNum < 0 || sPosNum >= m_sUseNum)
	return -1;

  return m_pSItem[sPosNum]->sPosID;
}

inline bool CKitbag::GetPosIDByGrid(SItemGrid* pGrid, short* psPosID)
{
  if(!pGrid)
	return false;
  for(short k = 0; k < m_sUseNum; k++)
  {
	if(pGrid == GetGridContByNum(k))
	{
	  if(psPosID)
		*psPosID = GetPosIDByNum(k);
	  return true;
	}
  }

  return false;
}

inline short CKitbag::GetID(short sPosID) const
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;

  return m_SItem[sPosID].SContent.sID;
}

inline short CKitbag::GetNum(short sPosID) const
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID == 0)
	return enumKBACT_ERROR_NULLGRID;
  return m_SItem[sPosID].SContent.sNum;
}

inline long CKitbag::GetDBParam(short sParamID, short sPosID)
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;
  if(sParamID < 0 || sParamID >= enumITEMDBP_MAXNUM)
	return enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID == 0)
	return enumKBACT_ERROR_NULLGRID;

  return m_SItem[sPosID].SContent.GetDBParam(sParamID);
}

inline short CKitbag::SetDBParam(short sParamID, long lParamVal, short sPosID)
{
  //if(IsPwdLocked())
  //return enumKBACT_ERROR_LOCK;
  if(m_bLock)
	return enumKBACT_ERROR_LOCK;

  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //	return enumKBACT_ERROR_RANGE;
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;

  if(sParamID < 0 || sParamID >= enumITEMDBP_MAXNUM)
	return enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID == 0)
	return enumKBACT_ERROR_NULLGRID;

  m_SItem[sPosID].SContent.SetDBParam(sParamID, lParamVal);

  return enumKBACT_SUCCESS;
}

inline short CKitbag::GetEnergy(bool bMax, short sPosID) const
{
  //if (sType < 0 || sType >= enumKBITEM_TYPE_NUM)
  //	return enumKBACT_ERROR_RANGE;
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID == 0)
	return enumKBACT_ERROR_NULLGRID;

  if(bMax)
	return m_SItem[sPosID].SContent.sEnergy[1];
  else
	return m_SItem[sPosID].SContent.sEnergy[0];
}

inline short CKitbag::SetEnergy(bool bMax, short sEnergy, short sPosID)
{
  //if(IsPwdLocked())
  //return enumKBACT_ERROR_LOCK;
  if(m_bLock)
	return enumKBACT_ERROR_LOCK;

  if(sPosID < 0 || sPosID >= m_sCapacity)
	return enumKBACT_ERROR_RANGE;

  if(m_SItem[sPosID].SContent.sID == 0)
	return enumKBACT_ERROR_NULLGRID;

  if(bMax)
	m_SItem[sPosID].SContent.sEnergy[1] = sEnergy;
  else
	m_SItem[sPosID].SContent.sEnergy[0] = sEnergy;

  return enumKBACT_SUCCESS;
}

inline BOOL CKitbag::HasItem(short sPosID) const
{
  return GetID(sPosID) > 0;
}

inline BOOL CKitbag::IsEnable(short sPosID) const
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return FALSE;

  return !(m_SItem[sPosID].byState & ITEM_DISENABLE);
}

inline void CKitbag::Enable(short sPosID)
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return;

  m_SItem[sPosID].byState &= ~ITEM_DISENABLE;
}

inline void CKitbag::Disable(short sPosID)
{
  if(sPosID < 0 || sPosID >= m_sCapacity)
	return;

  m_SItem[sPosID].byState |= ITEM_DISENABLE;
}

inline bool CKitbag::CheckValid(void)
{
  short sUseNum	 = GetUseGridNum();
  short sFactNum = 0;

  for(short i = 0; i < m_sCapacity; i++)
  {
	if(m_SItem[i].SContent.sID > 0)
	  sFactNum++;
  }

  if(sFactNum != sUseNum)
  {
	//LG("道具栏错误", "道具栏操作过程中出现错误！");
	LG("GridError", "Grid num can't match!");
	return false;
  }

  return true;
}

//=============================================================================
inline char* KitbagData2String(CKitbag* pKitbag, char* szStrBuf, int nLen)
{
  //static char buff[7000];
  if(!pKitbag || !szStrBuf) return NULL;

  __int64 lnCheckSum = 0;
  char	  szData[512];

  int nBufLen = 0, nDataLen;
  int lentemp; // 不加密的信息头
  //char * pbufftemp;
  //buff[0] = '\0';
  //szStrBuf[0] = '\0'; 外部已经全部初始为0

  //sprintf(szData, "%d@%d#", pKitbag->GetCapacity(), 114);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d@%d#", pKitbag->GetCapacity(), 114);
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szStrBuf, szData);
  strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;

  //pbufftemp = szStrBuf;
  //szStrBuf = buff;
  lentemp = nBufLen;

  short		 sUseNum;
  SItemGrid* pGridCont;

  sUseNum = pKitbag->GetUseGridNum();
  //sprintf(szData, "%d;", sUseNum);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d;", sUseNum);
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szStrBuf, szData);
  strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;

  for(int j = 0; j < pKitbag->GetCapacity(); j++)
  {
	pGridCont = pKitbag->GetGridContByID(j);
	if(!pGridCont)
	  continue;
	/*	2008-7-28	yyy	change	begin!	//	在最后增加数据库唯一ID号。
			sprintf(szData, "%d,%d,%d,%d,%d,%d,%d,%d",
				j, pGridCont->sID, pGridCont->sNum,
				pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv);
				*/
	//sprintf(szData, "%d,%d,%d,%d,%d,%d,%d,%d,%d",
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d",
				j, pGridCont->sID, pGridCont->sNum,
				pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv, pGridCont->dwDBID);
	//	2008-7-28	yyy	change	end!
	nDataLen = (int)strlen(szData);
	if(nBufLen + nDataLen >= nLen) return NULL;
	//strcat(szStrBuf, szData);
	strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
	nBufLen += nDataLen;
	/*	2008-7-28	yyy	change	begin!	//	检验和增加数据库唯一ID的信息。
			lnCheckSum += (pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv);
			*/
	lnCheckSum += (pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv + pGridCont->dwDBID);
	//	2008-7-28	yyy	change	end!
	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  //sprintf(szData, ",%d", pGridCont->GetDBParam(m));
	  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d", pGridCont->GetDBParam(m));
	  nDataLen = (int)strlen(szData);
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szStrBuf, szData);
	  strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
	  nBufLen += nDataLen;
	  lnCheckSum += pGridCont->GetDBParam(m);
	}
	if(pGridCont->IsInstAttrValid())
	{
	  nDataLen = 2;
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szStrBuf, ",1");
	  strncat_s(szStrBuf, nLen, ",1", _TRUNCATE);
	  nBufLen += nDataLen;

	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		//sprintf(szData, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		_snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		nDataLen = (int)strlen(szData);
		if(nBufLen + nDataLen >= nLen) return NULL;
		//strcat(szStrBuf, szData);
		strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
		nBufLen += nDataLen;
		lnCheckSum += pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1];
	  }
	} else
	{
	  nDataLen = 2;
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szStrBuf, ",0");
	  strncat_s(szStrBuf, nLen, ",0", _TRUNCATE);
	  nBufLen += nDataLen;
	}
	//sprintf(szData, ";");
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, ";");
	nDataLen = (int)strlen(szData);
	if(nBufLen + nDataLen >= nLen) return NULL;
	//strcat(szStrBuf, szData);
	strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
	nBufLen += nDataLen;
  }

  //sprintf(szData, "%d", lnCheckSum);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%lld", lnCheckSum);
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szStrBuf, szData);
  strncat_s(szStrBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;

  //int len  = Encrypt(pbufftemp+lentemp,7000,szStrBuf,nBufLen-lentemp);
  //pbufftemp[len+lentemp] = '\0';
  EncryptEx(szStrBuf + lentemp, nBufLen - lentemp);

  return szStrBuf;
}

inline const char* KitbagData2StringEx(CKitbag* pKitbag, StringPoolL& stringPool, int index)
{
  if(!pKitbag) return NULL;

  __int64 lnCheckSum = 0;
  char	  szData[512];

  stringPool[index].Printf("%d@%d#;", pKitbag->GetCapacity(), 114);

  short		 sUseNum;
  SItemGrid* pGridCont;

  sUseNum = pKitbag->GetUseGridNum();
  //sprintf(szData, "%d;", sUseNum);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d;", sUseNum);
  stringPool[index] += szData;

  for(int j = 0; j < pKitbag->GetCapacity(); j++)
  {
	pGridCont = pKitbag->GetGridContByID(j);
	if(!pGridCont)
	  continue;

	_snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d",
				j, pGridCont->sID, pGridCont->sNum,
				pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv, pGridCont->dwDBID);
	stringPool[index] += szData;

	lnCheckSum += (pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv + pGridCont->dwDBID);

	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d", pGridCont->GetDBParam(m));
	  stringPool[index] += szData;

	  lnCheckSum += pGridCont->GetDBParam(m);
	}
	if(pGridCont->IsInstAttrValid())
	{
	  stringPool[index] += ",1";

	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		_snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		stringPool[index] += szData;

		lnCheckSum += pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1];
	  }
	} else
	{
	  stringPool[index] += ",0";
	}

	stringPool[index] += ";";
  }

  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%lld", lnCheckSum);
  stringPool[index] += szData;

  //::OutputDebugStr((const char*)stringPool[index]);
  // 48@114#
  EncryptExEx(7, stringPool, index);

  return (const char*)stringPool[index];
}

inline bool String2KitbagData(CKitbag* pKitbag, std::string& strData)
{
  static char buff[7000];
  if(!pKitbag)
	return false;
  if(!strcmp(strData.c_str(), ""))
	return true;

  __int64	  lnCheckSum = 0;
  const short csStrNum	 = 1 * defMAX_KBITEM_NUM_PER_TYPE * 2 + 1 + 1;
  std::string strList[csStrNum];
  const short csSubNum = 8 + enumITEMDBP_MAXNUM + defITEM_INSTANCE_ATTR_NUM_VER110 * 2 + 1;
  std::string strSubList[csSubNum];
  std::string strVer[2];
  std::string strCap[2];
  bool		  bIsOldVer;
  int		  nSegNum;
  if(Util_ResolveTextLine(strData.c_str(), strCap, 2, '@') > 1) // 包含容量字段
  {
	pKitbag->SetCapacity(Str2Int(strCap[0]));
	bIsOldVer = Util_ResolveTextLine(strCap[1].c_str(), strVer, 2, '#') == 1 ? true : false;
  } else
  {
	bIsOldVer = Util_ResolveTextLine(strCap[0].c_str(), strVer, 2, '#') == 1 ? true : false;
  }

  //	2008-7-28	yangyinyu	add	begin!
  int iVer = atoi(strVer[0].c_str());
  //	2008-7-28	yangyinyu	add	end!

  if(bIsOldVer)
  {
	if(!strcmp(strVer[0].c_str(), ""))
	  return true;
	/*	2008-7-28	yangyinyu	change	begin!	//	因为增加道具的唯一ID号，提升版本为114。在这里113和114是兼容的。
		if(strcmp(strVer[0].c_str(),"113") == 0)
		*/
	if(iVer == 113 || iVer == 114)
	//	2008-7-28	yangyinyu	change	end!
	{
	  int len	= Decrypt(buff, 7000, strVer[1].c_str(), (int)strVer[1].length());
	  buff[len] = '\0';
	  nSegNum	= Util_ResolveTextLine(buff, strList, csStrNum, ';');

	} else
	  nSegNum = Util_ResolveTextLine(strVer[0].c_str(), strList, csStrNum, ';');
  } else
  {
	if(!strcmp(strVer[1].c_str(), ""))
	  return true;

	if(iVer == 113 || iVer == 114)
	{
	  int len	= Decrypt(buff, 7000, strVer[1].c_str(), (int)strVer[1].length());
	  buff[len] = '\0';
	  nSegNum	= Util_ResolveTextLine(buff, strList, csStrNum, ';');

	} else
	{
	  nSegNum = Util_ResolveTextLine(strVer[1].c_str(), strList, csStrNum, ';');
	}
	if(nSegNum < 2)
	  return false;
  }

  short sSegID	 = 0, sTCount;
  short sUseGridNum, sGridID;
  int	nItemNumPerPage;
  if(bIsOldVer) // 老版本不包含校验和
	nItemNumPerPage = (nSegNum - 1);
  else
	nItemNumPerPage = (nSegNum - 2);


	sUseGridNum = Str2Int(strList[sSegID++]);
  for(int j = 0; j < nItemNumPerPage; j++)
  {
	SItemGrid SGridCont;
	sTCount = 0;
	Util_ResolveTextLine(strList[sSegID++].c_str(), strSubList, csSubNum, ',');
	sGridID				 = Str2Int(strSubList[sTCount++]);
	SGridCont.sID		 = Str2Int(strSubList[sTCount++]);
	SGridCont.sNum		 = Str2Int(strSubList[sTCount++]);
	SGridCont.sEndure[0] = Str2Int(strSubList[sTCount++]);
	SGridCont.sEndure[1] = Str2Int(strSubList[sTCount++]);
	SGridCont.sEnergy[0] = Str2Int(strSubList[sTCount++]);
	SGridCont.sEnergy[1] = Str2Int(strSubList[sTCount++]);
	SGridCont.chForgeLv	 = Str2Int(strSubList[sTCount++]);
	//	2008-7-28	yangyinyu	add	begin!
	if(iVer == 114)
	{
	  SGridCont.dwDBID = Str2Int(strSubList[sTCount++]);
	} else
	{
	  SGridCont.dwDBID = 0;
	}
	//	2008-7-28	yangyinyu	add	end!

	/*	2008-7-28	yangyinyu	change	begin!
			lnCheckSum += SGridCont.sID + SGridCont.sNum + SGridCont.sEndure[0] + SGridCont.sEndure[1] + SGridCont.sEnergy[0] + SGridCont.sEnergy[1] + SGridCont.chForgeLv;
			*/
	lnCheckSum += SGridCont.sID + SGridCont.sNum + SGridCont.sEndure[0] + SGridCont.sEndure[1] + SGridCont.sEnergy[0] + SGridCont.sEnergy[1] + SGridCont.chForgeLv + SGridCont.dwDBID;
	//	2008-7-28	yangyinyu	change	end!
	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  SGridCont.SetDBParam(m, Str2Int(strSubList[sTCount++]));
	  lnCheckSum += SGridCont.GetDBParam(m);
	}

	if(!bIsOldVer && (Str2Int(strVer[0]) >= 113 || Str2Int(strVer[0]) == 112)) // 有属性数据是否存在的标示
	{
	  if(Str2Int(strSubList[sTCount++]) > 0) // 存在实例属性
	  {
		for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
		{
		  SGridCont.sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
		  SGridCont.sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
		  lnCheckSum += (SGridCont.sInstAttr[k][0] + SGridCont.sInstAttr[k][1]);
		}
	  } else
		SGridCont.SetInstAttrInvalid();
	} else
	{
	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		SGridCont.sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
		SGridCont.sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
		lnCheckSum += (SGridCont.sInstAttr[k][0] + SGridCont.sInstAttr[k][1]);
	  }
	}
	pKitbag->Push(&SGridCont, sGridID, true, true);
  }

  if(!bIsOldVer)
  {
	char szCheckSum[64];
	//sprintf(szCheckSum, "%d", lnCheckSum);
	_snprintf_s(szCheckSum, sizeof(szCheckSum), _TRUNCATE, "%lld", lnCheckSum);
	if(strncmp(szCheckSum, strList[sSegID++].c_str(), 64))
	  return false;
  } else
	pKitbag->SetVer(114);

  return true;
}

//	2008-7-28	yangyinyu	add	begin!

//	把道具转化成字符串。
inline bool SItemGrid2String(
	std::string& r,			 //	返回的串。
	long&		 lnCheckSum, //	返回的检验和。
	SItemGrid*	 pGridCont,	 //	栅格。
	int			 iOrder		 //	栅格次序。
)
{
  //	用于打印的临时缓冲区。
  static char szData[256];

  //	打印道具信息到字符串。
  //_snprintf(	szData,	256,	"%d,%d,%d,%d,%d,%d,%d,%d,%d",
  _snprintf_s(szData, 256, _TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d",
			  iOrder,
			  pGridCont->sID,
			  pGridCont->sNum,
			  pGridCont->sEndure[0],
			  pGridCont->sEndure[1],
			  pGridCont->sEnergy[0],
			  pGridCont->sEnergy[1],
			  pGridCont->chForgeLv,
			  pGridCont->dwDBID);

  r += szData;

  //	计算检验和。
  lnCheckSum +=
	  pGridCont->sID +
	  pGridCont->sNum +
	  pGridCont->sEndure[0] +
	  pGridCont->sEndure[1] +
	  pGridCont->sEnergy[0] +
	  pGridCont->sEnergy[1] +
	  pGridCont->chForgeLv +
	  pGridCont->dwDBID;

  //	打印DB参数。
  for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
  {
	//	打印DB参数。
	//_snprintf(	szData,	1,	",%d",	pGridCont->GetDBParam(m)	);
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d", pGridCont->GetDBParam(m));
	r += szData;

	//	计算检验和。
	lnCheckSum += pGridCont->GetDBParam(m);

	if(pGridCont->IsInstAttrValid())
	{
	  r += ",1";

	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		//_snprintf(	szData,	256,	",%d,%d",	pGridCont->sInstAttr[k][0],	pGridCont->sInstAttr[k][1]	);
		_snprintf_s(szData, 256, _TRUNCATE, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		r += szData;

		lnCheckSum += pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1];
	  }
	} else
	{
	  r += ",0";
	}
  };

  //
  return true;
};

//	把字符串转化成道具。
inline bool String2SItemGrid(SItemGrid* pGridCont, long& lnCheckSum, const std::string& sData, int iVer, bool bIsOldVer)
{
  //	解出字符串。
  const short csSubNum = 8 + enumITEMDBP_MAXNUM + defITEM_INSTANCE_ATTR_NUM_VER110 * 2 + 1;

  std::string strSubList[csSubNum];

  Util_ResolveTextLine(sData.c_str(), strSubList, csSubNum, ',');

  //	设置所有属性。
  short sTCount			= 0;
  short sGridID			= Str2Int(strSubList[sTCount++]);
  pGridCont->sID		= Str2Int(strSubList[sTCount++]);
  pGridCont->sNum		= Str2Int(strSubList[sTCount++]);
  pGridCont->sEndure[0] = Str2Int(strSubList[sTCount++]);
  pGridCont->sEndure[1] = Str2Int(strSubList[sTCount++]);
  pGridCont->sEnergy[0] = Str2Int(strSubList[sTCount++]);
  pGridCont->sEnergy[1] = Str2Int(strSubList[sTCount++]);
  pGridCont->chForgeLv	= Str2Int(strSubList[sTCount++]);

  //	2008-7-28	yangyinyu	add	begin!
  if(iVer == 114)
  {
	pGridCont->dwDBID = Str2Int(strSubList[sTCount++]);
  } else
  {
	pGridCont->dwDBID = 0;
  }
  //	2008-7-28	yangyinyu	add	end!

  //	计算检验和。
  /*	2008-7-28	yangyinyu	change	begin!
	lnCheckSum += SGridCont.sID + SGridCont.sNum + SGridCont.sEndure[0] + SGridCont.sEndure[1] + SGridCont.sEnergy[0] + SGridCont.sEnergy[1] + SGridCont.chForgeLv;
		*/
  lnCheckSum +=
	  pGridCont->sID +
	  pGridCont->sNum +
	  pGridCont->sEndure[0] +
	  pGridCont->sEndure[1] +
	  pGridCont->sEnergy[0] +
	  pGridCont->sEnergy[1] +
	  pGridCont->chForgeLv +
	  pGridCont->dwDBID;
  //	2008-7-28	yangyinyu	change	end!

  //	读DB数据。
  for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
  {
	pGridCont->SetDBParam(m, Str2Int(strSubList[sTCount++]));
	lnCheckSum += pGridCont->GetDBParam(m);
  }

  //	读实例数据。
  if(!bIsOldVer && (iVer >= 113 || iVer == 112)) // 有属性数据是否存在的标示
  {
	if(Str2Int(strSubList[sTCount++]) > 0) // 存在实例属性
	{
	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		pGridCont->sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
		pGridCont->sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
		lnCheckSum += (pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1]);
	  }
	} else
	  pGridCont->SetInstAttrInvalid();
  } else
  {
	for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	{
	  pGridCont->sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
	  pGridCont->sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
	  lnCheckSum += (pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1]);
	}
  }

  //	*
  return true;
};

  //	2008-7-28	yangyinyu	add	end!

#endif // KITBAG_H
