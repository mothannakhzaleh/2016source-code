#include "StdAfx.h"
#include "uiitemcommand.h"
#include "ItemRecord.h"
#include "uicompent.h"
#include "uigoodsgrid.h"
#include "Character.h"
#include "GameApp.h"
#include "uifastcommand.h"
#include "PacketCmd.h"
#include "CommFunc.h"
#include "uiequipform.h"
#include <strstream>
#include "StringLib.h"
#include "SkillRecord.h"
#include "uiboatform.h"
#include "shipset.h"
#include "itempreset.h"
#include "stpose.h"
#include "stnpctalk.h"
#include "stoneset.h"
#include "ItemRefineSet.h"
#include "ItemRefineEffectSet.h"
#include "elfskillset.h"
#include "STAttack.h"
#include "STMove.h"
#include "uinpctradeform.h"
#include "UIBoothForm.h"
#include "UIBankForm.h"
#include "uitradeform.h"
#include "UIDoublePwdForm.h" // ning.yan 2008-11-10
#include "uisystemform.h"

using namespace GUI;
//---------------------------------------------------------------------------
// class CItemCommand
//---------------------------------------------------------------------------
static char buf[256] = {0};

const DWORD VALID_COLOR	   = COLOR_RED;
const DWORD GENERIC_COLOR  = COLOR_WHITE;
const DWORD ADVANCED_COLOR = 0xFF9CCFFF;
const DWORD GLOD_COLOR	   = 0xFFFFFF00;

const unsigned int ITEM_HEIGHT = 32;
const unsigned int ITEM_WIDTH  = 32;

map<int, DWORD> CItemCommand::_mapCoolDown; // 保存上一次放的道具技能的时间

//CItemCommand::CItemCommand( CItemRecord* pItem )//modified guojiangang 20090108
CItemCommand::CItemCommand(CItemRecord* pItem, bool isIconInStore) :
	_pItem(pItem), _dwColor(COLOR_WHITE), _pBoatHint(NULL)
{
  if(!_pItem) LG("error", "msgCItemCommand::CItemCommand(CItemRecord* pItem) pItem is NULL");

  _pImage		   = new CGuiPic;
  const char* file = NULL;
  //file = pItem->GetIconFile();//modified guojiangang 20090108
  if(isIconInStore)
  {
	file = pItem->GetIconFileInStore();
  } else
  {
	file = pItem->GetIconFile();
  }

  // 判断文件是否存在
  HANDLE hFile = CreateFile(file, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
  if(INVALID_HANDLE_VALUE == hFile)
  {
	_pImage->LoadImage("texture/icon/error.tga", ITEM_WIDTH, ITEM_HEIGHT, 0);
  } else
  {
	CloseHandle(hFile);
	if(isIconInStore)
	{
	  _pImage->LoadImage(file, 64, 64, 0);
	} else
	{
	  _pImage->LoadImage(file, ITEM_WIDTH, ITEM_HEIGHT, 0);
	}
  }

  memset(&_ItemData, 0, sizeof(_ItemData));
  _ItemData.sID = (short)pItem->lID;
  _ItemData.SetValid();

  _nPrice = _pItem->lPrice;
}

CItemCommand::CItemCommand(const CItemCommand& rhs) :
	_pImage(new CGuiPic(*rhs._pImage)), _pBoatHint(NULL)
{
  _Copy(rhs);
}

CItemCommand& CItemCommand::operator=(const CItemCommand& rhs)
{
  *_pImage = *rhs._pImage;

  _Copy(rhs);
  return *this;
}

void CItemCommand::_Copy(const CItemCommand& rhs)
{
  memcpy(&_ItemData, &rhs._ItemData, sizeof(_ItemData));
  SetBoatHint(rhs._pBoatHint);

  _pItem   = rhs._pItem;
  _dwColor = rhs._dwColor;
  _nPrice  = rhs._nPrice;
}

CItemCommand::~CItemCommand()
{
  //delete _pImage;
  SAFE_DELETE(_pImage); // UI当机处理

  if(_pBoatHint)
  {
	delete _pBoatHint;
	_pBoatHint = NULL;
  }
}

void CItemCommand::PUSH_HINT(const char* str, int value, DWORD color, int index)
{
  if(value == 0) return;

  _snprintf_s(buf, _countof(buf), _TRUNCATE, str, value);
  PushHint(buf, color, 5, 0, index);
}

void CItemCommand::SaleRender(int x, int y, int nWidth, int nHeight)
{
  static int nX, nY;
  static int w, h;
  nX = x + (nWidth - ITEM_WIDTH) / 2;
  nY = y + (nHeight - ITEM_HEIGHT) / 2;

  _pImage->Render(nX, nY, _ItemData.IsValid() ? _dwColor : (DWORD)0xff757575);

  if(_ItemData.sNum >= 0)
  {
	static int xNum, yNum;
	_snprintf_s(buf, _countof(buf), _TRUNCATE, "%d", _ItemData.sNum);
	CGuiFont::s_Font.GetSize(buf, w, h);

	xNum = nX + ITEM_WIDTH - w;
	yNum = nY + ITEM_HEIGHT - h;
	GetRender().FillFrame(xNum, yNum, xNum + w, yNum + h, 0xE0ADF6F7);
	CGuiFont::s_Font.Render(buf, xNum, yNum, COLOR_BLACK);
  }

  CGuiFont::s_Font.GetSize(_pItem->szName, w, h);
  if(w > nWidth)
  {
	static char szBuf1[128] = {0};
	static char szBuf2[128] = {0};
	static int	nEnter		= 0;
	//strncpy( szBuf1, _pItem->szName, sizeof(szBuf1) );
	strncpy_s(szBuf1, sizeof(szBuf1), _pItem->szName, _TRUNCATE);
	nEnter = (int)strlen(szBuf1) / 2;
	if(_ismbslead((unsigned char*)szBuf1, (unsigned char*)&szBuf1[nEnter]))
	{
	  nEnter--;
	}
	if(nEnter < 0) return;

	nEnter++;
	szBuf1[nEnter] = '\0';
	//strncpy( szBuf2, &_pItem->szName[nEnter], sizeof(szBuf2) );
	strncpy_s(szBuf2, sizeof(szBuf2), &_pItem->szName[nEnter], _TRUNCATE);

	CGuiFont::s_Font.GetSize(szBuf1, w, h);
	CGuiFont::s_Font.Render(szBuf1, x + (nWidth - w) / 2, nY - h - h - 2, COLOR_BLACK);

	CGuiFont::s_Font.GetSize(szBuf2, w, h);
	CGuiFont::s_Font.Render(szBuf2, x + (nWidth - w) / 2, nY - h - 2, COLOR_BLACK);
  } else
  {
	CGuiFont::s_Font.Render(_pItem->szName, x + (nWidth - w) / 2, nY - h - 2, COLOR_BLACK);
  }

  _snprintf_s(buf, _countof(buf), _TRUNCATE, "$%s", StringSplitNum(_nPrice));
  CGuiFont::s_Font.GetSize(buf, w, h);
  CGuiFont::s_Font.Render(buf, x + (nWidth - w) / 2, nY + ITEM_HEIGHT + 2, COLOR_BLACK);
}

void CItemCommand::Render(int x, int y)
{
  _pImage->Render(x, y, _ItemData.IsValid() ? _dwColor : (DWORD)0xff757575);

  // 显示道具数量
  if(_ItemData.sNum > 1)
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, "%d", _ItemData.sNum);
	static int w, h;
	CGuiFont::s_Font.GetSize(buf, w, h);

	x += ITEM_WIDTH - w;
	y += ITEM_HEIGHT - h;
	GetRender().FillFrame(x, y, x + w, y + h, 0xE0ADF6F7);
	CGuiFont::s_Font.Render(buf, x, y, COLOR_BLACK);
  }

  // add by ning.yan  2008-11-13  在道具栏显示道具已锁 begin
  if(_ItemData.dwDBID)
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_961));
	static int w, h;
	CGuiFont::s_Font.GetSize(buf, w, h);

	GetRender().FillFrame(x, y, x + w, y + h, 0xE0ADF6F7);
	CGuiFont::s_Font.Render(buf, x, y, COLOR_RED);
  }
  // end
}

void CItemCommand::OwnDefRender(int x, int y, int nWidth, int nHeight)
{
  static int nX, nY;
  static int w, h;
  nX = x + (nWidth - ITEM_WIDTH) / 2;
  nY = y + (nHeight - ITEM_HEIGHT) / 2;

  _pImage->Render(nX, nY, _ItemData.IsValid() ? _dwColor : (DWORD)0xff757575);

  if(_ItemData.sNum >= 0)
  {
	static int xNum, yNum;
	_snprintf_s(buf, _countof(buf), _TRUNCATE, "%d", _ItemData.sNum);
	CGuiFont::s_Font.GetSize(buf, w, h);

	xNum = nX + ITEM_WIDTH - w;
	yNum = nY + ITEM_HEIGHT - h;
	GetRender().FillFrame(xNum, yNum, xNum + w, yNum + h, 0xE0ADF6F7);
	CGuiFont::s_Font.Render(buf, xNum, yNum, COLOR_BLACK);
  }

  CGuiFont::s_Font.GetSize(_pItem->szName, w, h);
  if(w > nWidth)
  {
	static char szBuf1[128] = {0};
	static char szBuf2[128] = {0};
	static int	nEnter		= 0;
	//strncpy( szBuf1, _pItem->szName, sizeof(szBuf1) );
	strncpy_s(szBuf1, sizeof(szBuf1), _pItem->szName, _TRUNCATE);
	nEnter = (int)strlen(szBuf1) / 2;
	if(_ismbslead((unsigned char*)szBuf1, (unsigned char*)&szBuf1[nEnter]))
	{
	  nEnter--;
	}
	if(nEnter < 0) return;

	nEnter++;
	szBuf1[nEnter] = '\0';
	//strncpy( szBuf2, &_pItem->szName[nEnter], sizeof(szBuf2) );
	strncpy_s(szBuf2, sizeof(szBuf2), &_pItem->szName[nEnter], _TRUNCATE);

	CGuiFont::s_Font.GetSize(szBuf1, w, h);
	CGuiFont::s_Font.Render(szBuf1, x + (nWidth - w) / 2, nY - h - h - 2, COLOR_BLACK);

	CGuiFont::s_Font.GetSize(szBuf2, w, h);
	CGuiFont::s_Font.Render(szBuf2, x + (nWidth - w) / 2, nY - h - 2, COLOR_BLACK);
  } else
  {
	CGuiFont::s_Font.Render(_pItem->szName, x + (nWidth - w) / 2, nY - h - 2, COLOR_BLACK);
  }

  //_snprintf_s( buf, _countof( buf ), _TRUNCATE, "$%s", StringSplitNum(_nPrice) );
  CGuiFont::s_Font.GetSize(_OwnDefText.c_str(), w, h);
  CGuiFont::s_Font.Render(_OwnDefText.c_str(), x + (nWidth - w) / 2, nY + ITEM_HEIGHT + 2, COLOR_BLACK);
}

void CItemCommand::AddHint(int x, int y, int index)
{
  bool isMain = false; // 判断是否要除二（卖出价）
  if(GetParent())
  {
	string name = GetParent()->GetForm()->GetName();
	if(name == "frmPlayertrade" || name == "frmItem" || name == "frmNPCstorage" || name == "frmTempBag" ||
	   name == "frmBreak" || name == "frmCooking" || name == "frmFound" || name == "frmBreak" ||
	   name == "frmStore" || name == "frmViewAll" ||
	   name == "frmSpiritMarry" || name == "frmSpiritErnie" || name == "frmEquipPurify")
	{
	  isMain = true;
	}
  }

  bool isStore = false; // 判断是否是商城
  if(GetParent())
  {
	string name = GetParent()->GetForm()->GetName();
	if(name == "frmStore")
	{
	  isStore = true;
	}
  }

  SGameAttr* pAttr = NULL;
  if(g_stUIBoat.GetHuman())
  {
	pAttr = g_stUIBoat.GetHuman()->getGameAttr();
  }
  if(!pAttr) return;

  SetHintIsCenter(true);

  static SItemHint item;
  memset(&item, 0, sizeof(SItemHint));
  CItemRecord* pEquipItem(0);
  // modify by ning.yan  20080821  begin
  if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // end
  {																			  //
	pEquipItem = GetItemRecordInfo(_ItemData.GetFusionItemID());
	if(pEquipItem)
	{
	  item.Convert(_ItemData, pEquipItem);
	}
  } else
  {
	item.Convert(_ItemData, _pItem);
  }

  //	2008-7-31	yangyinyu	add	begin!
  //	增加对道具锁定的处理。
  if(_ItemData.dwDBID)
  {
	PushHint(RES_STRING(CL_LANGUAGE_MATCH_960), COLOR_RED, 5, 0, index);
	AddHintHeight(6, index);
  }
  //	2008-7-31	yangyinyu	add	end!

  if(_pItem->sType >= 1 && _pItem->sType <= 10) // 武器:剑,巨剑,弓,火绳枪,刀,拳套,匕首,钱袋,短棒,锤子
  {
	if(_pItem->sType == 2)
	{
	  // modify by Philip.Wu  2006-06-09
	  // 将双手换一行显示，防止因用户ID过长而无法显示出双手

	  if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", GetName());
	  }

	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_624), COLOR_WHITE, 5, 1, index);
	} else
	{
	  if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
		PushHint(buf, COLOR_WHITE, 5, 1, index);
	  } else
	  {
		PushHint(GetName(), COLOR_WHITE, 5, 1, index);
	  }

	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	}

	// 基本类:攻击力,耐久度
	AddHintHeight(6, index);

	if(_pItem->lID != 3669) // 道具特殊处理，浪漫烟花，不显示攻击力
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_625), _GetValue(ITEMATTR_VAL_MNATK, item), _GetValue(ITEMATTR_VAL_MXATK, item));
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	// 需求类:力量，敏捷，体质，精神，幸运，专注,等级,职业
	AddHintHeight(6, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  if(_pItem->sNeedLv > pEquipItem->sNeedLv)
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }
	} else
	{
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	} else
	{
	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
  } else if(_pItem->sType == 22 || _pItem->sType == 11 || _pItem->sType == 27) // 衣服,盾,图腾
  {
	// 名字  modify by ning.yan 20080821 begin
	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // end
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	} else
	{
	  PushHint(GetName(), COLOR_WHITE, 5, 1, index);
	}

	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	// 基本类:防御力,耐久度
	AddHintHeight(6, index);

	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_629), ITEMATTR_VAL_DEF, item, COLOR_WHITE, index);

	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	//_PushValue( RES_STRING(CL_LANGUAGE_MATCH_630), ITEMATTR_VAL_PDEF, item, COLOR_WHITE, index );

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	AddHintHeight(6, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  if(_pItem->sNeedLv > pEquipItem->sNeedLv)
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }
	} else
	{
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	} else
	{
	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
  } else if(_pItem->sType == 25) // 项链
  {
	PushHint(GetName(), COLOR_WHITE, 5, 1, index); // 名字
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	//	曾亚要求加入耐久显示 Rain Add Begin.
	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}
	//	End.

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  if(_pItem->sNeedLv > pEquipItem->sNeedLv)
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }
	} else
	{
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	} else
	{
	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
	if(_pItem->lID == 6386 || _pItem->lID == 6387 || _pItem->lID == 6388 || _pItem->lID == 6389 || _pItem->lID == 6390 || _pItem->lID == 6391 || _pItem->lID == 6434 || _pItem->lID == 6428 || _pItem->lID == 6429 || _pItem->lID == 6430 || _pItem->lID == 6431 || _pItem->lID == 6432)
	{
	  _AddDescriptor(index);
	}
  } else if(_pItem->sType == 26) // 戒指
  {
	PushHint(GetName(), COLOR_WHITE, 5, 1, index); // 名字
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	//	曾亚要求加入耐久显示 Rain Add Begin.
	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}
	//	End.

	if(_pItem->lID == 1034) // 团队之星（特殊处理）
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_862), _ItemData.sEndure[0] * 10 - 1000, _ItemData.sEndure[1] * 10 - 1000); // 具体计算方式询问策划
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  return;
	} else
	{
	  if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	  {
		if(_pItem->sNeedLv > pEquipItem->sNeedLv)
		{
		  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
		} else
		{
		  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
		}
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }

	  if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	  {
		_ShowFusionBody(pEquipItem, index);
		_ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	  } else
	  {
		_ShowBody(index);
		_ShowWork(_pItem, pAttr, index);
	  }
	}
  } else if(_pItem->sType == 23) // 手套
  {
	// 名字 modify by ning.yan 20080821 begin
	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // end
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	} else
	{
	  PushHint(GetName(), COLOR_WHITE, 5, 1, index);
	}

	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	// 基本类:防御力,耐久度
	AddHintHeight(6, index);

	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_629), ITEMATTR_VAL_DEF, item, COLOR_WHITE, index);

	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_631), ITEMATTR_VAL_HIT, item, COLOR_WHITE, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	AddHintHeight(6, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  if(_pItem->sNeedLv > pEquipItem->sNeedLv)
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }

	} else
	{
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	} else
	{
	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
  } else if(_pItem->sType == 24) // 靴子
  {
	// 名字 modify by ning.yan  20080821 begin
	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // end
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	} else
	{
	  PushHint(GetName(), COLOR_WHITE, 5, 1, index);
	}

	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	// 基本类:防御力,耐久度
	AddHintHeight(6, index);
	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_629), ITEMATTR_VAL_DEF, item, COLOR_WHITE, index);

	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_632), ITEMATTR_VAL_FLEE, item, COLOR_WHITE, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	AddHintHeight(6, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  if(_pItem->sNeedLv > pEquipItem->sNeedLv)
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  } else
	  {
		PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), pEquipItem->sNeedLv, pAttr->get(ATTR_LV) >= pEquipItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);
	  }
	} else
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(_pItem, pEquipItem, pAttr, index);
	} else
	{
	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
  } else if(_pItem->sType == 20) // 头发
  {
	// 名字 modify by ning.yan  20080821 begin
	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // end
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", _ItemData.GetItemLevel(), GetName());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	} else
	{
	  PushHint(GetName(), COLOR_WHITE, 5, 1, index);
	}

	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	// 基本类:防御力,耐久度
	AddHintHeight(6, index);
	_PushValue(RES_STRING(CL_LANGUAGE_MATCH_629), ITEMATTR_VAL_DEF, item, COLOR_WHITE, index);

	if(!isStore) // 商城内不显示耐久
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	AddHintHeight(6, index);

	// 2006-05-25  by Philip
	// 已经熔合 => 取熔合之前两件装备的最高等级，两件装备的角色交集，两件装备的职业交集
	// 没有熔合 => 直接取当前装备的等级，角色，职业
	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  short nFusionItemLevel = _pItem->sNeedLv > pEquipItem->sNeedLv ? _pItem->sNeedLv : pEquipItem->sNeedLv;
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), nFusionItemLevel, pAttr->get(ATTR_LV) >= nFusionItemLevel ? GENERIC_COLOR : VALID_COLOR, index);

	  _ShowFusionBody(pEquipItem, index);
	  _ShowFusionWork(pEquipItem, _pItem, pAttr, index);
	} else
	{
	  PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);

	  _ShowBody(index);
	  _ShowWork(_pItem, pAttr, index);
	}
  } else if(_pItem->sType >= 31 && _pItem->sType <= 33) // 使用品:恢复类,加成类,特殊效果类
  {
	SetHintIsCenter(false);

	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	// Add by lark.li 20080430 begin
	if(5786 == _pItem->lID || 5787 == _pItem->lID || 5788 == _pItem->lID || 5789 == _pItem->lID || 6444 == _pItem->lID)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_644), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}
	// End

	//	绵羊要求加入耐久显示 Rain Add Begin.
	if(7050 == _pItem->lID || 7051 == _pItem->lID || 7052 == _pItem->lID)
	{
	  if(!isStore) // 商城内不显示耐久
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
		PushHint(buf, COLOR_WHITE, 5, 1, index);
	  }
	}
	//	End.
	if(_ItemData.sNum > 0)
	{
	  AddHintHeight(6, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_633), _ItemData.sNum);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	_AddDescriptor(index);

  }

  else if(_pItem->sType == 42) // 任务道具
  {
	PushHint(_pItem->szName, COLOR_BLUE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_BLUE, 5, 1, index);

	SetHintIsCenter(false);
	_AddDescriptor(index);
  } else if(_pItem->sType == 18 || _pItem->sType == 19) // 斧头,铁镐
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	if(_pItem->nID == 3908 || _pItem->nID == 3108 || _pItem->nID == 6538 || _pItem->nID == 6539 || _pItem->nID == 6585 || _pItem->nID == 6613 || _pItem->nID == 6917 || _pItem->nID == 6944) // 3108 add by Philip  2005-05-30
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	if(CItemRecord::IsVaildFusionID(_pItem) && _ItemData.GetFusionItemID() > 0) // modify by ning.yan  20080821
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_627), _ItemData.GetItemLevel() * 2 + 80); // 发挥度定义 0级-80% 1级-82% ...
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	}

	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);

	_AddDescriptor(index);
  } else if(_pItem->sType == 43) // 船长证明
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	if(_pBoatHint)
	{
	  PushHint(_pBoatHint->szName, COLOR_WHITE, 5, 1, index);

	  xShipInfo* pInfo = GetShipInfo(_pBoatHint->sBoatID);

	  if(pInfo)
	  {
		int nNeedLv = pInfo->sLvLimit;
		if(nNeedLv > 0)
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_628), nNeedLv);
		  PushHint(buf, g_stUIBoat.GetHuman()->getGameAttr()->get(ATTR_LV) >= nNeedLv ? GENERIC_COLOR : VALID_COLOR, 5, 1, index);
		}
	  }

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_634), _pBoatHint->sLevel);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00014), _pBoatHint->dwExp);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  AddHintHeight(6, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_636), _pBoatHint->dwHp, (int)(_pBoatHint->dwMaxHp));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  if(pInfo)
	  {
		_ShowWork(pInfo, g_stUIBoat.GetHuman()->getGameAttr(), index);
	  }

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_637), _pBoatHint->dwSp, (int)(_pBoatHint->dwMaxSp));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_638), _pBoatHint->dwMinAttack, (int)(_pBoatHint->dwMaxAttack));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_639), _pBoatHint->dwDef);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_640), _pBoatHint->dwSpeed);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_641), _pBoatHint->dwShootSpeed);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_642), _pBoatHint->byHasItem, _pBoatHint->byCapacity);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_643), StringSplitNum(_pBoatHint->dwPrice / 2));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	} else
	{
	  CBoat* pBoat = g_stUIBoat.FindBoat(_ItemData.GetDBParam(enumITEMDBP_INST_ID));
	  if(pBoat)
	  {
		CCharacter* pCha = pBoat->GetCha();
		PushHint(pCha->getName(), COLOR_WHITE, 5, 1, index);

		int nNeedLv = pCha->GetShipInfo()->sLvLimit;
		if(nNeedLv > 0)
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_628), nNeedLv);
		  PushHint(buf, g_stUIBoat.GetHuman()->getGameAttr()->get(ATTR_LV) >= nNeedLv ? GENERIC_COLOR : VALID_COLOR, 5, 1, index);
		}

		SGameAttr* pAttr = pCha->getGameAttr();
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_634), pAttr->get(ATTR_LV));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		char buff[32];
		_i64toa_s(pAttr->get(ATTR_CEXP), buff, sizeof(buff), 10);
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_635), buff);
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		AddHintHeight(6, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_636), (int)pAttr->get(ATTR_HP), (int)pAttr->get(ATTR_MXHP));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_ShowWork(pCha->GetShipInfo(), g_stUIBoat.GetHuman()->getGameAttr(), index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_637), (int)pAttr->get(ATTR_SP), (int)pAttr->get(ATTR_MXSP));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_638), (int)pAttr->get(ATTR_BMNATK), (int)pAttr->get(ATTR_BMXATK));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_639), pAttr->get(ATTR_BDEF));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_640), pAttr->get(ATTR_BMSPD));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_641), pAttr->get(ATTR_BASPD));
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		CGoodsGrid* pGoods = pBoat->GetGoodsGrid();
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_642), pGoods->GetCurNum(), pGoods->GetMaxNum());
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_643), StringSplitNum((long)pAttr->get(ATTR_BOAT_PRICE) / 2));
		PushHint(buf, COLOR_WHITE, 5, 1, index);
	  }
	}

	_AddDescriptor(index);
	return;
  } else if(_pItem->sType == 29) // 贝壳
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_628), _pItem->sNeedLv, pAttr->get(ATTR_LV) >= _pItem->sNeedLv ? GENERIC_COLOR : VALID_COLOR, index);

	_ShowWork(_pItem, pAttr, index);

	// _snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_644), _ItemData.sEnergy[0], _ItemData.sEnergy[1] );
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	_AddDescriptor(index);
  } else if(_pItem->sType == 45) // 贸易证明
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	//PUSH_HINT( RES_STRING(CL_LANGUAGE_MATCH_634), _ItemData.sEnergy[0], COLOR_WHITE, index );

	/*float fB320 = (float)_ItemData.sEnergy[1];
		float fRate = 0.0f;
		if( _ItemData.sEnergy[1]==0 )
		{
			fRate = 30.0f;
		}
		else
		{
			fRate = max( 0.0f, 30 - pow( fB320, 0.5f ) ) + pow( fB320, -0.5f );

			if( fRate > 30.0f ) fRate = 30.0f;
			if( fRate < 0.0f ) fRate = 0.0f;
		}
		_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_645), fRate );
		PushHint( buf, COLOR_WHITE, 5, 1, index );*/

  } else if(_pItem->sType == 34) // 技能书
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	CSkillRecord* pSkill = GetSkillRecordInfo(_pItem->szName);
	if(pSkill)
	{
	  if(pSkill->chJobSelect[0][0] >= 0)
	  {
		std::ostrstream str;
		str << RES_STRING(CL_LANGUAGE_MATCH_646);

		for(char i = 0; i < defSKILL_JOB_SELECT_NUM; i++)
		{
		  if(pSkill->chJobSelect[i][0] < 0)
			break;

		  if(i > 0 && (i % 2) == 0)
		  {
			str << RES_STRING(CL_LANGUAGE_MATCH_647);
		  }
		  str << g_GetJobName(pSkill->chJobSelect[i][0]);
		  str << " ";
		}
		str << '\0';

		PushHint(str.str(), pSkill->IsJobAllow((int)pAttr->get(ATTR_JOB)) ? GENERIC_COLOR : VALID_COLOR, 5, 1, index);

		// 内存泄漏
		str.freeze(false);
	  }

	  if(pSkill->sLevelDemand != -1)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_648), pSkill->sLevelDemand);
		PushHint(buf, pAttr->get(ATTR_LV) >= pSkill->sLevelDemand ? GENERIC_COLOR : VALID_COLOR, 5, 1, index);
	  }

	  CSkillRecord* p		   = NULL;
	  CSkillRecord* pSelfSkill = NULL;
	  for(int i = 0; i < defSKILL_PRE_SKILL_NUM; i++)
	  {
		if(pSkill->sPremissSkill[i][0] < 0)
		  break;

		p = GetSkillRecordInfo(pSkill->sPremissSkill[i][0]);
		if(p)
		{
		  pSelfSkill = g_stUIEquip.FindSkill(p->nID);
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_649), p->szName, pSkill->sPremissSkill[i][1]);
		  if(pSelfSkill && pSelfSkill->GetSkillGrid().chLv >= pSkill->sPremissSkill[i][1])
			PushHint(buf, COLOR_WHITE, 5, 1, index);
		  else
			PushHint(buf, VALID_COLOR, 5, 1, index);
		}
	  }
	  _AddDescriptor(index); //	Add by Rain.
	} else
	{
	  _AddDescriptor(index);
	}
  } else if(_pItem->sType == 46) // 勇者之证
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	//int show_attr[] = { ITEMATTR_VAL_STR, ITEMATTR_VAL_AGI, ITEMATTR_VAL_DEX, ITEMATTR_VAL_CON, ITEMATTR_VAL_STA };
	//string show_text[] = { RES_STRING(CL_LANGUAGE_MATCH_650), RES_STRING(CL_LANGUAGE_MATCH_651), RES_STRING(CL_LANGUAGE_MATCH_652), RES_STRING(CL_LANGUAGE_MATCH_653), RES_STRING(CL_LANGUAGE_MATCH_654) };
	//int value = 0;
	//const int count = sizeof(show_attr)/sizeof(show_attr[0]);
	//for( int i=0; i<count; i++ )
	//{
	//	value = item.sInstAttr[show_attr[i]];
	//	item.sInstAttr[show_attr[i]] = 0;
	//	_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%d", show_text[i].c_str(), value );
	//	PushHint( buf, GENERIC_COLOR, 5, 1, index );
	//}

	//_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_655), _ItemData.sEndure[1] );
	//PushHint( buf, GENERIC_COLOR, 5, 1, index );

	////_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%d", RES_STRING(CL_LANGUAGE_MATCH_848), _ItemData.sEnergy[1] );	// 乱斗点数
	//PushHint( buf, GENERIC_COLOR, 5, 1, index );

	//_AddDescriptor( index );
  } else if(_pItem->sType == 49)
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_656), std::to_string(item.sEnergy[1]).c_str(), _pItem->szName);
	PushHint(buf, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	PushHint(GetStoneHint(1).c_str(), COLOR_WHITE, 5, 1, index); // 单个宝石都显示1级的属性
	_AddDescriptor(index);
  } else if(_pItem->sType == 50)
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_656), std::to_string(item.sEnergy[1]).c_str(), _pItem->szName);
	PushHint(buf, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	_AddDescriptor(index);
  } else if(_pItem->sType == 59 || _pItem->sType == 67) // 59 = 精灵，67 = 精灵蛋
  {
	int nLevel = 0; /*item.sInstAttr[ITEMATTR_VAL_STR]
					+ item.sInstAttr[ITEMATTR_VAL_AGI] 
					+ item.sInstAttr[ITEMATTR_VAL_DEX] 
					+ item.sInstAttr[ITEMATTR_VAL_CON] 
					+ item.sInstAttr[ITEMATTR_VAL_STA];*/

	_snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s", nLevel, GetName());
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	AddHintHeight(6, index);

	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_657), item.sInstAttr[ITEMATTR_VAL_STR], COLOR_WHITE, index);
	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_658), item.sInstAttr[ITEMATTR_VAL_AGI], COLOR_WHITE, index);
	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_659), item.sInstAttr[ITEMATTR_VAL_CON], COLOR_WHITE, index);
	//		PUSH_HINT( RES_STRING(CL_LANGUAGE_MATCH_660), item.sInstAttr[ITEMATTR_VAL_DEX], COLOR_WHITE, index );
	PUSH_HINT(RES_STRING(CL_LANGUAGE_MATCH_661), item.sInstAttr[ITEMATTR_VAL_STA], COLOR_WHITE, index);

	/*item.sInstAttr[ITEMATTR_VAL_STR] = 0;
		item.sInstAttr[ITEMATTR_VAL_AGI] = 0;
		item.sInstAttr[ITEMATTR_VAL_DEX] = 0;
		item.sInstAttr[ITEMATTR_VAL_CON] = 0;
		item.sInstAttr[ITEMATTR_VAL_STA] = 0;*/

	AddHintHeight(6, index);

	if(!isStore) // 商城内不显示精灵的体力和成长度
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_662), _ItemData.sEndure[0] / 50, _ItemData.sEndure[1] / 50);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  //_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_663), _ItemData.sEnergy[0], _ItemData.sEnergy[1] );
	  //PushHint( buf, COLOR_WHITE, 5, 1, index );
	}

	AddHintHeight(6, index);

	// 加强,特殊加强
	AddHintHeight(6, index);
	for(int i = 0; i < ITEMATTR_CLIENT_MAX; i++)
	{
	  if(item.sInstAttr[i] != 0)
	  {
		_PushItemAttr(i, item, ADVANCED_COLOR, index);
	  }
	}

	int array[3][2] = {0};
	g_pGameApp->GetScriptMgr()->DoString("GetElfSkill", "u-dddddd", _ItemData.lDBParam[0], &array[0][0], &array[0][1], &array[1][0], &array[1][1], &array[2][0], &array[2][1]);

	CElfSkillInfo* pInfo = NULL;
	for(int i = 0; i < 3; i++)
	{
	  pInfo = GetElfSkillInfo(array[i][0], array[i][1]);
	  if(pInfo)
	  {
		PushHint(pInfo->szDataName, COLOR_WHITE, 5, 1, index);
	  }
	}
	_AddDescriptor(index);
	return;
  } else if(_pItem->sType == 65) // 黑龙祭坛  add by Philip.Wu  2006-06-19
  {
	// Add by lark.li 20080320 begin
	if(5724 == _pItem->lID)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00001), item.sEnergy[0] / 60);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  SetHintIsCenter(false);
	  _AddDescriptor(index);

	  return;
	}
	// End

	//	Add by alfred.shi 20081126	begin
	else if(_pItem->lID == 6066)
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_UIITEMCOMMAND_CPP_00002), (item.sInstAttr[ITEMATTR_VAL_STR] * 32768 + item.sInstAttr[ITEMATTR_VAL_CON]));
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_UIITEMCOMMAND_CPP_00003), item.sInstAttr[ITEMATTR_VAL_AGI]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  //			_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%d",RES_STRING(CL_UIITEMCOMMAND_CPP_00004),item.sInstAttr[ITEMATTR_VAL_DEX]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  return;
	}
	//	End
	//	Modify by alfred.shi 20080822
	if(3279 <= _pItem->lID && _pItem->lID <= 3282 || _pItem->lID == 6370 || _pItem->lID == 6371 || _pItem->lID == 6376 ||
	   _pItem->lID == 6377 || _pItem->lID == 6378 || (_pItem->lID >= 5882 && _pItem->lID <= 5893) || _pItem->lID == 5895 ||
	   _pItem->lID == 5897 || (_pItem->lID >= 6383 && _pItem->lID <= 6385) || _pItem->lID == 6378 ||
	   (_pItem->lID >= 6440 && _pItem->lID <= 6443)) // 读书系统特殊处理，暴恶心
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  SetHintIsCenter(false);
	  _AddDescriptor(index);

	  return;
	}

	SetHintIsCenter(true);

	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	AddHintHeight(6, index);

	if(_pItem->lID == 2911 || _pItem->lID == 2912 || _pItem->lID == 2952 ||
	   _pItem->lID == 3066 || _pItem->lID == 3078) // 任务道具特殊处理
	{
	  int nMonth  = 0;
	  int nDay	  = 0;
	  int nHour	  = 0;
	  int nMinute = 0;
	  int nSecond = 0;

	  /*for(int i = 0; i < 5; ++i)
			{
				switch(GetData().sInstAttr[i][0])
				{
				case ITEMATTR_VAL_STA:
					nMonth = GetData().sInstAttr[i][1];
					break;
				case ITEMATTR_VAL_STR:
					nDay = GetData().sInstAttr[i][1];
					break;
				case ITEMATTR_VAL_CON:
					nHour = GetData().sInstAttr[i][1];
					break;
				case ITEMATTR_VAL_DEX:
					nMinute = GetData().sInstAttr[i][1];
					break;
				case ITEMATTR_VAL_AGI:
					nSecond = GetData().sInstAttr[i][1];
					break;
				}
			}*/

	  if(_pItem->lID == 2911 || _pItem->lID == 2952 || _pItem->lID == 3066 || _pItem->lID == 3078)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_916), nMonth);
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_917), nDay);
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_918), nHour);
		PushHint(buf, COLOR_WHITE, 5, 1, index);

		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_919), nMinute);
		PushHint(buf, COLOR_WHITE, 5, 1, index);
	  }

	  if(_pItem->lID != 3066 && _pItem->lID != 3078)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_920), nSecond);
		PushHint(buf, COLOR_WHITE, 5, 1, index);
	  }

	  AddHintHeight(6, index);
	  _AddDescriptor(index);
	  AddHintHeight(6, index);

	  return;
	} else if(_pItem->lID == 2954) // 特殊道具处理（死亡证明）
	{
	  int nCount = 0;
	  for(int i = 0; i < 5; ++i)
	  {
		if(GetData().sInstAttr[i][0] == ITEMATTR_VAL_STR)
		{
		  nCount = GetData().sInstAttr[i][1];
		  break;
		}
	  }

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s: %d", RES_STRING(CL_LANGUAGE_MATCH_933), nCount); // "死亡次数"
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  AddHintHeight(6, index);
	  _AddDescriptor(index);
	  AddHintHeight(6, index);

	  return;
	} else if(_pItem->lID == 579) // 入学证书 当作普通道具显示特殊处理
	{
	  SetHintIsCenter(false);
	  _AddDescriptor(index);

	  return;
	}
	//Add by sunny.sun 20080528
	//Begin
	else if(_pItem->nID == 5803 || _pItem->nID == 6373)
	{
	  if(_pItem->nID == 5803)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_LANGUAGE_MATCH_651), item.sInstAttr[ITEMATTR_VAL_STR]);
	  }
	  if(_pItem->nID == 6373)
	  {
		int nCount = 0;
		for(int i = 0; i < 5; ++i)
		{
		  if(GetData().sInstAttr[i][0] == ITEMATTR_VAL_STR)
		  {
			nCount = GetData().sInstAttr[i][1];
			break;
		  }
		}

		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00010), nCount);
	  }

	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  _AddDescriptor(index);

	  return;
	}
	//End

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_664), 5 - item.sInstAttr[ITEMATTR_VAL_AGI]);
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_665), 5 - item.sInstAttr[ITEMATTR_VAL_STR]);
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	//		_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_666), 5 - item.sInstAttr[ITEMATTR_VAL_DEX] );
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_667), 5 - item.sInstAttr[ITEMATTR_VAL_CON]);
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	AddHintHeight(6, index);

	switch(item.sInstAttr[ITEMATTR_VAL_STA])
	{
	case 1: // item.sID = 866
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_668), COLOR_RED, 5, 1, index);
	  break;

	case 2: // item.sID = 865
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_669), COLOR_RED, 5, 1, index);
	  break;

	case 3: // item.sID = 864
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_670), COLOR_RED, 5, 1, index);
	  break;

	default:
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_671), COLOR_RED, 5, 1, index);
	  break;
	}

	AddHintHeight(6, index);

	//_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_672), _ItemData.sEnergy[0]);
	//PushHint( buf, COLOR_WHITE, 5, 1, index );

	return;
  } else if(_pItem->sType == 69) // XXX图纸
  {
	int			 iItem	   = 0;
	long		 lForge	   = 0;
	CItemRecord* pCItemRec = NULL;

	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_869), _ItemData.sEndure[0]);
	PushHint(buf, GENERIC_COLOR, 5, 1, index);

	iItem = item.sInstAttr[ITEMATTR_VAL_AGI];
	if(iItem)
	{
	  pCItemRec = GetItemRecordInfo(iItem);
	  if(pCItemRec)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_870), pCItemRec->szName);
		PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  }
	}

	//_snprintf_s( buf, _countof( buf ), _TRUNCATE,  RES_STRING(CL_LANGUAGE_MATCH_871), _ItemData.sEnergy[1] - 100);
	//PushHint(buf, GENERIC_COLOR, 5, 1, index );

	AddHintHeight(6, index);

	lForge = _ItemData.GetForgeParam();

	iItem = item.sInstAttr[ITEMATTR_VAL_STR];
	if(iItem)
	{
	  pCItemRec = GetItemRecordInfo(iItem);
	  if(pCItemRec)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_872), pCItemRec->szName, (lForge / 10000000));
		PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  }
	}

	lForge %= 10000000;
	iItem = item.sInstAttr[ITEMATTR_VAL_CON];
	if(iItem)
	{
	  pCItemRec = GetItemRecordInfo(iItem);
	  if(pCItemRec)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_873), pCItemRec->szName, (lForge / 10000));
		PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  }
	}

	lForge %= 1000;
	//iItem = item.sInstAttr[ITEMATTR_VAL_DEX];
	if(iItem)
	{
	  pCItemRec = GetItemRecordInfo(iItem);
	  if(pCItemRec)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_874), pCItemRec->szName, (lForge / 10));
		PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  }
	}

	AddHintHeight(6, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_875), item.sInstAttr[ITEMATTR_VAL_STA]);
	PushHint(buf, GENERIC_COLOR, 5, 1, index);

	//_snprintf_s( buf, _countof( buf ), _TRUNCATE,  RES_STRING(CL_LANGUAGE_MATCH_876), _ItemData.sEnergy[0] * 10);
	//PushHint(buf, GENERIC_COLOR, 5, 1, index );

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_877), _ItemData.sEndure[1]);
	PushHint(buf, GENERIC_COLOR, 5, 1, index);

	AddHintHeight(6, index);

	if(_nPrice != 0)
	{
	  AddHintHeight(6, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_674), StringSplitNum(isMain ? _nPrice / 2 : _nPrice));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", std::to_string(isMain ? _nPrice / 2 : _nPrice).c_str());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	return;
  } else if(_pItem->sType == 70)
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	if(_pItem->lID == 2902 || _pItem->lID == 2903) // 公主情缘符, 王子情缘符
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_909), item.sInstAttr[ITEMATTR_VAL_STR]); // "情缘编码：%d"
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  AddHintHeight(6, index);
	  _AddDescriptor(index);
	  AddHintHeight(6, index);

	  return;
	}

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_869), item.sInstAttr[ITEMATTR_VAL_STR]);
	PushHint(buf, GENERIC_COLOR, 5, 1, index);

	if(_pItem->lID != 2236)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_878), _ItemData.sEndure[0] / 50);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  //_snprintf_s( buf, _countof( buf ), _TRUNCATE,  RES_STRING(CL_LANGUAGE_MATCH_897), _ItemData.sEnergy[0]); // "工具经验：%i"
	  //PushHint(buf, GENERIC_COLOR, 5, 1, index );
	}

	AddHintHeight(6, index);

	_AddDescriptor(index);

	AddHintHeight(6, index);

	if(_nPrice != 0)
	{
	  AddHintHeight(6, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_674), StringSplitNum(isMain ? _nPrice / 2 : _nPrice));
	  PushHint(buf, COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", std::to_string(isMain ? _nPrice / 2 : _nPrice).c_str());
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	return;
  } else if(_pItem->sType == 71 && _pItem->lID == 3010)
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	//_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_644), _ItemData.sEnergy[0], _ItemData.sEnergy[1] );
	//PushHint( buf, COLOR_WHITE, 5, 1, index );

	SetHintIsCenter(true);
	_AddDescriptor(index);
  } else if(_pItem->sType == 71 && _pItem->lID == 3289) //学生证处理
  {
	//add by ALLEN 2007-10-16

	// 学生证特殊处理（极度恶心！！）
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index); // 名字
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	int			nLevel		  = item.chForgeLv;
	const char* arShowName[5] = {RES_STRING(CL_LANGUAGE_MATCH_944), RES_STRING(CL_LANGUAGE_MATCH_945), RES_STRING(CL_LANGUAGE_MATCH_946), RES_STRING(CL_LANGUAGE_MATCH_947), RES_STRING(CL_LANGUAGE_MATCH_948)}; // "幼儿园", "小学", "初中", "高中", "大学" };
	if(0 <= nLevel && nLevel <= 4)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_949), arShowName[nLevel]); // "学历:%s"
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_950), item.sEndure[0], item.sEndure[1]); // "学分(%d/%d)"
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_951), item.sEnergy[0] * 1000, item.sEnergy[1] * 1000); // "经验(%d/%d)"
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	return;
  }
  //	Add by alfred.shi 20080922 begin. 诅咒娃娃处理。
  else if(_pItem->sType == 71 && _pItem->lID == 6377)
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	SetHintIsCenter(false);
	_AddDescriptor(index);

	return;

  }
  //	End.
  else if(_pItem->sType == 41)
  {
	if(_pItem->lID == 58) // 疯女人要求特殊处理，蟹苗
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEnergy[0], item.sEnergy[1]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  SetHintIsCenter(true);
	  _AddDescriptor(index);

	  return;
	} else if(_pItem->lID == 171) // bragi要求特殊处理
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  static const char* pszText[5] = {RES_STRING(CL_LANGUAGE_MATCH_952),
									   RES_STRING(CL_LANGUAGE_MATCH_953),
									   RES_STRING(CL_LANGUAGE_MATCH_954),
									   RES_STRING(CL_LANGUAGE_MATCH_955),
									   RES_STRING(CL_LANGUAGE_MATCH_956)};

	  int nIndex = item.sEndure[0];

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_957), 0 <= nIndex && nIndex <= 4 ? pszText[nIndex] : "Not Valid");
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  SetHintIsCenter(true);
	  _AddDescriptor(index);

	  return;
	} else if(_pItem->lID == 2967) // 马嫂要求特殊处理，红酒
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEnergy[0], item.sEnergy[1]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  SetHintIsCenter(true);
	  _AddDescriptor(index);

	  return;
	} else if(_pItem->lID == 6066)
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_UIITEMCOMMAND_CPP_00002), item.sInstAttr[ITEMATTR_VAL_STR]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_UIITEMCOMMAND_CPP_00003), item.sInstAttr[ITEMATTR_VAL_AGI]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  //			_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%d",RES_STRING(CL_UIITEMCOMMAND_CPP_00004),item.sInstAttr[ITEMATTR_VAL_DEX]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	  return;
	}
	// add by ning.yan  2008-11-21 begin
	else if(_pItem->lID == 6535 || _pItem->lID == 6536) // 李恒要求此两个道具显示耐久
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_626), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  SetHintIsCenter(true);
	  _AddDescriptor(index);
	}
	// end
	else if(_pItem->lID == 6593)
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);
	  _snprintf_s(buf, _countof(buf), RES_STRING(CL_UIITEMCOMMAND_CPP_00014), item.sInstAttr[ITEMATTR_VAL_STR]);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);
	} else if(_pItem->lID == 6959)
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  int value = 0;
	  value		= item.sInstAttr[ITEMATTR_VAL_STR];
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s:%d", RES_STRING(CL_LANGUAGE_MATCH_1028), value);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  _AddDescriptor(index);
	} else // 一般道具
	{
	  PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	  if(index != -1)
		PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	  SetHintIsCenter(false);
	  _AddDescriptor(index);
	}
  } else if(_pItem->sType == 75) // 彩票
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	SetHintIsCenter(false);

	if(floor((float)item.sInstAttr[ITEMATTR_VAL_STR] / 1000) > 0)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00006), item.sInstAttr[ITEMATTR_VAL_STR] % 1000);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00007), (short)floor((float)item.sInstAttr[ITEMATTR_VAL_AGI] / 100), item.sInstAttr[ITEMATTR_VAL_AGI] % 100);
	  PushHint(buf, GENERIC_COLOR, 5, 1, index);

	  //short c1 = (short)floor( (float)item.sInstAttr[ITEMATTR_VAL_DEX] / 100);
	  //short c2 = item.sInstAttr[ITEMATTR_VAL_DEX] % 100;

	  //short c3 = (short)floor( (float)item.sInstAttr[ITEMATTR_VAL_CON] / 100);
	  //short c4 = item.sInstAttr[ITEMATTR_VAL_CON] % 100;

	  //short c5 = (short)floor( (float)item.sInstAttr[ITEMATTR_VAL_STA] / 100);
	  //short c6 = item.sInstAttr[ITEMATTR_VAL_STA] % 100;

	  ////_snprintf_s( buf, _countof( buf ), _TRUNCATE, "彩球号：%c %c %c %c %c %c", c1, c2, c3, c4, c5, c6);
	  //_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_UIITEMCOMMAND_CPP_00008), c1, c2, c3, c4, c5, c6);
	  //PushHint( buf, GENERIC_COLOR, 5, 1, index );
	} else
	  PushHint(RES_STRING(CL_UIITEMCOMMAND_CPP_00009), GENERIC_COLOR, 5, 1, index);

	_AddDescriptor(index);

	return;
  } else // 一般道具
  {
	PushHint(_pItem->szName, COLOR_WHITE, 5, 1, index);
	if(index != -1)
	  PushHint(RES_STRING(CL_LANGUAGE_MATCH_1041), COLOR_WHITE, 5, 1, index);

	if(_pItem->sType == 77)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_980), item.sEndure[0], item.sEndure[1]);
	  PushHint(buf, COLOR_WHITE, 5, 1, index);
	}

	SetHintIsCenter(false);
	_AddDescriptor(index);
  }
  if(_pItem->sType == 80)
  {
	/*int isZero = _ItemData.GetFusionItemID();
		int color = _ItemData.sEnergy[1];
		DWORD showcolor;
		if ( color>=0&&color<1000)
		{
			showcolor = COLOR_GRAY;
		} 
		else if (color>=1000&&color<3000)
		{
			showcolor = COLOR_WHITE;
		} 
		else if(color>=3000&&color<5000)
		{
			showcolor = COLOR_GREEN;
		}
		else if(color>=5000&&color<7000)
		{
			showcolor = COLOR_ZISE;
		}
		else if(color>=7000)
		{
			showcolor = COLOR_RED;
		}

		CItemRecord* sNameInfo = GetItemRecordInfo(isZero);
		if ( isZero != 0)
		{
			_snprintf_s( buf, _countof(buf), _TRUNCATE,"装备：%s",sNameInfo->szName);
			PushHint( buf, showcolor, 5, 1, index );
		}
		SetHintIsCenter(true);*/
  }

  if(_pItem->sType != 75 && _pItem->lID != 6959) //
  {
	// 加强,特殊加强
	AddHintHeight(6, index);
	for(int i = 0; i < ITEMATTR_CLIENT_MAX; i++)
	{
	  if(item.sInstAttr[i] != 0)
	  {
		_PushItemAttr(i, item, ADVANCED_COLOR, index);
	  }
	}
  }

  if(_hints.GetCount() > 0 && _pItem->sType <= 27 && _pItem->sType != 18 && _pItem->sType != 19 && _pItem->sType != 21)
  {
	// 能量最大值的百位代表颜色,十位及以下代表名字前缀
	char szBuf[16] = {0};
	//_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE, "%09d", _ItemData.sEnergy[1]/10 );		// 除十是因为服务器的数值为4位数,等待以后改为三位
	char szHundred[2] = {szBuf[6], 0};
	int	 nHundred	  = atoi(szHundred);
	int	 nTen		  = atoi(&szBuf[7]);

	DWORD dwNameColor = COLOR_BLACK;
	switch(nHundred)
	{
	case 0: dwNameColor = 0xffC1C1C1; break;
	case 1: dwNameColor = 0xffFFFFFF; break;
	case 2: dwNameColor = 0xffFFFFFF; break;
	case 3: dwNameColor = 0xffA2E13E; break;
	case 4: dwNameColor = 0xffA2E13E; break;
	case 5: dwNameColor = 0xffd68aff; break;
	case 6: dwNameColor = 0xffd68aff; break;
	case 7: dwNameColor = 0xffff6440; break;
	case 8: dwNameColor = 0xffff6440; break;
	case 9: dwNameColor = 0xffffcc12; break;
	}

	CItemPreInfo* pInfo = GetItemPreInfo(nTen);
	if(pInfo && strcmp(pInfo->szDataName, "0") != 0)
	{
	  if(CItemRecord::IsVaildFusionID(_pItem)) // modify by ning.yan  20080821
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "Lv%d %s%s", _ItemData.GetItemLevel(), pInfo->szDataName, GetName());

		//	2008-7-31	yangyinyu	add	begin!
		//	增加对道具锁定的处理。
		if(index == -1)
		{
		  if(_ItemData.dwDBID)
			_hints.GetHint(1)->hint = buf;
		  else
			_hints.GetHint(0)->hint = buf;
		} else
		{
		  if(_ItemData.dwDBID)
			_hints.GetHintRelated(index, 2)->hint = buf;
		  else
			_hints.GetHintRelated(index, 0)->hint = buf;
		}
	  } else
	  {
		if(index == -1)
		{
		  if(_ItemData.dwDBID)
			_hints.GetHint(1)->hint = pInfo->szDataName + _hints.GetHint(1)->hint;
		  else
			_hints.GetHint(0)->hint = pInfo->szDataName + _hints.GetHint(0)->hint;
		} else
		{
		  if(_ItemData.dwDBID)
			_hints.GetHintRelated(index, 2)->hint = pInfo->szDataName + _hints.GetHintRelated(index, 2)->hint;
		  else
			_hints.GetHintRelated(index, 0)->hint = pInfo->szDataName + _hints.GetHintRelated(index, 0)->hint;
		}
	  }
	}

	//	2008-7-31	yangyinyu	add	begin!
	//	增加对道具锁定的处理
	if(index == -1)
	{
	  if(_ItemData.dwDBID)
		_hints.GetHint(1)->color = dwNameColor;
	  else
		_hints.GetHint(0)->color = dwNameColor;
	} else
	{
	  if(_ItemData.dwDBID)
		_hints.GetHintRelated(index, 2)->color = dwNameColor;
	  else
	  {
		_hints.GetHintRelated(index, 0)->color = dwNameColor;
		_hints.GetHintRelated(index, 1)->color = dwNameColor;
	  }
	}
  }

  // 处理精炼
  SItemForge& Forge = GetForgeInfo();
  if(_hints.GetCount() > 0 && Forge.IsForge)
  {
	if(Forge.nHoleNum > 0)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_673), Forge.nHoleNum);
	  PushHint(buf, ADVANCED_COLOR, 5, 1, index);
	}

	for(int i = 0; i < Forge.nStoneNum && i < Forge.nHoleNum; i++)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_656), std::to_string(Forge.nStoneLevel[i]).c_str(), Forge.pStoneInfo[i]->szDataName);
	  PushHint(buf, ADVANCED_COLOR, 5, 1, index);
	}

	if(Forge.nStoneNum > 0)
	{
	  AddHintHeight(6, index);
	  for(int i = 0; i < Forge.nStoneNum && i < Forge.nHoleNum; i++)
	  {
		PushHint(Forge.szStoneHint[i], ADVANCED_COLOR, 5, 1, index);
	  }
	}

	if(Forge.nLevel > 0)
	{
	  if(index == -1)
	  {
		if(_ItemData.dwDBID)
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s +%d", _hints.GetHint(1)->hint.c_str(), Forge.nLevel);
		  _hints.GetHint(1)->hint = buf;
		} else
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s +%d", _hints.GetHint(0)->hint.c_str(), Forge.nLevel);
		  _hints.GetHint(0)->hint = buf;
		}
	  } else
	  {
		if(_ItemData.dwDBID)
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s +%d", _hints.GetHintRelated(index, 2)->hint.c_str(), Forge.nLevel);
		  _hints.GetHintRelated(index, 2)->hint = buf;
		} else
		{
		  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s +%d", _hints.GetHintRelated(index, 0)->hint.c_str(), Forge.nLevel);
		  _hints.GetHintRelated(index, 0)->hint = buf;
		}
	  }
	}
  }

  if(_nPrice != 0)
  {
	AddHintHeight(6, index);
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_674), StringSplitNum(isMain ? _nPrice / 2 : _nPrice));
	PushHint(buf, COLOR_WHITE, 5, 1, index);

	_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", std::to_string(isMain ? _nPrice / 2 : _nPrice).c_str());
	PushHint(buf, COLOR_WHITE, 5, 1, index);
  }

  //	yangyinyu	add!
  if(_ItemData.dwDBID && index == -1)
	_hints.GetHint(0)->color = 0xff888888;
  else if(_ItemData.dwDBID)
	_hints.GetHintRelated(index, 0)->color = 0xff888888;

  if(index == -1 && g_stUISystem.m_sysProp.m_gameOption.bCmpEquip)
	AddRelatedHint(x, y);
}

void CItemCommand::AddRelatedHint(int x, int y)
{
  if(_pItem->sType > 28 || _pItem->sType < 1)
	return;

  SGameAttr* pAttr = NULL;
  if(g_stUIBoat.GetHuman())
	pAttr = g_stUIBoat.GetHuman()->getGameAttr();
  if(!pAttr)
	return;

  bool track_related = false;

  string ParentName = GetParent()->GetForm()->GetName();

  if(ParentName == "frmItem")
  {
	for(int i = 0; i < g_stUIEquip.GetGoodsGrid()->GetMaxNum(); ++i)
	{
	  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(i));
	  if(pItemCommand == this)
		track_related = true;
	}
  } else if(ParentName == "frmNPCtrade")
  {
	for(int i = 0; i < g_stUINpcTrade.GetNPCtradeWeaponGrid()->GetMaxNum(); ++i)
	{
	  CItemCommand* pItemCommand =
		  dynamic_cast<CItemCommand*>(g_stUINpcTrade.GetNPCtradeWeaponGrid()->GetItem(i));
	  if(pItemCommand == this)
		track_related = true;
	}

	if(!track_related)
	{
	  for(int i = 0; i < g_stUINpcTrade.GetNPCtradeEquipGrid()->GetMaxNum(); ++i)
	  {
		CItemCommand* pItemCommand =
			dynamic_cast<CItemCommand*>(g_stUINpcTrade.GetNPCtradeEquipGrid()->GetItem(i));
		if(pItemCommand == this)
		  track_related = true;
	  }
	}

	if(!track_related)
	{
	  for(int i = 0; i < g_stUINpcTrade.GetNPCtradeOtherGrid()->GetMaxNum(); ++i)
	  {
		CItemCommand* pItemCommand =
			dynamic_cast<CItemCommand*>(g_stUINpcTrade.GetNPCtradeOtherGrid()->GetItem(i));
		if(pItemCommand == this)
		  track_related = true;
	  }
	}
  } else if(ParentName == "frmBooth")
  {
	for(int i = 0; i < g_stUIBooth.GetBoothItemsGrid()->GetMaxNum(); ++i)
	{
	  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(g_stUIBooth.GetBoothItemsGrid()->GetItem(i));
	  if(pItemCommand == this)
		track_related = true;
	}
  } else if(ParentName == "frmNPCstorage")
  {
	for(int i = 0; i < g_stUIBank.GetBankGoodsGrid()->GetMaxNum(); ++i)
	{
	  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(g_stUIBank.GetBankGoodsGrid()->GetItem(i));
	  if(pItemCommand == this)
		track_related = true;
	}
  } else if(ParentName == "frmPlayertrade")
  {
	for(int i = 0; i < g_stUITrade.GetPlayertradeSaleGrid()->GetMaxNum(); ++i)
	{
	  CItemCommand* pItemCommand =
		  dynamic_cast<CItemCommand*>(g_stUITrade.GetPlayertradeSaleGrid()->GetItem(i));
	  if(pItemCommand == this)
		track_related = true;
	}

	if(!track_related)
	{
	  for(int i = 0; i < g_stUITrade.GetPlayertradeBuyGrid()->GetMaxNum(); ++i)
	  {
		CItemCommand* pItemCommand =
			dynamic_cast<CItemCommand*>(g_stUITrade.GetPlayertradeBuyGrid()->GetItem(i));
		if(pItemCommand == this)
		  track_related = true;
	  }
	}

	if(!track_related)
	{
	  for(int i = 0; i < g_stUITrade.GetRequestGrid()->GetMaxNum(); ++i)
	  {
		CItemCommand* pItemCommand =
			dynamic_cast<CItemCommand*>(g_stUITrade.GetRequestGrid()->GetItem(i));
		if(pItemCommand == this)
		  track_related = true;
	  }
	}
  }

  if(track_related)
  {
	int index = 0;
	for(int i = 0; i < enumEQUIP_NUM; ++i)
	{
	  char Link = _pItem->szAbleLink[i];
	  if(Link < 0 || !g_stUIEquip.cnmEquip[Link])
		continue;

	  CItemCommand* pItem = dynamic_cast<CItemCommand*>(g_stUIEquip.cnmEquip[Link]->GetCommand());
	  if(pItem)
	  {
		pItem->AddHint(x, y, index);
		/*CItemRecord* pItemRecord = pItem->GetItemInfo();

				SItemHint item;
				memset( &item, 0, sizeof( SItemHint ) );
				CItemRecord* pRecord = NULL;
				if ( CItemRecord::IsVaildFusionID( pItemRecord ) && pItem->_ItemData.GetFusionItemID() > 0 )
				{
					pRecord = GetItemRecordInfo( pItem->_ItemData.GetFusionItemID() );
					if( pRecord )
						item.Convert( pItem->_ItemData, pRecord );
				}
				else
					item.Convert( pItem->_ItemData, pItemRecord );

				if( CItemRecord::IsVaildFusionID( pItemRecord ) && pItem->_ItemData.GetFusionItemID() > 0 )
					_snprintf_s( buf, _countof( buf ), _TRUNCATE, "Lv%d %s", pItem->_ItemData.GetItemLevel(), pItem->GetName() );
				else
					_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s", pItem->GetName() );

				char szBuf[16] = { 0 };
				_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE, "%09d", pItem->_ItemData.sEnergy[1]/10 );		// 除十是因为服务器的数值为4位数,等待以后改为三位
				char szHundred[2] = { szBuf[6], 0 };
				int nHundred = atoi( szHundred );
				DWORD dwNameColor = COLOR_BLACK;
				switch( nHundred )
				{
				case 0:   dwNameColor=0xffC1C1C1; break;
				case 1:   dwNameColor=0xffFFFFFF; break;
				case 2:   dwNameColor=0xffFFFFFF; break;
				case 3:   dwNameColor=0xffA2E13E; break;
				case 4:   dwNameColor=0xffA2E13E; break;
				case 5:   dwNameColor=0xffd68aff; break;
				case 6:   dwNameColor=0xffd68aff; break;
				case 7:   dwNameColor=0xffff6440; break; 
				case 8:   dwNameColor=0xffff6440; break;
				case 9:   dwNameColor=0xffffcc12; break;
				}

				PushHint( buf, dwNameColor, 5, 1, index );
				PushHint( RES_STRING( CL_LANGUAGE_MATCH_1041 ), dwNameColor, 5, 1, index );
				if( pItemRecord->sType == 2 )
					PushHint( RES_STRING( CL_LANGUAGE_MATCH_624 ), COLOR_WHITE, 5, 1, index );

				if( pItemRecord->sType == 26 )
				{
					if( pItemRecord->lID == 1034 )
					{
						_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_862 ),
							pItem->_ItemData.sEndure[0] * 10 - 1000, pItem->_ItemData.sEndure[1] * 10 - 1000 );
						PushHint( buf, COLOR_WHITE, 5, 1, index );

						break;
					}
				}

				AddHintHeight( 6, index );
				
				if( pItemRecord->sType >= 1 && pItemRecord->sType <= 10 )  
				{
					if( pItemRecord->lID != 3669 )
					{
						_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_625 ),
							_GetValue( ITEMATTR_VAL_MNATK, item ), _GetValue( ITEMATTR_VAL_MXATK, item ) );
						PushHint( buf, COLOR_WHITE, 5, 1, index );
					}
				}

				_PushValue( RES_STRING( CL_LANGUAGE_MATCH_629 ), ITEMATTR_VAL_DEF, item, COLOR_WHITE, index );

				if( item.sEndure[1] > 0 )
				{
					_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_626 ), item.sEndure[0], item.sEndure[1] );
					PushHint( buf, COLOR_WHITE, 5, 1, index );
				}

				_PushValue( RES_STRING( CL_LANGUAGE_MATCH_630 ), ITEMATTR_VAL_PDEF, item, COLOR_WHITE, index );
				_PushValue( RES_STRING( CL_LANGUAGE_MATCH_631 ), ITEMATTR_VAL_HIT, item, COLOR_WHITE, index );

				if( ( pItemRecord->sType >= 1 && pItemRecord->sType <= 11 ) || pItemRecord->sType == 18 || 
					pItemRecord->sType == 19 || pItemRecord->sType == 20 || pItemRecord->sType == 22 ||
					pItemRecord->sType == 23 || pItemRecord->sType == 24 || pItemRecord->sType == 27  )
				{
					if ( CItemRecord::IsVaildFusionID( pItemRecord ) && pItem->_ItemData.GetFusionItemID() > 0 )
					{
						_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_627 ), 
							pItem->_ItemData.GetItemLevel() * 2 + 80 );
						PushHint( buf, COLOR_WHITE, 5, 1, index );
					}
				}

				AddHintHeight( 6, index );

				if( CItemRecord::IsVaildFusionID( pItemRecord ) && pItem->_ItemData.GetFusionItemID() > 0 )
				{
					short nFusionItemLevel = pItemRecord->sNeedLv > pRecord->sNeedLv ? pItemRecord->sNeedLv : pRecord->sNeedLv;
					PUSH_HINT( RES_STRING( CL_LANGUAGE_MATCH_628 ), nFusionItemLevel, COLOR_WHITE, index );
				}
				else
					PUSH_HINT( RES_STRING( CL_LANGUAGE_MATCH_628 ), pItemRecord->sNeedLv, COLOR_WHITE, index );

				if( ( pItemRecord->sType >= 1 && pItemRecord->sType <= 11 ) || 
					( pItemRecord->sType >= 22 && pItemRecord->sType <= 25 ) ||
					( pItemRecord->sType >= 26 && pItemRecord->lID != 1034 ) ||
					pItemRecord->sType == 20 || pItemRecord->sType == 27 )
				{
					AddHintHeight( 6, index );

					if ( CItemRecord::IsVaildFusionID( pItemRecord ) && pItem->_ItemData.GetFusionItemID() > 0 )
					{
						pItem->_ShowFusionBody( pRecord, index );
						pItem->_ShowFusionWork( pItemRecord, pRecord, pAttr, index );
					}
					else
					{
						pItem->_ShowBody( index );
						pItem->_ShowWork( pItemRecord, pAttr, index );
					}
				}
				
				if( pItemRecord->lID != 6959 )
				{
					AddHintHeight( 6, index );

					_PushValue( RES_STRING( CL_LANGUAGE_MATCH_632 ), ITEMATTR_VAL_FLEE, item, ADVANCED_COLOR, index );
					
					for( int i = 0; i < ITEMATTR_CLIENT_MAX; ++ i )
					{
						if( item.sInstAttr[i] != 0 )
							pItem->_PushItemAttr( i, item, ADVANCED_COLOR, index );
					}
				}
				
				SItemForge& Forge = pItem->GetForgeInfo();
				if( pItem->_hints.GetCount() > 0 && Forge.IsForge )
				{
					AddHintHeight( 6, index );
					
					if( Forge.nHoleNum > 0 )
					{
						_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_673 ), Forge.nHoleNum );
						PushHint( buf, ADVANCED_COLOR, 5, 0,index );
					}
					
					for( int i= 0; i < Forge.nStoneNum && i < Forge.nHoleNum; i++ )
					{
						_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_656 ), 
							ConvertNumToChinese( Forge.nStoneLevel[i] ).c_str(), Forge.pStoneInfo[i]->szDataName );
						PushHint( buf, ADVANCED_COLOR, 5, 0,index );
					}

					if( Forge.nStoneNum>0 )
					{
						for( int i=0; i<Forge.nStoneNum && i<Forge.nHoleNum; i++ )
							PushHint( Forge.szStoneHint[i], ADVANCED_COLOR, 5, 0, index );
					}
				}


				if( pItem->_nPrice != 0 )
				{
					AddHintHeight( 6, index );	

					_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_674 ), StringSplitNum( pItem->_nPrice / 2 ) );
					PushHint( buf, COLOR_WHITE, 5, 0, index );

					_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s", ConvertNumToChinese( pItem->_nPrice / 2 ).c_str() );
					PushHint( buf, COLOR_WHITE, 5, 0, index );
				}

				if( pItemRecord->sType == 18 || pItemRecord->sType == 19 ||
					( pItemRecord->sType == 25 && 
					( pItemRecord->lID == 6386 || pItemRecord->lID == 6387 || pItemRecord->lID == 6388 ||
					pItemRecord->lID == 6389 || pItemRecord->lID == 6390 || pItemRecord->lID == 6391 ||
					pItemRecord->lID == 6434 || pItemRecord->lID == 6428 || pItemRecord->lID == 6429 ||
					pItemRecord->lID == 6430 || pItemRecord->lID == 6431 || pItemRecord->lID == 6432 ) ) )
				{
					AddHintHeight( 6, index );
					pItem->_AddDescriptor( index );
				}*/

		++index;
	  }
	}
  }
}

string CItemCommand::GetStoneHint(int nLevel)
{
  string hint = "error";
  if(_pItem->sType == 49)
  {
	CStoneInfo* pInfo  = NULL;
	int			nCount = CStoneSet::I()->GetLastID() + 1;
	for(int i = 0; i < nCount; i++)
	{
	  pInfo = ::GetStoneInfo(i);
	  if(!pInfo) continue;

	  if(pInfo->nItemID != _pItem->nID) continue;

	  if( nLevel<0 )
				g_pGameApp->GetScriptMgr()->DoString( pInfo->szHintFunc, "u-s", _ItemData.sEnergy[1], &hint );
			else
				g_pGameApp->GetScriptMgr()->DoString( pInfo->szHintFunc, "u-s", 1, &hint );
	  return hint;
	}
  }
  return hint;
}

//void CItemCommand::_PushItemAttr( int attr, SItemGrid& item, DWORD color )
//{
//    for( int i=0; i<defITEM_INSTANCE_ATTR_NUM; i++ )
//    {
//        if( item.sInstAttr[i][0]==attr )
//        {
//			if ( item.sInstAttr[i][1]==0 )
//			{
//				return;
//			}
//			else
//			{
//				if( attr <= ITEMATTR_COE_PDEF )
//				{
//					if( !(item.sInstAttr[i][1] % 10) )
//					{
//						_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+d%%", g_GetItemAttrExplain( item.sInstAttr[i][0]), item.sInstAttr[i][1] / 10 );
//					}
//					else
//					{
//						float f = (float)item.sInstAttr[i][1] / 10.0f;
//						_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+.1f%%", g_GetItemAttrExplain( item.sInstAttr[i][0]), f );
//					}
//				}
//				else
//				{
//					_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+d", g_GetItemAttrExplain( item.sInstAttr[i][0]), item.sInstAttr[i][1] );
//				}
//				PushHint( buf, color );
//
//				item.sInstAttr[i][0] = 0;
//				return;
//			}
//        }
//    }
//}

void CItemCommand::_PushValue(const char* szFormat, int attr, SItemHint& item, DWORD color, int index)
{
  if(attr <= 0 || attr >= ITEMATTR_CLIENT_MAX)
	return;

  if(item.sInstAttr[attr] == 0)
	return;

  PUSH_HINT(szFormat, item.sInstAttr[attr], color, index);
  item.sInstAttr[attr] = 0;
}

void CItemCommand::_PushItemAttr(int attr, SItemHint& item, DWORD color, int index)
{
  if(attr <= 0 || attr >= ITEMATTR_CLIENT_MAX)
	return;

  if(item.sInstAttr[attr] == 0)
	return;

  /*if( attr <= ITEMATTR_COE_PDEF )
	{
		if( !(item.sInstAttr[attr] % 10) )
		{						
			_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+d%%", g_GetItemAttrExplain( attr ), item.sInstAttr[attr] / 10 );
		}
		else
		{
			float f = (float)item.sInstAttr[attr] / 10.0f;
			_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+.1f%%", g_GetItemAttrExplain( attr ), f );
		}
	}
	else
	{
		_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s:%+d", g_GetItemAttrExplain( attr ), item.sInstAttr[attr] );
	}
	PushHint( buf, color, 5, 0, index );*/

  item.sInstAttr[attr] = 0;
}

bool CItemCommand::IsDragFast()
{
  return (_pItem->sType >= 31 && _pItem->sType <= 33) || _pItem->sType == 71;
}

void CItemCommand::SetTotalNum(int num)
{
  if(_pItem->GetIsPile())
  {
	if(num >= 0)
	{
	  _ItemData.sNum = num;
	}
  } else
  {
	_ItemData.sNum = 1;
  }
}

bool CItemCommand::IsAllowThrow()
{
  return _pItem->chIsThrow != 0;
}

//	2008-9-17	yangyinyu	add	begin!
bool _wait_select_lock_item_state_ = false; //	用户已经使用锁道具，正在等待选择被锁定的道具。

// modify by ning.yan 2008-11-11 改为全局变量，使UIDoublePwd.cpp文件中定义的函数可以使用 begin
//static	char	_lock_pos_;
//static	long	_lock_item_id_;
//static	long	_lock_grid_id_;
//static	long	_lock_fusion_item_id_;
//extern	bool	g_yyy_add_lock_item_wait_return_state;		//	已经发送锁定消息，等待服务器返回锁定结果状态。
char _lock_pos_			   = NULL;
long _lock_item_id_		   = 0;
long _lock_grid_id_		   = 0;
long _lock_fusion_item_id_ = 0;
// end

static void _evtSelectYesNoEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  //	关闭选择框。
  pSender->GetForm()->Close();

  //	取组件名字。
  string name = pSender->GetName();

  if(!strcmp(name.c_str(), "btnYes"))
  {
	//	发送加锁信息。
	//CS_DropLock(	_lock_pos_,	_lock_item_id_,	_lock_grid_id_,	_lock_fusion_item_id_	);
	CS_DropLock(_lock_pos_, _lock_item_id_, (dbc::Char)_lock_grid_id_, _lock_fusion_item_id_);
	//	设置等待光标。
	CCursor::I()->SetCursor(CCursor::stWait);
	//	设置等待服务器返回锁定结果状态。
	g_yyy_add_lock_item_wait_return_state = true;
  }

  //pBox->frmDialog->SetParent(	NULL );
};

#include "uiboxform.h"
extern CBoxMgr g_stUIBox;
//	2008-9-17	yangyinyu	add	end!

bool CItemCommand::MouseDown()
{
  CCharacter* pCha = CGameScene::GetMainCha();
  if(!pCha) return false;

  //	2008-9-17	yangyinyu	add	begin!

  //	如果是等待锁定消息返回状态，则直接跳过。
  if(g_yyy_add_lock_item_wait_return_state && _ItemData.sID != 5939)
  {
	return false;
  }
  //	如果是等待被锁定状态。
  else if(_wait_select_lock_item_state_ && _ItemData.sID != 5939)
  {
	//	发送加锁消息。
	CGoodsGrid* pOwn = dynamic_cast<CGoodsGrid*>(GetParent());

	if(pOwn)
	{
	  if(pOwn == g_stUIEquip.GetGoodsGrid())
	  {
		//	准备参数。
		_lock_grid_id_		  = pOwn->FindCommand(this);
		_lock_fusion_item_id_ = _ItemData.GetFusionItemID();
		// add by ning.yan 2008-11-10 如果道具已锁定，则解锁 begin
		if(_ItemData.dwDBID)
		{
		  CCursor::I()->SetCursor(CCursor::stNormal);
		  g_stUIDoublePwd.SetType(CDoublePwdMgr::ITEM_UNLOCK);
		  g_stUIDoublePwd.ShowDoublePwdForm();
		} else // end
		{
		  //	弹出选择框。
		  stSelectBox* pBox = g_stUIBox.ShowSelectBox(_evtSelectYesNoEvent, RES_STRING(CL_UIITEMCOMMAND_CPP_00011));
		  //	pBox->dwTag = 0;
		  //	pBox->dwParam = 0;

		  //delete by ning.yan 使框始终显示在游戏界面中央 2008-11-17 begin
		  // pBox->frmDialog->SetPos( 100, 250 );
		  // pBox->frmDialog->SetParent(	g_stUIEquip.GetItemForm() ); // end
		  pBox->frmDialog->Show();
		  pBox->frmDialog->Refresh();

		  CCursor::I()->SetCursor(CCursor::stNormal);

		  //CS_DropLock(	_lock_pos_,	_lock_item_id_,	GridID,	_ItemData.GetFusionItemID()	);

		  //	取消等待被锁定状态。
		  // _wait_select_lock_item_state_	=	false; // delete by ning.yan 2008-11-12
		}
		_wait_select_lock_item_state_ = false; // add by ning.yan 2008-11-12
	  }
	}
  }
  //	2008-9-17	yangyinyu	add	end!

  if(CRepairState* pState = dynamic_cast<CRepairState*>(pCha->GetActor()->GetCurState()))
  {
	// 如果处于修理道具状态
	if(_pItem->sType >= 31)
	{
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_675), _pItem->szName);
	  return false;
	}

	CGoodsGrid* pOwn = dynamic_cast<CGoodsGrid*>(GetParent());
	if(pOwn)
	{
	  if(pOwn == g_stUIEquip.GetGoodsGrid())
	  {
		int GridID = pOwn->FindCommand(this);
		if(GridID == -1) return false;

		CS_ItemRepairAsk(pCha->getAttachID(), pCha->lTag, 2, GridID);
		return true;
	  }
	}

	COneCommand* pOne = dynamic_cast<COneCommand*>(GetParent());
	if(pOne)
	{
	  CS_ItemRepairAsk(pCha->getAttachID(), pCha->lTag, 1, pOne->nTag);
	  return true;
	}
	return false;
  } else if(CFeedState* pState = dynamic_cast<CFeedState*>(pCha->GetActor()->GetCurState()))
  {
	// 喂食状态
	if(_pItem->sType != enumItemTypePet)
	{
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_676));
	  return false;
	}

	CGoodsGrid* pOwn = dynamic_cast<CGoodsGrid*>(GetParent());
	if(pOwn)
	{
	  if(pOwn == g_stUIEquip.GetGoodsGrid())
	  {
		int GridID = pOwn->FindCommand(this);
		if(GridID == -1) return false;

		stNetUseItem param;
		param.sGridID	 = pState->GetFeedGridID();
		param.sTarGridID = GridID;
		CS_BeginAction(g_stUIBoat.GetHuman(), enumACTION_ITEM_USE, (void*)&param);

		pState->PopState();
		return true;
	  }
	}
	return false;
  } else if(CFeteState* pState = dynamic_cast<CFeteState*>(pCha->GetActor()->GetCurState()))
  {
	// 祭祀状态  add by Philip.Wu  2006-06-20
	if(_pItem->sType != 65)
	{
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_677));
	  return false;
	}

	CGoodsGrid* pOwn = dynamic_cast<CGoodsGrid*>(GetParent());
	if(pOwn)
	{
	  if(pOwn == g_stUIEquip.GetGoodsGrid())
	  {
		int GridID = pOwn->FindCommand(this);
		if(GridID == -1) return false;

		stNetUseItem param;
		param.sGridID	 = pState->GetFeteGridID();
		param.sTarGridID = GridID;
		CS_BeginAction(g_stUIBoat.GetHuman(), enumACTION_ITEM_USE, (void*)&param);

		pState->PopState();
		return true;
	  }
	}
	return false;
  }
  return false;
}

void CItemCommand::RenderEnergy(int x, int y)
{
  /*if( _pItem->sType==29 && _ItemData.sEnergy[1]!=0 )
	{
		float fLen = (float)_ItemData.sEnergy[0] / (float)_ItemData.sEnergy[1] * (float)ITEM_HEIGHT;
		int yb = y+ITEM_HEIGHT;
		GetRender().FillFrame( x, y, x+2, yb, COLOR_BLUE );
		GetRender().FillFrame( x, yb-(int)fLen, x+2, yb, COLOR_RED );
	}*/
}

void CItemCommand::_AddDescriptor(int index)
{
  memset(buf, 0, sizeof(buf));
  StringNewLine(buf, sizeof(buf), 40, _pItem->szDescriptor, (unsigned int)strlen(_pItem->szDescriptor));
  PushHint(buf, COLOR_WHITE, 5, 0, index);
}

bool CItemCommand::UseCommand()
{
  static DWORD dwTime = 0;
  if(CGameApp::GetCurTick() < dwTime)
  {
	return false;
  }
  dwTime = CGameApp::GetCurTick() + 1000;

  if(!GetIsValid()) return false;

  CCharacter* pCha = CGameScene::GetMainCha();
  if(!pCha) return false;

  if(pCha->GetChaState()->IsFalse(enumChaStateUseItem))
  {
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_678));
	return false;
  }

  CGoodsGrid* pOwn = dynamic_cast<CGoodsGrid*>(GetParent());
  if(pOwn)
  {
	CCharacter* pCha = g_stUIBoat.FindCha(pOwn);
	if(!pCha) return false;

	int GridID = pOwn->FindCommand(this);
	if(GridID == -1) return false;

	if(_pItem->sType == enumItemTypePetFodder || _pItem->sType == enumItemTypePetSock)
	{
	  CActor* pActor = CGameScene::GetMainCha()->GetActor();

	  CFeedState* pState = new CFeedState(pActor);
	  pState->SetFeedGridID(GridID);
	  pActor->SwitchState(pState);
	  return false;
	} else if(_pItem->sType == 66 || (864 <= _pItem->lID && _pItem->lID <= 866)) // 添加祭祀状态  add by Philip.Wu  2006-06-20
	{
	  CActor* pActor = CGameScene::GetMainCha()->GetActor();

	  CFeteState* pState = new CFeteState(pActor);
	  pState->SetFeteGridID(GridID);
	  pActor->SwitchState(pState);
	  return false;
	} else if(GetItemInfo()->sType == 71) // 技能道具使用
	{
	  CCharacter* pCha = CGameScene::GetMainCha();
	  if(!pCha) return false;

	  int			nSkillID = atoi(GetItemInfo()->szAttrEffect);
	  CSkillRecord* pSkill	 = GetSkillRecordInfo(nSkillID);

	  // 被动技能，不执行
	  if(!pSkill || !pSkill->GetIsUse()) return false;

	  // 判断技能能否在海上施放
	  if(pCha->IsBoat() && pSkill->chSrcType != 2)
	  {
		g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_879));
		return false;
	  }

	  // 判断技能能否在陆地上施放
	  if(!pCha->IsBoat() && pSkill->chSrcType != 1)
	  {
		g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_880));
		return false;
	  }

	  int nCoolDownTime = atoi(pSkill->szFireSpeed);
	  if(nCoolDownTime > 0) // 有 cooldown 时间
	  {
		DWORD					  nCurTickCount = g_pGameApp->GetCurTick() - 500; // 500毫秒延时处理
		map<int, DWORD>::iterator it			= _mapCoolDown.find(nSkillID);

		if(it != _mapCoolDown.end() && it->second + nCoolDownTime >= nCurTickCount)
		{
		  // cooldown 中
		  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_898), (it->second + nCoolDownTime - nCurTickCount) / 1000 + 1); //"道具冷确中，剩余 %d 秒"
		  return false;
		}

		_mapCoolDown[nSkillID] = g_pGameApp->GetCurTick(); // 保存下道具技能使用时间
	  }

	  // 无需点击技能释放对象或范围
	  if(pSkill->GetDistance() <= 0)
	  {
		CAttackState* attack = new CAttackState(pCha->GetActor());
		attack->SetSkill(pSkill);
		attack->SetTarget(pCha);
		attack->SetCommand(this);
		return pCha->GetActor()->SwitchState(attack);
	  }

	  //pCha->GetActor()->Stop();
	  pCha->ChangeReadySkill(nSkillID);
	  return false;
	}

	stNetUseItem param;
	param.sGridID = GridID;
	if((_pItem->sType < 31 || _ItemData.sID == 5939) && pCha == CGameScene::GetMainCha() && g_stUIBoat.GetHuman() == pCha)
	{
	  //	yyy	add	begin!
	  //	如果使用锁道具，则设置选择被锁定道具状态。。
	  if(_ItemData.sID == 5939)
	  {
		//	记录锁道具的位置。
		_lock_pos_	   = GridID;
		_lock_item_id_ = _ItemData.GetFusionItemID();

		//	设置光标为锁头。
		CCursor::I()->SetCursor(CCursor::stPick);

		//	设置状态。
		_wait_select_lock_item_state_ = true;

		//	返回，继续选择。
		return false;
	  };

	  //	yyy	add	end!

	  CActor* pActor = g_stUIBoat.GetHuman()->GetActor();

	  CEquipState* pState = new CEquipState(pActor);
	  pState->SetUseItemData(param);
	  pActor->SwitchState(pState);
	} else
	{
	  CS_BeginAction(pCha, enumACTION_ITEM_USE, (void*)&param);
	}
	return false;
  }

  COneCommand* pOne = dynamic_cast<COneCommand*>(GetParent());
  if(pOne)
  {
	g_stUIEquip.UnfixToGrid(this, -1, pOne->nTag);
  }
  return false;
}

//int CItemCommand::_GetValue( int nItemAttrType, SItemGrid& item )
//{
//    for( int i=0; i<defITEM_INSTANCE_ATTR_NUM; i++ )
//    {
//        if( item.sInstAttr[i][0]==nItemAttrType )
//        {
//            item.sInstAttr[i][0] = 0;
//            return item.sInstAttr[i][1];
//        }
//    }
//
//    return -1;
//}

int CItemCommand::_GetValue(int nItemAttrType, SItemHint& item)
{
  if(nItemAttrType <= 0 || nItemAttrType >= ITEMATTR_CLIENT_MAX)
	return -1;

  int nValue = 0;
  if(item.sInstAttr[nItemAttrType] != 0)
  {
	nValue						  = item.sInstAttr[nItemAttrType];
	item.sInstAttr[nItemAttrType] = 0;
	return nValue;
  }

  return -1;
}

bool CItemCommand::GetIsPile()
{
  return _pItem->GetIsPile();
}

int CItemCommand::GetPrice()
{
  return _nPrice;
}

void CItemCommand::SetData(const SItemGrid& item)
{
  memcpy(&_ItemData, &item, sizeof(_ItemData));
  int start = 0;
  for(; start < defITEM_INSTANCE_ATTR_NUM; start++)
  {
	if(item.sInstAttr[start][0] == 0)
	{
	  break;
	}
  }
  for(int i = start; i < defITEM_INSTANCE_ATTR_NUM; i++)
  {
	_ItemData.sInstAttr[i][0] = 0;
	_ItemData.sInstAttr[i][1] = 0;
  }
}

int CItemCommand::GetTotalNum()
{
  return _ItemData.sNum;
}

const char* CItemCommand::GetName()
{
  if(_ItemData.chForgeLv == 0)
  {
	return _pItem->szName;
  } else
  {
	static char szBuf[128] = {0};
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%+d %s", _ItemData.chForgeLv, _pItem->szName);
	return szBuf;
  }
}

void CItemCommand::_ShowWork(CItemRecord* pItem, SGameAttr* pAttr, int index)
{
  bool isFind = false;
  bool isSame = false;

  for(int i = 0; i < MAX_JOB_TYPE; i++)
  {
	if(pItem->szWork[i] < 0)
	  break;

	if(!isFind)
	{
	  //	Add by alfred.shi 20080928
	  string name(RES_STRING(CL_UIITEMCOMMAND_CPP_00012));
	  g_GetJobName(pItem->szWork[i]);
	  if(name.compare(g_GetJobName(pItem->szWork[i])) == 0)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", RES_STRING(CL_UIITEMCOMMAND_CPP_00013));
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_679), g_GetJobName(pItem->szWork[i]));
	  }

	  isFind = true;
	  //	End.
	}

	if(!isSame)
	{
	  if(pAttr->get(ATTR_JOB) == pItem->szWork[i])
	  {
		isSame = true;
	  }
	}
  }

  if(isFind)
  {
	PushHint(buf, isSame ? GENERIC_COLOR : VALID_COLOR, 5, 0, index);
  }
}

void CItemCommand::_ShowFusionWork(CItemRecord* pAppearItem, CItemRecord* pEquipItem, SGameAttr* pAttr, int index) // 用于显示熔合后道具的职业限制
{
  bool		   isFind		= false;
  int		   iAppearIndex = -1;
  int		   iEquipIndex	= -1;
  bool		   isSame		= false;
  CItemRecord* pItem(0);

  if(pAppearItem->szWork[0] > pEquipItem->szWork[0])
  {
	pItem = pAppearItem;
  } else
  {
	pItem = pEquipItem;
  }

  for(int i = 0; i < MAX_JOB_TYPE; i++)
  {
	if(pItem->szWork[i] < 0)
	  break;

	if(!isFind)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_679), g_GetJobName(pItem->szWork[i]));
	  isFind = true;
	}

	if(!isSame)
	{
	  if(pAttr->get(ATTR_JOB) == pItem->szWork[i])
	  {
		isSame = true;
	  }
	}
  }

  if(isFind)
  {
	PushHint(buf, isSame ? GENERIC_COLOR : VALID_COLOR, 5, 0, index);
  }
}

void CItemCommand::_ShowWork(xShipInfo* pInfo, SGameAttr* pAttr, int index)
{
  bool isFind = false;
  bool isSame = false;

  for(int i = 0; i < MAX_JOB_TYPE; i++)
  {
	if(pInfo->sPfLimit[i] == (USHORT)-1)
	  break;

	//add by alfred.shi 20080714	begin
	/*	修改他人代码请加注释，暴发户问题已经修改，后来又出现，代码被人改动，字符串资源也没找到。*/
	if(!isFind)
	{
	  //string name(RES_STRING(CL_UIITEMCOMMAND_CPP_00010));
	  string name(RES_STRING(CL_UIITEMCOMMAND_CPP_00012));
	  g_GetJobName(pInfo->sPfLimit[i]);
	  if(name.compare(g_GetJobName(pInfo->sPfLimit[i])) == 0)
	  {
		//_snprintf_s( buf, _countof( buf ), _TRUNCATE, "%s",RES_STRING(CL_UIITEMCOMMAND_CPP_00011));
		_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s", RES_STRING(CL_UIITEMCOMMAND_CPP_00013));
		//PushHint( buf, VALID_COLOR );
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_679), g_GetJobName(pInfo->sPfLimit[i]));
	  }

	  isFind = true;
	}
	//	end

	if(!isSame)
	{
	  if(pAttr->get(ATTR_JOB) == pInfo->sPfLimit[i])
	  {
		isSame = true;
	  }
	}
  }

  if(isFind)
  {
	PushHint(buf, isSame ? GENERIC_COLOR : VALID_COLOR, 5, 0, index);
  }
}

void CItemCommand::_ShowBody(int index)
{
  if(_pItem->IsAllEquip()) return;

  if(!g_stUIBoat.GetHuman() || !g_stUIBoat.GetHuman()->GetDefaultChaInfo()) return;

  std::ostrstream str;
  str << RES_STRING(CL_LANGUAGE_MATCH_680);
  for(int i = 1; i < 5; i++)
  {
	if(!_pItem->IsAllowEquip(i))
	  continue;

	switch(i)
	{
	case 1: str << RES_STRING(CL_LANGUAGE_MATCH_681); break;
	case 2: str << RES_STRING(CL_LANGUAGE_MATCH_682); break;
	case 3: str << RES_STRING(CL_LANGUAGE_MATCH_683); break;
	case 4: str << RES_STRING(CL_LANGUAGE_MATCH_684); break;
	}
  }
  str << '\0';

  int nBodyType = g_stUIBoat.GetHuman()->GetDefaultChaInfo()->lID;
  PushHint(str.str(), _pItem->IsAllowEquip(nBodyType) ? GENERIC_COLOR : VALID_COLOR, 5, 0, index);

  // 内存泄漏
  str.freeze(false);
}

void CItemCommand::_ShowFusionBody(CItemRecord* pEquipItem, int index)
{
  if(_pItem->IsAllEquip() && pEquipItem->IsAllEquip()) return;

  if(!g_stUIBoat.GetHuman() || !g_stUIBoat.GetHuman()->GetDefaultChaInfo()) return;

  std::ostrstream str;
  str << RES_STRING(CL_LANGUAGE_MATCH_680);
  for(int i = 1; i < 5; i++)
  {
	if(_pItem->IsAllowEquip(i) && pEquipItem->IsAllowEquip(i))
	{
	  switch(i)
	  {
	  case 1: str << RES_STRING(CL_LANGUAGE_MATCH_681); break;
	  case 2: str << RES_STRING(CL_LANGUAGE_MATCH_682); break;
	  case 3: str << RES_STRING(CL_LANGUAGE_MATCH_683); break;
	  case 4: str << RES_STRING(CL_LANGUAGE_MATCH_684); break;
	  }
	}
  }
  str << '\0';

  int nBodyType = g_stUIBoat.GetHuman()->GetDefaultChaInfo()->lID;
  PushHint(str.str(), _pItem->IsAllowEquip(nBodyType) ? GENERIC_COLOR : VALID_COLOR, 5, 0, index);

  // 内存泄漏
  str.freeze(false);
}

void CItemCommand::SetBoatHint(const NET_CHARTRADE_BOATDATA* const pBoat)
{
  if(pBoat)
  {
	if(!_pBoatHint)
	{
	  _pBoatHint = new NET_CHARTRADE_BOATDATA;
	}
	memcpy(_pBoatHint, pBoat, sizeof(NET_CHARTRADE_BOATDATA));
  } else
  {
	if(_pBoatHint)
	{
	  delete _pBoatHint;
	  _pBoatHint = NULL;
	}
  }
}

SItemForge& CItemCommand::GetForgeInfo()
{
  return SItemForge::Convert(_ItemData.lDBParam[0]);
}

//---------------------------------------------------------------------------
// class SItemHint
//---------------------------------------------------------------------------
void SItemHint::Convert(SItemGrid& ItemGrid, CItemRecord* pInfo)
{
  sID = ItemGrid.sID;
  sNum = ItemGrid.sNum;
  sEndure[0] = ItemGrid.sEndure[0] / 50;
  sEndure[1] = ItemGrid.sEndure[1] / 50;
  sEnergy[0] = ItemGrid.sEnergy[0];
  sEnergy[1] = ItemGrid.sEnergy[1];
  chForgeLv = ItemGrid.chForgeLv;
  memcpy( lDBParam, ItemGrid.lDBParam, sizeof(lDBParam) );

  memset( sInstAttr, 0, sizeof(sInstAttr) );

  for( int i=0; i<ITEMATTR_CLIENT_MAX; i++ )
  {
  	sInstAttr[i] = pInfo->GetTypeValue( i );
  }

  // 读取属性，如果网络有属性，使用网络属性，否则从表格中读取
  int nAttr = 0;
  for( int i=0; i<defITEM_INSTANCE_ATTR_NUM; i++ )
  {
  	nAttr = ItemGrid.sInstAttr[i][0];
  	if( nAttr<=0 || nAttr>=ITEMATTR_CLIENT_MAX ) continue;

  	sInstAttr[nAttr] = ItemGrid.sInstAttr[i][1];
  }
}

//---------------------------------------------------------------------------
// class SItemForge
//---------------------------------------------------------------------------
SItemForge& SItemForge::Convert(DWORD v, int nItemID)
{
  static SItemForge forge;
  memset(&forge, 0, sizeof(forge));

  DWORD dwForgeValue = v;
  if(dwForgeValue == 0)
	return forge;

  forge.IsForge	 = true;
  forge.nHoleNum = v / 1000000000; // 槽数

  int		  nStoneData;
  CStoneInfo* pStoneInfo = NULL;
  for(int i = 0; i < 3; ++i)
  {
	nStoneData = (v / (int)(pow((double)1000, (double)(2 - i)))) % 1000; // 三位一取

	pStoneInfo = GetStoneInfo(nStoneData / 10);
	if(!pStoneInfo) continue;

	forge.pStoneInfo[forge.nStoneNum]  = pStoneInfo;
	forge.nStoneLevel[forge.nStoneNum] = nStoneData % 10;

	forge.nLevel += forge.nStoneLevel[forge.nStoneNum];

	string strHint = "";
	if(g_pGameApp->GetScriptMgr()->DoString(pStoneInfo->szHintFunc, "u-s", forge.nStoneLevel[forge.nStoneNum], &strHint))
	{
	  //strncpy( forge.szStoneHint[forge.nStoneNum], strHint.c_str(), sizeof(forge.szStoneHint[forge.nStoneNum]) );
	  strncpy_s(forge.szStoneHint[forge.nStoneNum], sizeof(forge.szStoneHint[forge.nStoneNum]), strHint.c_str(), _TRUNCATE);
	}

	forge.nStoneNum += 1;
  }

  if(nItemID > 0)
  {
	forge.Refresh(nItemID);
  }

  return forge;

  //////////////////////////////////////////////////////////////////////////////////
  // 下面的可能会有问题，不执行

  //int Num = 0;
  //if( g_pGameApp->GetScriptMgr()->DoString( "Get_HoleNum", "u-d", dwForgeValue, &Num ) )
  //{
  //	if( Num>0 )
  //	{
  //		forge.nHoleNum = Num;
  //	}
  //}

  //// 得到三颗宝石
  //int nStone;
  //int nStoneLv;
  //CStoneInfo* pStone = NULL;
  //int StoneNum = 0;
  //string hint;
  //for( int i=0; i<3; i++ )
  //{
  //	_snprintf_s( buf, _countof( buf ), _TRUNCATE, "Get_Stone_%d", i+1 );
  //	nStone = 0;
  //	if( !g_pGameApp->GetScriptMgr()->DoString( buf, "u-d", dwForgeValue, &nStone ) )
  //		continue;

  //	pStone = GetStoneInfo( nStone );
  //	if( !pStone ) continue;

  //	forge.pStoneInfo[ StoneNum ] = pStone;

  //	nStoneLv = 0;
  //	_snprintf_s( buf, _countof( buf ), _TRUNCATE, "Get_StoneLv_%d", i+1 );
  //	if( g_pGameApp->GetScriptMgr()->DoString( buf, "u-d", dwForgeValue, &nStoneLv ) )
  //	{
  //		forge.nStoneLevel[ StoneNum ] = nStoneLv;
  //		forge.nLevel += nStoneLv;

  //		hint = "";
  //		if( g_pGameApp->GetScriptMgr()->DoString( pStone->szHintFunc, "u-s", nStoneLv, &hint ) )
  //		{
  //			strncpy( forge.szStoneHint[StoneNum], hint.c_str(), sizeof(forge.szStoneHint[StoneNum]) );
  //		}
  //	}
  //	StoneNum++;
  //}

  //forge.nStoneNum = StoneNum;

  //if( nItemID>0 )
  //{
  //	forge.Refresh( nItemID );
  //}
  //return forge;
}

void SItemForge::Refresh(int nItemID)
{
  for(int i = 0; i < 3; i++)
  {
	if(pStoneInfo[i])
	  nStoneType[i] = pStoneInfo[i]->nType;
	else
	  nStoneType[i] = -1;
  }

  int nEffectID = 0;
  if(!g_pGameApp->GetScriptMgr()->DoString("Item_Stoneeffect", "ddd-d", nStoneType[0], nStoneType[1], nStoneType[2], &nEffectID))
	return;

  nEffectID--;
  if(nEffectID < 0 || nEffectID >= ITEM_REFINE_NUM)
	return;

  pRefineInfo = GetItemRefineInfo(nItemID);
  if(!pRefineInfo) return;

  pEffectInfo = GetItemRefineEffectInfo(pRefineInfo->Value[nEffectID]);
  if(!pEffectInfo) return;

  if(nLevel >= 1)
  {
	nEffectLevel = (nLevel - 1) / 4;
	if(nEffectLevel > 3) nEffectLevel = 3;
  }
}

float SItemForge::GetAlpha(int nTotalLevel)
{
  //static float fLevelAlpha[4] = { 150.0f, 180.0f, 220.0f, 255.0f };
  static float fLevelAlpha[4] = {80.0f, 140.0f, 200.0f, 255.0f};
  static float fLevelBase[4]  = {fLevelAlpha[1] - fLevelAlpha[0], fLevelAlpha[2] - fLevelAlpha[1], fLevelAlpha[3] - fLevelAlpha[2], 0.0f};

  if(nTotalLevel <= 1) return fLevelAlpha[0] / 255.0f;
  if(nTotalLevel >= 13) return 1.0f;

  --nTotalLevel;
  int nLevel = nTotalLevel / 4;
  return (fLevelAlpha[nLevel] + (float)(nTotalLevel % 4) / 4.0f * fLevelBase[nLevel]) / 255.0f;
}
