//=============================================================================
// FileName: CharacterPacket.cpp
// Creater: ZhangXuedong
// Date: 2005.05.09
// Comment: Build Character Packet
//=============================================================================

#include "Character.h"
#include "Player.h"
#include "GameApp.h"

void CCharacter::WriteBaseInfo(WPACKET &pkret)
{
	CPlayer	*pCPlayer = GetPlayer();

	WRITE_LONG(pkret, GetCat());
	WRITE_LONG(pkret, GetID());
	if (pCPlayer)
	{
		WRITE_LONG(pkret, pCPlayer->GetMainCha()->GetID());
		WRITE_STRING(pkret, pCPlayer->GetMainCha()->GetName());
		WRITE_CHAR(pkret, pCPlayer->GetGMLev());
	}
	else
	{
		WRITE_LONG(pkret, GetID());
		WRITE_STRING(pkret, "");
		WRITE_CHAR(pkret, 0);
	}
	WRITE_LONG(pkret, GetHandle());
	WRITE_CHAR(pkret, (Char)m_CChaAttr.GetAttr(ATTR_CHATYPE));
	WRITE_STRING(pkret, m_name);
	WRITE_STRING(pkret, GetMotto());
	WRITE_SHORT(pkret, GetPlyMainCha()->GetIcon());
	WRITE_LONG(pkret, GetValidGuildID());
	WRITE_STRING(pkret, GetValidGuildName());
	WRITE_STRING(pkret, GetValidGuildMotto());
	WRITE_STRING(pkret, GetStallName());
	WRITE_SHORT(pkret, GetExistState());
	WRITE_LONG(pkret, GetPos().x);
	WRITE_LONG(pkret, GetPos().y);
	WRITE_LONG(pkret, GetRadius());
	WRITE_SHORT(pkret, GetAngle());
	// 队长ID
	CPlayer	*pCPly = GetPlayer();
	if (pCPly)
		WRITE_LONG(pkret, pCPly->getTeamLeaderID());
	else
		WRITE_LONG(pkret, 0);
	//

	WriteSideInfo(pkret);
	WriteEventInfo(pkret);
	WriteLookData(pkret);
	WritePKCtrl(pkret);
	WriteAppendLook(this->GetKitbag(), pkret, true);
}

void CCharacter::WritePKCtrl(WPACKET &pkret)
{
	WRITE_CHAR(pkret, m_chPKCtrl);
}

void CCharacter::WriteSideInfo(WPACKET &pkret)
{
	WRITE_CHAR(pkret, (Char)GetSideID());
}

void CCharacter::WriteSkillbag(WPACKET &pk, int nSynType)
{
	SSkillGrid	*pSkillGrid = 0;
	CSkillTempData	*pSkillTData = 0;

	WRITE_SHORT(pk, m_sDefSkillNo);

	WRITE_CHAR(pk, nSynType);

	short	sChangeSkillNum = m_CSkillBag.GetChangeSkillNum();
	CCharacter	*pCCtrlCha = GetPlyCtrlCha();
	bool	bIsBoatCtrl = pCCtrlCha->IsBoat();
	bool	bAddBoatSkill = false;
	if (bIsBoatCtrl) // 主控是船角色，则加入船的默认技能
	{
#ifdef COMPACT_MEM
		pSkillGrid = pCCtrlCha->m_CSkillBag.GetFirstSkill();
#else
		pSkillGrid = pCCtrlCha->m_CSkillBag.GetSkillContByNum(0);
#endif
		if (pSkillGrid)
		{
			pSkillTData = g_pGameApp->GetSkillTData(pSkillGrid->sID, pSkillGrid->chLv);
			if (pSkillTData)
			{
				bAddBoatSkill = true;
				sChangeSkillNum += 1;
			}
		}
	}
	WRITE_SHORT(pk, sChangeSkillNum);
	if (bAddBoatSkill)
	{
		WRITE_SHORT(pk, pSkillGrid->sID);
		WRITE_CHAR(pk, pSkillGrid->chState);
		WRITE_CHAR(pk, pSkillGrid->chLv);
		WRITE_SHORT(pk, pSkillTData->sUseSP);
		WRITE_SHORT(pk, pSkillTData->sUseEndure);
		WRITE_SHORT(pk, pSkillTData->sUseEnergy);
		WRITE_LONG(pk, pSkillTData->lResumeTime);
		WRITE_SHORT(pk, pSkillTData->sRange[0]);
		if (pSkillTData->sRange[0] != enumRANGE_TYPE_NONE)
		{
			for (short j = 1; j < defSKILL_RANGE_EXTEP_NUM; j++)
				WRITE_SHORT(pk, pSkillTData->sRange[j]);
		}
	}
#ifdef COMPACT_MEM	
	for(map<short,  SSkillGrid>::iterator it = pCCtrlCha->m_CSkillBag.m_ChangeMap.begin(); it != pCCtrlCha->m_CSkillBag.m_ChangeMap.end(); it++)
	{
		pSkillGrid = &it->second;
#else
	for (short i = 0; i < sChangeSkillNum; i++)
	{
		pSkillGrid = m_CSkillBag.GetChangeSkill(i);
#endif
		if (!pSkillGrid)
			return;
		pSkillTData = g_pGameApp->GetSkillTData(pSkillGrid->sID, pSkillGrid->chLv);
		if (!pSkillTData)
			return;
		WRITE_SHORT(pk, pSkillGrid->sID);
		WRITE_CHAR(pk, pSkillGrid->chState);
		WRITE_CHAR(pk, pSkillGrid->chLv);
		WRITE_SHORT(pk, pSkillTData->sUseSP);
		WRITE_SHORT(pk, pSkillTData->sUseEndure);
		WRITE_SHORT(pk, pSkillTData->sUseEnergy);
		WRITE_LONG(pk, pSkillTData->lResumeTime);
		WRITE_SHORT(pk, pSkillTData->sRange[0]);
		if (pSkillTData->sRange[0] != enumRANGE_TYPE_NONE)
		{
			for (short j = 1; j < defSKILL_RANGE_EXTEP_NUM; j++)
				WRITE_SHORT(pk, pSkillTData->sRange[j]);
		}
	}
}

void CCharacter::WriteKitbag(CKitbag *pCKb, WPACKET &WtPk, int nSynType)
{
	SItemGrid	*pGridCont;
	CItemRecord* pItemRec;

	WRITE_CHAR(WtPk, nSynType);
	Short sCapacity = pCKb->GetCapacity();
	if (nSynType == enumSYN_KITBAG_INIT)
		WRITE_SHORT(WtPk, sCapacity);
	for (int i = 0; i < sCapacity; i++)
	{
		if (!pCKb->IsSingleChange(i))
			continue;
		WRITE_SHORT(WtPk, i);
		pGridCont = pCKb->GetGridContByID(i);
		if (!pGridCont)
		{
			WRITE_SHORT(WtPk, 0);
			continue;
		}
		pItemRec = GetItemRecordInfo( pGridCont->sID );
		if (!pItemRec)
		{
			WRITE_SHORT(WtPk, 0);
			continue;
		}
		// 有道具
		WRITE_SHORT(WtPk, pGridCont->sID);
		//	2008-7-31	yangyinyu	add	begin!
		//	记录锁定号。
		WRITE_LONG(WtPk,	pGridCont->dwDBID	);
		//	2008-7-31	yangyinyu	add	end!
		WRITE_SHORT(WtPk, pGridCont->sNum);
		WRITE_SHORT(WtPk, pGridCont->sEndure[0]);
		WRITE_SHORT(WtPk, pGridCont->sEndure[1]);
		WRITE_SHORT(WtPk, pGridCont->sEnergy[0]);
		WRITE_SHORT(WtPk, pGridCont->sEnergy[1]);
		WRITE_CHAR(WtPk, pGridCont->chForgeLv);
		WRITE_CHAR(WtPk, pGridCont->IsValid() ? 1 : 0);

		pItemRec = GetItemRecordInfo( pGridCont->sID );
		if( pItemRec->sType == enumItemTypeBoat ) // 船道具，写入船的WorldID，用于客户端将道具与船角色挂钩
		{
			CCharacter	*pCBoat = GetPlayer()->GetBoat((DWORD)pGridCont->GetDBParam(enumITEMDBP_INST_ID));
			if (pCBoat)
				WRITE_LONG(WtPk, pCBoat->GetID());
			else
				WRITE_LONG(WtPk, 0);
		}

		WRITE_LONG(WtPk, pGridCont->GetDBParam(enumITEMDBP_FORGE));
		WRITE_LONG(WtPk, pGridCont->GetDBParam(enumITEMDBP_INST_ID));
		if (pGridCont->IsInstAttrValid()) // 存在实例属性
		{
			WRITE_CHAR(WtPk, 1);
			for (int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
			{
				WRITE_SHORT(WtPk, pGridCont->sInstAttr[j][0]);
				WRITE_SHORT(WtPk, pGridCont->sInstAttr[j][1]);
			}
		}
		else
			WRITE_CHAR(WtPk, 0); // 不存在实例属性
	}
	WRITE_SHORT(WtPk, -1); // 结束标志
}

void CCharacter::WriteLookData(WPACKET &WtPk, Char chLookType, Char chSynType)
{
	WRITE_CHAR(WtPk, chSynType);
	WRITE_SHORT(WtPk, m_SChaPart.sTypeID);
	if( m_CChaAttr.GetAttr(ATTR_CHATYPE) == enumCHACTRL_PLAYER && IsBoat() )
	{
		WRITE_CHAR( WtPk, 1); // 船的外观
		WRITE_SHORT( WtPk, m_SChaPart.sPosID );
		WRITE_SHORT( WtPk, m_SChaPart.sBoatID );
		WRITE_SHORT( WtPk, m_SChaPart.sHeader );
		WRITE_SHORT( WtPk, m_SChaPart.sBody );
		WRITE_SHORT( WtPk, m_SChaPart.sEngine );
		WRITE_SHORT( WtPk, m_SChaPart.sCannon );
		WRITE_SHORT( WtPk, m_SChaPart.sEquipment );
		//WRITE_LONG( WtPk, m_SChaPart.dwBody );
		//WRITE_LONG( WtPk, m_SChaPart.dwHeader );
		//WRITE_LONG( WtPk, m_SChaPart.dwEngine );
		//WRITE_LONG( WtPk, m_SChaPart.dwFlag );
		//for( BYTE i = 0; i < BOAT_MAXNUM_MOTOR; i++ )
		//{
		//	WRITE_LONG( WtPk, m_SChaPart.dwMotor[i] );
		//}
	}
	else
	{		
		WRITE_CHAR( WtPk, 0); // 人角色的外观
		WRITE_SHORT(WtPk, m_SChaPart.sHairID);
		SItemGrid *pItem;

		int nItemCnt = enumEQUIP_NUM;

		if(chLookType==LOOK_TEAM) nItemCnt = 3; // 组队类型的外观通知, 只需要上半身信息

#ifdef TEAM_BUFF
		WRITE_SHORT( WtPk, nItemCnt );//Add by sunny.sun 20090810 和客户端统一
#endif
		for (int i = 0; i < nItemCnt; i++)
		{
			pItem = m_SChaPart.SLink + i;
			if (chSynType == enumSYN_LOOK_CHANGE)
			{
				if (!pItem->IsChange())
				{
					WRITE_SHORT(WtPk, 0);
					continue;
				}
			}
			WRITE_SHORT(WtPk, pItem->sID);
			//	2008-8-7	yangyinyu	add	begin!
			WRITE_LONG(WtPk, pItem->dwDBID);
			//	2008-8-7	yangyinyu	add	end!
			if (pItem->sID == 0)
				continue;
			if (chSynType == enumSYN_LOOK_CHANGE)
			{
				WRITE_SHORT(WtPk, pItem->sEndure[0]);
				WRITE_SHORT(WtPk, pItem->sEnergy[0]);
				WRITE_CHAR(WtPk, pItem->IsValid() ? 1 : 0);
				continue;
			}
			else
			{
				WRITE_SHORT(WtPk, pItem->sNum);
				WRITE_SHORT(WtPk, pItem->sEndure[0]);
				WRITE_SHORT(WtPk, pItem->sEndure[1]);
				WRITE_SHORT(WtPk, pItem->sEnergy[0]);
				WRITE_SHORT(WtPk, pItem->sEnergy[1]);
				WRITE_CHAR(WtPk, pItem->chForgeLv);
				WRITE_CHAR(WtPk, pItem->IsValid() ? 1 : 0);
			}

			if(chLookType!=LOOK_SELF) // 除非是自身通知, 否则不需要下面的信息
			{
				WRITE_CHAR(WtPk, 0);
				continue;
			}
			WRITE_CHAR(WtPk, 1);

			WRITE_LONG(WtPk, pItem->GetDBParam(enumITEMDBP_FORGE));
			WRITE_LONG(WtPk, pItem->GetDBParam(enumITEMDBP_INST_ID));
			if (pItem->IsInstAttrValid())
			{
				WRITE_CHAR(WtPk, 1);
				for (int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
				{
					WRITE_SHORT(WtPk, pItem->sInstAttr[j][0]);
					WRITE_SHORT(WtPk, pItem->sInstAttr[j][1]);
				}
			}
			else
				WRITE_CHAR(WtPk, 0);
		}
	}
}

// 注意该函数使用道具栏的改变标志。
bool CCharacter::WriteAppendLook(CKitbag *pCKb, WPACKET &pk, bool bInit)
{
	SItemGrid	*pGridCont;
	bool	bHasData = false;
	for (int i = 0; i < defESPE_KBGRID_NUM; i++)
	{
		if (!bHasData && pCKb->IsSingleChange(i))
			bHasData = true;
		pGridCont = pCKb->GetGridContByID(i);
		if (!pGridCont || !ItemIsAppendLook(pGridCont))
		{
			WRITE_SHORT(pk, 0);
			continue;
		}
		WRITE_SHORT(pk, pGridCont->sID);
		WRITE_CHAR(pk, pGridCont->IsValid() ? 1 : 0);
	}

	if (bInit) return true;
	else return bHasData;
}

void CCharacter::WriteShortcut(WPACKET &WtPk)
{
	for (int i = 0; i < SHORT_CUT_NUM; i++)
	{
		WRITE_CHAR(WtPk, m_CShortcut.chType[i]);
		WRITE_SHORT(WtPk, m_CShortcut.byGridID[i]);
	}
}

void CCharacter::WriteBoat(WPACKET &WtPk)
{
	CPlayer	*pCPlayer = GetPlayer();
	if (!pCPlayer)
	{
		WRITE_CHAR(WtPk, 0);
		return;
	}
	WRITE_CHAR(WtPk, pCPlayer->GetNumBoat());
	CCharacter	*pCBoat;
	for (BYTE i = 0; i < pCPlayer->GetNumBoat(); i++)
	{
		pCBoat = pCPlayer->GetBoat(i);
		if (!pCBoat)
			continue;
		WriteItemChaBoat(WtPk, pCBoat);
	}
}

void CCharacter::WriteItemChaBoat(WPACKET &WtPk, CCharacter *pCBoat)
{
	pCBoat->WriteBaseInfo(WtPk);
	pCBoat->WriteAttr(WtPk, enumATTRSYN_INIT);
	pCBoat->GetKitbag()->SetChangeFlag(true);
	pCBoat->WriteKitbag(pCBoat->GetKitbag(), WtPk, enumSYN_KITBAG_INIT); // 道具栏
	pCBoat->WriteSkillState(WtPk);
}
