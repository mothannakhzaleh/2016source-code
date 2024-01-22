#pragma once
#include "uiglobalvar.h"
#include "GuildData.h"
#include "UIPage.h"

namespace GUI
{

class CUIGuildMgr :
	public CUIInterface
{
  public:
  CUIGuildMgr(void);
  ~CUIGuildMgr(void);
  static void ShowForm();
  static void RefreshList();
  static void RefreshAttribute();
  static void RefreshForm();
  static void RemoveForm();

  protected:
  virtual bool Init();

  private:
  static CForm*	   m_pGuildMgrForm;
  static CLabelEx* m_plabGuildName;
  static CLabelEx* m_plabGuildMottoName;
  static CLabelEx* m_plabGuildType;
  static CLabelEx* m_plabGuildMaster;
  static CLabelEx* m_plabGuildMemberCount;
  static CLabelEx* m_plabGuildExperience;
  static CLabelEx* m_plabGuildMoney;
  static CLabelEx* m_plabGuildState;
  static CLabelEx* m_plabGuildRemainTime;
  //static CLabelEx*	m_plabGuildRank;
  static CListView*	  m_plstGuildMember;
  static CListView*	  m_plstRecruitMember;
  static CTextButton* m_pbtnGuildMottoEdit;
  static CTextButton* m_pbtnGuildDismiss;
  static CTextButton* m_pbtnMemberRecruit;
  static CTextButton* m_pbtnMemberRefuse;
  static CTextButton* m_pbtnMemberKick;
  static CPage*		  m_ppgeClass;
  static void		  _OnClickEditMottoName(CGuiData* pSender, int x, int y, DWORD key);
  static void		  _OnClickDismiss(CGuiData* pSender, int x, int y, DWORD key);
  static void		  _OnClickRecruit(CGuiData* pSender, int x, int y, DWORD key);
  static void		  _OnClickRefuse(CGuiData* pSender, int x, int y, DWORD key);
  static void		  _OnClickKick(CGuiData* pSender, int x, int y, DWORD key);
  static void		  _OnClickSelectPage(CGuiData* pSender);
  static void		  _OnClickLeave(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
  static void		  _OnPassKick(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
  static void		  _OnPassDismiss(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static CForm*		  m_pGuildMottoNameEditForm;
  static CEdit*		  m_pedtGuildMottoName;
  static CTextButton* m_pbtnGuildMottoFormOK;
  static void		  _OnClickMottoFormOK(CGuiData* pSender, int x, int y, DWORD key);

  static void OnBeforeShow(CForm* pForm, bool& IsShow);

  //	Rain.
  static CTextButton* btnyqrh;
  static CEdit*		  edtyqname;
  static void		  SendInviteName(CGuiData* pSender, int x, int y, DWORD key);
  //	End.
};

} // namespace GUI
