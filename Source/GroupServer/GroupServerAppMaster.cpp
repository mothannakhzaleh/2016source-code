#include <iostream>
#include "GroupServerApp.h"
#include "GameCommon.h"
#include <conformity.h>

//const cChar*	gc_master_group = RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00018);
//const cChar*	gc_prentice_group = RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00017);

void GroupServerApp::CP_MASTER_REFRESH_INFO(Player *ply,DataSocket *datasock,RPacket &pk)
{
	uLong	l_chaid	=pk.ReadLong();
	MutexArmor l_lockDB(m_mtxDB);
	//if(m_tblmaster->HasMaster(ply->m_chaid[ply->m_currcha],l_chaid) < 1)
	if(HasMaster(ply->m_chaid[ply->m_currcha],l_chaid) < 1)
	{
		l_lockDB.unlock();
		//ply->SendSysInfo("你们不是师徒关系！");
		ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00001));
	}else if(m_tblcharaters->FetchRowByChaID(l_chaid) ==1)
	{
		WPacket	l_wpk	=GetWPacket();
		l_wpk.WriteCmd(CMD_PC_MASTER_REFRESH_INFO);
		l_wpk.WriteLong(l_chaid);
		l_wpk.WriteString(m_tblcharaters->GetMotto());
		l_wpk.WriteShort(m_tblcharaters->GetIcon());
		l_wpk.WriteShort(m_tblcharaters->GetDegree());
		l_wpk.WriteString(m_tblcharaters->GetJob());
		l_wpk.WriteString(m_tblcharaters->GetGuildName());
		l_lockDB.unlock();
		SendToClient(ply,l_wpk);
	}
}

void GroupServerApp::CP_PRENTICE_REFRESH_INFO(Player *ply,DataSocket *datasock,RPacket &pk)
{
	uLong	l_chaid	=pk.ReadLong();
	MutexArmor l_lockDB(m_mtxDB);
	//if(m_tblmaster->HasMaster(l_chaid, ply->m_chaid[ply->m_currcha]) < 1)
	if(HasMaster(l_chaid, ply->m_chaid[ply->m_currcha]) < 1)
	{
		l_lockDB.unlock();
		//ply->SendSysInfo("你们不是师徒关系！");
		ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00001));
	}else if(m_tblcharaters->FetchRowByChaID(l_chaid) ==1)
	{
		WPacket	l_wpk	=GetWPacket();
		l_wpk.WriteCmd(CMD_PC_PRENTICE_REFRESH_INFO);
		l_wpk.WriteLong(l_chaid);
		l_wpk.WriteString(m_tblcharaters->GetMotto());
		l_wpk.WriteShort(m_tblcharaters->GetIcon());
		l_wpk.WriteShort(m_tblcharaters->GetDegree());
		l_wpk.WriteString(m_tblcharaters->GetJob());
		l_wpk.WriteString(m_tblcharaters->GetGuildName());
		l_lockDB.unlock();
		SendToClient(ply,l_wpk);
	}
}

void GroupServerApp::MP_MASTER_CREATE(Player *ply,DataSocket *datasock,RPacket &pk)
{
	cChar *szPrenticeName = pk.ReadString();
	uLong l_prentice_chaid = pk.ReadLong();
	cChar *szMasterName = pk.ReadString();
	uLong l_master_chaid = pk.ReadLong();

	Player *pPrentice = FindPlayerByChaName(szPrenticeName);
	//Player *pPrentice = GetPlayerByChaID(l_prentice_chaid);
	Player *pMaster = FindPlayerByChaName(szMasterName);
	//Player *pMaster = GetPlayerByChaID(l_master_chaid);

	if(!pPrentice || !pMaster)
	{
		LogLine l_line(g_LogMaster);
		//l_line<<newln<<"MP_MASTER_CREATE()成员不在线!";
		l_line<<newln<<"MP_MASTER_CREATE() member is offline!";
		return;
	}

	//邀请
	bool bInvited = false;
	if(pPrentice->m_CurrMasterNum >= const_master.MasterMax)
	{
		//pMaster->SendSysInfo("对方已经有导师了!");
		pMaster->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00003));
		//pPrentice->SendSysInfo("您已经有导师了!");
		pPrentice->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00004));
	}
	else if(m_tblmaster->GetPrenticeCount(l_master_chaid) >= const_master.PrenticeMax)
	{
		//pMaster->SendSysInfo("您的学徒数已经达到允许的上限了!");
		pMaster->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00005));
		//pPrentice->SendSysInfo("对方的学徒数已经达到允许的上限了!");
		pPrentice->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00006));
	}
	else
	{
		Invited			*	l_invited	=0;
		uShort				l_len = (uShort)strlen(szMasterName);
		cChar			*	l_invited_name	= szMasterName;
		if(!l_invited_name || l_len >common::conformity::character::name::max_length)
		{
			return;
		}
		Player			*	l_invited_ply	= pMaster;
		MutexArmor l_lockDB(m_mtxDB);
		if(!l_invited_ply || l_invited_ply->m_currcha <0 || l_invited_ply == pPrentice)
		{
			char l_buf[256];
			//sprintf(l_buf,"玩家【%s】当前不在线上。",l_invited_name);
			//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00007),l_invited_name);
			_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00007),l_invited_name);
			pPrentice->SendSysInfo(l_buf);
		}else if(l_invited = l_invited_ply->MasterFindInvitedByInviterChaID(pPrentice->m_chaid[pPrentice->m_currcha]))
		{
			//pPrentice->SendSysInfo(dstring("您当前对【")<<l_invited_name<<"】已经有一个未决的拜师申请，请稍安毋躁。");
			char l_buf[256];
			//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00008),l_invited_name);
			_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00008),l_invited_name);
			pPrentice->SendSysInfo(l_buf);
		}else if(l_invited = pPrentice->MasterFindInvitedByInviterChaID(l_invited_ply->m_chaid[l_invited_ply->m_currcha]))
		{
			//pPrentice->SendSysInfo(dstring("【")<<l_invited_name<<"】当前已经有一个对你的拜师申请，请接受即可。");
			char l_buf[256];
			//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00009),l_invited_name);
			_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00009),l_invited_name);
			pPrentice->SendSysInfo(l_buf);
		//}else if(m_tblmaster->HasMaster(pPrentice->m_chaid[pPrentice->m_currcha], l_invited_ply->m_chaid[l_invited_ply->m_currcha]) > 0)
		}else if(HasMaster(pPrentice->m_chaid[pPrentice->m_currcha], l_invited_ply->m_chaid[l_invited_ply->m_currcha]) > 0)
		{
			//pPrentice->SendSysInfo("你们已经是师徒了!");
			pPrentice->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00011));
			//pMaster->SendSysInfo("你们已经是师徒了!");
			pMaster->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00011));
		}else
		{
			PtInviter l_ptinviter = l_invited_ply->MasterBeginInvited(pPrentice);
			if(l_ptinviter )
			{
				char l_buf[256];
				//sprintf(l_buf,"玩家【%s】处于繁忙状态!",l_invited_name);
				//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00012),l_invited_name);
				_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00012),l_invited_name);
				l_ptinviter->SendSysInfo(l_buf);
			}

			bInvited = true;
		}
	}

	//确认
	if(bInvited)
	{
		uLong		l_inviter_chaid	= l_prentice_chaid;
		PtInviter	l_inviter		= pMaster->MasterEndInvited(l_inviter_chaid);
		if(l_inviter && l_inviter->m_currcha >=0 && l_inviter.m_chaid == l_inviter->m_chaid[l_inviter->m_currcha])
		{
			MutexArmor l_lockDB(m_mtxDB);
			++(pMaster->m_CurrPrenticeNum);
			if((++(pPrentice->m_CurrMasterNum)) >const_master.MasterMax)
			{
				--(pMaster->m_CurrPrenticeNum);
				--(pPrentice->m_CurrMasterNum);
				//pMaster->SendSysInfo(dstring("【")<<l_inviter->m_chaname[l_inviter->m_currcha].c_str()<<"】已经有导师了!");
				char l_buf[256];
				//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00013),l_inviter->m_chaname[l_inviter->m_currcha].c_str());
				_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00013),l_inviter->m_chaname[l_inviter->m_currcha].c_str());
				pMaster->SendSysInfo(l_buf);
			}else
			{
				LogLine	l_line(g_LogMaster);
				/*
				l_line<<newln<<"玩家"<<pMaster->m_chaname[pMaster->m_currcha]<<"("<<pMaster->m_chaid[pMaster->m_currcha]
				<<")和玩家"<<l_inviter->m_chaname[l_inviter->m_currcha]<<"("<<l_inviter_chaid<<")成为师徒!"
					<<endln;
				*/
				l_line<<newln<<"player"<<pMaster->m_chaname[pMaster->m_currcha]<<"("<<pMaster->m_chaid[pMaster->m_currcha]
				<<")and player"<<l_inviter->m_chaname[l_inviter->m_currcha]<<"("<<l_inviter_chaid<<")become Master!"
					<<endln;
				m_tblmaster->AddMaster(l_prentice_chaid, l_master_chaid);
				AddMaster(l_prentice_chaid, l_master_chaid);
				//pMaster->SendSysInfo("恭喜您收了徒弟!");
				pMaster->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00014));
				//pPrentice->SendSysInfo("恭喜您拜了师父!");
				pPrentice->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00015));
				WPacket	l_wpk =GetWPacket();
				l_wpk.WriteCmd(CMD_PC_MASTER_REFRESH);
				WPacket l_wpk2=l_wpk;
				l_wpk.WriteChar(MSG_MASTER_REFRESH_ADD);
				l_wpk.WriteString(Master::GetMasterGroup());
				l_wpk.WriteLong(pMaster->m_chaid[pMaster->m_currcha]);
				l_wpk.WriteString(pMaster->m_chaname[pMaster->m_currcha].c_str());
				l_wpk.WriteString(pMaster->m_motto[pMaster->m_currcha].c_str());
				l_wpk.WriteShort(pMaster->m_icon[pMaster->m_currcha]);
				SendToClient(l_inviter.m_ply,l_wpk);
				l_wpk2.WriteChar(MSG_PRENTICE_REFRESH_ADD);
				l_wpk2.WriteString(Master::GetPrenriceGroup());
				l_wpk2.WriteLong(l_inviter->m_chaid[l_inviter->m_currcha]);
				l_wpk2.WriteString(l_inviter->m_chaname[l_inviter->m_currcha].c_str());
				l_wpk2.WriteString(l_inviter->m_motto[l_inviter->m_currcha].c_str());
				l_wpk2.WriteShort(l_inviter->m_icon[l_inviter->m_currcha]);
				SendToClient(pMaster,l_wpk2);
			}
		}
	}
	else
	{
		LogLine l_line(g_LogMaster);
		//l_line<<newln<<"MP_MASTER_CREATE()邀请失败";
		l_line<<newln<<"MP_MASTER_CREATE() invite failed";
	}
}

void GroupServerApp::MP_MASTER_DEL(Player *ply,DataSocket *datasock,RPacket &pk)
{
	cChar *szPrenticeName = pk.ReadString();
	uLong l_prentice_chaid = pk.ReadLong();
	cChar *szMasterName = pk.ReadString();
	uLong l_master_chaid = pk.ReadLong();

	Player *pPrentice = FindPlayerByChaName(szPrenticeName);
	//Player *pPrentice = GetPlayerByChaID(l_prentice_chaid);
	Player *pMaster = FindPlayerByChaName(szMasterName);
	//Player *pMaster = GetPlayerByChaID(l_master_chaid);

	MutexArmor l_lockDB(m_mtxDB);
	//if(m_tblmaster->HasMaster(l_prentice_chaid,l_master_chaid) < 1)
	if(HasMaster(l_prentice_chaid,l_master_chaid) < 1)
	{
		return;
	}else
	{
		if(pPrentice)
		{
			WPacket	l_wpk =GetWPacket();
			l_wpk.WriteCmd(CMD_PC_MASTER_REFRESH);
			l_wpk.WriteChar(MSG_MASTER_REFRESH_DEL);
			l_wpk.WriteLong(l_master_chaid);
			SendToClient(pPrentice,l_wpk);
			--(pPrentice->m_CurrMasterNum);
		}
		
		if(pMaster)
		{
			WPacket	l_wpk =GetWPacket();
			l_wpk.WriteCmd(CMD_PC_MASTER_REFRESH);
			l_wpk.WriteChar(MSG_PRENTICE_REFRESH_DEL);
			l_wpk.WriteLong(l_prentice_chaid);
			SendToClient(pMaster,l_wpk);
			--(pMaster->m_CurrPrenticeNum);
		}

		m_tblmaster->DelMaster(l_prentice_chaid,l_master_chaid);
		DelMaster(l_prentice_chaid,l_master_chaid);
		LogLine	l_line(g_LogMaster);
		/*
		l_line<<newln<<"玩家"<<szMasterName<<"("<<l_master_chaid
		<<")和<<szPrenticeName<<("<<l_prentice_chaid<<")解除了师徒关系";
		*/
		l_line<<newln<<"player "<<szMasterName<<"("<<l_master_chaid
		<<")and " << szPrenticeName <<" ("<<l_prentice_chaid<<")free master relation";
	}
}

void GroupServerApp::MP_MASTER_FINISH(Player *ply,DataSocket *datasock,RPacket &pk)
{
	uLong l_prentice_chaid = pk.ReadLong();
	//if(m_tblmaster->GetMasterCount(l_prentice_chaid) > 0)

	MutexArmor l_lockDB(m_mtxDB);
	if(GetMasterCount(l_prentice_chaid) > 0)
	{
		m_tblmaster->FinishMaster(l_prentice_chaid);
		//FinishMaster(l_prentice_chaid);
	}
}

void Player::MasterInvitedCheck(Invited	*invited)
{
	Player *l_inviter	=invited->m_ptinviter.m_ply;
	if(m_currcha <0)
	{
		MasterEndInvited(l_inviter);
	}else if(l_inviter->m_currcha <0 || l_inviter->m_chaid[l_inviter->m_currcha] !=invited->m_ptinviter.m_chaid)
	{
		WPacket l_wpk	=g_gpsvr->GetWPacket();
		l_wpk.WriteCmd(CMD_PC_MASTER_CANCEL);
		l_wpk.WriteChar(MSG_MASTER_CANCLE_OFFLINE);
		l_wpk.WriteLong(invited->m_ptinviter.m_chaid);
		g_gpsvr->SendToClient(this,l_wpk);
		MasterEndInvited(l_inviter);
	}else if(l_inviter->m_CurrMasterNum >= g_gpsvr->const_master.MasterMax)
	{
		WPacket l_wpk	=g_gpsvr->GetWPacket();
		l_wpk.WriteCmd(CMD_PC_MASTER_CANCEL);
		l_wpk.WriteChar(MSG_MASTER_CANCLE_INVITER_ISFULL);
		l_wpk.WriteLong(invited->m_ptinviter.m_chaid);
		g_gpsvr->SendToClient(this,l_wpk);
		MasterEndInvited(l_inviter);
	}/*else if(m_CurrPrenticeNum >= g_gpsvr->const_master.PrenticeMax)
	{
		WPacket l_wpk	=g_gpsvr->GetWPacket();
		l_wpk.WriteCmd(CMD_PC_MASTER_CANCEL);
		l_wpk.WriteChar(MSG_MASTER_CANCLE_SELF_ISFULL);
		l_wpk.WriteLong(invited->m_ptinviter.m_chaid);
		g_gpsvr->SendToClient(this,l_wpk);
		MasterEndInvited(l_inviter);
	}*/else if(g_gpsvr->GetCurrentTick() -invited->m_tick	>= g_gpsvr->const_master.PendTimeOut)
	{
		char l_buf[256];
		//sprintf(l_buf,"你对【%s】的拜师申请已超过%d秒钟没有回应，系统自动取消了你的申请。",m_chaname[m_currcha].c_str(),g_gpsvr->const_master.PendTimeOut/1000);
		//sprintf(l_buf,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00016),m_chaname[m_currcha].c_str(),g_gpsvr->const_master.PendTimeOut/1000);
		//_snprintf_s(l_buf,sizeof(l_buf),_TRUNCATE,RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00016),m_chaname[m_currcha].c_str(),g_gpsvr->const_master.PendTimeOut/1000);
		CFormatParameter param(2);
		param.setString( 0, m_chaname[m_currcha].c_str() );
		param.setLong( 1, g_gpsvr->const_master.PendTimeOut/1000 );
		RES_FORMAT_STRING( GP_GROUPSERVERAPPMASTER_CPP_00016, param, l_buf );
		l_inviter->SendSysInfo(l_buf);

		WPacket l_wpk	=g_gpsvr->GetWPacket();
		l_wpk.WriteCmd(CMD_PC_MASTER_CANCEL);
		l_wpk.WriteChar(MSG_MASTER_CANCLE_TIMEOUT);
		l_wpk.WriteLong(invited->m_ptinviter.m_chaid);
		g_gpsvr->SendToClient(this,l_wpk);
		MasterEndInvited(l_inviter);
	}
}

void GroupServerApp::PC_MASTER_INIT(Player *ply)
{
	TBLMaster::master_dat l_farray1[200];
	TBLMaster::master_dat l_farray2[200];
	int l_num1 = 200;
	int l_num2 = 200;

	//通知学徒
	m_tblmaster->GetPrenticeData(l_farray1,l_num1,ply->m_chaid[ply->m_currcha]);

	WPacket	l_toPrentice =GetWPacket();
	l_toPrentice.WriteCmd(CMD_PC_MASTER_REFRESH);
	l_toPrentice.WriteChar(MSG_MASTER_REFRESH_ONLINE);
	l_toPrentice.WriteLong(ply->m_chaid[ply->m_currcha]);

	WPacket	l_toSelf1 =GetWPacket();
	l_toSelf1.WriteCmd(CMD_PC_MASTER_REFRESH);
	l_toSelf1.WriteChar(MSG_PRENTICE_REFRESH_START);

	l_toSelf1.WriteLong(ply->m_chaid[ply->m_currcha]);
	l_toSelf1.WriteString(ply->m_chaname[ply->m_currcha].c_str());
	l_toSelf1.WriteString(ply->m_motto[ply->m_currcha].c_str());
	l_toSelf1.WriteShort(ply->m_icon[ply->m_currcha]);

	ply->m_CurrPrenticeNum	= 0;

	Player *l_plylst1[10240];
	short	l_plynum1	=0;

	Player	*	l_ply11;char	l_currcha1;
	for(int i=0;i<l_num1;i++)
	{
		if(l_farray1[i].cha_id ==0)
		{
			if(l_farray1[i].icon_id ==0)
			{
				// Mem addr as short?
				l_toSelf1.WriteShort(uShort(l_farray1[i].memaddr));
			}else
			{
				//l_toSelf1.WriteString(l_farray1[i].relation.c_str());
				//l_toSelf1.WriteString("学徒");
				l_toSelf1.WriteString(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00017));
				// Mem addr as short?
				l_toSelf1.WriteShort(uShort(l_farray1[i].memaddr));
				ply->m_CurrPrenticeNum += l_farray1[i].memaddr;
			}
		}else if((l_ply11 =(Player*)MakePointer(l_farray1[i].memaddr))
			&&((l_currcha1 =l_ply11->m_currcha)>=0)
			&&(l_ply11->m_chaid[l_currcha1] ==l_farray1[i].cha_id))
		{
			l_plylst1[l_plynum1]	=l_ply11;
			l_plynum1++;

			l_toSelf1.WriteLong(l_farray1[i].cha_id);
			l_toSelf1.WriteString(l_farray1[i].cha_name.c_str());
			l_toSelf1.WriteString(l_farray1[i].motto.c_str());
			l_toSelf1.WriteShort(l_farray1[i].icon_id);
			l_toSelf1.WriteChar(1);
		}else
		{
			l_toSelf1.WriteLong(l_farray1[i].cha_id);
			l_toSelf1.WriteString(l_farray1[i].cha_name.c_str());
			l_toSelf1.WriteString(l_farray1[i].motto.c_str());
			l_toSelf1.WriteShort(l_farray1[i].icon_id);
			l_toSelf1.WriteChar(0);
		}
	}
	SendToClient(ply,l_toSelf1);
	LogLine	l_line1(g_LogMaster);
	//l_line1<<newln<<"上线通知的学徒数："<<l_plynum1<<endln;
	l_line1<<newln<<"online notice apprentice num:"<<l_plynum1<<endln;
	SendToClient(l_plylst1,l_plynum1,l_toPrentice);

	//通知导师
	m_tblmaster->GetMasterData(l_farray2,l_num2,ply->m_chaid[ply->m_currcha]);

	WPacket	l_toMaster =GetWPacket();
	l_toMaster.WriteCmd(CMD_PC_MASTER_REFRESH);
	l_toMaster.WriteChar(MSG_PRENTICE_REFRESH_ONLINE);
	l_toMaster.WriteLong(ply->m_chaid[ply->m_currcha]);

	WPacket	l_toSelf2 =GetWPacket();
	l_toSelf2.WriteCmd(CMD_PC_MASTER_REFRESH);
	l_toSelf2.WriteChar(MSG_MASTER_REFRESH_START);

	l_toSelf2.WriteLong(ply->m_chaid[ply->m_currcha]);
	l_toSelf2.WriteString(ply->m_chaname[ply->m_currcha].c_str());
	l_toSelf2.WriteString(ply->m_motto[ply->m_currcha].c_str());
	l_toSelf2.WriteShort(ply->m_icon[ply->m_currcha]);

	ply->m_CurrPrenticeNum	= 0;

	Player *l_plylst2[10240];
	short	l_plynum2	=0;

	Player	*	l_ply12;char	l_currcha2;
	for(int i=0;i<l_num2;i++)
	{
		if(l_farray2[i].cha_id ==0)
		{
			if(l_farray2[i].icon_id ==0)
			{
				// Mem addr as short?
				l_toSelf2.WriteShort(uShort(l_farray2[i].memaddr));
			}else
			{
				//l_toSelf2.WriteString(l_farray2[i].relation.c_str());
				//l_toSelf2.WriteString("导师");
				l_toSelf2.WriteString(RES_STRING(GP_GROUPSERVERAPPMASTER_CPP_00018));
				// Mem addr as short?
				l_toSelf2.WriteShort(uShort(l_farray2[i].memaddr));
				ply->m_CurrMasterNum += l_farray2[i].memaddr;
			}
		}else if((l_ply12 =(Player*)MakePointer(l_farray2[i].memaddr))
			&&((l_currcha2 =l_ply12->m_currcha)>=0)
			&&(l_ply12->m_chaid[l_currcha2] ==l_farray2[i].cha_id))
		{
			l_plylst2[l_plynum2]	=l_ply12;
			l_plynum2++;

			l_toSelf2.WriteLong(l_farray2[i].cha_id);
			l_toSelf2.WriteString(l_farray2[i].cha_name.c_str());
			l_toSelf2.WriteString(l_farray2[i].motto.c_str());
			l_toSelf2.WriteShort(l_farray2[i].icon_id);
			l_toSelf2.WriteChar(1);
		}else
		{
			l_toSelf2.WriteLong(l_farray2[i].cha_id);
			l_toSelf2.WriteString(l_farray2[i].cha_name.c_str());
			l_toSelf2.WriteString(l_farray2[i].motto.c_str());
			l_toSelf2.WriteShort(l_farray2[i].icon_id);
			l_toSelf2.WriteChar(0);
		}
	}
	SendToClient(ply,l_toSelf2);
	LogLine	l_line2(g_LogMaster);
	//l_line2<<newln<<"上线通知的导师数："<<l_plynum2<<endln;
	l_line2<<newln<<"online notice master num:"<<l_plynum2<<endln;
	SendToClient(l_plylst2,l_plynum2,l_toMaster);
}

bool GroupServerApp::InitMasterRelation()
{
	if(m_tblmaster->InitMasterRelation(m_mapMasterRelation))
		return true;
	return false;
}

int GroupServerApp::GetMasterCount(uLong cha_id)
{
	map<uLong, uLong>::iterator it = m_mapMasterRelation.find(cha_id);
	if(it != m_mapMasterRelation.end())
	{
		return 1;
	}
	return 0;
}

int GroupServerApp::GetPrenticeCount(uLong cha_id)
{
	return 0;
}

int GroupServerApp::HasMaster(uLong cha_id1,uLong cha_id2)
{
	map<uLong, uLong>::iterator it = m_mapMasterRelation.find(cha_id1);
	if(it != m_mapMasterRelation.end())
	{
		if(m_mapMasterRelation[cha_id1] == cha_id2)
			return 1;
	}
	return 0;
}

bool GroupServerApp::AddMaster(uLong cha_id1,uLong cha_id2)
{
	map<uLong, uLong>::iterator it = m_mapMasterRelation.find(cha_id1);
	if(it != m_mapMasterRelation.end())
	{
		return false;
	}

	m_mapMasterRelation[cha_id1] = cha_id2;
	return true;
}

bool GroupServerApp::DelMaster(uLong cha_id1,uLong cha_id2)
{
	map<uLong, uLong>::iterator it = m_mapMasterRelation.find(cha_id1);
	if(it != m_mapMasterRelation.end())
	{
		if(m_mapMasterRelation[cha_id1] == cha_id2)
		{
			m_mapMasterRelation.erase(it);
			return true;
		}
	}
	return false;
}

bool GroupServerApp::FinishMaster(uLong cha_id)
{
	map<uLong, uLong>::iterator it = m_mapMasterRelation.find(cha_id);
	if(it != m_mapMasterRelation.end())
	{
		m_mapMasterRelation.erase(it);
		return true;
	}
	return false;
}

