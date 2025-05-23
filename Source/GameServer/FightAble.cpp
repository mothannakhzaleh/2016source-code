//=============================================================================
// FileName: FightAble.cpp
// Creater: ZhangXuedong
// Date: 2004.09.15
// Comment: CFightAble class
//=============================================================================

#include "FightAble.h"
#include "Util.h"
#include "GameApp.h"
#include "GameAppNet.h"
#include "SubMap.h"
#include "Parser.h"
#include "LevelRecord.h"
#include "SailLvRecord.h"
#include "LifeLvRecord.h"
#include "CommFunc.h"
#include "Character.h"
#include "Player.h"
#include "ItemAttr.h"
#include "SkillStateRecord.h"
#include "SkillState.h"
#include "HarmRec.h"
#include "lua_gamectrl.h"

CTimeSkillMgr	g_CTimeSkillMgr;
char	g_chItemFall[defCHA_INIT_ITEM_NUM + 1];

_DBC_USING


//=============================================================================
CFightAble::CFightAble() : m_CSkillState(SKILL_STATE_MAXID)
{T_B
	m_SFightInit.chTarType = 0;
	m_SFightProc.sState = enumFSTATE_TARGET_NO;
	m_SFightProc.sRequestState = 0;

	m_pCChaRecord = 0;

	m_usTickInterval = 100;
	m_bOnFight = false;
	m_uchFightID = 0;
T_E}

void CFightAble::Initially()
{T_B
	CAttachable::Initially();

	memset(&m_SFightInit, 0, sizeof(SFightInit));
	m_SFightInit.chTarType = 0;
	memset(&m_SFightInitCache, 0, sizeof(SFightInit));
	m_SFightInitCache.chTarType = 0;
	memset(&m_SFightProc, 0, sizeof(SFightProc));
	m_SFightProc.sState = enumFSTATE_TARGET_NO;

	m_CChaAttr.Clear();
	m_pCChaRecord = 0;
	m_CSkillState.ResetSkillState();
	m_CSkillBag.InitSkill();
	m_sDefSkillNo = 0;

	m_usTickInterval = 100;
	m_bOnFight = false;
	m_uchFightID = 0;

	m_bLookAttrChange = false;
T_E}

void CFightAble::Finally()
{T_B
	m_SFightInit.chTarType = 0;
	CAttachable::Finally();
T_E}

void CFightAble::WritePK(WPACKET& wpk)		//写入玩家本身及其所有附加结构(如召唤兽等)的所有数据
{T_B
	Entity::WritePK(wpk);
	//ToDo:写入自己的数据
    WRITE_SEQ(wpk, (cChar *)&m_CChaAttr, sizeof(m_CChaAttr));

T_E}

void CFightAble::ReadPK(RPACKET& rpk)		//重构玩家本身及其所有附加结构(如召唤兽等)
{T_B
	Entity::ReadPK(rpk);
	//ToDo:读出自己的数据
	uShort usLen;
	cChar *pData = READ_SEQ(rpk, usLen);
	memcpy(&m_CChaAttr, pData, sizeof(m_CChaAttr));

	m_SFightInit.chTarType = 0;
	m_SFightProc.sState = enumFSTATE_TARGET_NO;
	m_SFightProc.sRequestState = 0;

	m_bOnFight = false;
T_E}

void CFightAble::ResetFight()
{T_B
	m_SFightInit.chTarType = 0;
	m_SFightProc.sState = enumFSTATE_TARGET_NO;
	m_SFightProc.sRequestState = 0;

	m_bOnFight = false;
T_E}

bool CFightAble::DesireFightBegin(SFightInit *pSFightInit)
{T_B
	m_CChaAttr.ResetChangeFlag();
	m_CSkillState.ResetSkillStateChangeFlag();

	if (!IsRightSkillSrc(pSFightInit->pCSkillRecord->chHelpful))
	{
		//m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("拒绝战斗请求（非战斗型实体）\n\n");
		//m_CLog.Log("refuse battle request（isn't battle entity）\n\n");
		memcpy(&m_SFightInit, pSFightInit, sizeof(SFightInit));
		m_SFightProc.sState = enumFSTATE_OFF;
		NotiSkillSrcToSelf();
		SubsequenceFight();
		return false;
	}
	if (m_SFightProc.sState == enumFSTATE_ON)
	{
		//m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("拒绝战斗请求（战斗中）\n\n");
		//m_CLog.Log("refuse fight request（fighting..）\n\n");
		EndFight();
		return false;
	}

	// 可以使用技能
	SetExistState(enumEXISTS_FIGHTING);
	if (GetTickCount() - (uLong)pSFightInit->pSSkillGrid->lColdDownT > (uLong)GetSkillTime(pSFightInit->pCSkillTData))
	{
		memcpy(&m_SFightInit, pSFightInit, sizeof(SFightInit));
		m_SFightProc.sRequestState = 0;
		BeginFight();
	}
	else// if( m_SFightInit.pSSkillGrid != pSFightInit->pSSkillGrid )
	{
		//m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("缓存战斗请求（技能恢复中）\n\n");
		//m_CLog.Log("difer fight request（skill is resume）\n\n");
		memcpy(&m_SFightInitCache, pSFightInit, sizeof(SFightInit));
		m_SFightProc.sRequestState = 2;
		OnFightBegin();
		return true;
	}
	return true;
T_E}

void CFightAble::BeginFight()
{T_B
	// log
	if(m_CLog.GetEnable())
	{
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("===Recieve(Skill):\tTick %u\n", GetTickCount());
		m_CLog.Log("SkillID:\t%3d\n", m_SFightInit.pCSkillRecord->sID);
		m_CLog.Log("Target:\t%d, \t%d\n", m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2);
		m_CLog.Log("\n");
	}
	//

	m_SFightProc.sState = enumFSTATE_ON;
	m_uchFightID++;

	Square	STarShape = {{0, 0}, 0};
	Long	lReqDist = 0;
	if (!GetFightTargetShape(&STarShape)) // 目标不存在
	{
		m_SFightProc.sState = enumFSTATE_TARGET_NO;
		m_SFightInit.chTarType = 0;
		NotiSkillSrcToEyeshot();
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(BeginFight): 目标不存在\n");
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(BeginFight): aim inexistent\n");
		SubsequenceFight();
		
		// add by ryan wang 目标不存在, 也应该重置lColdDownT, 怀疑造成玩家被秒杀现象
		m_ulLastTick = GetTickCount();
		m_SFightInit.pSSkillGrid->lColdDownT = m_ulLastTick;
		//----------------------------------------------------------------------------
		return;
	}
	lReqDist = GetRadius() + STarShape.radius + m_SFightInit.pCSkillRecord->sApplyDistance;

	long	lDistX2 = (GetShape().centre.x - STarShape.centre.x) * (GetShape().centre.x - STarShape.centre.x);
	long	lDistY2 = (GetShape().centre.y - STarShape.centre.y) * (GetShape().centre.y - STarShape.centre.y);
	if (lDistX2 + lDistY2 <= lReqDist * lReqDist)
	{
		if (m_SFightInit.pCSkillRecord->chOperate[0] == 0) // 普通技能
		{
			//g_CParser.DoString(m_SFightInit.pCSkillRecord->szPrepare, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER, 1, m_SFightInit.pSSkillGrid->chLv, DOSTRING_PARAM_END);
			SkillGeneral((long)sqrt((double)lDistX2 + lDistY2));
		}
		else
		{
			m_SFightProc.sState = enumFSTATE_OFF;
			NotiSkillSrcToSelf();
		}

		m_ulLastTick = GetTickCount();
		m_SFightInit.pSSkillGrid->lColdDownT = m_ulLastTick;
		if (m_SFightProc.sState == enumFSTATE_ON)
		{
			OnFightBegin();
		}
	}
	else
	{
		// add by ryan wang 目标离开范围, 也应该重置lColdDownT, 怀疑造成玩家被秒杀现象
		m_ulLastTick = GetTickCount();
		m_SFightInit.pSSkillGrid->lColdDownT = m_ulLastTick;
		//----------------------------------------------------------------------------
		
		m_SFightProc.sState = enumFSTATE_TARGET_OUT;
		NotiSkillSrcToSelf();
	}
	if (m_SFightProc.sState)
	{
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(BeginFight)\n");
		SubsequenceFight();
	}
T_E}

void CFightAble::OnFight(uLong ulCurTick)
{T_B
	if (!m_bOnFight)
		return;

	uLong	ulTickDist = ulCurTick - m_ulLastTick;
	if (ulTickDist < m_usTickInterval)
		return;
	m_ulLastTick = ulCurTick;

	if (m_SFightProc.sState == enumFSTATE_ON)
		if (m_SFightInit.pSSkillGrid->chState != enumSUSTATE_ACTIVE // 未激活
			|| (m_SFightInit.pCSkillTData->lResumeTime == 0 && !IsCharacter()->GetActControl(enumACTCONTROL_USE_GSKILL)) // 不能使用物理技能
			|| (m_SFightInit.pCSkillTData->lResumeTime > 0 && !IsCharacter()->GetActControl(enumACTCONTROL_USE_MSKILL))) // 不能使用魔法技能
		{
			m_SFightProc.sState = enumFSTATE_CANCEL; // 被要求停止
			NotiSkillSrcToEyeshot();
			//m_CLog.Log("不合法的技能请求（存在不能使用技能的状态）[PacketID: %u]\n", m_ulPacketID);
			//m_CLog.Log("irregular skill request(exist cannot use skill state)[PacketID: %u]\n", m_ulPacketID);
			EndFight();
			return;
		}

	m_CChaAttr.ResetChangeFlag();
	m_CSkillState.ResetSkillStateChangeFlag();

	if (m_SFightProc.sRequestState == 1)
	{
		m_SFightProc.sState = enumFSTATE_CANCEL; // 被要求停止
		m_SFightProc.sRequestState = 0;
		NotiSkillSrcToEyeshot();
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(OnFight): 客户要求停止\n");
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(OnFight): client request cease\n");
		SubsequenceFight();
	}

	Square	STarShape = {{0, 0}, 0};
	Long	lReqDist = 0;
	if (m_SFightProc.sState == enumFSTATE_ON && !GetFightTargetShape(&STarShape)) // 目标不存在
	{
		m_SFightProc.sState = enumFSTATE_TARGET_NO;
		m_SFightInit.chTarType = 0;
		NotiSkillSrcToEyeshot();
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(OnFight): 目标不存在\n");
		//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OnEndFight(OnFight): aim inexistent\n");
		SubsequenceFight();
	}

	if (m_SFightProc.sState == enumFSTATE_ON)
	{
		lReqDist = GetRadius() + STarShape.radius + m_SFightInit.pCSkillRecord->sApplyDistance;

		long	lDistX2 = (GetShape().centre.x - STarShape.centre.x) * (GetShape().centre.x - STarShape.centre.x);
		long	lDistY2 = (GetShape().centre.y - STarShape.centre.y) * (GetShape().centre.y - STarShape.centre.y);
		if (lDistX2 + lDistY2 > lReqDist * lReqDist)
		{
			m_SFightProc.sState = enumFSTATE_TARGET_OUT; // 对象离开攻击范围
			NotiSkillSrcToEyeshot();
		}
		else
		{
			Long	lResumeT = GetSkillTime(m_SFightInit.pCSkillTData);
			Long	lResumeDist = ulCurTick - m_SFightInit.pSSkillGrid->lColdDownT;

			if (lResumeDist > lResumeT)
			{
				Short	sExecTime;
				if (lResumeT <= 0)
					sExecTime = 1;
				else
					sExecTime = Short(lResumeDist / lResumeT);

				// add by ryan wang, 解决玩家可能被秒杀问题, 源头在于技能计算流程过于混乱
				if(GetPlayer()==NULL)
				{
					if(sExecTime > 1)
					{
						//LG("skill_error", "[%s]使用[%s]技能, 间隔时间计算出错, 离上一次%d ms, 技能cooldown = %d\n", GetName(), m_SFightInit.pCSkillRecord->szName, lResumeDist, lResumeT);
						//LG("skill_error", "[%s] use [%s] skill, interval time account error, interval last time %d ms, skill cooldown = %d\n", GetName(), m_SFightInit.pCSkillRecord->szName, lResumeDist, lResumeT);
						sExecTime = 1; // 最多重置为1次, 防止玩家被秒杀
						m_SFightInit.pSSkillGrid->lColdDownT = ulCurTick - lResumeT; 
					}
				}
				//-----------------------------------------------------------------------

				if (m_SFightInit.pCSkillRecord->chOperate[0] == 0) // 普通技能
				{
					short i;
					for (i = 0; i < sExecTime; i++)
					{
						if (!SkillGeneral((long)sqrt((double)lDistX2 + lDistY2)))
							break;
					}
					m_SFightInit.pSSkillGrid->lColdDownT += lResumeT * i;
				}
				//else
					//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!在OnFight中执行的技能不是普通技能，这种情况不应该发生\n");
					//m_CLog.Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!in OnFight uesed skill cannot is common skill，such state did't occur\n");
			}
		}

		if (m_SFightProc.sState != enumFSTATE_ON)
			SubsequenceFight();
	}

	if (m_SFightProc.sState != enumFSTATE_ON)
	{
		if (m_SFightProc.sRequestState == 2)
		{
			if (ulCurTick - (uLong)m_SFightInitCache.pSSkillGrid->lColdDownT > (uLong)GetSkillTime(m_SFightInitCache.pCSkillTData)) // 存在缓存的战斗请求
			{
				memcpy(&m_SFightInit, &m_SFightInitCache, sizeof(SFightInit));
				m_SFightProc.sRequestState = 0;
				OnFightEnd();
				BeginFight();
				return;
			}
		}
		else
			OnFightEnd();
	}
T_E}

void CFightAble::EndFight()
{
	m_SFightProc.sRequestState = 1;
}

void CFightAble::SkillTarEffect(SFireUnit *pSFireSrc)
{
	// 因为调用次函数前已经确保了技能源的有效性，因此无需对此进一步判断
	CCharacter	*pSrcCha = pSFireSrc->pCFightSrc->IsCharacter();
	CCharacter	*pSrcMainC = 0;
	pSrcMainC = pSrcCha->GetPlyMainCha();
	if (pSrcMainC == pSrcCha)
		pSrcMainC = 0;

	g_uchFightID = pSFireSrc->uchFightID;

	pSrcCha->m_CChaAttr.ResetChangeFlag();
	pSrcCha->m_CSkillState.ResetSkillStateChangeFlag();
	if (pSrcMainC)
	{
		pSrcMainC->m_CChaAttr.ResetChangeFlag();
		pSrcMainC->m_CSkillState.ResetSkillStateChangeFlag();
		pSrcMainC->SetLookChangeFlag();
		pSrcMainC->SetEspeItemChangeFlag();
	}
	else
	{
		pSrcCha->SetLookChangeFlag();
		pSrcCha->SetEspeItemChangeFlag();
	}
	m_CChaAttr.ResetChangeFlag();
	m_CSkillState.ResetSkillStateChangeFlag();
	IsCharacter()->GetPlyMainCha()->SetLookChangeFlag();
	IsCharacter()->GetPlyMainCha()->SetEspeItemChangeFlag();

	// 技能效果计算
	m_SFightProc.bCrt = false;
	m_SFightProc.bMiss = false;

	Long	lOldHP = (long)m_CChaAttr.GetAttr(ATTR_HP);
	Long	lNowHP;
	Long	lSrcOldHP = (long)pSrcCha->m_CChaAttr.GetAttr(ATTR_HP);
	// 计算目标被攻击多少次后致死
	for (int i = 0; i < pSFireSrc->sExecTime; i++)
		g_CParser.DoString(pSFireSrc->pCSkillRecord->szEffect, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pSrcCha, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER, 1, pSrcCha->m_SFightInit.pSSkillGrid->chLv, DOSTRING_PARAM_END);
	lNowHP = (long)m_CChaAttr.GetAttr(ATTR_HP);
	BeUseSkill(lOldHP, lNowHP, pSrcCha, pSFireSrc->pCSkillRecord->chHelpful);

	// 判断是否是采矿技能
	if( m_CChaAttr.GetAttr(ATTR_CHATYPE) != enumCHACTRL_MONS_MINE && m_CChaAttr.GetAttr(ATTR_CHATYPE) != enumCHACTRL_MONS_TREE
		&& m_CChaAttr.GetAttr(ATTR_CHATYPE) != enumCHACTRL_MONS_FISH && m_CChaAttr.GetAttr(ATTR_CHATYPE) != enumCHACTRL_MONS_DBOAT)
	{
		// 
		if (lOldHP > 0 && lNowHP <= 0)
		{
			SetDie(pSrcCha);
		}
		if (lSrcOldHP > 0 && pSrcCha->m_CChaAttr.GetAttr(ATTR_HP) <= 0)
		{
			pSrcCha->SetDie(IsCharacter());
		}
	}
	else
	{
		// 采矿或者采木技能使得矿石不断被开采出来
		if(lNowHP <= 0)
		{
			// 矿或者木材被开采完毕
			SetExistState(enumEXISTS_WITHERING);
			m_SFightInit.chTarType = 0;
			m_SFightProc.sState = enumFSTATE_DIE;
			m_SExistCtrl.ulTick = GetTickCount();
			m_CSkillState.ResetSkillState();
		}

		Long lNumData;
		if (lNowHP <= 0)
			lNumData = lOldHP;
		else
			lNumData = lOldHP - lNowHP;
		// 计算掉出小矿石碎片
		for( int i = 0; i < lNumData; i++ )
		{
			// 根据技能等级有不同的等级的掉料率
			SpawnResource( pSrcCha, pSrcCha->m_SFightInit.pSSkillGrid->chLv );
		}

		/* 因为采矿或者采木不会有反弹攻击危险所以主角不需要计算采矿或者采木时生命是否死亡
		
		// 如果角色采矿或者采木时被反击则计算是否死亡
		if (pSrcCha->m_CChaAttr.GetAttr(ATTR_HP) <= 0)
		{
			bSrcDie = true;
			pSrcCha->SetExistState(enumEXISTS_WITHERING);
			pSrcCha->m_SFightInit.chTarType = 0;
			pSrcCha->m_SFightProc.sState = enumFSTATE_DIE;
			pSrcCha->m_SExistCtrl.ulTick = GetTickCount();
			pSrcCha->m_CSkillState.Reset();
		}
		*/
	}

	NotiSkillTarToEyeshot(pSFireSrc);
	RectifyAttr();
	IsCharacter()->GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
	IsCharacter()->GetPlyMainCha()->SynEspeItem();
	pSrcCha->RectifyAttr();
	if (pSrcMainC)
	{
		pSrcMainC->SynAttr(enumATTRSYN_ATTACK);
		pSrcMainC->SynSkillStateToEyeshot();
		pSrcMainC->RectifyAttr();
		pSrcMainC->SynLook(enumSYN_LOOK_CHANGE);
		pSrcMainC->SynEspeItem();
	}
	else
	{
		pSrcCha->SynLook(enumSYN_LOOK_CHANGE);
		pSrcCha->SynEspeItem();
	}
}

bool CFightAble::RectifyAttr()
{
	bool	bRectify = false;
	Long	lMaxHP = (long)m_CChaAttr.GetAttr(ATTR_MXHP);
	if (m_CChaAttr.GetAttr(ATTR_HP) > lMaxHP)
	{
		bRectify = true;
		m_CChaAttr.ResetChangeFlag();
		setAttr(ATTR_HP, lMaxHP);
	}
	Long	lMaxSP = (long)m_CChaAttr.GetAttr(ATTR_MXSP);
	if (m_CChaAttr.GetAttr(ATTR_SP) > lMaxSP)
	{
		if (!bRectify)
			m_CChaAttr.ResetChangeFlag();
		setAttr(ATTR_SP, lMaxSP);
	}

	if (bRectify)
		SynAttr(enumATTRSYN_RECTIFY);

	return bRectify;
}

// 返回值：0，失败。1，成功设置，但请求的值超过最大值。2，成功设置。
Long CFightAble::setAttr(int nIdx, LONG64 lValue, int nType)
{
	if (nIdx == ATTR_GD && lValue < 0)
		return m_CChaAttr.SetAttr(nIdx, 0);

	LONG64	lOldVal = m_CChaAttr.GetAttr(nIdx);

	Long	lRet = m_CChaAttr.SetAttr(nIdx, lValue);
	if (lRet != 2)
		return lRet;
	if (nType != 0)
		return lRet;
	if (IsCharacter() != IsCharacter()->GetPlyMainCha())
		return lRet;
	if (nIdx == ATTR_CEXP)
		CountLevel();
	else if (nIdx == ATTR_CSAILEXP)
		CountSailLevel();
	else if (ATTR_CLIFEEXP == nIdx )
		CountLifeLevel();

	AfterAttrChange(nIdx, lOldVal, m_CChaAttr.GetAttr(nIdx));

	return lRet;
}

void CFightAble::SetDie(CCharacter *pCSkillSrcCha)
{
	SetItemHostObj(0);
	SetExistState(enumEXISTS_WITHERING);
	m_SFightInit.chTarType = 0;
	m_SFightProc.sState = enumFSTATE_DIE;
	m_SExistCtrl.ulTick = GetTickCount();
	RemoveAllSkillState();
	m_CSkillState.ResetSkillState();

	CCharacter	*pCDieCha = this->IsCharacter();
	if (pCSkillSrcCha && pCSkillSrcCha != g_pCSystemCha)
	{
		pCDieCha->JustDie(pCSkillSrcCha);
	}

	pCDieCha->m_pHate->ClearHarmRec();

	if (pCDieCha->IsPlayerOwnCha() && pCSkillSrcCha && pCSkillSrcCha->IsPlayerOwnCha())
	{
		g_CParser.DoString("after_player_kill_player", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pCSkillSrcCha, pCDieCha, DOSTRING_PARAM_END);
	}
}

Long CFightAble::GetSkillTime(CSkillTempData *pCSkillTData)
{
	if (pCSkillTData->lResumeTime == 0) // 天生技能
		return (long)m_CChaAttr.GetAttr(ATTR_ASPD);
	else
		return pCSkillTData->lResumeTime;
}

void CFightAble::BeUseSkill(dbc::Long lPreHp, dbc::Long lNowHp, CCharacter *pCSrcCha, Char chSkillEffType)
{
	if (!pCSrcCha || pCSrcCha == g_pCSystemCha)
		return;

	if (chSkillEffType == enumSKILL_EFF_BANEFUL)
	{
		SetMonsterFightObj(pCSrcCha->GetID(), pCSrcCha->GetHandle());
		if (lPreHp != lNowHp)
		{
			CCharacter *pCha = IsCharacter();
			if(pCha->m_HostCha!=pCSrcCha) // 主人攻击不记入伤害记录
			{
				pCha->m_pHate->AddHarm(pCSrcCha, Short(lPreHp - lNowHp), pCSrcCha->GetID());
			}
		}
	}
}

void CFightAble::SetMonsterFightObj(uLong ulObjWorldID, Long lObjHandle)
{
	if (m_SFightInit.chTarType == 0 && m_CChaAttr.GetAttr(ATTR_CHATYPE) != enumCHACTRL_PLAYER)
	{
		m_SFightInit.chTarType = 1;
		m_SFightInit.lTarInfo1 = ulObjWorldID;
		m_SFightInit.lTarInfo2 = lObjHandle;
	}

}

void CFightAble::NotiSkillSrcToEyeshot(Short sExecTime)
{T_B
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_NOTIACTION);		// 命令2字节
	WRITE_LONG(pk, m_ID);	  				// ID
	WRITE_LONG(pk, m_ulPacketID);
	WRITE_CHAR(pk, enumACTION_SKILL_SRC);
	WRITE_CHAR(pk, m_uchFightID);
	WRITE_SHORT(pk, m_sAngle);
	WRITE_SHORT(pk, m_SFightProc.sState);
	if (m_SFightProc.sState & enumFSTATE_DIE)
		WRITE_SHORT(pk, enumEXISTS_WITHERING);
	else if (m_SFightProc.sState != enumFSTATE_ON)
		WRITE_SHORT(pk, m_SFightInit.sStopState);
	WRITE_LONG(pk, m_SFightInit.pCSkillRecord->sID);
	WRITE_LONG(pk, GetSkillTime(m_SFightInit.pCSkillTData));
	WRITE_CHAR(pk, m_SFightInit.chTarType);
	if (m_SFightInit.chTarType == 1)
	{
		WRITE_LONG(pk, m_SFightInit.lTarInfo1);
		Entity *pEnt = g_pGameApp->GetEntity(m_SFightInit.lTarInfo2);
		if (!pEnt)
		{
			WRITE_LONG(pk, GetShape().centre.x);
			WRITE_LONG(pk, GetShape().centre.y);
		}
		else
		{
			WRITE_LONG(pk, pEnt->GetShape().centre.x);
			WRITE_LONG(pk, pEnt->GetShape().centre.y);
		}
	}
	else if (m_SFightInit.chTarType == 2)
	{
		WRITE_LONG(pk, m_SFightInit.lTarInfo1);
		WRITE_LONG(pk, m_SFightInit.lTarInfo2);
	}
	WRITE_SHORT(pk, sExecTime);

	// 属性
	short sTempChangeNum = 0;
	short sAttrChangeNum = m_CChaAttr.GetChangeNumClient();
	WRITE_SHORT(pk, sAttrChangeNum);
	if (sAttrChangeNum > 0)
	{
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				if (sTempChangeNum >= sAttrChangeNum)
					//MessageBox(0, "属性变化个数的两个统计值不吻合", "错误", MB_OK);
					MessageBox(0, RES_STRING(GM_FIGHTALBE_CPP_00001), RES_STRING(GM_FIGHTALBE_CPP_00002), MB_OK);
				WRITE_CHAR(pk, i);
				if(i == ATTR_NLEXP ||i == ATTR_CLEXP||i == ATTR_CEXP)
					WRITE_LONGLONG(pk, m_CChaAttr.GetAttr(i));
				else
					WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(i));
				sTempChangeNum++;
			}
		}
	}
	// 状态
	sTempChangeNum = 0;
	uChar uchStateChangeNum = m_CSkillState.GetSkillStateChangeNum();
	if (uchStateChangeNum > 0)
	{
		WRITE_CHAR(pk, uchStateChangeNum);
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			//if (m_CSkillState.GetChangeBitFlag(pSStateUnit->GetStateID())) // 如果该状态有变，则压包
			{
				//if (sTempChangeNum >= uchStateChangeNum)
				//	MessageBox(0, "状态变化个数的两个统计值不吻合", "错误", MB_OK);
				WRITE_CHAR(pk, pSStateUnit->GetStateID());
				WRITE_CHAR(pk, pSStateUnit->GetStateLv());
				sTempChangeNum++;
			}
		}
	}
	else
		WRITE_CHAR(pk, 0);

	NotiChgToEyeshot(pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Skill Represent):\tFightID %u\tTick %u\n", m_uchFightID, GetTickCount());
		m_CLog.Log("SkillID:\t%d\n", m_SFightInit.pCSkillRecord->sID);
		if (m_SFightInit.chTarType == 1)
			m_CLog.Log("Target(ID):\t%u\n", m_SFightInit.lTarInfo1);
		else if (m_SFightInit.chTarType == 2)
			m_CLog.Log("Target(Pos):\t%d, \t%d\n", m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2);
		m_CLog.Log("Exec Time:\t%d\n", sExecTime);
		//m_CLog.Log("属性:[ID, Value]\n");
		m_CLog.Log("attribute:[ID, Value]\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				m_CLog.Log("\t%d, \t%d\n", i, m_CChaAttr.GetAttr(i));
			}
		}
		////m_CLog.Log("状态 %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		//m_CLog.Log("state %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		//SSkillStateUnit	*pSStateUnit;
		//m_CSkillState.BeginGetState();
		//while (pSStateUnit = m_CSkillState.GetNextState())
		//	m_CLog.Log("\t%d, %d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		//if (m_SFightProc.sState)
		//	m_CLog.Log("@@@EndSkill\tState:%d\n", m_SFightProc.sState);
		//m_CLog.Log("\n");
		//
	}
T_E}

void CFightAble::NotiSkillSrcToSelf(Short sExecTime)
{T_B
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_NOTIACTION);		//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WRITE_LONG(pk, m_ulPacketID);
	WRITE_CHAR(pk, enumACTION_SKILL_SRC);
	WRITE_CHAR(pk, m_uchFightID);
	WRITE_SHORT(pk, m_sAngle);
	WRITE_SHORT(pk, m_SFightProc.sState);
	if (m_SFightProc.sState & enumFSTATE_DIE)
		WRITE_SHORT(pk, enumEXISTS_WITHERING);
	else if (m_SFightProc.sState != enumFSTATE_ON)
		WRITE_SHORT(pk, m_SFightInit.sStopState);
	WRITE_LONG(pk, m_SFightInit.pCSkillRecord->sID);
	WRITE_LONG(pk, GetSkillTime(m_SFightInit.pCSkillTData));
	WRITE_CHAR(pk, m_SFightInit.chTarType);
	if (m_SFightInit.chTarType == 1)
	{
		WRITE_LONG(pk, m_SFightInit.lTarInfo1);
		Entity *pEnt = g_pGameApp->GetEntity(m_SFightInit.lTarInfo2);
		WRITE_LONG(pk, pEnt->GetShape().centre.x);
		WRITE_LONG(pk, pEnt->GetShape().centre.y);
	}
	else if (m_SFightInit.chTarType == 2)
	{
		WRITE_LONG(pk, m_SFightInit.lTarInfo1);
		WRITE_LONG(pk, m_SFightInit.lTarInfo2);
	}
	WRITE_SHORT(pk, sExecTime);

	// 属性
	short sTempChangeNum = 0;
	short sAttrChangeNum = m_CChaAttr.GetChangeNumClient();
	WRITE_SHORT(pk, sAttrChangeNum);
	if (sAttrChangeNum > 0)
	{
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				if (sTempChangeNum >= sAttrChangeNum)
					//MessageBox(0, "属性变化个数的两个统计值不吻合", "错误", MB_OK);
					MessageBox(0, RES_STRING(GM_FIGHTALBE_CPP_00001), RES_STRING(GM_FIGHTALBE_CPP_00002), MB_OK);
				WRITE_CHAR(pk, i);
				if (i==ATTR_NLEXP ||i==ATTR_CLEXP||i ==ATTR_CEXP)
				{
					WRITE_LONGLONG(pk, m_CChaAttr.GetAttr(i));
				}else
					WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(i));
				sTempChangeNum++;
			}
		}
	}
	// 状态
	sTempChangeNum = 0;
	uChar uchStateChangeNum = m_CSkillState.GetSkillStateChangeNum();
	if (uchStateChangeNum > 0)
	{
		WRITE_CHAR(pk, uchStateChangeNum);
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			if (m_CSkillState.GetSkillStateChangeBitFlag(pSStateUnit->GetStateID())) // 如果该状态有变，则压包
			{
				if (sTempChangeNum >= uchStateChangeNum)
					//MessageBox(0, "属性变化个数的两个统计值不吻合", "错误", MB_OK);
					MessageBox(0, RES_STRING(GM_FIGHTALBE_CPP_00001), RES_STRING(GM_FIGHTALBE_CPP_00002), MB_OK);
				WRITE_CHAR(pk, pSStateUnit->GetStateID());
				WRITE_CHAR(pk, pSStateUnit->GetStateLv());
				sTempChangeNum++;
			}
		}
	}
	else
		WRITE_CHAR(pk, 0);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Skill Represent):\tFightID %u\tTick %u\n", m_uchFightID, GetTickCount());
		m_CLog.Log("SkillID:\t%d\n", m_SFightInit.pCSkillRecord->sID);
		if (m_SFightInit.chTarType == 1)
			m_CLog.Log("Target(ID):\t%u\n", m_SFightInit.lTarInfo1);
		else if (m_SFightInit.chTarType == 2)
			m_CLog.Log("Target(Pos):\t%d, \t%d\n", m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2);
		m_CLog.Log("Exec Time:\t%d\n", sExecTime);
		//m_CLog.Log("属性:[ID, Value]\n");
		m_CLog.Log("state:[ID, Value]\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				m_CLog.Log("\t%d, \t%d\n", i, m_CChaAttr.GetAttr(i));
			}
		}
		//m_CLog.Log("状态 %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		m_CLog.Log("state  %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%d, %d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}

		if (m_SFightProc.sState)
			m_CLog.Log("@@@EndSkill\tState:%d\n", m_SFightProc.sState);
		m_CLog.Log("\n");
		//
	}
T_E}

void CFightAble::NotiSkillTarToEyeshot(SFireUnit *pSFireSrc)
{
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_NOTIACTION);	//命令2字节
	WRITE_LONG(pk, m_ID);	  			//ID
#ifdef defPROTOCOL_HAVE_PACKETID
	WRITE_LONG(pk, pSFireSrc->ulPacketID);
#endif
	WRITE_CHAR(pk, enumACTION_SKILL_TAR);
	WRITE_CHAR(pk, pSFireSrc->uchFightID);
	WRITE_SHORT(pk, m_SFightProc.sState);
	WRITE_CHAR(pk, m_SFightProc.bCrt);
	WRITE_CHAR(pk, m_SFightProc.bMiss);
	if (g_bBeatBack)
	{
		WRITE_CHAR(pk, 1);
		WRITE_LONG(pk, GetPos().x);
		WRITE_LONG(pk, GetPos().y);
		g_bBeatBack = false;
	}
	else
		WRITE_CHAR(pk, 0);
	WRITE_LONG(pk, pSFireSrc->ulID);
	WRITE_LONG(pk, pSFireSrc->SSrcPos.x);
	WRITE_LONG(pk, pSFireSrc->SSrcPos.y);
	WRITE_LONG(pk, pSFireSrc->pCSkillRecord->sID);
	WRITE_LONG(pk, pSFireSrc->lTarInfo1);
	WRITE_LONG(pk, pSFireSrc->lTarInfo2);
	WRITE_SHORT(pk, pSFireSrc->sExecTime);

	WriteAttr(pk, enumATTRSYN_ATTACK);
	if (m_CSkillState.GetSkillStateChangeNum() > 0)
	{
		WRITE_CHAR(pk, 1);
		WriteSkillState(pk);
	}
	else
		WRITE_CHAR(pk, 0);

	if (pSFireSrc->pCFightSrc != this)
	{
		WRITE_CHAR(pk, 1);
		WRITE_SHORT(pk, pSFireSrc->pCFightSrc->m_SFightProc.sState);
		pSFireSrc->pCFightSrc->WriteAttr(pk, enumATTRSYN_ATTACK);
		if (pSFireSrc->pCFightSrc->m_CSkillState.GetSkillStateChangeNum() > 0)
		{
			WRITE_CHAR(pk, 1);
			pSFireSrc->pCFightSrc->WriteSkillState(pk);
		}
		else
			WRITE_CHAR(pk, 0);
		//
	}
	else
		WRITE_CHAR(pk, 0);

	NotiChgToEyeshot(pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
	#ifdef defPROTOCOL_HAVE_PACKETID
		m_CLog.Log("$$$PacketID:\t%u\n", pSFireSrc->ulPacketID);
	#endif
		m_CLog.Log("###Send(Skill Effect):\tTick %u\n", GetTickCount());
		m_CLog.Log("SourceChaID:\t%u\n", pSFireSrc->ulID);
		m_CLog.Log("SkillID:\t%d\n", pSFireSrc->pCSkillRecord->sID);
		m_CLog.Log("Exec Time:\t%d\n", pSFireSrc->sExecTime);
		//m_CLog.Log("属性:[ID, Value]\n");
		m_CLog.Log("state:[ID, Value]\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				m_CLog.Log("\t%d, \t%d\n", i, m_CChaAttr.GetAttr(i));
			}
		}
		//m_CLog.Log("状态 %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		m_CLog.Log("state  %d:[ID, LV]\n", m_CSkillState.GetStateNum());
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%d, %d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}
		if (m_SFightProc.sState == enumFSTATE_DIE)
			m_CLog.Log("@@@Die\n");
		//m_CLog.Log("技能源属性:[ID, Value]\n");
		m_CLog.Log("skill attribute:[ID, Value]\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (pSFireSrc->pCFightSrc->m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				m_CLog.Log("\t%d, \t%d\n", i, pSFireSrc->pCFightSrc->m_CChaAttr.GetAttr(i));
			}
		}
		//m_CLog.Log("技能源状态 %d:[ID, LV]\n", pSFireSrc->pCFightSrc->m_CSkillState.GetStateNum());
		m_CLog.Log("skill attribute %d:[ID, LV]\n", pSFireSrc->pCFightSrc->m_CSkillState.GetStateNum());
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = pSFireSrc->pCFightSrc->m_CSkillState.m_SStateMap.begin(); it != pSFireSrc->pCFightSrc->m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		pSFireSrc->pCFightSrc->m_CSkillState.BeginGetState();
		while (pSStateUnit = pSFireSrc->pCFightSrc->m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%d, %d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}
		if (pSFireSrc->pCFightSrc->m_SFightProc.sState == enumFSTATE_DIE)
			m_CLog.Log("@@@Die\n");
		m_CLog.Log("\n");
		//
	}
}

void CFightAble::SynAttr(Short sType)
{T_B
	short	sAttrChangeNum = m_CChaAttr.GetChangeNumClient();
	if (sAttrChangeNum == 0)
		return;

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNATTR);		//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WriteAttr(pk, sType);

	NotiChgToEyeshot(pk, true);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization Attribute):\tTick %u\n\n", GetTickCount());
		//m_CLog.Log("\t属性编号\t属性值\n");
		m_CLog.Log("\t attribute number\t attribute value\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
				m_CLog.Log("\t%d\t%u\n", i, m_CChaAttr.GetAttr(i));
		}
		//
	}
T_E}

void CFightAble::SynAttrToSelf(Short sType)
{T_B
	short	sAttrChangeNum = m_CChaAttr.GetChangeNumClient();
	if (sAttrChangeNum == 0)
		return;

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNATTR);		//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WriteAttr(pk, sType);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization Attribute):\tTick %u\n\n", GetTickCount());
		//m_CLog.Log("\t属性编号\t属性值\n");
		m_CLog.Log("\tattribute number\tattribute value\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
				m_CLog.Log("\t%d\t%u\n", i, m_CChaAttr.GetAttr(i));
		}
		//
	}
T_E}

void CFightAble::SynAttrToEyeshot(Short sType) //不包括自己
{T_B
	short	sAttrChangeNum = m_CChaAttr.GetChangeNumClient();
	if (sAttrChangeNum == 0)
		return;

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNATTR);		//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WriteAttr(pk, sType);

	NotiChgToEyeshot(pk, false);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization Attribute):\tTick %u\n\n", GetTickCount());
		//m_CLog.Log("\t属性编号\t属性值\n");
		m_CLog.Log("\tattribute number\tattribute value\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
				m_CLog.Log("\t%d\t%u\n", i, m_CChaAttr.GetAttr(i));
		}
		//
	}
T_E}

// 将pCObj的属性通告给自己
void CFightAble::SynAttrToUnit(CFightAble *pCObj, Short sType)
{T_B
	if (!pCObj)
		return;

	short	sAttrChangeNum = pCObj->m_CChaAttr.GetChangeNumClient();
	if (sAttrChangeNum == 0)
		return;

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNATTR);		//命令2字节
	WRITE_LONG(pk, pCObj->GetID());		//ID
	pCObj->WriteAttr(pk, sType);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization %s Attribute to own):\tTick %u\n\n", pCObj->m_CLog.GetLogName(), GetTickCount());
		//m_CLog.Log("\t属性编号\t属性值\n");
		m_CLog.Log("\tattribute number\tattribute value\n");
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (pCObj->m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
				m_CLog.Log("\t%d\t%u\n", i, pCObj->m_CChaAttr.GetAttr(i));
		}
		//
	}
T_E}

// 将pCObj的属性通告给自己
void CFightAble::SynAttrToUnit(CFightAble *pCObj, Short sStartAttr, Short sEndAttr, Short sType)
{T_B
	if (!pCObj)
		return;

	if (sEndAttr >= ATTR_CLIENT_MAX)
		return;

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNATTR);		//命令2字节
	WRITE_LONG(pk, pCObj->GetID());		//ID
	pCObj->WriteAttr(pk, sStartAttr, sEndAttr, sType);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization %s Attribute to own):\tTick %u\n\n", pCObj->m_CLog.GetLogName(), GetTickCount());
		//m_CLog.Log("\t属性编号\t属性值\n");
		m_CLog.Log("\tattribute number\tattribute value\n");
		for (int i = sStartAttr; i <= sEndAttr; i++)
		{
			m_CLog.Log("\t%d\t%u\n", i, pCObj->m_CChaAttr.GetAttr(i));
		}
		//
	}
T_E}

void CFightAble::SynSkillStateToSelf()
{T_B
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNASKILLSTATE);	//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WriteSkillState(pk);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization Skill State): StateNum[%d]\tTick %u\n", m_CSkillState.GetStateNum(), GetTickCount());
		//m_CLog.Log("\t编号\t等级\n");
		m_CLog.Log("\tnumber\tgrade\n");
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%4d\t%4d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}
		m_CLog.Log("\n");
		//
	}
T_E}

void CFightAble::SynSkillStateToEyeshot()
{T_B
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_SYNASKILLSTATE);	//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WriteSkillState(pk);

	NotiChgToEyeshot(pk, true);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization Skill State): StateNum[%d]\tTick %u\n", m_CSkillState.GetStateNum(), GetTickCount());
		//m_CLog.Log("\t编号\t等级\n");
		m_CLog.Log("\tnumber\tgrade\n");;
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%4d\t%4d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}
		m_CLog.Log("\n");
		//
	}
T_E}

// 将pCObj的技能状态通告给自己
void CFightAble::SynSkillStateToUnit(CFightAble *pCObj)
{T_B
	if (!pCObj)
		return;
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_SYNASKILLSTATE);	//命令2字节
	WRITE_LONG(pk, pCObj->GetID());		//ID
	pCObj->WriteSkillState(pk);

	ReflectINFof(this,pk);//通告

	if (m_CLog.GetEnable())
	{
		// log
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		m_CLog.Log("###Send(Synchronization %s SkillState to own): StateNum[%d]\tTick %u\n", pCObj->m_CLog.GetLogName(), pCObj->m_CSkillState.GetStateNum(), GetTickCount());
		//m_CLog.Log("\t编号\t等级\n");
		m_CLog.Log("\tnumber\tgrade\n");;
		SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = pCObj->m_CSkillState.m_SStateMap.begin(); it != pCObj->m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		pCObj->m_CSkillState.BeginGetState();
		while (pSStateUnit = pCObj->m_CSkillState.GetNextState())
		{
#endif
			m_CLog.Log("\t%4d\t%4d\n", pSStateUnit->GetStateID(), pSStateUnit->GetStateLv());
		}
		m_CLog.Log("\n");
		//
	}
T_E}

void CFightAble::SynLookEnergy(void)
{
	CCharacter	*pCMainCha = IsCharacter()->GetPlyMainCha();

	WPACKET WtPk=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
	WRITE_LONG(WtPk, pCMainCha->GetID());
	WRITE_LONG(WtPk, pCMainCha->m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_LOOK_ENERGY);

	pCMainCha->WriteLookEnergy(WtPk);
	pCMainCha->ReflectINFof(this,WtPk);//通告
}

void CFightAble::WriteSkillState(WPACKET& pk) {
	WRITE_LONG(pk, GetTickCount()); // current time
	WRITE_CHAR(pk, m_CSkillState.GetStateNum());
	SSkillStateUnit* pSStateUnit;
	m_CSkillState.BeginGetState();
	while (pSStateUnit = m_CSkillState.GetNextState()) {
		WRITE_CHAR(pk, pSStateUnit->GetStateID());
		WRITE_CHAR(pk, pSStateUnit->GetStateLv());
		// end time = pSStateUnit->lOnTick + pSStateUnit->ulStartTick
		if (pSStateUnit->lOnTick < 1) {
			WRITE_LONG(pk, 0); // current time
			WRITE_LONG(pk, 0); // current time
		} else {
			WRITE_LONG(pk, pSStateUnit->lOnTick);     // duration
			WRITE_LONG(pk, pSStateUnit->ulStartTick); // start time
		}
	}
}
//技能ID，等级，时间
void CFightAble::WriteSkillStateMore(WPACKET &pk)
{
	WRITE_CHAR(pk, m_CSkillState.GetStateNum());
	SSkillStateUnit	*pSStateUnit;
#ifdef COMPACT_MEM_2
	for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
	{
		pSStateUnit = &it->second;
#else
	m_CSkillState.BeginGetState();
	while (pSStateUnit = m_CSkillState.GetNextState())
	{
#endif
		WRITE_CHAR(pk, pSStateUnit->GetStateID());
		WRITE_CHAR(pk, pSStateUnit->GetStateLv());
		WRITE_LONG(pk, pSStateUnit->lOnTick);
	}
}

void CFightAble::WriteAttr(WPACKET &pk, Short sSynType)
{
	short	sAttrChangeNum = m_CChaAttr.GetChangeNumClient();

	WRITE_CHAR(pk, (Char)sSynType);
	WRITE_SHORT(pk, sAttrChangeNum);
	if (sAttrChangeNum > 0)
	{
		for (int i = 0; i < ATTR_CLIENT_MAX; i++)
		{
			if (m_CChaAttr.GetChangeBitFlag(i)) // 如果该属性有变，则压包
			{
				WRITE_CHAR(pk, i);
				if (i==ATTR_NLEXP ||i==ATTR_CLEXP||i ==ATTR_CEXP)
				{
					WRITE_LONGLONG(pk, m_CChaAttr.GetAttr(i));
				}else
					WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(i));
				
				//char val[32];
				//_i64toa(m_CChaAttr.GetAttr(i), val, 10);
				//LG( "Fight", "ID = %d Val = %s \r\n" ,i, val);
			}
		}
	}
}

void CFightAble::WriteMonsAttr(WPACKET &pk, Short sSynType)
{
	WRITE_CHAR(pk, (Char)sSynType);
	WRITE_SHORT(pk, 5);

	WRITE_CHAR(pk, ATTR_LV);
	WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(ATTR_LV));
	WRITE_CHAR(pk, ATTR_HP);
	WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(ATTR_HP));
	WRITE_CHAR(pk, ATTR_MXHP);
	WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(ATTR_MXHP));
	WRITE_CHAR(pk, ATTR_ASPD);
	WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(ATTR_ASPD));
	WRITE_CHAR(pk, ATTR_MSPD);
	WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(ATTR_MSPD));
}

void CFightAble::WriteAttr(WPACKET &pk, dbc::Short sStartAttr, dbc::Short sEndAttr, Short sSynType)
{
	short	sAttrChangeNum = m_CChaAttr.GetChangeNumClient();

	WRITE_CHAR(pk, (Char)sSynType);
	WRITE_SHORT(pk, sEndAttr - sStartAttr + 1);
	for (int i = sStartAttr; i <= sEndAttr; i++)
	{
		WRITE_CHAR(pk, i);
		if (i==ATTR_NLEXP ||i==ATTR_CLEXP||i ==ATTR_CEXP)
		{
			WRITE_LONGLONG(pk, m_CChaAttr.GetAttr(i));
		}else
			WRITE_LONG(pk, (long)m_CChaAttr.GetAttr(i));
	}
}

void CFightAble::WriteLookEnergy(WPACKET &pk)
{
	SItemGrid *pItem;
	for (int i = 0; i < enumEQUIP_NUM; i++)
	{
		pItem = IsCharacter()->m_SChaPart.SLink + i;
		if (!g_IsRealItemID(pItem->sID))
			WRITE_SHORT(pk, 0);
		else
			WRITE_SHORT(pk, pItem->sEnergy[0]);
	}
}

bool CFightAble::GetFightTargetShape(Square *pSTarShape)
{T_B
	if (m_SFightInit.chTarType == 1) // 目标是物体
	{
		Entity	*pTarObj = g_pGameApp->IsMapEntity(m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2);
		if (!pTarObj)
			return false;
		if (pSTarShape)
		{
			*pSTarShape = pTarObj->GetShape();
		}
	}
	else if (m_SFightInit.chTarType == 2) // 目标是点
	{
		if (pSTarShape)
		{
			pSTarShape->centre.x = m_SFightInit.lTarInfo1;
			pSTarShape->centre.y = m_SFightInit.lTarInfo2;
			pSTarShape->radius = 0;
		}
	}

	return true;
T_E}

bool CFightAble::SkillExpend(Short sExecTime)
{
	CCharacter	*pCMainCha = this->IsCharacter();
	if (GetPlayer())
		pCMainCha = GetPlayer()->GetMainCha();
	if (pCMainCha != this->IsCharacter())
		pCMainCha->m_CChaAttr.ResetChangeFlag();
	pCMainCha->SetLookChangeFlag();
	// 消耗SP
	if (m_SFightInit.pCSkillTData->sUseSP > 0)
	{
		if (m_SFightInit.pCSkillTData->sUseSP * sExecTime > pCMainCha->m_CChaAttr.GetAttr(ATTR_SP))
		{
			m_SFightProc.sState |= enumFSTATE_NO_EXPEND;
			NotiSkillSrcToEyeshot(sExecTime);
			return false;
		}
		else
			pCMainCha->setAttr(ATTR_SP, pCMainCha->m_CChaAttr.GetAttr(ATTR_SP) - m_SFightInit.pCSkillTData->sUseSP * sExecTime);
	}

	// 消耗能量
	Short	sNeedEnergy = m_SFightInit.pCSkillTData->sUseEnergy * sExecTime;
	if (sNeedEnergy > 0)
	{
		SItemGrid	*pGrid;
		for (int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
		{
			if (m_SFightInit.pCSkillRecord->sConchNeed[i][0] == cchSkillRecordKeyValue)
				break;

			pGrid = pCMainCha->m_SChaPart.SLink + m_SFightInit.pCSkillRecord->sConchNeed[i][0];
			if (!g_IsRealItemID(pGrid->sID))
				continue;
			sNeedEnergy -= pGrid->sEnergy[0];
			if (sNeedEnergy <= 0)
				break;
		}

		if (sNeedEnergy > 0) // 能量不足
		{
			m_SFightProc.sState |= enumFSTATE_NO_EXPEND;
			NotiSkillSrcToEyeshot(sExecTime);
			return false;
		}
		else
		{
			sNeedEnergy = m_SFightInit.pCSkillTData->sUseEnergy * sExecTime;
			SItemGrid	*pGrid;
			for (int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
			{
				pGrid = pCMainCha->m_SChaPart.SLink + m_SFightInit.pCSkillRecord->sConchNeed[i][0];
				if (!g_IsRealItemID(pGrid->sID))
					continue;
				sNeedEnergy -= pGrid->sEnergy[0];
				if (sNeedEnergy > 0)
					pGrid->SetInstAttr(ITEMATTR_ENERGY, 0);
				else if (sNeedEnergy == 0)
				{
					pGrid->SetInstAttr(ITEMATTR_ENERGY, 0);
					break;
				}
				else
				{
					pGrid->SetInstAttr(ITEMATTR_ENERGY, -1 * sNeedEnergy);
					break;
				}
			}
		}
	}

	// 执行脚本
	if (strcmp(m_SFightInit.pCSkillRecord->szUse, "0"))
		g_CParser.DoString(m_SFightInit.pCSkillRecord->szUse, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER, 1, m_SFightInit.pSSkillGrid->chLv, DOSTRING_PARAM_END);
	if (m_SFightProc.sState == enumFSTATE_NO_EXPEND)
	{
		NotiSkillSrcToEyeshot(sExecTime);
		return false;
	}

	if (pCMainCha != this->IsCharacter())
		pCMainCha->SynAttrToSelf(enumATTRSYN_ATTACK);
	pCMainCha->SynLook(enumSYN_LOOK_CHANGE);

	return true;
}

void CFightAble::RangeEffect(SFireUnit *pSFireSrc, SubMap *pCMap, Long *plRangeBParam)
{
	CCharacter *pCFightObj;

	if (!pCMap)
		return;

	Long	lEParam[defSKILL_RANGE_EXTEP_NUM];
	for (short i = 0; i < defSKILL_RANGE_EXTEP_NUM; i++)
		lEParam[i] = pSFireSrc->pCSkillTData->sRange[i];
	pCMap->BeginSearchInRange(plRangeBParam, lEParam, true);
	while (pCFightObj = pCMap->GetNextCharacterInRange())
	{
		if (!pCFightObj->IsLiveing()) // 对方已经死亡
			continue;

		if (!pCFightObj->IsRightSkillTar(this,
			pSFireSrc->pCSkillRecord->chApplyTarget, pSFireSrc->pCSkillRecord->chTarType, pSFireSrc->pCSkillRecord->chHelpful, true))
			continue;

		pCFightObj->SkillTarEffect(pSFireSrc);
		if (m_SFightProc.sState & enumFSTATE_DIE) // 自己死亡
		{
			//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
			//m_CLog.Log("!!!death\tTick %u\n", GetTickCount());
			Die();
			return;
		}
		if (pCFightObj->m_SFightProc.sState & enumFSTATE_DIE) // 对方受攻击后死亡
		{
			//pCFightObj->m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
			//m_CLog.Log("!!!death\tTick %u\n", GetTickCount());
			pCFightObj->Die();

			if (pSFireSrc->pCSkillRecord->chPlayTime && pSFireSrc->pCSkillRecord->chApplyType != 2)
			{
				m_CChaAttr.ResetChangeFlag();
				m_CSkillState.ResetSkillStateChangeFlag();

				m_SFightInit.chTarType = 0;
				m_SFightProc.sState = enumFSTATE_TARGET_DIE;
				NotiSkillSrcToEyeshot();
			}
		}
	}

	if (pSFireSrc->pCSkillTData->sStateParam[0] != SSTATE_NONE)
	{
		pCMap->RangeAddState(pSFireSrc->uchFightID, pSFireSrc->pCFightSrc->GetID(), pSFireSrc->pCFightSrc->GetHandle(),
			pSFireSrc->pCSkillRecord->chApplyTarget, pSFireSrc->pCSkillRecord->chTarType, pSFireSrc->pCSkillRecord->chHelpful,
			pSFireSrc->pCSkillTData->sStateParam);
	}
}

//=============================================================================
// lDist 到技能目标位置的距离（厘米）。sExecTime 技能的执行次数
// 技能成功使用，返回true。否则返回false。
//=============================================================================
bool CFightAble::SkillGeneral(Long lDist, Short sExecTime) // 普通技能
{
	if (!m_SFightInit.pCSkillRecord->chPlayTime) // 只使用一次技能
		m_SFightProc.sState |= enumFSTATE_STOP;

	if (IsCharacter()->IsPlayerCha())
		if (!SkillExpend())
			return false;

	if (m_SFightInit.chTarType == 2) // 对象是坐标
	{
		g_SSkillPoint.x = m_SFightInit.lTarInfo1;
		g_SSkillPoint.y = m_SFightInit.lTarInfo2;

		Point SrcPos = GetPos();
		Point TarPos = {m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2};
		if (SrcPos != TarPos)
			SetAngle(arctan(SrcPos, TarPos));
		NotiSkillSrcToEyeshot(sExecTime);

		if (m_SFightInit.pCSkillTData->sRange[0] == enumRANGE_TYPE_STICK || m_SFightInit.pCSkillTData->sRange[0] == enumRANGE_TYPE_FAN)
		{
			m_SFightProc.lERangeBParam[0] = GetPos().x;
			m_SFightProc.lERangeBParam[1] = GetPos().y;
		}
		else
		{
			m_SFightProc.lERangeBParam[0] = m_SFightInit.lTarInfo1;
			m_SFightProc.lERangeBParam[1] = m_SFightInit.lTarInfo2;
		}
		m_SFightProc.lERangeBParam[2] = GetAngle();

		SFireUnit SFire;
#ifdef defPROTOCOL_HAVE_PACKETID
		SFire.ulPacketID = m_ulPacketID;
#endif
		SFire.uchFightID = m_uchFightID;
		SFire.pCFightSrc = this;
		SFire.ulID = GetID();
		SFire.SSrcPos = GetPos();
		SFire.lTarInfo1 = m_SFightInit.lTarInfo1;
		SFire.lTarInfo2 = m_SFightInit.lTarInfo2;
		SFire.pCSkillRecord = m_SFightInit.pCSkillRecord;
		SFire.pCSkillTData = m_SFightInit.pCSkillTData;
		SFire.sExecTime = sExecTime;

		if (m_SFightInit.pCSkillRecord->sSkySpd > 0)
		{
			uLong ulLeftTime = lDist * 1000 / m_SFightInit.pCSkillRecord->sSkySpd;
			g_CTimeSkillMgr.Add(&SFire, ulLeftTime, m_submap, &TarPos, m_SFightProc.lERangeBParam);
		}
		else if (m_SFightInit.pCSkillRecord->sSkySpd == 0)// 无需计算飞行时间
			RangeEffect(&SFire, m_submap, m_SFightProc.lERangeBParam);
		else {} // 未定义
	}
	else if (m_SFightInit.chTarType == 1) // 对象是ID
	{
		Entity	*pTarObj = g_pGameApp->IsMapEntity(m_SFightInit.lTarInfo1, m_SFightInit.lTarInfo2);
		if (!pTarObj) // 目标不存在
		{
			m_SFightProc.sState = enumFSTATE_TARGET_NO;
			NotiSkillSrcToEyeshot();
			return false;
		}

		CCharacter	*pObjCha = pTarObj->IsCharacter();

		if (!pObjCha->IsRightSkillTar(this,
			m_SFightInit.pCSkillRecord->chApplyTarget, m_SFightInit.pCSkillRecord->chTarType, m_SFightInit.pCSkillRecord->chHelpful)) // 目标不合法
		{
			m_SFightProc.sState = enumFSTATE_TARGET_IMMUNE;
			NotiSkillSrcToEyeshot();
			m_SFightInit.chTarType = 0;
			IsCharacter()->m_AITarget = 0;
			IsCharacter()->m_pHate->ClearHarmRecByCha(pObjCha);
			return false;
		}

		if (GetPos() != pTarObj->GetPos())
			SetAngle(arctan(GetPos(), pTarObj->GetPos()));
		NotiSkillSrcToEyeshot(sExecTime);

		m_SFightProc.lERangeBParam[0] = pTarObj->GetPos().x;
		m_SFightProc.lERangeBParam[1] = pTarObj->GetPos().y;
		m_SFightProc.lERangeBParam[2] = GetAngle();

		SFireUnit SFire;
#ifdef defPROTOCOL_HAVE_PACKETID
		SFire.ulPacketID = m_ulPacketID;
#endif
		SFire.uchFightID = m_uchFightID;
		SFire.pCFightSrc = this;
		SFire.ulID = GetID();
		SFire.SSrcPos = GetPos();
		SFire.lTarInfo1 = m_SFightInit.lTarInfo1;
		SFire.lTarInfo2 = m_SFightInit.lTarInfo2;
		SFire.pCSkillRecord = m_SFightInit.pCSkillRecord;
		SFire.pCSkillTData = m_SFightInit.pCSkillTData;
		SFire.sExecTime = sExecTime;

		if (m_SFightInit.pCSkillRecord->chApplyType == 3) // 溅射技能，范围伤害
			RangeEffect(&SFire, m_submap, m_SFightProc.lERangeBParam);
		else
		{
			bool	bTarIsLive = pObjCha->IsLiveing();
			pObjCha->SkillTarEffect(&SFire);


			if (m_SFightProc.sState & enumFSTATE_DIE) // 自己死亡
			{
				//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
				//m_CLog.Log("!!!death\tTick %u\n", GetTickCount());
				Die();
				return true;
			}

			if (pObjCha->m_SFightProc.sState & enumFSTATE_DIE) // 对方受攻击后死亡
			{
				m_SFightInit.chTarType = 0;
				if (m_SFightProc.sState == enumFSTATE_ON)
				{
					m_CChaAttr.ResetChangeFlag();
					m_CSkillState.ResetSkillStateChangeFlag();

					m_SFightProc.sState = enumFSTATE_TARGET_DIE;
					NotiSkillSrcToEyeshot();
				}

				//pObjCha->m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
				//m_CLog.Log("!!!death\tTick %u\n", GetTickCount());
				if (bTarIsLive)
					pObjCha->Die();
			}
		}
	}

	return true;
}

// 该例程内部的语句顺序非常严格，不可随便更改！！！
CCharacter* CFightAble::SkillPopBoat(Long lPosX, Long lPosY, Short sDir) // 放船
{T_B
	CCharacter	*pCCha = 0;

	Short	sUnitWidth, sUnitHeight;
	Short	sUnitX, sUnitY;
	uShort	usAreaAttr;

	m_submap->GetTerrainCellSize(&sUnitWidth, &sUnitHeight);
	sUnitX = static_cast<Short>(lPosX / sUnitWidth);
	sUnitY = static_cast<Short>(lPosY / sUnitHeight);
	m_submap->GetTerrainCellAttr(sUnitX, sUnitY, usAreaAttr);

	if (g_IsSea(usAreaAttr)) // 目标点是水域
	{
		Point		SPos = {lPosX, lPosY};
		if (sDir == -1)
			sDir = GetAngle();
		pCCha = GetSubMap()->ChaSpawn(302, enumCHACTRL_PLAYER, sDir, &SPos, true, GetName(), 0);
		if (pCCha)
		{
			pCCha->SetShip(g_pGameApp->m_CabinHeap.Get());

			SSkillGrid	SSkillCont;
			SSkillCont.chState = enumSUSTATE_ACTIVE;
			SSkillCont.sID = 39;	// “登陆“技能
			SSkillCont.chLv = 1;
			pCCha->m_CSkillBag.AddSkill(&SSkillCont);

			pCCha->SetShipMaster(pCCha->IsAttachable());
		}
	}

	return pCCha;
T_E}

// 该例程内部的语句顺序非常严格，不可随便更改！！！
bool CFightAble::SkillPopBoat(CCharacter *pCBoat, Long lPosX, Long lPosY, Short sDir) // 放船
{
	if (GetSubMap())
	{
		if (sDir == -1)
			sDir = GetAngle();
		pCBoat->SetAngle(sDir);

		Square	SEntShape = {{lPosX, lPosY}, pCBoat->GetRadius()};

		SubMap	*pCTempMap = pCBoat->GetSubMap();
		pCBoat->SetSubMap(GetSubMap());
		if (!pCBoat->GetSubMap()->EnsurePos(&SEntShape, pCBoat))
		{
			pCBoat->SetSubMap(pCTempMap);
			return false;
		}
		pCBoat->SetSideID(IsCharacter()->GetSideID());
		SEntShape.centre = pCBoat->GetPos();
		if (!pCBoat->GetSubMap()->Enter(&SEntShape, pCBoat))
			return false;
		pCBoat->SetBirthMap(pCBoat->GetSubMap()->GetName());
	}

	pCBoat->SetShipMaster(pCBoat->IsAttachable());

	return true;
}

// 该例程内部的语句顺序非常严格，不可随便更改！！！
bool CFightAble::SkillInBoat(CCharacter *pCBoat) // 上船
{T_B
	// 取消所有非计时技能产生的状态
	RemoveOtherSkillState();

	// 更换主角
	Point	SUpPos = GetPos();
	if (GetSubMap())
	{
		GetSubMap()->MoveTo(this, pCBoat->GetPos());
		NotiChangeMainCha(pCBoat->GetID());
	}
	if (m_pCPlayer == pCBoat->GetPlayer())
		m_pCPlayer->SetCtrlCha(pCBoat);
	pCBoat->GetShip()->Add(this);
	SetShipMaster(pCBoat->IsAttachable());
	if (GetSubMap())
	{
		BreakAction();
		m_CSkillState.ResetSkillState();
		m_submap->GoOut(this);
		SetPos(SUpPos), m_lastpos = SUpPos;

		m_CSkillBag.SetChangeSkillFlag(false);
		pCBoat->SkillRefresh();
		IsCharacter()->SynSkillBag(enumSYN_SKILLBAG_MODI);
		m_pCPlayer->SetLoginCha(enumLOGIN_CHA_BOAT, (long)pCBoat->getAttr(ATTR_BOAT_DBID));
		pCBoat->SynPKCtrl();
	}

	return true;
T_E}

// 该例程内部的语句顺序非常严格，不可随便更改！！！
bool CFightAble::SkillOutBoat(Long lPosX, Long lPosY, Short sDir) // 下船
{T_B
	// 取消所有非计时技能产生的状态
	RemoveOtherSkillState();

	CAttachable	*pOutObj = this;
	CAttachable	*pCShipM = GetShipMaster();
	if (!pCShipM)
		return false;

	if (pCShipM == this) // 主控者下船
	{
		if (!(pOutObj = GetShip()->GetLeader()))
			return false;
	}

	SubMap	*pCMap = pCShipM->GetSubMap();
	Point	STarPos = {lPosX, lPosY};
	Square	SShape = {STarPos, GetRadius()};

	SubMap	*pCTempMap = pOutObj->GetSubMap();
	pOutObj->SetSubMap(pCMap);
	if (!pOutObj->GetSubMap()->EnsurePos(&SShape, pOutObj))
	{
		pOutObj->SetSubMap(pCTempMap);
		return false;
	}

	pOutObj->IsCharacter()->SetSideID(IsCharacter()->GetSideID());
	CPlayer	*pCPlayer = pOutObj->GetPlayer();
	if (sDir == -1)
		sDir = GetAngle();
	pOutObj->SetAngle(sDir);
	bool	bEntSuc = pCMap->Enter(&SShape, pOutObj);
	if (!bEntSuc)
		return false;
	else
	{
		// 更换主角
		pCMap->MoveTo(this, pOutObj->GetPos());
		NotiChangeMainCha(pOutObj->GetID());
		if (pCPlayer == pCShipM->GetPlayer())
			m_pCPlayer->SetCtrlCha(pOutObj->IsCharacter());
		pOutObj->SetShipMaster(0);
		//

		CCharacter	*pCCha = pOutObj->IsCharacter();
		pCCha->m_CSkillBag.SetChangeSkillFlag(false);
		pCCha->SkillRefresh();
		pCCha->SynSkillBag(enumSYN_SKILLBAG_MODI);
		pCCha->SetBirthMap(pCMap->GetName());
		pCPlayer->SetLoginCha(enumLOGIN_CHA_MAIN, 0);

		pCCha->SynPKCtrl();
	}

	return true;
T_E}

// 该例程内部的语句顺序非常严格，不可随便更改！！！
bool CFightAble::SkillPushBoat(CCharacter* pCBoat, bool bFree) // 收船
{T_B
	if (bFree)
		pCBoat->GetShip()->Free(); // 此处要完善，收船时，“乘客“必须为空

	pCBoat->BreakAction();
	pCBoat->m_CSkillState.ResetSkillState();
	pCBoat->GetSubMap()->GoOut(pCBoat);
	pCBoat->SetBirthMap("");

	if (bFree)
		pCBoat->Free();

	return true;
T_E}

void CFightAble::NotiChangeMainCha(uLong ulTargetID)
{T_B
	WPACKET pk	=GETWPACKET();

	WRITE_CMD(pk, CMD_MC_NOTIACTION);		//命令2字节
	WRITE_LONG(pk, m_ID);	  				//ID
	WRITE_LONG(pk, m_ulPacketID);
	WRITE_CHAR(pk, enumACTION_CHANGE_CHA);
	WRITE_LONG(pk, ulTargetID);

	ReflectINFof(this, pk);

	// log
	//
T_E}

bool CFightAble::IsRightSkill(CSkillRecord *pSkill)
{T_B
	if (IsCharacter()->IsPlayerCha())
	{
		if (IsCharacter()->IsBoat())
		{
			if (pSkill->chSrcType == enumSKILL_SRC_BOAT)
				return true;
			return false;
		}
		else
		{
			if (pSkill->chSrcType == enumSKILL_SRC_HUMAN)
				return true;
			return false;
		}
	}
	return true;
T_E}

bool CFightAble::IsRightSkillSrc(Char chSkillEffType)
{T_B
	if ((GetAreaAttr() & enumAREA_TYPE_NOT_FIGHT) && (chSkillEffType != enumSKILL_EFF_HELPFUL)) // 角色在非战斗区域且非有益技能
		return false;
	else
		return true;
T_E}

bool CFightAble::IsRightSkillTar(CFightAble *pSkillSrc, Char chSkillObjType, Char chSkillObjHabitat, Char chSkillEffType, bool bIncHider)
{T_B
	//if (GetPlayer() && GetPlayer()->GetGMLev() > 0) // 不能作用于GM
	//	return false;
	if (!bIncHider)
		if (IsCharacter()->IsHide())
			return false;
	if (!IsCharacter()->GetActControl(enumACTCONTROL_INVINCIBLE))
		return false;

	bool	bIsTeammate = pSkillSrc->IsTeammate(this);
	bool	bIsFriend = pSkillSrc->IsFriend(this);

	int nCheckRet = g_IsRightSkillTar((long)m_CChaAttr.GetAttr(ATTR_CHATYPE), !IsLiveing(), IsCharacter()->GetActControl(enumACTCONTROL_BEUSE_SKILL), GetAreaAttr(),
						(long)pSkillSrc->m_CChaAttr.GetAttr(ATTR_CHATYPE), chSkillObjType, chSkillObjHabitat, chSkillEffType, bIsTeammate, bIsFriend, pSkillSrc == this);
	if (nCheckRet != enumESKILL_SUCCESS)
		return false;

	return true;
T_E}

inline bool CFightAble::IsTeammate(CFightAble *pCTar)
{
	CPlayer	*pCPly1 = GetPlayer();
	CPlayer	*pCPly2 = 0;
	if (pCTar)
		pCPly2 = pCTar->GetPlayer();
	CCharacter	*pCCha1 = IsCharacter();
	CCharacter	*pCCha2 = 0;
	if (pCTar)
		pCCha2 = pCTar->IsCharacter();

	if (g_CParser.DoString("is_teammate", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pCCha1, pCCha2, DOSTRING_PARAM_END))
		return g_CParser.GetReturnNumber(0) != 0 ? true : false;
	else
		return false;
}

inline bool CFightAble::IsFriend(CFightAble *pCTar)
{
	CPlayer	*pCPly1 = GetPlayer();
	CPlayer	*pCPly2 = 0;
	if (pCTar)
		pCPly2 = pCTar->GetPlayer();
	CCharacter	*pCCha1 = IsCharacter();
	CCharacter	*pCCha2 = 0;
	if (pCTar)
		pCCha2 = pCTar->IsCharacter();

	if (g_CParser.DoString("is_friend", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pCCha1, pCCha2, DOSTRING_PARAM_END))
		return g_CParser.GetReturnNumber(0) != 0 ? true : false;
	else
		return false;
}

//=============================================================================
// 根据当前经验值，返回升级数
//=============================================================================
void CFightAble::CountLevel()
{T_B
	if (!IsLiveing())
		return;
	LONG64	lOldLevel, lCurLevel;
	LONG64	lCurExp = m_CChaAttr.GetAttr(ATTR_CEXP);//	Modify by alfred.shi 20080805

	lOldLevel = lCurLevel = m_CChaAttr.GetAttr(ATTR_LV);
	CLevelRecord	*pCLvRec = 0, *pNLvRec = 0;
	while (1)
	{
		pCLvRec = GetLevelRecordInfo((int)lCurLevel + 1);
		if (!pCLvRec)
		{
			//m_CLog.Log("******找不到等级%d的纪录\n");
			//m_CLog.Log("******can't find level %d record\n", lCurLevel + 1);
			break;
		}
		if (lCurExp >= pCLvRec->ulExp)
		{
			lCurLevel++;
			setAttr(ATTR_LV, lCurLevel);
			setAttr(ATTR_CLEXP, pCLvRec->ulExp);
			pNLvRec = GetLevelRecordInfo((int)lCurLevel + 1);
			if (pNLvRec)
			{
				setAttr(ATTR_NLEXP, pNLvRec->ulExp);
			}
			g_CParser.DoString("Shengji_Shuxingchengzhang", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), DOSTRING_PARAM_END); // 升级计算（配置基本属性，设置属性点）
			OnLevelUp( (USHORT)lCurLevel );
		}
		else
			break;
	}
T_E}

//=============================================================================
// 根据当前航海经验值，返回升级数
//=============================================================================
void CFightAble::CountSailLevel()
{T_B
	if (!IsLiveing())
		return;
	Long	lOldLevel, lCurLevel;
	Long	lCurExp = (long)m_CChaAttr.GetAttr(ATTR_CSAILEXP);

	lOldLevel = lCurLevel = (long)m_CChaAttr.GetAttr(ATTR_SAILLV);
	CSailLvRecord	*pCLvRec = 0, *pNLvRec = 0;
	while (1)
	{
		pCLvRec = GetSailLvRecordInfo(lCurLevel + 1);
		if (!pCLvRec)
		{
			//m_CLog.Log("******找不到航海等级%d的纪录\n");
			//m_CLog.Log("******not find navigate grade %d note\n");
			break;
		}
		if ((uLong)lCurExp >= pCLvRec->ulExp)
		{
			lCurLevel++;
			setAttr(ATTR_SAILLV, lCurLevel);
			setAttr(ATTR_CLV_SAILEXP, pCLvRec->ulExp);
			pNLvRec = GetSailLvRecordInfo(lCurLevel + 1);
			if (pNLvRec)
			{
				setAttr(ATTR_NLV_SAILEXP, pNLvRec->ulExp);
			}
			g_CParser.DoString("Saillv_Up", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), DOSTRING_PARAM_END); // 升级计算（配置基本属性，设置属性点）
			OnSailLvUp( (USHORT)lCurLevel );
		}
		else
			break;
	}
T_E}

//=============================================================================
// 根据当前生活经验值，返回升级数
//=============================================================================
void CFightAble::CountLifeLevel()
{T_B
	if (!IsLiveing())
		return;
	Long	lOldLevel, lCurLevel;
	LONG64	lCurExp = m_CChaAttr.GetAttr(ATTR_CLIFEEXP);

	lOldLevel = lCurLevel = (long)m_CChaAttr.GetAttr(ATTR_LIFELV);
	CLifeLvRecord	*pCLvRec = 0, *pNLvRec = 0;
	while (1)
	{
		pCLvRec = GetLifeLvRecordInfo(lCurLevel + 1);
		if (!pCLvRec)
		{
			//m_CLog.Log("******找不到生活等级%d的纪录\n");
			//m_CLog.Log("******not find live grade %d note\n");
			break;
		}
		if (lCurExp >= pCLvRec->ulExp)
		{
			lCurLevel++;
			setAttr(ATTR_LIFELV, lCurLevel);
			setAttr(ATTR_CLV_LIFEEXP, pCLvRec->ulExp);
			pNLvRec = GetLifeLvRecordInfo(lCurLevel + 1);
			if (pNLvRec)
			{
				setAttr(ATTR_NLV_LIFEEXP, pNLvRec->ulExp);
			}
			g_CParser.DoString("Lifelv_Up", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), DOSTRING_PARAM_END); // 升级计算（配置基本属性，设置属性点）
			OnLifeLvUp( (USHORT)lCurLevel );
		}
		else
			break;
	}
T_E}

void CFightAble::AddExp(LONG64 ulAddExp)
{
	g_CParser.DoString("EightyLv_ExpAdd", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER_LONG64, 1, ulAddExp, DOSTRING_PARAM_END); // 升级计算（配置基本属性，设置属性点）
}

bool CFightAble::AddExpAndNotic(LONG64 lAddExp, Short sNotiType)
{T_B
	m_CChaAttr.ResetChangeFlag();
	AddExp(lAddExp);
	SynAttr(sNotiType);

	return true;
T_E}

void CFightAble::SpawnResource( CCharacter *pCAtk, dbc::Long lSkillLv )
{T_B
	Long i = 0;
	for( i = 0; i < defCHA_INIT_ITEM_NUM; i++ )
	{
		if( m_pCChaRecord->lItem[i][1] <= 0 )
			break;
	}

	// 没有物品可以暴
	if( i < 1 ) return;

	g_chItemFall[0] = 0;
	// 爆料脚本的参数：攻击方等级，受击方等级，攻击方MF，受击方MF，可爆物品的个数，defCHA_INIT_ITEM_NUM个物品的爆出几率。该脚本调用C函数SetItemFall()
	lua_getglobal( g_pLuaState, "Check_SpawnResource" );
	if( !lua_isfunction( g_pLuaState, -1 ) )
	{
		lua_pop(g_pLuaState, 1);
		//LG( "生活技能爆料", "暴资源函数Check_SpawnResource无效！" );
		// printf( "暴资源函数Check_SpawnResource无效！" );
		return;
	}

	lua_pushlightuserdata( g_pLuaState, pCAtk);
	lua_pushlightuserdata( g_pLuaState, this->IsCharacter() );
	lua_pushnumber( g_pLuaState, lSkillLv );
	lua_pushnumber( g_pLuaState, i ); // 几个有效物品参数
	for( int n = 0; n < i; n++ )
	{
		lua_pushnumber( g_pLuaState, m_pCChaRecord->lItem[n][1] );
	}

	//int nStatus = lua_pcall( g_pLuaState, 4 + i, 0, 0 );
	int nStatus = CParser::docall(g_pLuaState, 4+i, 1);
	if( nStatus )
	{
		//LG( "生活技能爆料", "暴资源函数Check_SpawnResource调用失败！" );
		// printf( "暴资源函数Check_SpawnResource调用失败！" );
		lua_callalert(g_pLuaState, nStatus);
		lua_settop(g_pLuaState, 0);
		return;
	}
	lua_settop(g_pLuaState, 0);

	CItem	*pCItem;
	for (int i = 0; i < g_chItemFall[0]; i++)
	{
		//LG("生活技能爆料", "\t掉落的物品编号：%d\n", m_pCChaRecord->lItem[g_chItemFall[i + 1] - 1][0]);
		// printf( "SpawnResource:掉落的物品编号：%d\n", m_pCChaRecord->lItem[g_chItemFall[i + 1] - 1][0]);
		// 实例化
		SItemGrid GridContent((Short)m_pCChaRecord->lItem[g_chItemFall[i + 1] - 1][0], 1);
		ItemInstance(enumITEM_INST_MONS, &GridContent);
		// 出生
		CCharacter	*pCCtrlCha = IsCharacter()->GetPlyCtrlCha(), *pCAtkMainCha = pCAtk->GetPlyMainCha();
		Long	lPosX, lPosY;
		pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
		pCItem = pCCtrlCha->GetSubMap()->ItemSpawn(&GridContent, lPosX, lPosY, enumITEM_APPE_MONS, pCCtrlCha->GetID(), pCAtkMainCha->GetID(), pCAtkMainCha->GetHandle());
		if (pCItem)
			pCItem->SetProtType(enumITEM_PROT_TEAM);
	}
T_E}

bool CFightAble::GetTrowItemPos(Long *plPosX, Long *plPosY)
{
	Point	Pos;
	CCharacter	*pCCtrlCha = IsCharacter()->GetPlyCtrlCha();
	SubMap	*pCMap = pCCtrlCha->GetSubMapFar();
	if (!pCMap)
		return false;

	// 检测是否合法位置
	Pos = pCCtrlCha->GetShape().centre;
	Pos.move(rand() % 360, 150);
	if (!pCMap->IsValidPos(Pos.x, Pos.y))
	{
		*plPosX = pCCtrlCha->GetPos().x;
		*plPosY = pCCtrlCha->GetPos().y;
		return false;
	}

	uShort	usAreaAttr = pCMap->GetAreaAttr(Pos);

	if (g_IsLand(usAreaAttr) != g_IsLand(GetAreaAttr()))
		Pos = pCCtrlCha->GetPos();
	else
	{
		if (pCMap->IsBlock(Short(Pos.x / pCMap->GetBlockCellWidth()), Short(Pos.y / pCMap->GetBlockCellHeight())))
			Pos = pCCtrlCha->GetPos();
	}
	//

	*plPosX = Pos.x;
	*plPosY = Pos.y;

	return true;
}

void CFightAble::ItemCount(CCharacter *pAtk)
{T_B
	CCharacter	*pCItemHCha = pAtk;
	if (m_pCItemHostObj)
		pCItemHCha = m_pCItemHostObj->IsCharacter();

	CCharacter	*pThis = this->IsCharacter();
	CCharacter	*pCCtrlCha = pThis->GetPlyCtrlCha(), *pCItemHMainCha = pCItemHCha->GetPlyMainCha();

	if (pThis->IsBoat() && pThis->IsPlayerCha()) // 玩家船，则爆出船舱所有的物品
	{
		//Short	sItemNum = pThis->GetKitbag()->GetUseGridNum();
		//SItemGrid	*pCThrow;
		//Long	lPosX, lPosY;
		//for (Short	sNo = 0; sNo < sItemNum; sNo++)
		//{
		//	pCThrow = pThis->GetKitbag()->GetGridContByNum(sNo);
		//	if (!pCThrow)
		//		continue;

		//	GetTrowItemPos(&lPosX, &lPosY);
		//	GetSubMap()->ItemSpawn(pCThrow, lPosX, lPosY, enumITEM_APPE_MONS, GetID(), pCItemHMainCha->GetID(), pCItemHMainCha->GetHandle(), -1);
		//}
		//pThis->GetKitbag()->Reset();
		return;
	}

	CItem	*pCItem;
	Long	lItem[defCHA_INIT_ITEM_NUM], lIndex[defCHA_INIT_ITEM_NUM];
	Long	lItemNum;
	Char	*szItemScript = "Check_Baoliao";

	// 普通物品爆料
	g_chItemFall[0] = 0;
	LETimer t; t.Begin();
	lua_getglobal(g_pLuaState, szItemScript);
	if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
	{
		lua_pop(g_pLuaState, 1);
		return;
	}
	lua_pushlightuserdata(g_pLuaState, pCItemHCha);
	lua_pushlightuserdata(g_pLuaState, pThis);
	lItemNum = 0;
	for (Long i = 0; i < defCHA_INIT_ITEM_NUM; i++)
	{
		if (m_pCChaRecord->lItem[i][1] == cchChaRecordKeyValue)
			break;
		lua_pushnumber(g_pLuaState, m_pCChaRecord->lItem[i][1]);
		lItemNum++;
	}
	if (lItemNum < 1)
	{
		lua_settop(g_pLuaState, 0);
		return;
	}
	//int nState = lua_pcall(g_pLuaState, 2 + lItemNum, LUA_MULTRET, 0);
	int nState = CParser::docall(g_pLuaState, 2+lItemNum, 0);
	if (nState != 0)
	{
		LG("lua_err", "DoString %s\n", szItemScript);
		lua_callalert(g_pLuaState, nState);
		lua_settop(g_pLuaState, 0);
		return;
	}
	lua_settop(g_pLuaState, 0);
	DWORD dwEndTime = t.End();
	if(dwEndTime > 20)
		//LG("script_time", "脚本[%s]花费时间过长 time = %d\n", szItemScript, dwEndTime);
		LG("script_time", "%s,%d\n", szItemScript, dwEndTime);

	Long	lFallNum = g_chItemFall[0];
	if (lFallNum > lItemNum)
		//LG("爆料错误", "角色 %s 爆料物品个数(%u)错误", GetName(), lFallNum);
		LG("fall error", "character %s fall res number (%u) error", GetName(), lFallNum);
	else
	{
		//m_CLog.Log("爆料个数：%d\n", lFallNum);
		//m_CLog.Log("fall number：%d\n", lFallNum);
		for (int i = 0; i < lFallNum; i++)
			lItem[i] = g_chItemFall[i + 1];
		for (int i = 0; i < lFallNum; i++)
		{
			//m_CLog.Log("物品编号：%d\n", m_pCChaRecord->lItem[lItem[i] - 1][0]);
			//m_CLog.Log("res number：%d\n", m_pCChaRecord->lItem[lItem[i] - 1][0]);
			// 实例化
			SItemGrid GridContent((Short)m_pCChaRecord->lItem[lItem[i] - 1][0], 1);
			ItemInstance(enumITEM_INST_MONS, &GridContent);
			// 出生
			Long	lPosX, lPosY;
			pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
			pCItem = pCCtrlCha->GetSubMap()->ItemSpawn(&GridContent, lPosX, lPosY, enumITEM_APPE_MONS, pCCtrlCha->GetID(), pCItemHMainCha->GetID(), pCItemHMainCha->GetHandle());
			if (pCItem)
				pCItem->SetProtType(enumITEM_PROT_TEAM);
		}
	}

	// 任务物品爆料
	g_chItemFall[0] = 0;
	t.Begin();
	lua_getglobal(g_pLuaState, szItemScript);
	if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
	{
		lua_pop(g_pLuaState, 1);
		return;
	}
	lua_pushlightuserdata(g_pLuaState, pCItemHCha);
	lua_pushlightuserdata(g_pLuaState, pThis);
	lItemNum = 0;
	for (Long i = 0; i < defCHA_INIT_ITEM_NUM; i++)
	{
		if (m_pCChaRecord->lTaskItem[i][1] == cchChaRecordKeyValue)
			break;
		if (pCItemHCha->IsMisNeedItem((uShort)m_pCChaRecord->lTaskItem[i][0]))
		{
			lua_pushnumber(g_pLuaState, m_pCChaRecord->lTaskItem[i][1]);
			lIndex[lItemNum] = i;
			lItemNum++;
		}
		else
		{
			CPlayer* pCItemHply = pCItemHCha->GetPlayer();
			if( pCItemHply )
			{
				for(int i = 0; i < pCItemHply->GetTeamMemberCnt(); i++) // 队伍里每一个人都需要
				{
					CCharacter *pOther = pCItemHply->GetTeamMemberCha(i);
					if (!pOther)			 continue;
					if(!pOther->IsLiveing()) continue;
					if ((pOther->IsMisNeedItem((uShort)m_pCChaRecord->lTaskItem[i][0])))
					{
						lua_pushnumber(g_pLuaState, m_pCChaRecord->lTaskItem[i][1]);
						lIndex[lItemNum] = i;
						lItemNum++;
					}
				}
			}
		}
	}
	if (lItemNum < 1)
	{
		lua_settop(g_pLuaState, 0);
		return;
	}
	//nState = lua_pcall(g_pLuaState, 2 + lItemNum, LUA_MULTRET, 0);
	nState = CParser::docall(g_pLuaState, 2+lItemNum, 0);
	if (nState != 0)
	{
		LG("lua_err", "DoString %s\n", szItemScript);
		lua_callalert(g_pLuaState, nState);
		lua_settop(g_pLuaState, 0);
		return;
	}
	lua_settop(g_pLuaState, 0);
	dwEndTime = t.End();
	if(dwEndTime > 20)
		//LG("script_time", "脚本[%s]花费时间过长 time = %d\n", szItemScript, dwEndTime);
		LG("script_time", "%s,%d\n", szItemScript, dwEndTime);

	lFallNum = g_chItemFall[0];
	if (lFallNum > lItemNum)
		//LG("爆料错误", "角色 %s 爆料任务物品个数(%u)错误", GetName(), lFallNum);
		LG("fall error", "roll %s fall task res number (%u)error", GetName(), lFallNum);
	else
	{
		//m_CLog.Log("任务物品爆料个数：%d\n", lFallNum);
		//m_CLog.Log("task res fall number:%d\n", lFallNum);
		for (int i = 0; i < lFallNum; i++)
			lItem[i] = g_chItemFall[i + 1];
		for (int i = 0; i < lFallNum; i++)
		{
			//m_CLog.Log("物品编号：%d\n", m_pCChaRecord->lTaskItem[lIndex[lItem[i] - 1]][0]);
			//m_CLog.Log("res number:%d\n", m_pCChaRecord->lTaskItem[lIndex[lItem[i] - 1]][0]);
			// 实例化
			SItemGrid GridContent((Short)m_pCChaRecord->lTaskItem[lIndex[lItem[i] - 1]][0], 1);
			ItemInstance(enumITEM_INST_MONS, &GridContent);
			// 出生
			Long	lPosX, lPosY;
			pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
			pCItem = pCCtrlCha->GetSubMap()->ItemSpawn(&GridContent, lPosX, lPosY, enumITEM_APPE_MONS, pCCtrlCha->GetID(), pCItemHMainCha->GetID(), pCItemHMainCha->GetHandle(), -1);
		}
	}
T_E}

void CFightAble::ItemInstance(Char chType, SItemGrid *pGridContent)
{T_B
	if (!pGridContent)
		return;
	CItemRecord *pCItemRec;
	pCItemRec = GetItemRecordInfo(pGridContent->sID);
	if (!pCItemRec)
		return;

	//char szItemInstLog[256] = "实例化";
												
	char szItemInstLog[256];
	//strncpy( szItemInstLog, RES_STRING(GM_FIGHTABLE_CPP_00003), 256 - 1 );
	strncpy_s( szItemInstLog, sizeof(szItemInstLog), RES_STRING(GM_FIGHTABLE_CPP_00003), _TRUNCATE );

	pGridContent->sEndure[1] = g_pCItemAttr[pGridContent->sID].GetAttr(ITEMATTR_MAXURE, false);
	pGridContent->sEndure[0] = pGridContent->sEndure[1];
	pGridContent->sEnergy[1] = g_pCItemAttr[pGridContent->sID].GetAttr(ITEMATTR_MAXENERGY, false);
	pGridContent->sEnergy[0] = pGridContent->sEnergy[1];

	pGridContent->SetInstAttrInvalid();

	if (pCItemRec->chInstance == 0)
		goto ItemInstanceEnd;

	int	nAttrPos = 0;
	int nRetNum = 15;
	if (!g_CParser.DoString("Creat_Item", enumSCRIPT_RETURN_NUMBER, nRetNum, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pGridContent, enumSCRIPT_PARAM_NUMBER, 3, pCItemRec->sType, pCItemRec->sNeedLv, chType, DOSTRING_PARAM_END))
		goto ItemInstanceEnd;

	short sMin, sMax;
	int nRetID = 0;
	int nAttrNum = g_CParser.GetReturnNumber(0);
	int	nAttrID, nAttr;
	for (int i = 0; i < nAttrNum; i++)
	{
		nRetID = i * 2 + 1;
		nAttrID = g_CParser.GetReturnNumber(nRetID);
		nAttr = g_CParser.GetReturnNumber(nRetID + 1);
		sMin = g_pCItemAttr[pGridContent->sID].GetAttr(nAttrID, false);
		sMax = g_pCItemAttr[pGridContent->sID].GetAttr(nAttrID, true);
		if (nAttrID == ITEMATTR_MAXURE)
		{
			if (nAttr < 0 || nAttr > 100) // 错误的比例
			{
				/*LG("道具实例化错误", "实例化道具：编号 %u，名称 %s，类型 %u，需求等级 %u，实例化类型 %u。属性错误：属性号 %u，值 %d。\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);*/
				LG("item instantiation error", "instantiation itme:number %u,name %s,type %u,requirement grade %u,instantiation type %u.attribute error:attribute number %u,value %d.\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);
				continue;
			}
			pGridContent->sEndure[1] = sMin + (sMax - sMin) * nAttr / 100;
			pGridContent->sEndure[0] = pGridContent->sEndure[1];
		}
		else if (nAttrID == ITEMATTR_MAXENERGY) // 能量为千分比
		{
			if (nAttr < 0 || nAttr > 1000) // 错误的比例
			{
				/*LG("道具实例化错误", "实例化道具：编号 %u，名称 %s，类型 %u，需求等级 %u，实例化类型 %u。属性错误：属性号 %u，值 %d。\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);*/
				LG("item instantiation error", "instantiation itme:number %u,name %s,type %u,requirement grade %u,instantiation type %u.attribute error:attribute number %u,value %d.\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);
				continue;
			}
			pGridContent->sEnergy[1] = sMin + (sMax - sMin) * nAttr / 100; // 整理后需要改成除以1000
			pGridContent->sEnergy[0] = pGridContent->sEnergy[1];
		}
		else if(nAttrID == ITEMATTR_URE)  // 当前耐久
		{
			if (nAttr < 0 || nAttr > 1000) // 错误的比例
			{
				/*LG("道具实例化错误", "实例化道具：编号 %u，名称 %s，类型 %u，需求等级 %u，实例化类型 %u。属性错误：属性号 %u，值 %d。\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);*/
				LG("item instantiation error", "instantiation itme:number %u,name %s,type %u,requirement grade %u,instantiation type %u.attribute error:attribute number %u,value %d.\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);
				continue;
			}
			pGridContent->sEndure[0] = int((float)pGridContent->sEndure[1] * ((float)nAttr / 1000.0));
		}
		else
		{
			if (nAttrPos < defITEM_INSTANCE_ATTR_NUM)
			{
				if (nAttr < 0 || nAttr > 100) // 错误的比例
				{
					/*LG("道具实例化错误", "实例化道具：编号 %u，名称 %s，类型 %u，需求等级 %u，实例化类型 %u。属性错误：属性号 %u，值 %d。\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);*/
					LG("item instantiation error", "instantiation itme:number %u,name %s,type %u,requirement grade %u,instantiation type %u.attribute error:attribute number %u,value %d.\n",
					pCItemRec->lID, pCItemRec->szName, pCItemRec->sType, pCItemRec->sNeedLv, chType, nAttrID, nAttr);
					continue;
				}
				pGridContent->sInstAttr[nAttrPos][0] = nAttrID;
				pGridContent->sInstAttr[nAttrPos][1] = sMin + (sMax - sMin) * nAttr / 100;
				nAttrPos++;
			}
			else
				break;
		}
	}
	if (nAttrPos < defITEM_INSTANCE_ATTR_NUM)
		pGridContent->sInstAttr[nAttrPos][0] = 0;

ItemInstanceEnd:
	return;
T_E}

void CFightAble::OnSkillState(DWORD dwCurTick)
{T_B
	if (!IsLiveing())
		return;

	if (m_CSkillState.GetStateNum() > 0)
	{
		Entity	*pCEnt;
		CCharacter	*pCCha;
		CCharacter	*pSrcMainC = 0;

		IsCharacter()->GetPlyMainCha()->SetLookChangeFlag();
		m_CChaAttr.ResetChangeFlag();
		m_CSkillState.ResetSkillStateChangeFlag();
		CSkillStateRecord	*pCSStateRec = 0;
		SSkillStateUnit		*pSStateUnit;
		Short	sExecTime = 0;
		Long	lOldHP;
		bool	bIsDie;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end();)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			pCSStateRec = GetCSkillStateRecordInfo(pSStateUnit->GetStateID());

			pCCha = 0;
			pSrcMainC = 0;
			pCEnt = g_pGameApp->IsLiveingEntity(pSStateUnit->ulSrcWorldID, pSStateUnit->lSrcHandle);
			if (pCEnt)
			{
				pCCha = pCEnt->IsCharacter();
				if (pCCha != g_pCSystemCha && pCCha != this)
				{
					pCCha->GetPlyMainCha()->SetLookChangeFlag();
					pCCha->m_CChaAttr.ResetChangeFlag();
					pCCha->m_CSkillState.ResetSkillStateChangeFlag();
				}
				pSrcMainC = pCCha->GetPlyMainCha();
				if (pSrcMainC == pCCha || pSrcMainC == this)
					pSrcMainC = 0;
				if (pSrcMainC)
				{
					pSrcMainC->m_CChaAttr.ResetChangeFlag();
				}
			}

			lOldHP = (long)m_CChaAttr.GetAttr(ATTR_HP);
			if (pSStateUnit->lOnTick > 0) // 有限持续时间
			{
				if (dwCurTick - pSStateUnit->ulStartTick > (unsigned long)pSStateUnit->lOnTick * 1000)
				{
#ifdef COMPACT_MEM_2
					if(DelSkillState(it, false))
					{
						continue;
					}
#else
					DelSkillState(pSStateUnit->GetStateID(), false);
#endif
				}
				else
				{
					if (pCSStateRec->sFrequency > 0) // 时间脉冲触发
					{
						sExecTime = Short(dwCurTick - pSStateUnit->ulLastTick) / (pCSStateRec->sFrequency * 1000);
						for (int j = 0; j < sExecTime; j++)
						{
							g_CParser.DoString(pCSStateRec->szAddState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER, 1, pSStateUnit->GetStateLv(), DOSTRING_PARAM_END);
						}
						pSStateUnit->ulLastTick += pCSStateRec->sFrequency * sExecTime * 1000;
					}
					else if (pCSStateRec->sFrequency < 0) // 只触发一次（在添加的时候已经触发过）
					{
						pSStateUnit->ulLastTick = dwCurTick;
					}
				}
			}
			else if (pSStateUnit->lOnTick < 0) // 无限持续时间
			{
				if (pCSStateRec->sFrequency > 0) // 时间脉冲触发
				{
					sExecTime = Short(dwCurTick - pSStateUnit->ulLastTick) / (pCSStateRec->sFrequency * 1000);
					for (int j = 0; j < sExecTime; j++)
					{
						g_CParser.DoString(pCSStateRec->szAddState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this->IsCharacter(), enumSCRIPT_PARAM_NUMBER, 1, pSStateUnit->GetStateLv(), DOSTRING_PARAM_END);
					}
					pSStateUnit->ulLastTick += pCSStateRec->sFrequency * sExecTime * 1000;
				}
				else if (pCSStateRec->sFrequency < 0) // 只触发一次（在添加的时候已经触发过）
				{
					pSStateUnit->ulLastTick = dwCurTick;
				}
			}

			BeUseSkill(lOldHP, (long)m_CChaAttr.GetAttr(ATTR_HP), pCCha, pSStateUnit->chEffType);
			if (lOldHP > 0 && m_CChaAttr.GetAttr(ATTR_HP) <= 0) bIsDie = true;
			else bIsDie = false;
			if (bIsDie) // 死亡
			{
				SetDie(pCCha);
			}
			if (pCCha && pCCha != g_pCSystemCha && pCCha != this)
			{
				pCCha->GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
				pCCha->SynSkillStateToEyeshot();
				pCCha->SynAttr(enumATTRSYN_ATTACK);
				pCCha->RectifyAttr();
			}
			if (pSrcMainC)
			{
				pSrcMainC->SynAttr(enumATTRSYN_ATTACK);
			}
			if (bIsDie) // 死亡
			{
				//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
				//m_CLog.Log("!!!death\tTick %u\n", GetTickCount());
				Die();
				break;
			}

#ifdef COMPACT_MEM_2
			it++;
#endif
		}
		// log
		//m_CLog.Log("$$$由状态引发的属性同步\n");
		//m_CLog.Log("$$$attribute in-phase cause by state\n");
		//
		SynSkillStateToEyeshot();
		SynAttr(enumATTRSYN_SKILL_STATE);
		IsCharacter()->GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
		RectifyAttr();
	}
T_E}

void CFightAble::RemoveOtherSkillState()
{
	if (m_CSkillState.GetStateNum() > 0)
	{
		IsCharacter()->GetPlyMainCha()->SetLookChangeFlag();
		m_CChaAttr.ResetChangeFlag();
		m_CSkillState.ResetSkillStateChangeFlag();
		SSkillStateUnit		*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
			if (pSStateUnit->lOnTick > 0) // 有限持续时间
			{
				DelSkillState(pSStateUnit->GetStateID(), false);
			}
		}

		SynSkillStateToEyeshot();
		SynAttr(enumATTRSYN_SKILL_STATE);
		IsCharacter()->GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
	}
}

void CFightAble::RemoveAllSkillState()
{
	if (m_CSkillState.GetStateNum() > 0)
	{
		SSkillStateUnit		*pSStateUnit;
#ifdef COMPACT_MEM_2
		for(map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end();)
		{
			pSStateUnit = &it->second;
#else
		m_CSkillState.BeginGetState();
		while (pSStateUnit = m_CSkillState.GetNextState())
		{
#endif
#ifdef COMPACT_MEM_2
			if(DelSkillState(it, false))
			{
				continue;
			}
#else
			DelSkillState(pSStateUnit->GetStateID(), false);
#endif

#ifdef COMPACT_MEM_2
			it++;
#endif
		}
	}
}

// 根据技能栏中技能的等级，计算出与其相关的项
void CFightAble::EnrichSkillBag(bool bActive)
{T_B
	SSkillGrid	SSkillCont;
	if (bActive)
		SSkillCont.chState = enumSUSTATE_ACTIVE;
	else
		SSkillCont.chState = enumSUSTATE_INACTIVE;

	// 每种职业最多11种技能
	for (int i = 0; i < defCHA_INIT_SKILL_NUM; i++)
	{
		if (m_pCChaRecord->lSkill[i][0] > 0)
		{
			SSkillCont.sID = (Short)m_pCChaRecord->lSkill[i][0];
			SSkillCont.chLv = 1;
			m_CSkillBag.AddSkill(&SSkillCont);
		}
	}
T_E}

//=============================================================================
CTimeSkillMgr::CTimeSkillMgr(unsigned short usFreq)
{T_B
	m_ulTick = GetTickCount();
	m_usFreq = usFreq;
	m_pSExecQueue = NULL;
	m_pSFreeQueue = NULL;
T_E}

CTimeSkillMgr::~CTimeSkillMgr()
{T_B
	SMgrUnit	*pSCarrier;

	pSCarrier = m_pSExecQueue;
	while (pSCarrier)
	{
		m_pSExecQueue = pSCarrier->pSNext;
		delete pSCarrier;
		pSCarrier = m_pSExecQueue;
	}

	pSCarrier = m_pSFreeQueue;
	while (pSCarrier)
	{
		m_pSFreeQueue = pSCarrier->pSNext;
		delete pSCarrier;
		pSCarrier = m_pSFreeQueue;
	}
T_E}

void CTimeSkillMgr::Add(SFireUnit *pSFireSrc, uLong ulLeftTick, SubMap *pCMap, Point *pStarget, Long *plRangeBParam)
{T_B
	SMgrUnit	*pSCarrier = NULL;

	if (m_pSFreeQueue) // 有空闲的载体
	{
		pSCarrier = m_pSFreeQueue;
		m_pSFreeQueue = pSCarrier->pSNext;
	}
	else // 分配新的载体
	{
		pSCarrier = new(std::nothrow) SMgrUnit;
		if (!pSCarrier)
		{
		  throw excpMem(RES_STRING(GM_FIGHTALBE_CPP_00004));
		}
	}

	// 设置数据并将之加入执行队列
	pSCarrier->SFireSrc = *pSFireSrc;
	pSCarrier->ulLeftTick = ulLeftTick;
	pSCarrier->pCMap = pCMap;
	pSCarrier->STargetPos = *pStarget;

	memcpy(pSCarrier->lERangeBParam, plRangeBParam, sizeof(Long) * defSKILL_RANGE_BASEP_NUM);

	pSCarrier->pSNext = m_pSExecQueue;
	m_pSExecQueue = pSCarrier;
T_E}

void CTimeSkillMgr::Run(unsigned long ulCurTick)
{T_B
	unsigned long	ulTickDist = ulCurTick - m_ulTick;

	if (ulTickDist < m_usFreq)
		return;
	m_ulTick = ulCurTick;

	SMgrUnit	*pSCarrier, *pSLastCarrier;
	pSCarrier = pSLastCarrier = m_pSExecQueue;
	while (pSCarrier)
	{
		if (pSCarrier->ulLeftTick > ulTickDist)

		{
			pSCarrier->ulLeftTick -= ulTickDist;
			pSLastCarrier = pSCarrier;
			pSCarrier = pSCarrier->pSNext;

		}
		else // 载体的计时完成
		{
			ExecTimeSkill(pSCarrier);
			// 从执行队列中脱链
			if (pSCarrier == m_pSExecQueue)
			{
				m_pSExecQueue = pSCarrier->pSNext;

				pSCarrier->pSNext = m_pSFreeQueue;
				m_pSFreeQueue = pSCarrier;

				pSLastCarrier = m_pSExecQueue;
				pSCarrier = pSLastCarrier;
			}
			else
			{
				pSLastCarrier->pSNext = pSCarrier->pSNext;

				pSCarrier->pSNext = m_pSFreeQueue;
				m_pSFreeQueue = pSCarrier;

				pSCarrier = pSLastCarrier->pSNext;
			}
		}
	}
T_E}

void CTimeSkillMgr::ExecTimeSkill(SMgrUnit *pFireInfo)
{T_B
	// 搜索符合条件的目标
	CCharacter	*pSrcCha;
	Entity	*pSrcEnt = g_pGameApp->IsLiveingEntity(pFireInfo->SFireSrc.ulID, pFireInfo->SFireSrc.pCFightSrc->GetHandle());
	if (!pSrcEnt || !(pSrcCha = pSrcEnt->IsCharacter())) // 技能源已经无效
		return;

	g_ulCurID = pSrcCha->GetID();
	g_lCurHandle = pSrcCha->GetHandle();

	g_SSkillPoint = pFireInfo->STargetPos;
	pSrcCha->RangeEffect(&pFireInfo->SFireSrc, pFireInfo->pCMap, pFireInfo->lERangeBParam);

	g_ulCurID = defINVALID_CHA_ID;
	g_lCurHandle = defINVALID_CHA_HANDLE;
T_E}

