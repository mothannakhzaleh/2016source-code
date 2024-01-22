#include "SubMap.h"
#include "GameApp.h"
#include "GameAppNet.h"
#include "CharTrade.h"
#include "Parser.h"
#include "NPC.h"
#include "WorldEudemon.h"
#include "Player.h"
#include "LevelRecord.h"
#include "HairRecord.h"
#include "gamedb.h"

#include "Birthplace.h"
#include "CharBoat.h"
#include "Guild.h"
#include "CharStall.h"

#include "Auction.h"

#include "lua_gamectrl.h"
#ifdef XTRAP_S
#include "Xtrap_S_Interface.h"
#endif

#include <conformity.h>

_DBC_USING
const short g_sLiveSkillNeedItemNum[4] = {6,4,6,6};

#ifdef	XTRAP_S 
extern unsigned char g_XTrapMap[CSFLIE_NUM][XTRAP_CS4_BUFSIZE_MAP];
#endif
//extern std::string g_strLogName;
//----------------------------------------------------------
//                    所有网络消息的处理
//----------------------------------------------------------
void CCharacter::ProcessPacket(unsigned short usCmd, RPACKET pk)
{T_B
	switch (usCmd)
	{
	case CMD_CM_PING:
		{
			uLong	ulPing = GetTickCount() - READ_LONG(pk);
			unsigned long long	lGateSvr = READ_LONGLONG(pk);
			Long	lSrcID = READ_LONG(pk);
			Long	lGatePlayerID = READ_LONG(pk);
			unsigned long long	lGatePlayerAddr = READ_LONGLONG(pk);

			// 校验从客户端过来的指针
			BEGINGETGATE();
			GateServer	*pNoGate;
			GateServer	*pGate = 0;
			while (pNoGate = GETNEXTGATE())
			{
				if (MakeULong(pNoGate) == lGateSvr)
				{
					pGate = pNoGate;
					break;
				}
			}
			if (!pGate)
				break;
			//

			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_QUERY_CHAPING);
			WRITE_LONG(WtPk, lSrcID);
			WRITE_STRING(WtPk, GetName());
			WRITE_STRING(WtPk, GetSubMap()->GetName());
			WRITE_LONG(WtPk, ulPing);
			WRITE_LONG(WtPk, lGatePlayerID);
			WRITE_LONGLONG(WtPk, lGatePlayerAddr);
			WRITE_SHORT(WtPk, 1);
			pGate->SendData(WtPk);

			break;
		}
	case CMD_CM_CHECK_PING:
		{
			DWORD	dwPing = GetTickCount() - m_dwPingSendTick;
			/*if (m_dwPingRec[0] == 0)
			{
				for (int i = 0; i < defPING_RECORD_NUM; i++)
					m_dwPingRec[i] = dwPing;
				m_dwPing = dwPing;
			}
			else
			{
				DWORD	dwAddPing = 0;
				for (int i = 1; i < defPING_RECORD_NUM; i++)
				{
					m_dwPingRec[i - 1] = m_dwPingRec[i];
					dwAddPing += m_dwPingRec[i];
				}
				m_dwPingRec[defPING_RECORD_NUM - 1] = dwPing;
				dwAddPing += dwPing;
				m_dwPing = dwAddPing / defPING_RECORD_NUM;
			}*/
			m_dwPing = dwPing;
			//printf("ping = %d [%s]\n", m_dwPing, GetName());
			SendPreMoveTime();
			break;
		}
	case CMD_CM_CANCELEXIT:
		{
			CancelExit();
		}
		break;
	case CMD_CM_BEGINACTION:
		{
			uLong	ulWorldID = READ_LONG(pk);
			if(GetPlayer())
			{
				if (GetPlayer()->GetCtrlCha() && ulWorldID == GetPlayer()->GetCtrlCha()->GetID())
					GetPlayer()->GetCtrlCha()->BeginAction(pk);
				else if (GetPlayer()->GetMainCha() && ulWorldID == GetPlayer()->GetMainCha()->GetID())
					GetPlayer()->GetMainCha()->BeginAction(pk);
			}
			break;
		}
	case CMD_CM_ENDACTION:
		{
			EndAction(pk);

			break;
		}
	case CMD_CM_DIE_RETURN:
		{
			m_chSelRelive = READ_CHAR(pk);
			GetPlyMainCha()->ResetChaRelive();	// 复活状态恢复
			if (m_chSelRelive == enumEPLAYER_RELIVE_NORIGIN)
				SetRelive(enumEPLAYER_RELIVE_ORIGIN, 0);
			break;
		}
	case CMD_CM_SAY:
		{
			DWORD	dwNowTick = GetTickCount();
			// add by ning.yan 2008-11-17 resolve the problem of  press Ctrl+123...(face shortcut key)  begin
			uShort	l_retlen;
			cChar	*l_content = READ_SEQ(pk, l_retlen);

			// Add by lark.li 20090311 begin
			if(!l_content)
				break;

			// Char	szComHead[256], szComParam[2048]; 特殊命令
			if(l_retlen <=0 || l_retlen > (2048 + 256 + 2))
				break;
			// End

			char buf[10];
			bool isShortcutKey = false;
			for (int i=0; i<=50; i++)
			{
				//sprintf(buf, "***%d", i);
				_snprintf_s(buf,sizeof(buf),_TRUNCATE, "***%d", i);

				if( !strcmp(l_content, buf) )
				{
					isShortcutKey = true;
					break;
				}
			}
			if ( !isShortcutKey && dwNowTick - _dwLastSayTick < (DWORD)g_Config.m_lSayInterval)
			{
					//SystemNotice("请勿频繁发言！");
					SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00001));
					isShortcutKey = true;
					break;
			}
			// ning.yan  end

			_dwLastSayTick = dwNowTick;

			if (!GetSubMap())
			{
				//LG("对话错误", "角色%s 在对话时，其地图为空！\n", m_CLog.GetLogName());
				LG("dialog error", "when character%s is dialog,the map is null!\n", m_CLog.GetLogName());
				break;
			}

			 // delete by ning.yan 2008-11-17 begin
			//uShort	l_retlen;
			//cChar	*l_content = READ_SEQ(pk, l_retlen);// end
			if (!l_content)
				break;
			else if (*l_content == '&') // 特殊命令
			{
				const Char chGMLv = GetPlayer()->GetGMLev();
				if ((chGMLv == 0 || chGMLv > 150))
					SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00002));
				else
					DoCommand(l_content + 1, l_retlen - 1);
			}
			else if (*l_content == '$' && *(l_content+1)=='$') // 特殊命令
			{
				DoCommand_CheckStatus(l_content + 3, l_retlen - 2);
			}
			else if (*l_content == '/' && *(l_content+1)=='?') // 玩家请求帮忙查询
			{
				HandleHelp(l_content + 2, l_retlen - 2);
			}
			else
			{
				if(this->IsLiveing()) // 死亡后，禁止视野说话
				{
					WPACKET wpk	= GETWPACKET();
					WRITE_CMD(wpk, CMD_MC_SAY);
					WRITE_LONG(wpk, m_ID);
					WRITE_SEQ(wpk, l_content,l_retlen);
					NotiChgToEyeshot(wpk);
				}
				else
				{
					this->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00049));
				}
			}
			break;
		}
	case CMD_CM_REQUESTTALK:
	case CMD_CM_REQUESTTRADE:
		{
			uLong ulID = READ_LONG(pk);
			if( ulID == mission::g_WorldEudemon.GetID() )
			{
				mission::g_WorldEudemon.MsgProc( *this, pk );
				break;
			}
			if( pTradeNPC )
			{
				if( ulID == pTradeNPC->GetID())
				{
					pTradeNPC->MsgProc( *this, pk );
					break;
				}
			}
			CCharacter* pCha = m_submap->FindCharacter( ulID, GetShape().centre );
			if( pCha == NULL ) break;
			mission::CNpc* pNpc = pCha->IsNpc();
			if( pNpc )
			{
				pNpc->MsgProc( *this, pk );
				break;
			}

		}
		break;
	case CMD_CM_REQUEST_ANYTIMETRADE:
		{
			if(! pTradeNPC )
				break;
			pTradeNPC->MsgProc( *this, pk );
		}
		break;
	case CMD_CM_MISLOG:
		{
			MisLog();
		}
		break;
	case CMD_CM_MISLOGINFO:
		{
			WORD wMisID  = READ_SHORT(pk);
			MisLogInfo( wMisID );
		}
		break;
	case CMD_CM_MISLOG_CLEAR:
		{
			WORD wMisID  = READ_SHORT(pk);
			MisLogClear( wMisID );
		}
		break;
//这个命令已经没在用, 精炼用别的命令 -Waiting Mark 2009-03-25
// 	case CMD_CM_FORGE:
// 		{
// 			BYTE byIndex = READ_CHAR(pk);
// 			g_ForgeSystem.ForgeItem( *this, byIndex );
// 		}
// 		break;
	case CMD_CM_CHARTRADE_REQUEST:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			g_TradeSystem.Request( byType, *this, dwCharID );
		}
		break;
	case CMD_CM_CHARTRADE_ACCEPT:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			g_TradeSystem.Accept( byType, *this, dwCharID );
		}
		break;
	case CMD_CM_CHARTRADE_REJECT:
		{
		}
		break;
	case CMD_CM_CHARTRADE_CANCEL:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			g_TradeSystem.Cancel( byType, *this, dwCharID );
		}
		break;
	case CMD_CM_CHARTRADE_ITEM:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			BYTE  byOpType = READ_CHAR(pk);
			BYTE  byIndex  = READ_CHAR(pk);
			BYTE  byItemIndex = READ_CHAR(pk);
			BYTE  byCount  = READ_CHAR(pk);
			g_TradeSystem.AddItem( byType, *this, dwCharID, byOpType, byIndex, byItemIndex, byCount );
		}
		break;
	case CMD_CM_CHARTRADE_MONEY:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			BYTE  byOpType = READ_CHAR(pk);
			DWORD dwMondy  = READ_LONG(pk);
			g_TradeSystem.AddMoney( byType, *this, dwCharID, byOpType, dwMondy );
		}
		break;
	case CMD_CM_CHARTRADE_VALIDATEDATA:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			g_TradeSystem.ValidateItemData( byType, *this, dwCharID );
		}
		break;
	case CMD_CM_CHARTRADE_VALIDATE:
		{
			BYTE byType = READ_CHAR(pk);
			DWORD dwCharID = READ_LONG(pk);
			g_TradeSystem.ValidateTrade( byType, *this, dwCharID );
		}
		break;
	case CMD_CM_CREATE_BOAT:
		{
			g_CharBoat.MakeBoat( *this, pk );
		}
		break;
	case CMD_CM_UPDATEBOAT_PART:
		{
			g_CharBoat.Update( *this, pk );
		}
		break;
	case CMD_CM_BOAT_GETINFO:
		{
			if( GetPlayer()->IsLuanchOut() )
			{
				g_CharBoat.GetBoatInfo( *this, GetPlayer()->GetLuanchID() );
			}
			else
			{
				//SystemNotice( "你的船只没有出海！" );
				SystemNotice( RES_STRING(GM_CHARACTERPRL_CPP_00003) );
			}
		}
		break;
	case CMD_CM_BOAT_CANCEL:
		{
			g_CharBoat.Cancel( *this );
		}
		break;
	case CMD_CM_BOAT_LUANCH:
		{
			DWORD dwNpcID = READ_LONG( pk );
			if(dwNpcID)
			{
				CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
				if( pCha == NULL )
					break;
			}

			BYTE byIndex = READ_CHAR( pk );
			BoatSelLuanch( byIndex );
		}
		break;
	case CMD_CM_BOAT_SELECT:
		{
			DWORD dwNpcID = READ_LONG( pk );
			if(dwNpcID)
			{
				CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
				if( pCha == NULL )
					break;
			}

			BYTE byType = READ_CHAR( pk );
			BYTE byIndex = READ_CHAR( pk );
			BoatSelected( byType, byIndex );
		}
		break;
	case CMD_CM_BOAT_BAGSEL:
		{
			DWORD dwNpcID = READ_LONG( pk );
			if(dwNpcID)
			{
				CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
				if( pCha == NULL )
					break;
			}

			BYTE byIndex = READ_CHAR( pk );
			BoatPackBag( byIndex );
		}
		break;
	case CMD_CM_ENTITY_EVENT:
		{
			DWORD dwEntityID = READ_LONG( pk );
			CCharacter* pCha = m_submap->FindCharacter( dwEntityID, GetShape().centre );
			if( pCha == NULL ) break;
			mission::CEventEntity* pEntity = pCha->IsEvent();
			if( pEntity )
			{
				pEntity->MsgProc( *this, pk );
				break;
			}
		}
		break;
	case CMD_CM_STALL_ALLDATA:
		{
			g_StallSystem.StartStall( *this, pk );
		}
		break;
	case CMD_CM_STALL_OPEN:
		{
			g_StallSystem.OpenStall( *this, pk );
		}
		break;
	case CMD_CM_STALL_BUY:
		{
			g_StallSystem.BuyGoods( *this, pk );
		}
		break;
	case CMD_CM_STALL_CLOSE:
		{
			g_StallSystem.CloseStall( *this );
		}
		break;
	case CMD_CM_READBOOK_START:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(!IsBoat())
			{
				pMainCha->SetReadBookState(true);
				pMainCha->ForgeAction(true);
				pMainCha->GetKitbag()->Lock();
			}
			else
				//pMainCha->SystemNotice("船上不能读书！");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00004));
			
		}
		break;
	case CMD_CM_READBOOK_CLOSE:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(!IsBoat())
			{
				pMainCha->SetReadBookState(false);
				pMainCha->ForgeAction(false);
				pMainCha->GetKitbag()->UnLock();
			}
			else
				//pMainCha->SystemNotice("船上不能结束读书！");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00005));
		}
		break;
	case CMD_CM_SYNATTR: // 同步六个基础属性(把终端请求的六个基础属性相对值，转换为基本基础属性，再算出各项属性，返还给终端)
			GetPlayer()->GetMainCha()->Cmd_ReassignAttr(pk);
		break;
	case CMD_CM_SKILLUPGRADE:
		{
			Short	sSkillID = READ_SHORT(pk);
			Char	chAddGrade = READ_CHAR(pk);

			GetPlayer()->GetMainCha()->LearnSkill(sSkillID, chAddGrade, false);
		}
		break;
	case CMD_CM_REFRESH_DATA:
		{
			Long	lWorldID = READ_LONG(pk);
			Long	lHandle = READ_LONG(pk);
			Entity	*pCEnt = g_pGameApp->IsLiveingEntity(lWorldID, lHandle);
			if (pCEnt)
			{
				CCharacter	*pCCha = pCEnt->IsCharacter();
				if (pCCha && pCCha->GetPlayer() == GetPlayer()) // 玩家自己的角色
				{
					pCCha->SynAttr(enumATTRSYN_ITEM_EQUIP);
				}
			}
		}
		break;
	case CMD_TM_CHANGE_PERSONINFO:
		{
			SetMotto(READ_STRING(pk));
			SetIcon(READ_SHORT(pk));
		}
		break;
	case CMD_CM_GUILD_PUTNAME:
		{
			bool	l_confirm	=READ_CHAR(pk)?true:false;
			cChar * l_guildname =READ_STRING(pk);

			// Add by lark.li 20090311 begin
			if(!l_guildname)
				break;
			// End

			cChar *	l_passwd	=READ_STRING(pk);

			// Add by lark.li 20090311 begin
			if(!l_passwd)
				break;
			// End

			if(Guild::IsValidGuildName(l_guildname,uShort(strlen(l_guildname))) && !strchr(l_passwd,'\''))
			{
				Guild::cmd_CreateGuild(GetPlyMainCha(),l_confirm,l_guildname,l_passwd);
			}
			else
			{
				//GetPlyMainCha()->SystemNotice("工会名包含非法字符！");
				GetPlyMainCha()->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00006));
			}
		}
		break;
	case CMD_CM_GUILD_TRYFOR:
		{
			Guild::cmd_GuildTryFor(GetPlyMainCha(),READ_LONG(pk));
		}
		break;
	case CMD_CM_GUILD_TRYFORCFM:
		{
			Guild::cmd_GuildTryForComfirm(GetPlyMainCha(),READ_CHAR(pk));
		}
		break;
	case CMD_CM_GUILD_LISTTRYPLAYER:
		{
			Guild::cmd_GuildListTryPlayer(GetPlyMainCha());
		}
		break;
	case CMD_CM_GUILD_APPROVE:
		{
			Guild::cmd_GuildApprove(GetPlyMainCha(),READ_LONG(pk));
		}
		break;
	case CMD_CM_GUILD_REJECT:
		{
			Guild::cmd_GuildReject(GetPlyMainCha(),READ_LONG(pk));
		}
		break;
	case CMD_CM_GUILD_KICK:
		{
			Guild::cmd_GuildKick(GetPlyMainCha(),READ_LONG(pk));
		}
		break;
	case CMD_CM_GUILD_LEAVE:
		{
			if(!(GetPlyCtrlCha()->GetSubMap()->GetMapRes()->CanGuild()))
			{
				//GetPlyMainCha()->SystemNotice("此地图不能退会!");
				GetPlyMainCha()->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00007));
				break;
			}

			Guild::cmd_GuildLeave(GetPlyMainCha());
		}
		break;
	case CMD_CM_GUILD_DISBAND:
		{
			cChar	*l_passwd	=READ_STRING(pk);

			if(l_passwd == NULL)
				break;

			if(!strchr(l_passwd,'\''))
			{
				Guild::cmd_GuildDisband(GetPlyMainCha(),l_passwd);
			}
		}
		break;
		case CMD_CM_GUILD_MOTTO:
		{
		  uShort len;
		  cChar* l_motto = pk.ReadString(&len);
		  if(!l_motto)
			break;

		  if(!common::conformity::guild::motto::is_valid(l_motto, len))
			break;

		  Guild::cmd_GuildMotto(GetPlyMainCha(), l_motto);
		}
		break;
	case CMD_PM_GUILD_DISBAND:
		{
			Guild::cmd_PMDisband(GetPlyMainCha());
		}
		break;
	case CMD_CM_GUILD_CHALLENGE:
		{
			BYTE byLevel = READ_CHAR(pk);
			DWORD dwMoney = READ_LONG(pk);
			Guild::cmd_GuildChallenge( GetPlyMainCha(), byLevel, dwMoney );
		}
		break;
	case CMD_CM_GUILD_LEIZHU:
		{
			BYTE byLevel = READ_CHAR(pk);
			DWORD dwMoney = READ_LONG(pk);
			Guild::cmd_GuildLeizhu( GetPlyMainCha(), byLevel, dwMoney );
		}
		break;
	case CMD_CM_MAP_MASK:
		{
			if (!GetSubMap())
				break;
			//const char	*szMapName = READ_STRING(pk);
			const char	*szMapName = GetSubMap()->GetName();

			long	lDataLen;
			BYTE	*pData = GetPlayer()->GetMapMask(lDataLen);
			WPACKET wpk	= GETWPACKET();
			WRITE_CMD(wpk, CMD_MC_MAP_MASK);
			WRITE_LONG(wpk, m_ID);
			if (!pData)
			{
				WRITE_CHAR(wpk, 0);
			}
			else
			{
				WRITE_CHAR(wpk, 1);
				WRITE_SEQ(wpk, (cChar *)pData, (uShort)lDataLen);
			}
			ReflectINFof(this, wpk);
		}
		break;

	case CMD_CM_UPDATEHAIR: // 更换发型
		{
			if (!GetSubMap()) break;
			Cmd_ChangeHair(pk);
		}
		break;
	case CMD_CM_TEAM_FIGHT_ASK: // 队伍挑战请求
		{
			Char	chType = READ_CHAR(pk);
			Long	lID = READ_LONG(pk);
			Long	lHandle = READ_LONG(pk);
			Cmd_FightAsk(chType, lID, lHandle);
		}
		break;
	case CMD_CM_TEAM_FIGHT_ASR: // 队伍挑战应答
		{
			Char	chAnswer = READ_CHAR(pk);
			Cmd_FightAnswer(chAnswer != 0 ? true : false);
		}
		break;
	case CMD_CM_ITEM_REPAIR_ASK:
		{
			Long	lTarID = READ_LONG(pk);
			Long	lTarHandle = READ_LONG(pk);
			Char	chPosType = READ_CHAR(pk);
			Char	chPosID = READ_CHAR(pk);

			Cmd_ItemRepairAsk(chPosType, chPosID);
		}
		break;
	case CMD_CM_ITEM_REPAIR_ASR:
		{
			Cmd_ItemRepairAnswer(READ_CHAR(pk) != 0 ? true : false);
		}
		break;
	case CMD_CM_ITEM_FORGE_CANACTION:
		{
			short canaction = READ_CHAR(pk);
			bool bCan = (canaction == 0) ? false : true;
			ForgeAction(bCan);
			break;
		}
	case CMD_CM_ITEM_FORGE_ASK:
		{
			if (READ_CHAR(pk) == 0)
			{
				ForgeAction(false);
				break;
			}
			Char	chType = READ_CHAR(pk);
			SForgeItem	SFgeItem;
			for (int i = 0; i < defMAX_ITEM_FORGE_GROUP; i++)
			{
				SFgeItem.SGroup[i].sGridNum = READ_SHORT(pk);
				if (SFgeItem.SGroup[i].sGridNum < 0 || SFgeItem.SGroup[i].sGridNum > defMAX_KBITEM_NUM_PER_TYPE)
				{
					ForgeAction(false);
					break;
				}
				for (short j = 0; j < SFgeItem.SGroup[i].sGridNum; j++)
				{
					SFgeItem.SGroup[i].SGrid[j].sGridID = READ_SHORT(pk);
					SFgeItem.SGroup[i].SGrid[j].sItemNum = READ_SHORT(pk);
				}
			}
			Cmd_ItemForgeAsk(chType, &SFgeItem);
		}
		break;
	case CMD_CM_ITEM_FORGE_ASR:
		{
			Cmd_ItemForgeAnswer(READ_CHAR(pk) != 0 ? true : false);
		}
		break;
	case CMD_CM_KITBAG_LOCK:
		{
			GetPlyMainCha()->Cmd_LockKitbag();
		}
		break;
	case CMD_CM_LIFESKILL_ASK:
		{
			// Modify by lark.li 20080801 begin
			long type = READ_LONG(pk);
			if(type >=0 && type < 4)
			{
				long dwNpcID = READ_LONG( pk );

				SLifeSkillItem LifeSkillItem;
				LifeSkillItem.sbagCount = g_sLiveSkillNeedItemNum[type];
				for(int i = 0; i < LifeSkillItem.sbagCount; i++)
				{
					LifeSkillItem.sGridID[i] = READ_SHORT(pk);
				}
				switch(type)
				{
				case 0:
					{
						LifeSkillItem.sReturn  = atoi(GetPlayer()->GetLifeSkillinfo().c_str());
						break;
					}
				case 1:
					{
						string	strVer[2];
						Util_ResolveTextLine(GetPlayer()->GetLifeSkillinfo().c_str(),strVer,2,',');
						if(atoi(strVer[0].c_str()) > atoi(strVer[1].c_str()))
							LifeSkillItem.sReturn = 1;
						else
							LifeSkillItem.sReturn = 0;
						break;
					}
				case 2:
					{
						short sret = READ_SHORT(pk);
						string	strVer[3];
						Util_ResolveTextLine(GetPlayer()->GetLifeSkillinfo().c_str(),strVer,3,',');
						int count = atoi(strVer[0].c_str())+atoi(strVer[1].c_str())+atoi(strVer[2].c_str());
						count -= 9;
						if(count >0) 
							count = 1;
						else
							count = 0;
						if(count == sret)
							LifeSkillItem.sReturn = 1;
						else
							LifeSkillItem.sReturn = 0;
						break;
					}
				case 3:
					{
						LifeSkillItem.sReturn = READ_SHORT(pk);
						break;
					}
				}
				Cmd_LifeSkillItemAsk(type,&LifeSkillItem);
			}
			//long type = READ_LONG(pk);
			//long dwNpcID = READ_LONG( pk );

			//SLifeSkillItem LifeSkillItem;
			//LifeSkillItem.sbagCount = g_sLiveSkillNeedItemNum[type];
			//for(int i = 0; i < LifeSkillItem.sbagCount; i++)
			//{
			//	LifeSkillItem.sGridID[i] = READ_SHORT(pk);
			//}
			//switch(type)
			//{
			//case 0:
			//	{
   //                 LifeSkillItem.sReturn  = atoi(GetPlayer()->GetLifeSkillinfo().c_str());
			//		break;
			//	}
			//case 1:
			//	{
			//		string	strVer[2];
			//		Util_ResolveTextLine(GetPlayer()->GetLifeSkillinfo().c_str(),strVer,2,',');
			//		if(atoi(strVer[0].c_str()) > atoi(strVer[1].c_str()))
			//			LifeSkillItem.sReturn = 1;
			//		else
			//			LifeSkillItem.sReturn = 0;
			//		break;
			//	}
			//case 2:
			//	{
			//		short sret = READ_SHORT(pk);
			//		string	strVer[3];
			//		Util_ResolveTextLine(GetPlayer()->GetLifeSkillinfo().c_str(),strVer,3,',');
			//		int count = atoi(strVer[0].c_str())+atoi(strVer[1].c_str())+atoi(strVer[2].c_str());
			//		count -= 9;
			//		if(count >0) 
			//			count = 1;
			//		else
			//			count = 0;
			//		if(count == sret)
			//			LifeSkillItem.sReturn = 1;
			//		else
			//			LifeSkillItem.sReturn = 0;
			//		break;
			//	}
			//case 3:
			//	{
			//		LifeSkillItem.sReturn = READ_SHORT(pk);
			//		break;
			//	}
			//}
			//Cmd_LifeSkillItemAsk(type,&LifeSkillItem);
			// End
			break;
		}
	case CMD_CM_LIFESKILL_ASR:
		{
			// Modify by lark.li 20080801 begin
			long type = READ_LONG(pk);

			if(type >= 0 && type < 4)
			{
				long dwNpcID = READ_LONG( pk );
				SLifeSkillItem LifeSkillItem;
				LifeSkillItem.sbagCount = g_sLiveSkillNeedItemNum[type];
				for(int i = 0; i < LifeSkillItem.sbagCount; i++)
				{
					LifeSkillItem.sGridID[i] = READ_SHORT(pk);
				}

				switch(type)
				{
				case 0:
					{
						const char * pchar =READ_STRING(pk);
						LifeSkillItem.sReturn = 1;
					}
				case 1:
					{
						LifeSkillItem.sReturn = 0;
					}
				case 2:
					{
						LifeSkillItem.sReturn  = READ_SHORT(pk);

						break;
					}
				case 3:
					{
						LifeSkillItem.sReturn = READ_SHORT(pk);
						break;
					}
				}

				Cmd_LifeSkillItemAsR(type,&LifeSkillItem);
			}

			//long type = READ_LONG(pk);
			//long dwNpcID = READ_LONG( pk );
			//SLifeSkillItem LifeSkillItem;
			//LifeSkillItem.sbagCount = g_sLiveSkillNeedItemNum[type];
			//for(int i = 0; i < LifeSkillItem.sbagCount; i++)
			//{
			//	LifeSkillItem.sGridID[i] = READ_SHORT(pk);
			//}

			//switch(type)
			//{
			//case 0:
			//	{
			//		const char * pchar =READ_STRING(pk);
			//		LifeSkillItem.sReturn = 1;
			//	}
			//case 1:
			//	{
			//		LifeSkillItem.sReturn = 0;
			//	}
			//case 2:
			//	{
			//		LifeSkillItem.sReturn  = READ_SHORT(pk);

			//		break;
			//	}
			//case 3:
			//	{
			//		LifeSkillItem.sReturn = READ_SHORT(pk);
			//		break;
			//	}
			//}

			//Cmd_LifeSkillItemAsR(type,&LifeSkillItem);
			// End
		}
		break;
	case CMD_CM_KITBAG_UNLOCK:
		{
			const char *szPwd = READ_STRING(pk);

			if(szPwd == NULL)
				break;

			GetPlyMainCha()->Cmd_UnlockKitbag(szPwd);
		}
		break;
	case CMD_CM_KITBAG_CHECK:
		{
			GetPlyMainCha()->Cmd_CheckKitbagState();
		}
		break;
	case CMD_CM_KITBAG_AUTOLOCK:
		{
			char cAutoLock = READ_CHAR(pk);
			GetPlyMainCha()->Cmd_SetKitbagAutoLock(cAutoLock);
		}
		break;
	case CMD_CM_STORE_OPEN_ASK:
		{
			const char *szPwd = READ_STRING(pk);

			if(szPwd == NULL)
				break;

			CCharacter *pMainCha = GetPlyMainCha();

			//add by ALLEN 2007-10-16
			if(pMainCha->IsReadBook())
            {
              //  pMainCha->SystemNotice("读书时不允许打开商城！");
				  pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00008));
                break;
            }

			if(pMainCha->IsStoreEnable())
			{
				break;
			}

			if(!pMainCha->CheckStoreTime(10000))
			{
				//pMainCha->SystemNotice("商城操作过于频繁,请稍后再试!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00009));
				break;
			}
			else
			{
				pMainCha->ResetStoreTime();
			}

			CPlayer	*pCply = pMainCha->GetPlayer();
			cChar *szPwd2 = pCply->GetPassword();

			if((szPwd2[0] == 0) || (!strcmp(szPwd, szPwd2)))
			{
				g_StoreSystem.RequestRoleInfo(pMainCha);
			}
			else
			{
				//pMainCha->PopupNotice("二次密码不正确!");
				pMainCha->PopupNotice(RES_STRING(GM_CHARACTERPRL_CPP_00010));

			}
		}
		break;
	case CMD_CM_STORE_CLOSE:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			pMainCha->SetStoreEnable(false);
			pMainCha->ForgeAction(false);
		}
		break;
	case CMD_CM_STORE_LIST_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			long lClsID = READ_LONG(pk);
			short sPage = READ_SHORT(pk);
			short sNum = READ_SHORT(pk);

			if(!pMainCha->IsStoreEnable())
			{
				break;
			}

			g_StoreSystem.RequestItemList(pMainCha, lClsID, sPage, sNum);
		}
		break;
	case CMD_CM_STORE_BUY_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			long lComID = READ_LONG(pk);

			if(!pMainCha->IsStoreEnable())
			{
				break;
			}

			g_StoreSystem.Request(pMainCha, lComID);
		}
		break;
	case CMD_CM_STORE_CHANGE_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			long lNum = READ_LONG(pk);

			if(!pMainCha->IsStoreEnable())
			{
				break;
			}

			if(!pMainCha->CheckStoreTime(10000))
			{
				//pMainCha->SystemNotice("商城操作过于频繁,请稍后再试!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00009));
				break;
			}
			else
			{
				pMainCha->ResetStoreTime();
			}

			g_StoreSystem.RequestChange(pMainCha, lNum);
		}
		break;
	case CMD_CM_STORE_QUERY:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			long lNum = READ_LONG(pk);

			if(!pMainCha->IsStoreEnable())
			{
				break;
			}

			g_StoreSystem.RequestRecord(pMainCha, lNum);
		}
		break;
	//case CMD_CM_STORE_VIP:
	//	{
	//		CCharacter *pMainCha = GetPlyMainCha();
	//		short sVipID = READ_SHORT(pk);
	//		short sMonth = READ_SHORT(pk);

	//		if(!pMainCha->IsStoreEnable())
	//		{
	//			break;
	//		}

	//		if(!pMainCha->CheckStoreTime(10000))
	//		{
	//			//pMainCha->SystemNotice("商城操作过于频繁,请稍后再试!");
	//			pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00009));
	//			break;
	//		}
	//		else
	//		{
	//			pMainCha->ResetStoreTime();
	//		}

	//		if(pMainCha->GetPlayer()->GetVipType() > 0)
	//		{
	//			//pMainCha->PopupNotice("你已经是白金会员了!");
	//			pMainCha->PopupNotice(RES_STRING(GM_CHARACTERPRL_CPP_00011));
	//			break;
	//		}

	//		g_StoreSystem.RequestVIP(pMainCha, sVipID, sMonth);
	//	}
	//	break;
	case CMD_CM_TIGER_START:
		{
			DWORD dwNpcID = READ_LONG( pk );

			for(int i = 0; i < 3; i++)
			{
				short sTigerSel = READ_SHORT(pk);
				m_sTigerSel[i] = (sTigerSel > 0) ? 1 : 0;
			}

			CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
			if( pCha == NULL )
				break;

			CCharacter *pMainCha = GetPlyMainCha();
			pMainCha->DoTigerScript("TigerStart");
		}
		break;
	case CMD_CM_TIGER_STOP:
		{
			DWORD dwNpcID = READ_LONG( pk );
			CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
			if( pCha == NULL )
				break;

			CCharacter *pMainCha = GetPlyMainCha();
			short sNum = READ_SHORT(pk);

			if(sNum < 1 || sNum > 3)
			{
				pMainCha->ForgeAction(false);
				memset(m_sTigerItemID, 0, sizeof(m_sTigerItemID));
				memset(m_sTigerSel, 0, sizeof(m_sTigerSel));
				break;
			}

			short sIndex = 3 * (sNum - 1);
			bool bSucc = true;
			WPACKET wpk	= GETWPACKET();
			WRITE_CMD(wpk, CMD_MC_TIGER_ITEM_ID);
			WRITE_SHORT(wpk, sNum);
			for(int i = 0; i < 3; i++)
			{
				if(pMainCha->m_sTigerItemID[sIndex] <= 0)
				{
					bSucc = false;
				}
				WRITE_SHORT(wpk, pMainCha->m_sTigerItemID[sIndex++]);
			}
			ReflectINFof(this, wpk);

			if(bSucc)
			{
				if(sNum == 3)
				{
					pMainCha->DoTigerScript("TigerStop");
					memset(m_sTigerItemID, 0, sizeof(m_sTigerItemID));
					memset(m_sTigerSel, 0, sizeof(m_sTigerSel));
				}
			}	
		}
		break;
	case CMD_CM_VOLUNTER_OPEN:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			short sNum = READ_SHORT(pk);
			
			// Add by lark.li 20090311 begin
			// 客户端缺省是10
			if(sNum <= 0 || sNum > 20)
				break;
			// End

			int nVolNum = g_pGameApp->GetVolNum();
			int nStart = 0;
			short sRetNum = (nVolNum - nStart < sNum) ? (nVolNum - nStart) : sNum;
			if(sRetNum < 0)
				sRetNum = 0;
			short sPageNum = (nVolNum % sNum == 0) ? (nVolNum / sNum) : (nVolNum / sNum + 1);

			char chState = (pMainCha->IsVolunteer() ? 1 : 0);
			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_VOLUNTER_OPEN);
			WRITE_CHAR(packet,chState);
			WRITE_SHORT(packet, sPageNum);
			WRITE_SHORT(packet,sRetNum);
			for(int i = 0; i < sRetNum; i++)
			{
				SVolunteer *pVolunteer = g_pGameApp->GetVolInfo(nStart + i);

				if(pVolunteer)
				{
					WRITE_STRING(packet, pVolunteer->szName);
					WRITE_LONG(packet, pVolunteer->lLevel);
					WRITE_LONG(packet, pVolunteer->lJob);
					WRITE_STRING(packet, pVolunteer->szMapName);
				}
				else
				{
					WRITE_STRING(packet, "none name");
					WRITE_LONG(packet, 0);
					WRITE_LONG(packet, 0);
					WRITE_STRING(packet, "none map");
				}
			}
			ReflectINFof(this, packet);
		}
		break;
	case CMD_CM_VOLUNTER_LIST:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			short sPage = READ_SHORT(pk);
			// Add by lark.li 20090313 begin
			// 当前页码
			if(sPage <= 0 || sPage > 20)
				break;
			// End

			short sNum = READ_SHORT(pk);

			// Add by lark.li 20090311 begin
			// 客户端缺省是10
			if(sNum <= 0 || sNum > 20)
				break;
				break;
			// End

			int nVolNum = g_pGameApp->GetVolNum();
			int nStart = (sPage - 1) * sNum;
			short sRetNum = (nVolNum - nStart < sNum) ? (nVolNum - nStart) : sNum;
			if(sRetNum < 0)
				sRetNum = 0;
			short sPageNum = (nVolNum % sNum == 0) ? (nVolNum / sNum) : (nVolNum / sNum + 1);

			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_VOLUNTER_LIST);
			WRITE_SHORT(packet, sPageNum);
			WRITE_SHORT(packet, sPage);
			WRITE_SHORT(packet,sRetNum);
			for(int i = 0; i < sRetNum; i++)
			{
				SVolunteer *pVolunteer = g_pGameApp->GetVolInfo(nStart + i);

				if(pVolunteer)
				{
					WRITE_STRING(packet, pVolunteer->szName);
					WRITE_LONG(packet, pVolunteer->lLevel);
					WRITE_LONG(packet, pVolunteer->lJob);
					WRITE_STRING(packet, pVolunteer->szMapName);
				}
				else
				{
					WRITE_STRING(packet, "none name");
					WRITE_LONG(packet, 0);
					WRITE_LONG(packet, 0);
					WRITE_STRING(packet, "none map");
				}
			}
			ReflectINFof(this, packet);
		}
		break;
	case CMD_CM_VOLUNTER_ADD:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			pMainCha->Cmd_AddVolunteer();
			pMainCha->SynVolunteerState(pMainCha->IsVolunteer());
		}
		break;
	case CMD_CM_VOLUNTER_DEL:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			pMainCha->Cmd_DelVolunteer();
			pMainCha->SynVolunteerState(pMainCha->IsVolunteer());
		}
		break;
	case CMD_CM_VOLUNTER_SEL:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szName = READ_STRING(pk);

			// Add by lark.li 20090313 begin
			if(!szName)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), "None");
				break;
			}
			// End

			CCharacter *pTarCha = FindVolunteer(szName);
			if(!pTarCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(pTarCha == pMainCha)
			{
				//pMainCha->SystemNotice("你不能同自己组队!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00013));
				break;
			}

			// Add by lark 20080923 begin
			SubMap* pTarSubMap = pTarCha->GetSubMap();
			SubMap* pSubMap = GetSubMap();

			if(pTarSubMap == NULL || pSubMap == NULL)
			{
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00014));
				LG( "vloluter", "pTarCha %s pMainCha %s\r\n", (pTarSubMap == NULL ? "Null" : "Ok"), (pSubMap == NULL ? "Null" : "Ok"));
				break;
			}

			CMapRes* pTarMapRes = pTarSubMap->GetMapRes();
			CMapRes* pMapRes = pSubMap->GetMapRes();

			if(pTarSubMap == NULL || pSubMap == NULL)
			{
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00014));
				LG( "vloluter", "pTarCha %s pMainCha %s\r\n", (pTarMapRes == NULL ? "Null" : pTarMapRes->GetName()), (pMapRes == NULL ? "Null" : pMapRes->GetName()));
				break;
			}

			// End

			if(strcmp(pTarCha->GetSubMap()->GetName(), GetSubMap()->GetName()))
			{
				//pMainCha->SystemNotice("很遗憾的, 你们不在同一个地图!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00014));
				break;
			}

			if(!(GetPlyCtrlCha()->GetSubMap()->GetMapRes()->CanTeam()))
			{
				//pMainCha->SystemNotice("此地图不能组队!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00015));
				break;
			}

			//pMainCha->SystemNotice("您的邀请已发出,请耐心等待回应!");
			pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00016));

			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_VOLUNTER_ASK);
			WRITE_STRING(packet, pMainCha->GetName());
			pTarCha->ReflectINFof(pTarCha, packet);
		}
		break;
	case CMD_CM_VOLUNTER_ASR:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			short sRet = READ_SHORT(pk);
			cChar *szName = READ_STRING(pk);

			// Add by lark.li 20090313 begin
			if(!szName)
			{
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), "None");
				break;
			}
			// End

			CCharacter *pSrcCha = g_pGameApp->FindChaByName(szName);
			if(!pSrcCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(sRet == 0)
			{
				//pSrcCha->SystemNotice("%s 不同意和您组队!", pMainCha->GetName());
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00018), pMainCha->GetName());
				break;
			}
			else if(sRet == 1)
			{
				WPacket l_wpk = GETWPACKET();
				WRITE_CMD(l_wpk,CMD_MP_TEAM_CREATE);
				WRITE_STRING(l_wpk,pSrcCha->GetName());
				WRITE_STRING(l_wpk,pMainCha->GetName());
				pMainCha->ReflectINFof(pMainCha,l_wpk);
			}
		}
		break;
	case CMD_CM_KITBAGTEMP_SYNC:
		{
			CCharacter *pMainCha = GetPlyMainCha();

			if(!pMainCha->m_pCKitbagTmp)
			{
				break;
			}

			WPACKET pkret = GETWPACKET();
			WRITE_CMD(pkret, CMD_MC_KITBAGTEMP_SYNC);
			pMainCha->WriteKitbag(pMainCha->m_pCKitbagTmp, pkret, enumSYN_KITBAG_INIT);
			pMainCha->ReflectINFof(pMainCha, pkret);

			long lStoreItemID = pMainCha->GetStoreItemID();
			if(lStoreItemID > 0)
			{
				if(g_StoreSystem.Accept(pMainCha, lStoreItemID))
				{
					pMainCha->SetStoreItemID(0);
				}
			}
		}
		break;
		// Add by lark.li 20080707 begin
	case CMD_CM_CAPTAIN_CONFIRM_ASR:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(pMainCha == NULL)
				break;

			short sRet = READ_SHORT(pk);
			DWORD dwTeamID = READ_LONG(pk);

			if(dwTeamID < 0)
				break;

			pMainCha->Cmd_CaptainConfirmAnswer(sRet, dwTeamID);
		}
		break;
		// End
		//Add by sunny.sun 20090313
	case CMD_CM_SELECT_TIME_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(pMainCha)
			{
				char  cIsGet = READ_CHAR(pk);
				short sSeltime = READ_SHORT(pk);
				short sGridPos = READ_SHORT(pk);
				short sNum = READ_SHORT(pk);
				pMainCha->Cmd_SelectTimeExperience_Ask( cIsGet, sSeltime, sGridPos, sNum );
			}
		}
		break;
	case CMD_CM_SELECT_COIN_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(pMainCha)
			{
				short sBottonNo = READ_SHORT(pk);
				short sNum = READ_SHORT(pk);
				pMainCha->Cmd_SelectCoinAsk( sBottonNo, sNum);
			}
		}
		break;
		//Add by sunny.sun 20090402
	case CMD_CM_REQUEST_JEWELRYUP_ASK:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			if(pMainCha)
			{
				short sIsGet = READ_SHORT(pk);
				short sItemPos = READ_SHORT(pk);
				short sSelNO = READ_SHORT(pk);
				pMainCha->Cmd_SelectJewelryupAsk( sIsGet, sItemPos, sSelNO);
			}		
		}
		break;
#ifdef SHUI_JING
	case CMD_CM_OPEN_CRYSTALTRADE_ASK:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter *pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					// 取客户端发来的二次密码
					const char *szPwd = READ_STRING(pk);
					if(szPwd == NULL)
						break;
					CPlayer	*pCply = pMainCha->GetPlayer();
					if( pCply )
					{	
						// 取数据库中保存的二次密码
						cChar *szPwd2 = pCply->GetPassword();
						if(szPwd2 == NULL)
							break;

						if((szPwd2[0] == 0) || (!strcmp(szPwd, szPwd2)))
						{
							g_StoreSystem.RequestActInfo( pMainCha );
						}
						else
						{
							WPACKET	rpk	= GETWPACKET();
							WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
							WRITE_CHAR( rpk, 0 );//失败				
							pMainCha->ReflectINFof(	pMainCha,	rpk	);
						}
					}
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}

		}
		break;
	case CMD_CM_REQUEST_BUY_ASK:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter *pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					DWORD iCslPrice = (DWORD)READ_LONG(pk);
					int iCslNum = READ_LONG(pk);
					char type = READ_CHAR(pk);//快买or挂单
					pMainCha->Cmd_CrystalBuyAsk( iCslPrice, iCslNum, type );
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}
		break;
	case CMD_CM_REQUEST_SALE_ASK:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter *pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					DWORD iCslPrice = (DWORD)READ_LONG(pk);
					int iCslNum = READ_LONG(pk);
					char type = READ_CHAR(pk);//快卖or挂单
					pMainCha->Cmd_CrystalSaleAsk( iCslPrice, iCslNum,type );
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}
		break;
	case CMD_CM_REQUEST_CANCEL_ASK:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter* pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					DWORD	l_curtick	= GetCurrentTime();
					if( l_curtick - this->m_cancelSaletick < 30 * 1000 )
				{
					WPACKET pk = GETWPACKET();
					WRITE_CMD( pk, CMD_MC_REQUEST_CANCEL_ASR );
					WRITE_CHAR( pk, '2');
					ReflectINFof(this,pk);	
					return;
				}
				else
				{
						this->m_cancelSaletick = l_curtick;
						int type = READ_SHORT(pk);
						pMainCha->Cmd_CrystalCancelAsk( type );
					}
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}
		break;
	case CMD_CM_REQUEST_GETFLATMONEY:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter* pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					DWORD	l_curtick	= GetCurrentTime();
					if( l_curtick - this->m_getmoneytick < 30 * 1000 )
				{
					WPACKET	rpk	=	GETWPACKET();
					WRITE_CMD(	rpk, CMD_MC_REQUEST_GETFLATMONEY	);
					WRITE_CHAR( rpk, '2');
					ReflectINFof(this,rpk);	
					return;
				}
				else
				{
						this->m_getmoneytick = l_curtick;
						DWORD Money = READ_LONG(pk);
						pMainCha->Cmd_GetCrystalFlatMoneyTOGD( Money );
					}
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}
		break;
	case CMD_CM_REQUEST_REFRESH_ASK:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{
				CCharacter* pMainCha = GetPlyMainCha();
				if( pMainCha )
				{
					WPACKET	rpk	=	GETWPACKET();
					DWORD	l_curtick	= GetCurrentTime();
				if( l_curtick - this->m_refreshtick < 30 * 1000 )
				{
					WRITE_CMD(	rpk, CMD_MC_REQUEST_REFRESH_ASR	);
					WRITE_CHAR( rpk, '2');
					ReflectINFof(this,rpk);	
					return;
				}
				else
				{
					this->m_refreshtick = l_curtick;
						WRITE_CMD(	rpk, CMD_MC_REQUEST_REFRESH_ASR	);
						WRITE_CHAR( rpk, '1');
						ReflectINFof(this,rpk);	
						pMainCha->Cmd_CrystalBuyAndSaleList();
					}
				}		
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}break;
	case CMD_CM_CHA_CONFIRM_CRYSTALTRADE:
		{
			if( g_StoreSystem.IsCrystalTrade() )
			{

				CCharacter* pMainCha = GetPlyMainCha();
				int type = READ_SHORT( pk );
				int state = READ_SHORT( pk );
				if( state == 1 )
					break;
			if( pMainCha )
			{
				if( type == 2 )
				{
					game_db.ChangeStateByTemp( pMainCha->GetID(), CrystalTradeType::enumbuy, CrystalTradeType::enumstart );
					game_db.ChangeStateByTemp( pMainCha->GetID(), CrystalTradeType::enumsale, CrystalTradeType::enumstart );
					return;
					}
					if( type == 0 || type == 1 )
					{
						//修改为开始状态，不让每次登录都发消息
						game_db.ChangeStateByTemp( pMainCha->GetID(), CrystalTradeType::TradeType( type ), CrystalTradeType::enumstart );
						return;
					}
				}
			}
			else
			{
				WPACKET	rpk	= GETWPACKET();
				WRITE_CMD( rpk, CMD_MC_OPEN_CRYSTALTRADE_ASR );
				WRITE_CHAR( rpk, 2 );//失败				
				ReflectINFof(	this,	rpk	);
			}
		}
		break;
#endif
		//	2008-7-28	yangyinyu	add	begin!
	case	CMD_CM_ITEM_LOCK_ASK:	//	处理道具锁定请求。
		{
			//	准备返回消息包。
			WPACKET	rpk	=	GETWPACKET();
			WRITE_CMD(	rpk,	CMD_CM_ITEM_LOCK_ASR	);

			//	取人物，取包裹。
			CCharacter*	pMainCha	=	GetPlyMainCha();

			if(	pMainCha	)
			{
				//	寻找锁道具。
				dbc::Char	chPosType_lock	=	READ_CHAR( pk	);
				dbc::Long	lItemID			=	READ_LONG( pk	);
				
				SItemGrid*	lock_item	=	pMainCha->GetKitbag()->GetGridContByID(	chPosType_lock	);
				if(	lock_item	&&	lock_item->sID	==	5939	)
				{
					//	寻找被锁的道具。
					dbc::Char	chPosType	=	READ_CHAR(	pk	);
					dbc::Long	lItemID		=	READ_LONG(	pk	);

					SItemGrid*	item	=	pMainCha->GetKitbag()->GetGridContByID(	chPosType	);
					if(	item	)
					{
						//	检查道具类型。
						CItemRecord	*pCItemRec = GetItemRecordInfo(	item->sID );

						if(	pCItemRec	&&	(
									pCItemRec->sType	==	enumItemTypeSword			// 剑
								||	pCItemRec->sType	==	enumItemTypeGlave			// 巨剑
								||	pCItemRec->sType	==	enumItemTypeBow				// 弓
								||	pCItemRec->sType	==	enumItemTypeHarquebus		// 火绳枪
								||	pCItemRec->sType	==	enumItemTypeFalchion		// 刀
								||	pCItemRec->sType	==	enumItemTypeMitten			// 拳套
								||	pCItemRec->sType	==	enumItemTypeStylet			// 匕首
								||	pCItemRec->sType	==	enumItemTypeCosh			// 短棒
								||	pCItemRec->sType	==	enumItemTypeSinker			// 锤子
								||	pCItemRec->sType	==	enumItemTypeShield			// 盾
								||	pCItemRec->sType	==	enumItemTypeHeadpiece		// 头盔
								||	pCItemRec->sType	==	enumItemTypeClothing		// 衣服
								||	pCItemRec->sType	==	enumItemTypeGlove			// 手套
								||	pCItemRec->sType	==	enumItemTypeBoot			// 靴子
								||	pCItemRec->sType	==	enumItemTypeConch			// 贝壳
								||	pCItemRec->sType	==	enumItemTypePet				// 守护精灵
								)
							)
						{
							//	为道具在道具表中创建唯一ID并保存。
							CPlayer*	pPlayer	=	pMainCha->GetPlayer();

							if(	pPlayer	)
							{
									if(	game_db.LockItem(	item,	pPlayer->GetDBChaId()	)	)
									{
										 WRITE_CHAR(	rpk,	1	); // 1，加锁
										 // 删除锁道具 add by ning.yan 2008-11-10 begin
										pMainCha->Cmd_RemoveItem(	5939,	1,	0,	-1,	2,	0,	true,	1	);
										// end
									}
								else
								{
									WRITE_CHAR(	rpk,	0	); // 0，道具不可锁
								};

								//	删除锁道具 delete by ning.yan 2008-11-10
								// pMainCha->Cmd_RemoveItem(	5939,	1,	0,	-1,	2,	0,	true,	1	);

								//	同步背包信息。
								this->GetKitbag()->SetChangeFlag();
								this->SynKitbagNew( enumSYN_KITBAG_SWITCH );

								//	返回成功消息。
								this->ReflectINFof(	pMainCha, rpk	);
								break;
							};
						};
					};
				};
			};

			//	返回失败消息。
			WRITE_CHAR(	rpk,	0	);
			pMainCha->ReflectINFof(	pMainCha,	rpk	);
		}
		break;
//	2008-7-28	yangyinyu	add	end!

	// add by ning.yan  道具解锁  2008-11-12 begin
	case CMD_CM_ITEM_UNLOCK_ASK:
		{
			//	准备返回消息包。
			WPACKET	rpk	= GETWPACKET();
			WRITE_CMD( rpk, CMD_MC_ITEM_UNLOCK_ASR );

			//	取人物
			CCharacter*	pMainCha	=	GetPlyMainCha();
			if(	pMainCha )
			{
				// 取客户端发来的二次密码
			    const char *szPwd = READ_STRING(pk);

				if(szPwd == NULL)
					break;

				// 取数据库中保存的二次密码
				CPlayer	*pCply = pMainCha->GetPlayer();
				cChar *szPwd2 = pCply->GetPassword();

				if((szPwd2[0] == 0) || (!strcmp(szPwd, szPwd2)))
				{
					//	取锁道具
					dbc::Char	chPosType_lock	=	READ_CHAR( pk );
					dbc::Long	lItemID			=	READ_LONG( pk );

					SItemGrid*	lock_item	=	pMainCha->GetKitbag()->GetGridContByID( chPosType_lock );
					if(	lock_item && lock_item->sID	==	5939 )
					{
						// 取被锁道具。
						dbc::Char	chPosType =	READ_CHAR( pk );
						dbc::Long	lItemID	  = READ_LONG( pk );

						SItemGrid* item = pMainCha->GetKitbag()->GetGridContByID( chPosType );
						if(	item )
						{
							CItemRecord	*pCItemRec = GetItemRecordInfo(	item->sID );
							if(	pCItemRec )
							{
								//	为道具在道具表中创建唯一ID并保存。
								CPlayer* pPlayer = pMainCha->GetPlayer();

								if(	pPlayer	)
								{
									if(	game_db.UnlockItem( item, pPlayer->GetDBChaId() )  )
									{
										WRITE_CHAR(	rpk,	1	); // 1，道具解锁成功
										//	删除锁道具
										pMainCha->Cmd_RemoveItem(	5939,	1,	0,	-1,	2,	0,	true,	1	);
									}
									else
									{
										WRITE_CHAR(	rpk,	0	); // 0，解锁失败
									}

									//	同步背包信息。
									this->GetKitbag()->SetChangeFlag();
									this->SynKitbagNew( enumSYN_KITBAG_SWITCH );

									//	返回成功消息。
									this->ReflectINFof(	pMainCha, rpk	);
									break;
								}
							}
						}
					}
				}
				else
				{
					// 二次密码不正确
					WRITE_CHAR(	rpk,	2	); // 2，二次密码不正确
					pMainCha->PopupNotice(RES_STRING(GM_CHARACTERPRL_CPP_00010));

				}

			}

			//	返回失败消息
			WRITE_CHAR(	rpk,	0	);
			pMainCha->ReflectINFof(	pMainCha,	rpk	);
		}
		break;
	// ning.yan 2008-11-12 end

	case CMD_CM_MASTER_INVITE:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szName = READ_STRING(pk);

			if(szName == NULL)
				break;

			DWORD dwCharID = READ_LONG(pk);

			if(IsBoat())
			{
				//SystemNotice("船上不能拜师!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00019));
				break;
			}

			CCharacter* pTarCha = pMainCha->GetSubMap()->FindCharacter( dwCharID, pMainCha->GetShape().centre );
			if(!pTarCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(pTarCha->GetLevel() < 41)
			{
				//pMainCha->SystemNotice("对方等级不够!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00017));
				break;
			}

			if(pMainCha->GetLevel() > 40)
			{
				//pMainCha->SystemNotice("您的等级太高了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00020));
				break;
			}

			if(pMainCha->GetMasterDBID() != 0)
			{
				//pMainCha->SystemNotice("您已经有师父了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00021));
				break;
			}

			if(pTarCha->IsInvited())
			{
				//pMainCha->SystemNotice("对方在接受其他人的邀请!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00022));
				break;
			}

			pTarCha->SetInvited(true);

			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_MASTER_ASK);
			WRITE_STRING(packet, pMainCha->GetName());
			WRITE_LONG(packet, pMainCha->GetID());
			pTarCha->ReflectINFof(pTarCha, packet);
		}
		break;
	case CMD_CM_MASTER_ASR:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			short sRet = READ_SHORT(pk);
			cChar *szName = READ_STRING(pk);

			if(szName == NULL)
				break;

			DWORD dwCharID = READ_LONG(pk);

			pMainCha->SetInvited(false);

			if(IsBoat())
			{
				//SystemNotice("船上不能收徒!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00023));
				break;
			}

			CCharacter* pSrcCha = pMainCha->GetSubMap()->FindCharacter( dwCharID, pMainCha->GetShape().centre );
			if(!pSrcCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(pMainCha->GetLevel() < 41)
			{
				//pSrcCha->SystemNotice("对方的等级不够!");
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00017));
				//pMainCha->SystemNotice("您的等级不够!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00024));
				break;
			}

			if(pSrcCha->GetLevel() > 40)
			{
				//pSrcCha->SystemNotice("您的等级太高了!");
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00020));
				//pMainCha->SystemNotice("对方的等级太高了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00025));
				break;
			}

			if(sRet == 0)
			{
				//pSrcCha->SystemNotice("%s 不同意收你为徒!", pMainCha->GetName());
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00026), pMainCha->GetName());
				break;
			}

			WPacket l_wpk = GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_MASTER_CREATE);
			WRITE_STRING(l_wpk,pSrcCha->GetName());
			WRITE_LONG(l_wpk,pSrcCha->GetPlayer()->GetDBChaId());
			WRITE_STRING(l_wpk,pMainCha->GetName());
			WRITE_LONG(l_wpk,pMainCha->GetPlayer()->GetDBChaId());
			pMainCha->ReflectINFof(pMainCha,l_wpk);
		}
		break;
	case CMD_CM_MASTER_DEL:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szName = READ_STRING(pk);

			if(szName == NULL)
				break;

			uLong ulChaID = READ_LONG(pk);

			if(pMainCha->GetLevel() > 40)
			{
				//pMainCha->SystemNotice("您已经出师了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00027));
				break;
			}

			long lDelMoney = 500 * pMainCha->GetLevel();
			if(!pMainCha->HasMoney(lDelMoney))
			{
				//pMainCha->SystemNotice("您的金钱不够!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00028));
				break;
			}
			//pMainCha->TakeMoney("系统", lDelMoney);
			pMainCha->TakeMoney(RES_STRING(GM_CHARSCRIPT_CPP_00001), lDelMoney);

			WPacket l_wpk = GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_MASTER_DEL);
			WRITE_STRING(l_wpk,pMainCha->GetName());
			WRITE_LONG(l_wpk,pMainCha->GetPlayer()->GetDBChaId());
			WRITE_STRING(l_wpk,szName);
			WRITE_LONG(l_wpk,ulChaID);
			pMainCha->ReflectINFof(pMainCha,l_wpk);
		}
		break;
	case CMD_CM_PRENTICE_DEL:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szName = READ_STRING(pk);

			if(szName == NULL)
				break;

			uLong ulChaID = READ_LONG(pk);

			//long lDelMoney = 10000 * pMainCha->GetLevel();
			//if(!pMainCha->HasMoney(lDelMoney))
			//{
			//	pMainCha->SystemNotice("您的金钱不够!");
			//	break;
			//}
			//pMainCha->TakeMoney("系统", lDelMoney);
			long lCredit = (long)pMainCha->GetCredit() - 5 * pMainCha->GetLevel();
			if(lCredit < 0)
			{
				lCredit = 0;
			}
			pMainCha->SetCredit(lCredit);
			pMainCha->SynAttr(enumATTRSYN_TASK);
			//pMainCha->SystemNotice("您的声望下降了!");
			pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00029));

			WPacket l_wpk = GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_MASTER_DEL);
			WRITE_STRING(l_wpk,szName);
			WRITE_LONG(l_wpk,ulChaID);
			WRITE_STRING(l_wpk,pMainCha->GetName());
			WRITE_LONG(l_wpk,pMainCha->GetPlayer()->GetDBChaId());
			pMainCha->ReflectINFof(pMainCha,l_wpk);
		}
		break;
	case CMD_CM_PRENTICE_INVITE:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szName = READ_STRING(pk);

			if(szName == NULL)
				break;

			DWORD dwCharID = READ_LONG(pk);

			if(IsBoat())
			{
				//SystemNotice("船上不能收徒!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00023));
				break;
			}

			CCharacter* pTarCha = pMainCha->GetSubMap()->FindCharacter( dwCharID, pMainCha->GetShape().centre );
			if(!pTarCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(pMainCha->GetLevel() < 41)
			{
				//pMainCha->SystemNotice("您的等级不够!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00024));
				break;
			}

			if(pTarCha->GetLevel() > 40)
			{
				//pMainCha->SystemNotice("对方的等级太高了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00025));
				break;
			}

			if(pTarCha->IsInvited())
			{
				//pMainCha->SystemNotice("对方在接受其他人的邀请!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00022));
				break;
			}

			pTarCha->SetInvited(true);

			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_PRENTICE_ASK);
			WRITE_STRING(packet, pMainCha->GetName());
			WRITE_LONG(packet, pMainCha->GetID());
			pTarCha->ReflectINFof(pTarCha, packet);
		}
		break;
	case CMD_CM_PRENTICE_ASR:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			short sRet = READ_SHORT(pk);
			cChar *szName = READ_STRING(pk);
			
			if(szName == NULL)
				break;

			DWORD dwCharID = READ_LONG(pk);

			pMainCha->SetInvited(false);

			if(IsBoat())
			{
				//SystemNotice("船上不能拜师!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00019));
				break;
			}

			CCharacter* pSrcCha = pMainCha->GetSubMap()->FindCharacter( dwCharID, pMainCha->GetShape().centre );
			if(!pSrcCha)
			{
				//pMainCha->SystemNotice("%s 已经离开了!", szName);
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00012), szName);
				break;
			}

			if(pSrcCha->GetLevel() < 41)
			{
				//pSrcCha->SystemNotice("您的等级不够!");
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00024));
				//pMainCha->SystemNotice("对方的等级不够!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00017));
				break;
			}

			if(pMainCha->GetLevel() > 40)
			{
				//pSrcCha->SystemNotice("对方的等级太高了!");
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00025));
				//pMainCha->SystemNotice("您的等级太高了!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00020));
				break;
			}

			if(sRet == 0)
			{
				//pSrcCha->SystemNotice("%s 不同意拜你为师!", pMainCha->GetName());
				pSrcCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00030), pMainCha->GetName());
				break;
			}

			WPacket l_wpk = GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_MASTER_CREATE);
			WRITE_STRING(l_wpk,pMainCha->GetName());
			WRITE_LONG(l_wpk,pMainCha->GetPlayer()->GetDBChaId());
			WRITE_STRING(l_wpk,pSrcCha->GetName());
			WRITE_LONG(l_wpk,pSrcCha->GetPlayer()->GetDBChaId());
			pMainCha->ReflectINFof(pMainCha,l_wpk);
		}
		break;
	case CMD_CM_SAY2CAMP:
		{
			CCharacter *pMainCha = GetPlyMainCha();
			cChar *szContent = READ_STRING(pk);
			CCharacter *pCha = NULL;
			SubMap *pSubMap = GetPlyCtrlCha()->GetSubMap();

			BOOL bHasGuild = pMainCha->HasGuild();
			if(!bHasGuild)
			{
				//SystemNotice("你还没有加入公会!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00031));
				break;
			}

			if(pSubMap->GetMapRes()->CanGuildWar())
			{
				char cGuildType = pMainCha->GetGuildType();

				pSubMap->BeginGetPlyCha();
				while(pCha = pSubMap->GetNextPlyCha())
				{
					if(pCha->HasGuild() && pCha->GetGuildType() == cGuildType)
					{
						WPacket l_wpk = GETWPACKET();
						WRITE_CMD(l_wpk, CMD_MC_SAY2CAMP);
						WRITE_STRING(l_wpk, pMainCha->GetName());
						WRITE_STRING(l_wpk, szContent);
						pCha->ReflectINFof(pCha, l_wpk);
					}
				}
			}
			else
			{
				//SystemNotice("本频道只能在圣战地图内使用!");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00032));
			}
		}
		break;
	case CMD_CM_GM_SEND:
		{
			// Add by lark.li 20090313 begin
			if(m_submap)
				break;
			// End

			CCharacter *pMainCha = GetPlyMainCha();

			DWORD dwNpcID = READ_LONG( pk );
			CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
			if( pCha == NULL )
				break;

			cChar *szTitle = READ_STRING(pk);

			// Add by lark.li 20090311 begin
			if(!szTitle)
				break;
			// End

			cChar *szContent = READ_STRING(pk);

			// Add by lark.li 20090311 begin
			if(!szContent)
				break;
			// End

			if(strlen(szTitle) > 32 || strlen(szContent) > 512)
			{
				//pMainCha->SystemNotice("邮件长度非法!");
				pMainCha->SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00033));
				break;
			}
			g_StoreSystem.RequestGMSend(pMainCha, szTitle, szContent);
		}
		break;
	case CMD_CM_GM_RECV:
		{
			CCharacter *pMainCha = GetPlyMainCha();

			DWORD dwNpcID = READ_LONG( pk );
			CCharacter* pCha = m_submap->FindCharacter( dwNpcID, GetShape().centre );
			if( pCha == NULL )
				break;

			g_StoreSystem.RequestGMRecv(pMainCha);
		}
		break;
    case CMD_CM_PK_CTRL:
		{
			CCharacter *pMainCha = GetPlyMainCha();

			if (READ_CHAR(pk))
				Cmd_SetInPK();
			else
				Cmd_SetInPK(false);
			SynPKCtrl();

		}
		break;
	case CMD_CM_CHEAT_CHECK:
		{
			//防外挂暂时不上
			/*CCharacter *pMainCha = GetPlyMainCha();

			cChar *answer = READ_STRING(pk);
			pMainCha->CheatCheck(answer);*/
		}
		break;
	case CMD_CM_BIDUP:
		//add by ALLEN 2007-10-19
		{
			//婚姻系统暂时不上
			CCharacter *pMainCha = GetPlyMainCha();
			if (g_CParser.DoString("YORN", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pMainCha, DOSTRING_PARAM_END))
			{
				if(g_CParser.GetReturnNumber(0))
				{
					DWORD dwNpcID = READ_LONG( pk );
					CCharacter* pNpc = m_submap->FindCharacter( dwNpcID, GetShape().centre );
					if( pNpc == NULL )
					{
						//SystemNotice( "竞价NPCID%d无效！", dwNpcID );
						SystemNotice( RES_STRING(GM_CHARACTERPRL_CPP_00034), dwNpcID );
						break;
					}
					short sItemID = READ_SHORT(pk);
					long price = READ_LONG(pk);
					g_AuctionSystem.BidUp(pMainCha, sItemID, (uInt)price);
					g_AuctionSystem.NotifyAuction( this, pNpc );
				}
			}
		}
        break;
#ifdef XTRAP_S
	//Add by sunny.sun 20090728
	case XTRAP_CMD_STEP_TWO:
		{
			int nRet;
			uShort len = 128;
			const char* sTemp = READ_SEQ( pk, len );
			nRet = XTrap_CS_Step3( SessionBuf,sTemp );
			//if( nRet!= XTRAP_CC_RETURN_OK )
			//{
			//	switch( nRet )
			//	{
			//	case XTRAP_CC_RETURN_ERROR:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_ERROR);
			//		break;
			//	case XTRAP_CC_RETURN_UNKNOWN:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_UNKNOWN);
			//		break;
			//	case XTRAP_CC_RETURN_INVALID_PARAMETER:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_INVALID_PARAMETER);
			//		break;
			//	case XTRAP_CC_RETURN_CRC:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_CRC);
			//		break;
			//	case XTRAP_CC_RETURN_TIMEOUT:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_TIMEOUT);
			//		break;
			//	case XTRAP_CC_RETURN_DETECTHACK:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_DETECTHACK);
			//		break;
			//	default:
			//		LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step3 has error, reason = %d\n", this->GetName(), this->GetID(), nRet);
			//		break;
			//	}
			//	//KICKPLAYER(this->GetPlayer(), 0);
			//	//g_pGameApp->GoOutGame(this->GetPlayer(), true);
			//	return;

			//}
		}
		break;
#endif
	default:
		break;
	}
T_E}

#ifdef XTRAP_S
void CCharacter::MapFileChange()
{
	DWORD dwRet = 0;
	FILE*  fi;
	
	fi = fopen("Map.cs3","rb");
	if( fi == NULL )
	{
		std::cout<<"Can't Read Map.cs3!\n"<<std::endl;
		return;
	}
	memset( g_XTrapMap, 0, sizeof(g_XTrapMap));
	fread( g_XTrapMap[0], XTRAP_CS4_BUFSIZE_MAP, 1, fi );
	fclose( fi );
}
#endif

void CCharacter::BeginAction(RPACKET pk)
{T_B
	const long clPing = 300;

	if (!IsLiveing())
	{
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("拒绝行动请求(自身不存在)\n\n");
		m_CLog.Log("refuse action request(self inexistent)\n\n");
		return;
	}
	if (GetPlayer()->GetCtrlCha() == this && !GetSubMap())
	{
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
		m_CLog.Log("refuse action request(map is null)\n\n");
		return;
	}

	uLong ulPacketId = 0;
#ifdef defPROTOCOL_HAVE_PACKETID
	ulPacketId = READ_LONG(pk);
#endif
	Char chActionType= READ_CHAR(pk);

	m_CLog.Log("Begin Action: \t%d\tPacketID: %u\n", chActionType, ulPacketId);
	//GameServerLG(g_strLogName.c_str(), "Begin Action: \t%d\tPacketID: %ld\n", chActionType, ulPacketId);

	m_ulPacketID = ulPacketId;
	switch (chActionType)
	{
	case	enumACTION_MOVE:
		{
			if (!GetSubMap())
			{
				m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
				//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
				m_CLog.Log("refuse action request(map is null)\n\n");
				return;
			}

			if (m_CAction.GetCurActionNo() >= 0) // 之前的行动没有结束
			{
				FailedActionNoti(enumACTION_MOVE, enumFACTION_EXISTACT);
				//SystemNotice("不合法的行动请求(先前的行动没有结束)\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00035));
				//m_CLog.Log("不合法的行动请求(先前的行动没有结束)[PacketID: %u]\n", ulPacketId);
				m_CLog.Log("irregular action request(foregone action hasn't finish)[PacketID: %u]\n", ulPacketId);
				break;
			}

			if (m_sPoseState == enumPoseSeat)
			{
				FailedActionNoti(enumACTION_MOVE, enumFACTION_EXISTACT);
				//SystemNotice("不合法的行动请求(先前的行动没有结束)\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00035));
				//m_CLog.Log("不合法的行动请求(先前的行动没有结束)[PacketID: %u]\n", ulPacketId);
				m_CLog.Log("irregular action request(foregone action hasn't finish)[PacketID: %u]\n", ulPacketId);
				break;
			}
			ResetPosState();

			uShort ulTurnNum;
			cChar *pData = READ_SEQ(pk, ulTurnNum);
			Point Path[defMOVE_INFLEXION_NUM];
			Char chPointNum;
			if (!pData)
			{
				FailedActionNoti(enumACTION_MOVE, enumFACTION_MOVEPATH);
				//SystemNotice("移动路径错误，没有移动序列点\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00036));
				//m_CLog.Log("移动路径错误，没有移动序列点\n");
				m_CLog.Log("move path error,don't have move sequence point\n");
				break;
			}
			if(ulTurnNum <= 0)
			{
				m_CLog.Log("move path error TurnNum <= 0 \n");
				break;
			}
			else if ((chPointNum = Char(ulTurnNum / sizeof(Point))) > defMOVE_INFLEXION_NUM)
			{
				FailedActionNoti(enumACTION_MOVE, enumFACTION_MOVEPATH);
				//SystemNotice("移动路径错误(拐点数:%d，最大拐点数:%d)\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM);
				//SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00037), ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM);
				char szData[128];
				CFormatParameter param(2);
				param.setDouble( 0, ulTurnNum / sizeof(Point) );
				param.setDouble( 1, defMOVE_INFLEXION_NUM );
				RES_FORMAT_STRING( GM_CHARACTERPRL_CPP_00037, param, szData );
				SystemNotice( szData );
				//m_CLog.Log("移动路径错误(拐点数:%d，最大拐点数:%d)[PacketID: %u]\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM, ulPacketId);
				m_CLog.Log("move path error(inflexion number:%d，max inflexion number:%d)[PacketID: %u]\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM, ulPacketId);
				break;
			}
			memcpy(Path, pData, chPointNum*sizeof(Point));

			Cmd_BeginMove((Short)m_dwPing, Path, chPointNum);
		}
		break;
	case	enumACTION_SKILL:
		{
			if(GetPlyMainCha()->GetKitbag()->IsLock())
			{
				//SystemNotice("背包处于锁定状态，施放技能失败！\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00038));
				FailedActionNoti(enumACTION_SKILL, enumFACTION_ACTFORBID);
				break;
			}

			if (!GetSubMap())
			{
				m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
				//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
				m_CLog.Log("refuse action request(map is null)\n\n");
				return;
			}

            if(GetPlayer()->GetBankNpc())
            {
                //SystemNotice("请先关闭银行！\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00039));
                FailedActionNoti(enumACTION_SKILL, enumFACTION_ACTFORBID);
                break;
            }

			if (m_CAction.GetCurActionNo() >= 0) // 之前的行动没有结束
			{
				FailedActionNoti(enumACTION_SKILL, enumFACTION_EXISTACT);
				//SystemNotice("不合法的行动请求(先前的行动没有结束)\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00035));
				//m_CLog.Log("不合法的行动请求(先前的行动没有结束)[PacketID: %u]\n", ulPacketId);
				m_CLog.Log("irregular action request(foregone action hasn't finish)[PacketID: %u]\n", ulPacketId);
				break;
			}

			if (m_sPoseState == enumPoseSeat)
			{
				FailedActionNoti(enumACTION_SKILL, enumFACTION_EXISTACT);
				//SystemNotice("不合法的行动请求(先前的行动没有结束)\n");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00035));
				//m_CLog.Log("不合法的行动请求(先前的行动没有结束)[PacketID: %u]\n", ulPacketId);
				m_CLog.Log("irregular action request(foregone action hasn't finish)[PacketID: %u]\n", ulPacketId);
				break;
			}
			ResetPosState();

			char chMove = READ_CHAR(pk);
			if (chMove == 2) // 移动到目标点后再使用技能
			{
				Char chFightID = READ_CHAR(pk);
				// 移动包
				Point Path[defMOVE_INFLEXION_NUM];
				Char chPointNum;
				uShort ulTurnNum;
				cChar *pData = READ_SEQ(pk, ulTurnNum);
				if (!pData)
				{
					FailedActionNoti(enumACTION_SKILL, enumFACTION_MOVEPATH);
					//SystemNotice("移动路径错误，没有移动序列点\n");
					SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00036));
					//m_CLog.Log("移动路径错误，没有移动序列点\n");
					m_CLog.Log("move path error,don't have move sequence point\n");
					break;
				}

				if(ulTurnNum <= 0)
				{
					m_CLog.Log("move path error, don't have move sequence point too\n");
				}
				else if ((chPointNum = Char(ulTurnNum / sizeof(Point))) > defMOVE_INFLEXION_NUM)
				{
					FailedActionNoti(enumACTION_SKILL, enumFACTION_MOVEPATH);
					//SystemNotice("移动路径错误(拐点数:%d，最大拐点数:%d)\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM);
				    //SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00037), ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM);
					char szData[128];
					CFormatParameter param(2);
					param.setDouble( 0, ulTurnNum / sizeof(Point) );
					param.setDouble( 1, defMOVE_INFLEXION_NUM );
					RES_FORMAT_STRING( GM_CHARACTERPRL_CPP_00037, param, szData );
					SystemNotice( szData );
				    //m_CLog.Log("移动路径错误(拐点数:%d，最大拐点数:%d)[PacketID: %u]\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM, ulPacketId);
				    m_CLog.Log("move path error(inflexion number:%d,max inflexion number:%d)[PacketID: %u]\n", ulTurnNum / sizeof(Point), defMOVE_INFLEXION_NUM, ulPacketId);
					break;
				}
				//m_CLog.Log("移动路径(ulTurnNum: %d)[PacketID: %u]\n", ulTurnNum, ulPacketId);
				m_CLog.Log("move path(ulTurnNum: %d)[PacketID: %u]\n", ulTurnNum, ulPacketId);
				memcpy(Path, pData, chPointNum*sizeof(Point));
				// 技能包
				dbc::uLong ulSkillID = READ_LONG(pk);
				Long lTarInfo1 = READ_LONG(pk);
				Long lTarInfo2 = READ_LONG(pk);

				CSkillRecord *pRec = GetSkillRecordInfo(ulSkillID);
				if (!pRec)
				{
					//LG( "技能不存在", "角色《%s》1技能不存在(技能编号: %d)[PacketID: %u]\n", GetName(), ulSkillID, ulPacketId);
					LG( "skill inexistence", "character《%s》1skill inexistence(skill number: %d)[PacketID: %u]\n", GetName(), ulSkillID, ulPacketId);
					FailedActionNoti(enumACTION_SKILL, enumFACTION_NOSKILL);
					//LG( "技能不存在", "角色《%s》2技能不存在(技能编号: %d)[PacketID: %u]\n", GetName(), ulSkillID, ulPacketId);
					LG( "skill inexistence", "character《%s》2skill inexistence(skill number: %d)[PacketID: %u]\n", GetName(), ulSkillID, ulPacketId);
					//SystemNotice("技能不存在(技能编号: %d)\n", ulSkillID);					
					SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00040), ulSkillID);					
					//m_CLog.Log("技能不存在(技能编号: %d)[PacketID: %u]\n", ulSkillID, ulPacketId);
					m_CLog.Log("skill inexistence(skill number: %d)[PacketID: %u]\n", ulSkillID, ulPacketId);
					break;
				}
				Cmd_BeginSkill((Short)m_dwPing, Path, chPointNum, pRec, 1, lTarInfo1, lTarInfo2);
			}
			else
			{
				//SystemNotice("该行动类型(直接使用技能)已经作废");
				SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00041));
				//m_CLog.Log("该行动类型(直接使用技能)已经作废[PacketID: %u]\n", ulPacketId);
				m_CLog.Log("the action type(directness use skills)has been cancellation[PacketID: %u]\n", ulPacketId);
				break;
			}
		}
		break;
	case	enumACTION_STOP_STATE:
		{
			if (!GetSubMap())
			{
				m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
				//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
				m_CLog.Log("refuse action request(map is null)\n\n");
				return;
			}

			Short	sStateID = READ_SHORT(pk);

			CSkillStateRecord	*pSSkillState = GetCSkillStateRecordInfo((uChar)sStateID);
			if (!pSSkillState)
				break;
			if (!pSSkillState->bCanCancel)
				break;
			DelSkillState((uChar)sStateID);
		}
		break;
	case	enumACTION_LEAN: // 倚靠
		{
			if (!GetSubMap())
			{
				m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
				//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
				m_CLog.Log("refuse action request(map is null)\n\n");
				return;
			}

			m_sPoseState = enumPoseLean;
			m_SSeat.chIsSeat = 0;

			m_SLean.ulPacketID = ulPacketId;
			m_SLean.lPose = READ_LONG(pk);
			m_SLean.lAngle = READ_LONG(pk);
			m_SLean.lPosX = READ_LONG(pk);
			m_SLean.lPosY = READ_LONG(pk);
			m_SLean.lHeight = READ_LONG(pk);
			m_SLean.chState = 0;

			// 转发
			WPACKET WtPk = GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
			WRITE_LONG(WtPk, m_ID);
			WRITE_LONG(WtPk, m_SLean.ulPacketID);
			WRITE_CHAR(WtPk, enumACTION_LEAN);
			WRITE_CHAR(WtPk, m_SLean.chState);
			WRITE_LONG(WtPk, m_SLean.lPose);
			WRITE_LONG(WtPk, m_SLean.lAngle);
			WRITE_LONG(WtPk, m_SLean.lPosX);
			WRITE_LONG(WtPk, m_SLean.lPosY);
			WRITE_LONG(WtPk, m_SLean.lHeight);
			NotiChgToEyeshot(WtPk);//通告
			//

			// log
			m_CLog.Log("$$$PacketID:\t%u\n", m_SLean.ulPacketID);
			m_CLog.Log("===Recieve(Lean):\tTick %u\n", GetTickCount());
			m_CLog.Log("\n");
			m_CLog.Log("$$$PacketID:\t%u\n", m_SLean.ulPacketID);
			m_CLog.Log("###Send(Lean):\tTick %u\n", GetTickCount());
			m_CLog.Log("\n");
			//
		}
		break;
	case	enumACTION_ITEM_PICK: // 捡道具
		{
			Long	lWorldID = READ_LONG(pk);
			Long	lHandle = READ_LONG(pk);

			Short sRet = Cmd_PickupItem(lWorldID, lHandle);
			if (sRet != enumITEMOPT_SUCCESS		 //捡不到的情况太多，例如客户端频繁发消息，或者被别人抢先
				&& sRet!=enumITEMOPT_ERROR_NONE) //这种情况不需要告诉客户端 "道具不存在" by Waiting 2009-06-23
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_TOTAL_ITEM_PICK://多道具拾取
		{
			Short nCount = READ_SHORT(pk);
			if( nCount < 0 || nCount > 48 )
				break;
			for( int i = 0; i<nCount; i++ )
			{
				Long	lWorldID = READ_LONG(pk);
				Long	lHandle = READ_LONG(pk);			
				Short sRet = Cmd_PickupItem(lWorldID, lHandle);
				if (sRet != enumITEMOPT_SUCCESS
					&& sRet != enumITEMOPT_ERROR_NONE)
					ItemOprateFailed(sRet);
			}
		}
		break;
	case	enumACTION_ITEM_THROW: // 丢道具(从道具栏丢到地面)
		{
			Short	sGridID = READ_SHORT(pk);
			Short	sNum = READ_SHORT(pk);
			Long	lPosX = READ_LONG(pk);
			Long	lPosY = READ_LONG(pk);

			Short sRet = Cmd_ThrowItem(sGridID, &sNum, lPosX, lPosY);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_ITEM_USE: // 使用道具
		{
			Short	sFromGridID = READ_SHORT(pk);
			Short	sToGridID = READ_SHORT(pk);

			Short sRet = Cmd_UseItem(sFromGridID, sToGridID);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_ITEM_UNFIX: // 卸装道具
		{
			m_CChaAttr.ResetChangeFlag();

			Char	chDir;
			Long	lParam1, lParam2;

			Char	chLinkID = READ_CHAR(pk);
			Short	sGridID = READ_SHORT(pk);
			if (sGridID == -2) // 丢到地面
			{
				chDir = 0;
				lParam1 = READ_LONG(pk);
				lParam2 = READ_LONG(pk);
			}
			else if (sGridID == -1) // 卸到道具栏，搜索位置
			{
				chDir = 1;
				lParam1 = 0;
				lParam2 = -1;
			}
			else if (sGridID >= 0) // 卸到道具栏，指定位置
			{
				chDir = 1;
				lParam1 = 0;
				lParam2 = sGridID;
			}

			Short	sUnfixNum = 0;
			Short sRet = Cmd_UnfixItem(chLinkID, &sUnfixNum, chDir, lParam1, lParam2);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_ITEM_POS: // 改变道具位置
		{
			Short	sSrcGrid = READ_SHORT(pk);
			Short	sSrcNum = READ_SHORT(pk);
			Short	sTarGrid = READ_SHORT(pk);

			Short sRet = Cmd_ItemSwitchPos(0, sSrcGrid, sSrcNum, sTarGrid);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case    enumACTION_KITBAGTMP_DRAG: //临时背包拖放
		{
			Short	sSrcGrid = READ_SHORT(pk);
			Short	sSrcNum = READ_SHORT(pk);
			Short	sTarGrid = READ_SHORT(pk);

			Short sRet = Cmd_DragItem(sSrcGrid, sSrcNum, sTarGrid);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_ITEM_DELETE: // 删除道具
		{
			Short	sFromGridID = READ_SHORT(pk);

			Short	sOptNum = 0;
			Short sRet = Cmd_DelItem(sFromGridID, &sOptNum);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_ITEM_INFO: // 道具信息
		{			
			ViewItemInfo( pk );
		}
		break;
	case	enumACTION_BANK:
		{
			Char	chSrcType = READ_CHAR(pk);
			Short	sSrcGrid = READ_SHORT(pk);
			Short	sSrcNum = READ_SHORT(pk);
			Char	chTarType = READ_CHAR(pk);
			Short	sTarGrid = READ_SHORT(pk);
			Short sRet = Cmd_BankOper(chSrcType, sSrcGrid, sSrcNum, chTarType, sTarGrid);
			if (sRet != enumITEMOPT_SUCCESS)
				ItemOprateFailed(sRet);
		}
		break;
	case	enumACTION_CLOSE_BANK:
		{
			GetPlayer()->CloseBank();
		}
		break;
	case	enumACTION_SHORTCUT:
		{
			char chIndex = READ_CHAR(pk);
			char chType = READ_CHAR(pk);
			short sGrid = READ_SHORT(pk);

			if (chIndex < 0 || chIndex >= SHORT_CUT_NUM)
				break;
			m_CShortcut.chType[chIndex] = chType;
			m_CShortcut.byGridID[chIndex] = sGrid;
		}
		break;
	case	enumACTION_LOOK:
		{
			//m_SChaPart.sTypeID = READ_SHORT(pk);
			//for (int i = 0; i < enumEQUIP_NUM; i++)
			//	m_SChaPart.SLink[i].sID = READ_SHORT(pk);

			//// 转发
			//WPACKET WtPk	=GETWPACKET();
			//WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
			//WRITE_LONG(WtPk, m_ID);
			//WRITE_LONG(WtPk, ulPacketId);
			//WRITE_CHAR(WtPk, enumACTION_LOOK);
			//WRITE_SHORT(WtPk, m_SChaPart.sTypeID);
			//for (int i = 0; i < enumEQUIP_NUM; i++)
			//	WRITE_SHORT(WtPk, m_SChaPart.sLink[i]);
			//NotiChgToEyeshot(WtPk);//通告
		}
		break;
	case	enumACTION_TEMP:
		{
			m_STempChaPart.sItemID = (short)(READ_LONG(pk));
			m_STempChaPart.sPartID = (short)(READ_LONG(pk));

			// 转发
			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
			WRITE_LONG(WtPk, m_ID);
			WRITE_LONG(WtPk, ulPacketId);
			WRITE_CHAR(WtPk, enumACTION_TEMP);
			WRITE_LONG(WtPk, m_STempChaPart.sItemID);
			WRITE_LONG(WtPk, m_STempChaPart.sPartID);

			NotiChgToEyeshot(WtPk);//通告
		}
		break;
	case	enumACTION_EVENT:
		{
			Long lID = READ_LONG(pk);
			Long lHandle = READ_LONG(pk);
			Entity *pCObj = g_pGameApp->IsLiveingEntity(lID, lHandle);
			if (!pCObj)
			{
				//m_CLog.Log("地图上不存在该实体\n");
				m_CLog.Log("it inexistent this entity in this map");
				break;
			}
			uShort	usEventID = READ_SHORT(pk);
			ExecuteEvent(pCObj, usEventID);
		}
		break;
	case	enumACTION_FACE:
		{
			Short	sAngle = READ_SHORT(pk);
			Short	sPose = READ_SHORT(pk);

			// 转发
			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
			WRITE_LONG(WtPk, m_ID);
			WRITE_LONG(WtPk, ulPacketId);
			WRITE_CHAR(WtPk, enumACTION_FACE);
			WRITE_SHORT(WtPk, sAngle);
			WRITE_SHORT(WtPk, sPose);
			NotiChgToEyeshot(WtPk);//通告
		}
		break;
	case	enumACTION_SKILL_POSE:
		{
			if (!GetSubMap())
			{
				m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
				//m_CLog.Log("拒绝行动请求(地图为空)\n\n");
				m_CLog.Log("refuse action request(map is null)\n\n");
				return;
			}

			if (IsBoat())
				break;
			if (GetMoveState() == enumMSTATE_ON || GetFightState() == enumFSTATE_ON || !GetActControl(enumACTCONTROL_MOVE))
				break;

			Short	sAngle = READ_SHORT(pk);
			Short	sPose = READ_SHORT(pk);

			// 转发
			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
			WRITE_LONG(WtPk, m_ID);
			WRITE_LONG(WtPk, ulPacketId);
			WRITE_CHAR(WtPk, enumACTION_SKILL_POSE);
			WRITE_SHORT(WtPk, sAngle);
			WRITE_SHORT(WtPk, sPose);
			NotiChgToEyeshot(WtPk);//通告

			bool	bToSeat = g_IsSeatPose(sPose);
			if ((bToSeat && m_SSeat.chIsSeat) || (!bToSeat && !m_SSeat.chIsSeat))
				break;

			// 坐下技能(恢复速度加快)
			dbc::uLong	ulSkillID = 202;
			CSkillRecord *pCSkill = GetSkillRecordInfo(ulSkillID);
			if (!pCSkill)
			{
				//m_CLog.Log("技能不存在(技能编号: %d)\n", ulSkillID);
				m_CLog.Log("skills inexistence(skills number: %d)\n", ulSkillID);
				break;
			}

			if (bToSeat) // 坐下
			{
				m_SSeat.chIsSeat = 1;
				m_SSeat.sAngle = sAngle;
				m_SSeat.sPose = sPose;
				g_CParser.DoString(pCSkill->szActive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, 1, DOSTRING_PARAM_END);
			}
			else // 站起
			{
				m_SSeat.chIsSeat = 0;
				g_CParser.DoString(pCSkill->szInactive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, 1, DOSTRING_PARAM_END);
			}
			if (bToSeat)
				m_sPoseState = enumPoseSeat;
			else
				m_sPoseState = enumPoseStand;
		}
		break;
	case	enumACTION_PK_CTRL:
		{
			if (READ_CHAR(pk))
				Cmd_SetInPK();
			else
				Cmd_SetInPK(false);
			SynPKCtrl();
		}
		break;
	default:
		break;
	}
T_E}


// 协议 : 处理更换发型的请求
void CCharacter::Cmd_ChangeHair(RPACKET &pk)
{T_B
	char szRes[128];

	short sScriptID  = READ_SHORT(pk);

	TradeAction(false); // 收到这条消息, 交易状态被结束了
	HairAction(false);	// 解除理发状态

	if(sScriptID==0) // 关闭理发界面
	{
		return;
	}

	if(GetKitbag()->IsPwdLocked())
	{
		//sprintf(szRes, "请求更换发型失败, 道具栏已锁");
		//sprintf(szRes, RES_STRING(GM_CHARACTERPRL_CPP_00042));
		_snprintf_s(szRes,sizeof(szRes),_TRUNCATE, RES_STRING(GM_CHARACTERPRL_CPP_00042));

		Prl_ChangeHairResult(0, szRes);
		return;
	}

	CHairRecord *pHair = GetHairRecordInfo(sScriptID);
	if(!pHair)
	{
		//sprintf(szRes, "请求更换发型失败, 无效发型ID = %d", sScriptID);
		//sprintf(szRes, RES_STRING(GM_CHARACTERPRL_CPP_00043), sScriptID);
		_snprintf_s(szRes,sizeof(szRes),_TRUNCATE, RES_STRING(GM_CHARACTERPRL_CPP_00043), sScriptID);

		Prl_ChangeHairResult(0, szRes);
		return;
	}

	short sValidCnt = 0;
	short sValidGrid[defHAIR_MAX_ITEM][3];

	for(short i = 0; i < defHAIR_MAX_ITEM; i++)
	{
		short sNeedItemID = (short)(pHair->dwNeedItem[i][0]);
		if(sNeedItemID > 0)
		{
			BOOL bOK = TRUE;
			short sGridLoc = READ_SHORT(pk);
			if(sGridLoc==-1) bOK = FALSE;

			if(bOK)
			{
				// 检验该背包格上是否有指定道具	
				short sNowItemID = GetKitbag()->GetID(sGridLoc);
				if(sNowItemID!=sNeedItemID)
				{
					bOK = FALSE;
				}
			}

			if(!bOK)
			{
				//sprintf(szRes, "更换发型失败, 缺少需要的道具");
				//sprintf(szRes, RES_STRING(GM_CHARACTERPRL_CPP_00044));
				_snprintf_s(szRes,sizeof(szRes),_TRUNCATE, RES_STRING(GM_CHARACTERPRL_CPP_00044));

				Prl_ChangeHairResult(0, szRes);
				return;
			}
			sValidGrid[sValidCnt][0] = sGridLoc;
			sValidGrid[sValidCnt][1] = sNeedItemID;
			sValidGrid[sValidCnt][2] = (short)(pHair->dwNeedItem[i][1]); // 数量记录
			sValidCnt++;
		}
	}


	// 扣除金钱和道具, 刷新背包
	GetKitbag()->SetChangeFlag( false );
	/*if(!TakeMoney("理发师", pHair->dwMoney))
	{
		SystemNotice("更换发型失败, 金钱不足!");
		return;
	}*/
	if(!TakeMoney(RES_STRING(GM_CHARACTERPRL_CPP_00045), pHair->dwMoney))
	{
		SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00046));
		return;
	}

	SItemGrid item;
	for(short i = 0; i < sValidCnt; i++)
	{
		item.sID  = sValidGrid[i][1];  
		item.sNum = sValidGrid[i][2];

		short sRet = KbPopItem(true, false, &item, sValidGrid[i][0]);
		if(sRet != enumKBACT_SUCCESS)
		{
			//SystemNotice("更换发型失败, 需要的道具不存在或者道具数量不足!");
			
			SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00047));
			return;
		}
	}

	// 同步角色背包数据
	SynKitbagNew( enumSYN_KITBAG_FROM_NPC );

	// 更换发型成功, 修改角色外观数据

	SetLookChangeFlag(true);
	// 10%的几率获得很丑的发型
	if(rand()%100 < 10 && pHair->GetFailItemNum() > 0)
	{
		int nRandFail = rand()%pHair->GetFailItemNum();
		short sFailHair = (short)(pHair->dwFailItemID[nRandFail]);
		m_SChaPart.sHairID = sFailHair;
		//SystemNotice("你的运气真糟糕, 发型搞砸了!");
		SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00048));
		Prl_ChangeHairResult(sScriptID, "fail", true); 
	}
	else
	{
		// 反馈给客户端, 发型更换成功
		m_SChaPart.sHairID = (short)(pHair->dwItemID); // 正常发型
		Prl_ChangeHairResult(sScriptID, "ok", true);
	}

	// 视野内外观更新通知
	SynLook(); // 包括自己在内的所有人都会收到这条消息

T_E}

// 更换发型的反馈
// 参数1 : 发型ID, 失败则为0
// 参数2 : 字符串的原因说明
void CCharacter::Prl_ChangeHairResult(int nScriptID, const char* szReason, BOOL bNoticeAll)
{T_B
	WPACKET wpk	= GETWPACKET();
	WRITE_CMD(wpk, CMD_MC_UPDATEHAIR_RES);
	WRITE_LONG(wpk, GetID());
	WRITE_SHORT(wpk, nScriptID);
	WRITE_STRING(wpk, szReason);
	if(bNoticeAll)
	{
		NotiChgToEyeshot(wpk);//通告
	}
	else
	{
		ReflectINFof(this, wpk);
	}
T_E}

// 通知客户端打开理发界面
void CCharacter::Prl_OpenHair()
{T_B
	HairAction(true);

	WPACKET wpk	= GETWPACKET();
	WRITE_CMD(wpk, CMD_MC_OPENHAIR);
	ReflectINFof(this, wpk);

T_E}

