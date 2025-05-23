//add by ALLEN 2007-10-19

#include "AuctionItem.h"
#include "GameDB.h"
#include "GameApp.h"

CAuctionItem::CAuctionItem(short sItemID, const string& strName, short sCount, uInt nBasePrice, uInt nMinBid)
{
	m_sItemID = sItemID;
	m_sCount = sCount;
	m_nBasePrice = nBasePrice;
	m_nMinBid = nMinBid;
	m_dwCurChaID = 0;
	m_nCurPrice = 0;
	m_strName = strName;
}

CAuctionItem::~CAuctionItem()
{
}

BOOL CAuctionItem::BidUp(CCharacter *pCha, uInt price)
{
	if(pCha->GetKitbag()->IsPwdLocked())
	{
		//pCha->SystemNotice("道具栏已锁定,不能竞拍!");
		pCha->SystemNotice(RES_STRING(GM_AUCTIONITEM_CPP_00001));
		return false;
	}

	if(pCha->IsReadBook())
	{
		//pCha->SystemNotice("读书状态,不能竞拍!");
		pCha->SystemNotice(RES_STRING(GM_AUCTIONITEM_CPP_00002));
		return false;
	}

	if(GetCurPrice() == 0)
	{
		if(!pCha->HasMoney(GetBasePrice()))
		{
			//pCha->SystemNotice("你的资金不足!");
			pCha->SystemNotice(RES_STRING(GM_AUCTIONITEM_CPP_00003));
			return false;
		}

		SetCurPrice(GetBasePrice());
		SetCurChaID(pCha->GetPlayer()->GetDBChaId());
		SetCurChaName(pCha->GetName());
		//if(pCha->TakeMoney("系统", GetCurPrice()))
		if(pCha->TakeMoney(RES_STRING(GM_AUCTIONITEM_CPP_00004), GetCurPrice()))
		//LG("Auction", "角色 %s 投标 %ld 成功!\n", GetCurChaName().c_str(),GetCurPrice());
		LG("Auction", "character %s bid %ld success!\n", GetCurChaName().c_str(),GetCurPrice());
		return true;
	}

	if((price < GetCurPrice()) || (price - GetCurPrice() < GetMinBid()))
	{
		//pCha->SystemNotice("你出价太低!");
		pCha->SystemNotice(RES_STRING(GM_AUCTIONITEM_CPP_00005));
		return false;
	}

	if(!pCha->HasMoney(price))
	{
		//pCha->SystemNotice("你的资金不足!");
		pCha->SystemNotice(RES_STRING(GM_AUCTIONITEM_CPP_00003));
		return false;
	}

	DWORD dwPreChaID = GetCurChaID();
	uInt nPrePrice = GetCurPrice();
	string strPreChaName = GetCurChaName();

	SetCurPrice(price);
	SetCurChaID(pCha->GetPlayer()->GetDBChaId());
	SetCurChaName(pCha->GetName());
	//if(pCha->TakeMoney("系统", GetCurPrice()))
	if(pCha->TakeMoney( RES_STRING(GM_AUCTIONITEM_CPP_00004), GetCurPrice()))
		//LG("Auction", "角色 %s 投标 %ld 成功!\n", GetCurChaName().c_str(),GetCurPrice());
		LG("Auction", "character %s bid %ld success!\n", GetCurChaName().c_str(),GetCurPrice());

	//返还金钱
	BOOL bOnline = false;
	if(!game_db.IsChaOnline(dwPreChaID, bOnline))
	{
		//LG("Auction", "读取角色 %s 在线状态失败!\n", strPreChaName.c_str());
		LG("Auction", "get character %s online state failed!\n", strPreChaName.c_str());
	}
	else
	{
		if(!bOnline)
		{
			if(!game_db.AddMoney(dwPreChaID, nPrePrice))
			{
				//LG("Auction", "角色 %s 返还金钱 %ld 失败!\n", strPreChaName.c_str(), nPrePrice);
				LG("Auction", "character %s back money %ld failed!\n", strPreChaName.c_str(), nPrePrice);
			}
		}
		else
		{
			CCharacter *pCha_ = NULL;
			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(dwPreChaID);
			if(pPlayer)
			{
				pCha_ = pPlayer->GetMainCha();
			}
			if(pCha_)
			{
				//pCha_->AddMoney("系统", nPrePrice);
				pCha_->AddMoney(RES_STRING(GM_AUCTIONITEM_CPP_00004), nPrePrice);
			}
			else
			{
				WPACKET WtPk  = GETWPACKET();
				WRITE_CMD(WtPk, CMD_MM_ADDMONEY);
				WRITE_LONG(WtPk, pCha->GetID());
				WRITE_LONG(WtPk, dwPreChaID);
				WRITE_LONG(WtPk, nPrePrice);
				pCha->ReflectINFof(pCha, WtPk);
			}
		}
	}

	return true;
}