#include <iostream>
#include "GroupServerApp.h"
#include "GameCommon.h"

// Add by lark.li 20080809 begin
void GroupServerApp::CP_QUERY_PERSONINFO(Player *ply,DataSocket *datasock,RPacket &pk)
{
	stQueryPersonInfo info;

	uShort	l_len;
	//strncpy(info.sChaName, pk.ReadString(&l_len), sizeof(info.sChaName));
	strncpy_s(info.sChaName,sizeof(info.sChaName), pk.ReadString(&l_len),_TRUNCATE);
	//info.bHavePic = pk.ReadChar();
	info.bHavePic =  (pk.ReadChar() == 1 ? true: false);
	//strncpy(info.cSex, pk.ReadString(&l_len), sizeof(info.cSex));
	strncpy_s(info.cSex,sizeof(info.cSex), pk.ReadString(&l_len), _TRUNCATE);
	info.nMinAge[0] = pk.ReadLong();
	info.nMinAge[1] = pk.ReadLong();
	//strncpy(info.szAnimalZodiac, pk.ReadString(&l_len), sizeof(info.szAnimalZodiac));
	strncpy_s(info.szAnimalZodiac,sizeof(info.szAnimalZodiac), pk.ReadString(&l_len),_TRUNCATE);
	info.iBirthday[0] = pk.ReadLong();
	info.iBirthday[1] = pk.ReadLong();
	//strncpy(info.szState, pk.ReadString(&l_len), sizeof(info.szState));
	strncpy_s(info.szState, sizeof(info.szState), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szCity, pk.ReadString(&l_len), sizeof(info.szCity));
	strncpy_s(info.szCity,sizeof(info.szCity), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szConstellation, pk.ReadString(&l_len), sizeof(info.szConstellation));
	strncpy_s(info.szConstellation,sizeof(info.szConstellation), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szCareer, pk.ReadString(&l_len), sizeof(info.szCareer));
	strncpy_s(info.szCareer,sizeof(info.szCareer), pk.ReadString(&l_len),_TRUNCATE);
	info.nPageItemNum = pk.ReadLong();
	info.nCurPage = pk.ReadLong();

	int num;
	int totalpage;
	int totalrecord;

	MutexArmor l_lockDB(m_mtxDB);

	stQueryResoultPersonInfo result[10];
	m_tblpersoninfo->Query(&info, result, num, totalpage, totalrecord);
	l_lockDB.unlock();

	WPacket	l_wpk	=GetWPacket();
	l_wpk.WriteCmd(CMD_PC_QUERY_PERSONINFO);
	l_wpk.WriteShort(num);
	l_wpk.WriteLong(totalpage);
	l_wpk.WriteLong(totalrecord);
	
	for(int i=0;i<num;i++)
	{
		l_wpk.WriteString(result[i].sChaName);
		l_wpk.WriteShort(result[i].nMinAge);
		l_wpk.WriteString(result[i].cSex);
		l_wpk.WriteString(result[i].szState);
		l_wpk.WriteString(result[i].nCity);
	}
	SendToClient(ply,l_wpk);
}

// End

void GroupServerApp::CP_CHANGE_PERSONINFO(Player *ply,DataSocket *datasock,RPacket &pk)
{
	// Modify by lark.li 20080807 begin
	stPersonInfo info;

	uShort	l_len;
	//strncpy(info.szMotto, pk.ReadString(&l_len), sizeof(info.szMotto));
	strncpy_s(info.szMotto,sizeof(info.szMotto), pk.ReadString(&l_len),_TRUNCATE);
	//info.bShowMotto = pk.ReadChar();
	info.bShowMotto = (pk.ReadChar() == 1 ?true:false);
	//strncpy(info.szSex, pk.ReadString(&l_len), sizeof(info.szSex));
	strncpy_s(info.szSex,sizeof(info.szSex), pk.ReadString(&l_len),_TRUNCATE);
	info.sAge = (short)pk.ReadLong();
	//strncpy(info.szName, pk.ReadString(&l_len), sizeof(info.szName));
	strncpy_s(info.szName,sizeof(info.szName), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szAnimalZodiac, pk.ReadString(&l_len), sizeof(info.szAnimalZodiac));
	strncpy_s(info.szAnimalZodiac,sizeof(info.szAnimalZodiac), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szBloodType, pk.ReadString(&l_len), sizeof(info.szBloodType));
	strncpy_s(info.szBloodType,sizeof(info.szBloodType), pk.ReadString(&l_len),_TRUNCATE);
	info.iBirthday = pk.ReadLong();
	//strncpy(info.szState, pk.ReadString(&l_len), sizeof(info.szState));
	strncpy_s(info.szState,sizeof(info.szState), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szCity, pk.ReadString(&l_len), sizeof(info.szCity));
	strncpy_s(info.szCity,sizeof(info.szCity) ,pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szConstellation, pk.ReadString(&l_len), sizeof(info.szConstellation));
	strncpy_s(info.szConstellation, sizeof(info.szConstellation), pk.ReadString(&l_len),_TRUNCATE);
	//strncpy(info.szCareer, pk.ReadString(&l_len), sizeof(info.szCareer));
	strncpy_s(info.szCareer,sizeof(info.szCareer), pk.ReadString(&l_len),_TRUNCATE);
	info.iSize = pk.ReadLong();

	if(info.iSize>0 && info.iSize<8*1024)
	{
		memcpy(info.pAvatar, pk.ReadSequence(l_len), info.iSize);
	}

	//info.bPprevent = pk.ReadChar();
	info.bPprevent = (pk.ReadChar() == 1? true:false);
	info.iSupport = pk.ReadLong();
	info.iOppose = pk.ReadLong();
	
	MutexArmor l_lockDB(m_mtxDB);
	ply->m_refuse_sess	=info.bPprevent?true:false;
	m_tblpersoninfo->DelInfo(ply->m_chaid[ply->m_currcha]);
	m_tblpersonavatar->DelInfo(ply->m_chaid[ply->m_currcha]);
	m_tblpersoninfo->AddInfo(ply->m_chaid[ply->m_currcha], &info);
	m_tblpersonavatar->AddInfo(ply->m_chaid[ply->m_currcha], &info);

	//
	cChar *l_motto	=pk.ReadString(&l_len);
	m_tblcharaters->UpdateInfo(ply->m_chaid[ply->m_currcha],1,l_motto);

	l_lockDB.unlock();

	WPacket	l_wpk	=GetWPacket();
	l_wpk.WriteCmd(CMD_PC_CHANGE_PERSONINFO);
	l_wpk.WriteString(l_motto);
	l_wpk.WriteShort(1);
	l_wpk.WriteChar(ply->m_refuse_sess?1:0);
	SendToClient(ply,l_wpk);

	//uShort	l_len;
	//cChar *l_motto	=pk.ReadString(&l_len);
	//if(!l_motto ||l_len >16 || !IsValidName(l_motto,l_len))
	//{
	//	return;
	//}
	//uShort		l_icon	=pk.ReadShort();
	//if(l_icon >const_cha.MaxIconVal)
	//{
	//	ply->SendSysInfo("个性图标值非法");
	//	ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPPRSN_CPP_00001));
	//}else if(strchr(l_motto,'\'') || strlen(l_motto) !=l_len || !CTextFilter::IsLegalText(CTextFilter::NAME_TABLE,l_motto))
	//{
	//	ply->SendSysInfo("座右铭格式非法");
	//	ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPPRSN_CPP_00002));
	//}else
	//{
	//	MutexArmor l_lockDB(m_mtxDB);
	//	ply->m_refuse_sess	=pk.ReadChar()?true:false;
	//	m_tblcharaters->UpdateInfo(ply->m_chaid[ply->m_currcha],l_icon,l_motto);
	//	l_lockDB.unlock();

	//	WPacket	l_wpk	=GetWPacket();
	//	l_wpk.WriteCmd(CMD_PC_CHANGE_PERSONINFO);
	//	l_wpk.WriteString(l_motto);
	//	l_wpk.WriteShort(l_icon);
	//	l_wpk.WriteChar(ply->m_refuse_sess?1:0);
	//	SendToClient(ply,l_wpk);
	//}
	// End
}
void GroupServerApp::CP_FRND_REFRESH_INFO(Player *ply,DataSocket *datasock,RPacket &pk)
{
	// Modify by lark.li 20080808 begin
	uLong	l_chaid	=pk.ReadLong();
	MutexArmor l_lockDB(m_mtxDB);

	if(ply->m_chaid[ply->m_currcha] != l_chaid)
	{
		if(m_tblfriends->GetFriendsCount(ply->m_chaid[ply->m_currcha],l_chaid) !=2)
		{
			l_lockDB.unlock();
			//ply->SendSysInfo("你们不是好友关系！");
			ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPPRSN_CPP_00003));
			return;
		}
	}
	
	stPersonInfo st;

	if(m_tblcharaters->FetchRowByChaID(l_chaid) ==1)
	{	
		WPacket	l_wpk	=GetWPacket();
		l_wpk.WriteCmd(CMD_PC_FRND_REFRESH_INFO);
		
		string act_name = "";
		if(m_tblcharaters->FetchActNameRowByChaID(l_chaid,act_name) != 1 )
		{
			act_name = "";
		}
		l_wpk.WriteString(act_name.c_str());

		l_wpk.WriteLong(l_chaid);

		l_wpk.WriteString(m_tblcharaters->GetMotto());
		l_wpk.WriteShort(m_tblcharaters->GetIcon());
		l_wpk.WriteShort(m_tblcharaters->GetDegree());
		l_wpk.WriteString(m_tblcharaters->GetJob());
		l_wpk.WriteString(m_tblcharaters->GetGuildName());

		if(m_tblpersoninfo->GetInfo(l_chaid, &st) && m_tblpersonavatar->GetInfo(l_chaid, &st))		
		{
			l_wpk.WriteChar(true);
			l_wpk.WriteString(st.szMotto);				// 签名
			l_wpk.WriteChar(st.bShowMotto);				// 显示签名开关
			l_wpk.WriteString(st.szSex);				// 性别
			l_wpk.WriteLong(st.sAge);					// 年龄
			l_wpk.WriteString(st.szName);				// 名字
			l_wpk.WriteString(st.szAnimalZodiac);		// 属相
			l_wpk.WriteString(st.szBloodType);			// 血型
			l_wpk.WriteLong(st.iBirthday);				// 生日
			l_wpk.WriteString(st.szState);				// 州（省）
			l_wpk.WriteString(st.szCity);				// 城市（区）
			l_wpk.WriteString(st.szConstellation);		// 星座
			l_wpk.WriteString(st.szCareer);				// 职业
			l_wpk.WriteLong(st.iSize);					// 头像大小
			l_wpk.WriteSequence(st.pAvatar,st.iSize);	// 头像
			l_wpk.WriteChar(st.bPprevent);				// 是否阻止消息
			l_wpk.WriteLong(st.iSupport);				// 鲜花数
			l_wpk.WriteLong(st.iOppose);				// 臭鸡蛋数
		}
		else
			l_wpk.WriteChar(false);

	
		l_lockDB.unlock();
		SendToClient(ply,l_wpk);
	}
	else
	{
		ply->SendSysInfo("Failed!");
	}

	//uLong	l_chaid	=pk.ReadLong();
	//MutexArmor l_lockDB(m_mtxDB);
	//if(m_tblfriends->GetFriendsCount(ply->m_chaid[ply->m_currcha],l_chaid) !=2)
	//{
	//	l_lockDB.unlock();
	//	//ply->SendSysInfo("你们不是好友关系！");
	//	ply->SendSysInfo(RES_STRING(GP_GROUPSERVERAPPPRSN_CPP_00003));
	//}else if(m_tblcharaters->FetchRowByChaID(l_chaid) ==1)
	//{
	//	WPacket	l_wpk	=GetWPacket();
	//	l_wpk.WriteCmd(CMD_PC_FRND_REFRESH_INFO);
	//	l_wpk.WriteLong(l_chaid);
	//	l_wpk.WriteString(m_tblcharaters->GetMotto());
	//	l_wpk.WriteShort(m_tblcharaters->GetIcon());
	//	l_wpk.WriteShort(m_tblcharaters->GetDegree());
	//	l_wpk.WriteString(m_tblcharaters->GetJob());
	//	l_wpk.WriteString(m_tblcharaters->GetGuildName());
	//	l_lockDB.unlock();
	//	SendToClient(ply,l_wpk);
	//}
	// End
}
void GroupServerApp::CP_REFUSETOME(Player *ply,DataSocket *datasock,RPacket &pk)
{
	ply->m_refuse_tome	=pk.ReadChar()?true:false;
}
