// RolePage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "CommonHeader.h"
#include "SelfObject.h"
#include "PlayerMgr.h"
#include "RolePage.h"
#include "GameThread.h"
#include "NetIF.h"
#include ".\rolepage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif








const static CString m_AttribName[]=
{
	"角色等级",							// 0
	"当前HP",							// 1
	"当前SP",							// 2
	"行会ID",							// 3
	"角色称号",							// 4
	"角色职业",							// 5
	"当前经验",							// 6
	"下一级所需经验",					// 7
	"名声",								// 8
	"属性点",							// 9
	"技能点",							// 10
	"金钱",								// 11
	"炮弹飞行速度",						// 12
	"角色控制类型(玩家，NPC，怪物等)",	// 13
	"当前等级的经验",					// 14
	"航海等级",							// 15
	"当前剩余航海经验",					// 16
	"累积航海经验(当前航海经验)",		// 17
	"当前等级航海经验",					// 18
	"下一等级等级航海经验",				// 19
	"生活等级",							// 20
	"当前生活经验",						// 21
	"当前等级生活经验",					// 22
	"下一等级生活经验",					// 23
	"生活技能点",						// 24
	"船只停泊港口",						// 25
	"行会状态",							// 26
	"货舱(背包)容量",					// 27
	"行会类型",							// 28
	"未定义的参数",						// 29
	"未定义的参数",						// 30
	"力量",								// 31
	"灵巧",								// 32
	"敏捷",								// 33
	"体质",								// 34
	"精力",								// 35
	"幸运",								// 36
	"最大HP",							// 37
	"最大SP",							// 38
	"最小攻击力",						// 39
	"最大攻击力",						// 40
	"防御力",							// 41
	"命中率",							// 42
	"闪避率",							// 43
	"寻宝率",							// 44
	"爆击率",							// 45
	"hp恢复速度",						// 46
	"sp恢复速度",						// 47
	"攻击间隔",							// 48
	"攻击距离",							// 49
	"移动速度",							// 50
	"资源采集速度",						// 51
	"物理抵抗",							// 52
	"船只炮弹爆炸范围",					// 53
	"船只炮弹飞行速度",					// 54
	"船的价值",							// 55
	"基本力量",							// 56
	"基本灵巧",							// 57
	"基本敏捷",							// 58
	"基本体质",							// 59
	"基本精力",							// 60
	"基本幸运",							// 61
	"基本幸运",							// 62
	"基本最大SP",						// 63
	"基本最小攻击力",					// 64
	"基本最大攻击力",					// 65
	"基本防御力",						// 66
	"基本命中率",						// 67
	"基本闪避率",						// 68
	"基本寻宝率",						// 69
	"基本爆击率",						// 70
	"基本hp恢复速度",					// 71
	"基本角色SP恢复速度(船只为消耗速度)",// 72
	"基本攻击间隔",						// 73
	"基本攻击距离",						// 74
	"基本移动速度",						// 75
	"基本资源采集速度",					// 76
	"基本物理抵抗",						// 77
	"船只基本炮弹爆炸范围",				// 78
	"船只基本炮弹飞行速度",				// 79
	"未定义的参数",						// 80
	"力量道具系数加成"					// 81
};



CString GetAttribName(WORD index)
{
	int nTotal=sizeof(m_AttribName)/sizeof(CString);
	if (index>=nTotal)
	{
		return "未定义的参数";
	}
	return m_AttribName[index];
}













// CRolePage dialog

IMPLEMENT_DYNAMIC(CRolePage, CPropertyPage)
CRolePage::CRolePage()
	: CPropertyPage(CRolePage::IDD)
{
}

CRolePage::~CRolePage()
{
}

void CRolePage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_STATIC_NAME, m_strName);
	DDX_Control(pDX, IDC_STATIC_LEVEL, m_strLevel);
	DDX_Control(pDX, IDC_STATIC_HP, m_strHP);
	DDX_Control(pDX, IDC_STATIC_SP, m_strSP);
	DDX_Control(pDX, IDC_PROGRESS_HP, m_prgHP);
	DDX_Control(pDX, IDC_PROGRESS_SP, m_prgSP);
	DDX_Control(pDX, IDC_STATIC_EXP, m_strEXP);
	DDX_Control(pDX, IDC_PROGRESS_EXP, m_prgEXP);
	DDX_Control(pDX, IDC_STATIC_EXP_PERCENT, m_strEXPPercent);
	DDX_Control(pDX, IDC_STATIC_STR, m_strSTR);
	DDX_Control(pDX, IDC_STATIC_DEX, m_strDEX);
	DDX_Control(pDX, IDC_STATIC_AGI, m_strAGI);
	DDX_Control(pDX, IDC_STATIC_VIT, m_strVIT);
	DDX_Control(pDX, IDC_STATIC_STA, m_strSTA);
	DDX_Control(pDX, IDC_STATIC_LUK, m_strLUK);
	DDX_Control(pDX, IDC_STATIC_ATTRIBUTE_POINT, m_strAttributePoint);
	DDX_Control(pDX, IDC_STATIC_SKILL_POINT, m_strSkillPoint);
	DDX_Control(pDX, IDC_LIST_STATE, m_StateList);
	DDX_Control(pDX, IDC_STATIC_MONEY, m_strMoney);
	DDX_Control(pDX, IDC_STATIC_MAP_NAME, m_strMapName);
	DDX_Control(pDX, IDC_STATIC_MAP_POSITION, m_strMapPosition);
}


BEGIN_MESSAGE_MAP(CRolePage, CPropertyPage)
	ON_BN_CLICKED(IDC_BUTTON_ADD_STR, OnBnClickedButtonAddStr)
	ON_BN_CLICKED(IDC_BUTTON_ADD_DEX, OnBnClickedButtonAddDex)
	ON_BN_CLICKED(IDC_BUTTON_ADD_AGI, OnBnClickedButtonAddAgi)
	ON_BN_CLICKED(IDC_BUTTON_ADD_VIT, OnBnClickedButtonAddVit)
	ON_BN_CLICKED(IDC_BUTTON_ADD_STA, OnBnClickedButtonAddSta)
	ON_BN_CLICKED(IDC_BUTTON_ADD_LUK, OnBnClickedButtonAddLuk)
END_MESSAGE_MAP()


// CRolePage message handlers

BOOL CRolePage::OnInitDialog()
{
	UpdateData(FALSE);
	m_StateList.InsertColumn(0,"ID",LVCFMT_LEFT,25);
	m_StateList.InsertColumn(1,"属性说明",LVCFMT_LEFT,100);
	m_StateList.InsertColumn(2,"属性值",LVCFMT_LEFT,100);
	m_StateList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	return TRUE;
}

void CRolePage::ResetPage()
{
	m_strName.SetWindowText("名字:");
	m_strLevel.SetWindowText("等级");
	m_strHP.SetWindowText("0/0");
	m_prgHP.SetRange32(0,0);
	m_prgHP.SetPos(0);
	m_strSP.SetWindowText("0/0");
	m_prgSP.SetRange32(0,0);
	m_prgSP.SetPos(0);
	m_strEXP.SetWindowText("0/0");
	m_prgEXP.SetRange32(0,0);
	m_prgEXP.SetPos(0);
	m_strEXPPercent.SetWindowText("0.00%");
	m_strMoney.SetWindowText("Money:0");
	m_strSTR.SetWindowText("力量(STR):");
	m_strDEX.SetWindowText("灵巧(DEX):");
	m_strAGI.SetWindowText("敏捷(AGI):");
	m_strVIT.SetWindowText("体质(VIT):");
	m_strSTA.SetWindowText("精力(STA):");
	m_strLUK.SetWindowText("幸运(LUK):");
	m_strAttributePoint.SetWindowText("剩余属性点:");
	m_strSkillPoint.SetWindowText("剩余技能点:");
	m_strMapName.SetWindowText("当前地图：未知");
	m_strMapPosition.SetWindowText("当前坐标：");
	m_StateList.DeleteAllItems();
}

void CRolePage::RefreshPage()
{
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	CString str;
	m_strName.SetWindowText("名字:"+pSelf->GetName());
	str.Format("等级:%d",pSelf->GetLevel());
	m_strLevel.SetWindowText(str);
	str.Format("%d/%d",pSelf->GetHP(),pSelf->GetMaxHP());
	m_strHP.SetWindowText(str);
	m_prgHP.SetRange32(0,pSelf->GetMaxHP());
	m_prgHP.SetPos(pSelf->GetHP());
	str.Format("%d/%d",pSelf->GetSP(),pSelf->GetMaxSP());
	m_strSP.SetWindowText(str);
	m_prgSP.SetRange32(0,pSelf->GetMaxSP());
	m_prgSP.SetPos(pSelf->GetSP());
	__int64 lEXP=pSelf->GetLevelEXP();
	__int64 lMaxEXP=pSelf->GetLevelMaxEXP();

	char v1[32];
	char v2[32];
	_i64toa(lEXP, v1, 10);
	_i64toa(lMaxEXP, v2, 10);

	str.Format("%s/%s",v1,v2);
	m_strEXP.SetWindowText(str);

	double maxV = pow(2, 32);

	if(lMaxEXP > maxV || lEXP > maxV)
	{
		lMaxEXP -= maxV;
		lEXP -= maxV;
	}

	m_prgEXP.SetRange32(0,(int)lMaxEXP);
	m_prgEXP.SetPos((int)lEXP);

	if (lMaxEXP==0) lMaxEXP=1;
	str.Format("%.2f%%",(((float)lEXP)/lMaxEXP)*100);
	m_strEXPPercent.SetWindowText(str);
	str.Format("Money:%d",pSelf->GetMoney());
	m_strMoney.SetWindowText(str);

	str.Format("力量(STR):%3d",pSelf->GetSTR());
	m_strSTR.SetWindowText(str);
	str.Format("灵巧(DEX):%3d",pSelf->GetDEX());
	m_strDEX.SetWindowText(str);
	str.Format("敏捷(AGI):%3d",pSelf->GetAGI());
	m_strAGI.SetWindowText(str);
	str.Format("体质(VIT):%3d",pSelf->GetVIT());
	m_strVIT.SetWindowText(str);
	str.Format("精力(STA):%3d",pSelf->GetSTA());
	m_strSTA.SetWindowText(str);
	str.Format("幸运(LUK):%3d",pSelf->GetLUK());
	m_strLUK.SetWindowText(str);

	str.Format("剩余属性点:%d",pSelf->GetAttributePoint());
	m_strAttributePoint.SetWindowText(str);
	str.Format("剩余技能点:%d",pSelf->GetSkillPoint());
	m_strSkillPoint.SetWindowText(str);


	for (int i=0;i<pSelf->GetMaxAvailableAttribNum();i++)
	{
		str.Format("%d",i);
		m_StateList.InsertItem(i,str);
		m_StateList.SetItem(i,1,LVIF_TEXT|LVIF_STATE,GetAttribName(i),0,0,0,NULL);
		str.Format("%d",pSelf->GetAttribute(i));
		m_StateList.SetItem(i,2,LVIF_TEXT|LVIF_STATE,str,0,0,0,NULL);
	}

	m_strMapName.SetWindowText("当前地图："+pSelf->GetMapName());
	str.Format("当前坐标：%.2f，%.2f",pSelf->GetPositionFloatX(),pSelf->GetPositionFloatY());
	m_strMapPosition.SetWindowText(str);
}

void CRolePage::RefreshMapPosition()
{
	CString str;
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	str.Format("当前坐标：%.2f，%.2f",pSelf->GetPositionFloatX(),pSelf->GetPositionFloatY());
	m_strMapPosition.SetWindowText(str);
}
void CRolePage::OnBnClickedButtonAddStr()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_STR);
}

void CRolePage::OnBnClickedButtonAddDex()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_DEX);
}

void CRolePage::OnBnClickedButtonAddAgi()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_AGI);
}

void CRolePage::OnBnClickedButtonAddVit()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_CON);
}

void CRolePage::OnBnClickedButtonAddSta()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_STA);
}

void CRolePage::OnBnClickedButtonAddLuk()
{
	// TODO: Add your control notification handler code here
	AddAttribute(ATTR_LUK);
}

void CRolePage::AddAttribute(WORD attrID)
{
	CPlayer* pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CGameThread* pGameThread=pPlayer->GetPlayerGameThread();
	if (!pGameThread)
	{
		return;
	}
	CNetIF *pNet=pGameThread->GetNetIF();
	if (!pNet)
	{
		return;
	}
	pNet->GetSender().AddAttribute(attrID);
}
