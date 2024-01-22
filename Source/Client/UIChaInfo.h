//----------------------------------------------------------------------
// 名称:用于实现人物信息界面
// 作者:zcj 2008-8-7
// 最后修改日期:2008-8-7
//----------------------------------------------------------------------
#pragma once
#include "UIGlobalVar.h"
#include <list>
class CCharacter2D;

#include "netprotocol.h"

extern int SMALL_ICON_SIZE;
extern int BIG_ICON_SIZE;

namespace GUI
{
class CGuiData;
class CMenu;
class CTreeNodeObj;
class CItemObj;
class CGuiTime;
class CTextButton;
class CEdit;
class CLabel;
class CMember;

//struct stPersonInfo
//{
//	char	szMotto[40];				// 签名
//	bool	bShowMotto;					// 显示签名开关
//	char	szSex[10];					// 性别
//	short	sAge;						// 年龄
//	char	szName[50];					// 名字
//	char	szAnimalZodiac[50];			// 属相
//	char	szBloodType[50];			// 血型
//	int		iBirthday;					// 生日（）
//	char	szState[50];				// 州（省）
//	char	szCity[50];					// 城市（区）
//	char	szConstellation[50];		// 星座
//	char	szCareer[50];				// 职业
//	int		iSize;						// 头像大小([8 * 1024])
//	char	pAvatar[8096];				// 头像
//	bool	bPprevent;					// 是否阻止消息
//	int		iSupport;					// 鲜花数
//	int		iOppose;					// 臭鸡蛋数
//	stPersonInfo&  operator =(const stPersonInfo & _info)
//	{
//		strcpy(szMotto,_info.szMotto);
//		bShowMotto = _info.bShowMotto;
//		strcpy(szSex,_info.szSex);
//		sAge = _info.sAge;
//		strcpy(szName,_info.szName);
//		strcpy(szAnimalZodiac,_info.szAnimalZodiac);
//		strcpy(szBloodType,_info.szBloodType);
//		iBirthday = _info.iBirthday;
//		strcpy(szState,_info.szState);
//		strcpy(szCity,_info.szCity);
//		strcpy(szConstellation,_info.szConstellation);
//		strcpy(szCareer,_info.szCareer);
//		iSize = _info.iSize;
//		strcpy(pAvatar,_info.pAvatar);
//		bPprevent = _info.bPprevent;
//		iSupport = _info.iSupport;
//		iOppose = _info.iOppose;
//		return *this;
//	}
//
//
//};
//struct stQueryPersonInfo
//{
//	char	sChaName[64];			// 名字
//	bool	bHavePic;				// 是否显示头像
//	char	cSex[4];				// 性别	  1是男 0是女的
//	int		nMinAge[2];				// 年龄查询的m_nMinAge[1]最大和m_nMinAge[0]最小值
//	char	szAnimalZodiac[4];		// 生肖
//	int		iBirthday[2];			// 查询出生年的m_nBirth[1]最大和m_nBirth[0]最小值
//									 0xffff0000&month   0xffff&day
//	char	szState[32];			// 省份
//	char	szCity[32];				// 城市
//	char	szConstellation[16];	// 星座
//	char	szCareer[32];			// 工作
//	int		nCurPage;				// 当前页数
//	stQueryPersonInfo& operator =(const stQueryPersonInfo& _info)
//	{
//		strcpy(sChaName,_info.sChaName);
//		bHavePic = _info.bHavePic;
//		strcpy(cSex,_info.cSex);
//		nMinAge[0] = _info.nMinAge[0];
//		nMinAge[1] = _info.nMinAge[1];
//		strcpy(szAnimalZodiac,_info.szAnimalZodiac);
//		iBirthday[0] = _info.iBirthday[0];
//		iBirthday[1] = _info.iBirthday[1];
//		strcpy(szState,_info.szState);
//		strcpy(szCity,_info.szCity);
//		strcpy(szConstellation,_info.szConstellation);
//		strcpy(szCareer,_info.szCareer);
//		nCurPage = _info.nCurPage;
//		return *this;
//	}
//
//};
//struct stQueryResoultPersonInfo
//{
//	char	sChaName[64];		// 名字
//	int		nMinAge;			// 年龄
//	char	cSex[4];			// 性别	  1是男 0是女的
//	char	szState[32];		// 省份
//	char	nCity[32];			// 城市
//	char	pAvatar[8096];		// 头像图片
//	stQueryResoultPersonInfo& operator =(const stQueryResoultPersonInfo& _info)
//	{
//		strcpy(sChaName,_info.sChaName);
//		nMinAge = _info.nMinAge;
//		strcpy(cSex,_info.cSex);
//		strcpy(szState,_info.szState);
//		strcpy(nCity,_info.nCity);
//		strcpy(pAvatar,_info.pAvatar);
//		return   *this;
//	}
//};
//
class CChaQeryInfo : public CUIInterface
{
  public:
  CChaQeryInfo();

  bool Init();
  void End();

  void RefreshInfo(); // 刷新人物界面

  void RefreshInfoData(CMember* pCurMember); // 刷新人物数据

  void ClearInfo(); // 清除人物界面

  void SetShowChaInfo(bool _b);

  void SetShowQChaInfo(bool _b);

  void SetShowQRChaInfo(bool _b);

  bool SetSearchFrmData(stPersonInfo* _info, CMember* _m);

  stPersonInfo* GetSearchFrmData();

  bool SetQueryFrmData(stQueryPersonInfo* _info);

  stQueryPersonInfo* GetQueryFrmData();

  bool SetQueryRFrmData(stQueryResoultPersonInfo* _info, int num);

  stQueryResoultPersonInfo* GetQueryRFrmData();

  void ClearQueryRFrmData(); // 清空查询结果面板上次的数据

  void UpdateInfo();

  void FrameMove(DWORD dwTime);

  private:
  static bool _Error(const char* strInfo, const char* strFormName, const char* strCompentName)
  {
	LG("gui", strInfo, strFormName, strCompentName);
	return false;
  }

  static void _RenderEvent(C3DCompent* pSender, int x, int y);
  static void _MemberMouseDownEvent(CGuiData* pSender, int x, int y, DWORD key);

  static void _evSFrm(CGuiData* pSender, int x, int y, DWORD key);
  static void _evQFrm(CGuiData* pSender, int x, int y, DWORD key);

  public:
  // data
  stPersonInfo								  m_ShowInfo;	 // 玩家信息
  stQueryPersonInfo							  m_QeryInfo;	 // 查询信息
  stQueryResoultPersonInfo					  m_ResoultInfo; // 查询结果信息
  typedef std::list<stQueryResoultPersonInfo> ResoultList;
  ResoultList								  m_ResoultInfoList; // 查询结果信息列表

  //UI
  static CForm* m_pFrmSInfo;
  static CForm* m_pFrmQInfo;
  static CForm* m_pFrmQRInfo;

  // form   search info
  CLabel*	   m_pEdtTradeGold;	 //	座右铭
  CLabel*	   m_pLabName;		 //  用户名称
  CLabel*	   m_pChaguild;		 //  公会名称
  CLabel*	   m_pChaLv;		 //  角色等级
  CLabel*	   m_pChaJob;		 //	职业
  CLabel*	   m_pReputation;	 //  声望
  CLabel*	   m_pChaNickName;	 //   角色称号
  CLabel*	   m_pSupport;		 //  支持度(鲜花)
  CLabel*	   m_pOppose;		 //	反对（臭鸡蛋）
  CLabel*	   m_pAttention;	 //  关注度
  CLabel*	   m_pChaSex;		 //   角色性别
  CLabel*	   m_pChaAge;		 //   角色年龄
  CLabel*	   m_pChaName;		 //	 玩家姓名
  CLabel*	   m_pAnimalZodiac;	 //	 属相
  CLabel*	   m_pBloodType;	 //	 血型
  CLabel*	   m_pBirthMonth;	 //	 出生月
  CLabel*	   m_pBirthDay;		 //	 出生日
  CLabel*	   m_pState;		 //	 出生省
  CLabel*	   m_pCity;			 //	 出生市
  CLabel*	   m_pConstellation; //	 星座
  CLabel*	   m_pJob;			 //	 玩家真正的职业
  CLabel*	   m_pIdiograph;	 //	 玩家签名
  CTextButton* m_pAddFlowerBt;	 //	 鲜花添加
  CTextButton* m_pAddEggBt;		 //	 臭鸡蛋添加
  CTextButton* m_pChangePhoto;	 //	 更换头像按扭
  CImage*	   m_pChaPhoto;		 //	 头像
  //CCheckBox*			m_pStopChat;				//	 禁言
  CTextButton* m_pBtYes; //	 确定按扭

  // form query info
  CEdit*	   m_pQchaName;		  //   角色名称
  CEdit*	   m_pQHasPic;		  //   角色是否有照片
  CEdit*	   m_pQSex;			  //	 角色性别
  CEdit*	   m_pQminAge;		  //	 角色年龄最小
  CEdit*	   m_pQmaxAge;		  //	 角色年龄最大
  CEdit*	   m_pQAnimalZodiac;  //	 角色属相
  CEdit*	   m_pQBirthmonth0;	  //	 角色生日（月）第一个
  CEdit*	   m_pQBirthmonth1;	  //	 角色生日（月）第二个
  CEdit*	   m_pQBirthday0;	  //	 角色生日（日）第一个
  CEdit*	   m_pQBirthday1;	  //	 角色生日（日）第二个
  CEdit*	   m_pQstate;		  //	 角色省份
  CEdit*	   m_pQcity;		  //	 角色城市
  CEdit*	   m_pQConstellation; //	 角色星座
  CEdit*	   m_pQjob;			  //	 角色职业
  CTextButton* m_pQYes;			  //	 角色确定
  CTextButton* m_pPicBox1;		  //	 相册1
  CTextButton* m_pPicBox2;		  //	 相册2
								  //	CTextButton*		m_pAddPicBox;				//	 增加相册

  // for  resoult query info
  CList* m_pQRList; //	 查询显示结果列表
};

} // namespace GUI
extern CChaQeryInfo g_ChaQeryInfo;
