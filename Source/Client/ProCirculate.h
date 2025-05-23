#ifndef PROCIRCULATE_H
#define PROCIRCULATE_H
#include "GameCommon.h"

class CActionState;
class CChaAttr;
class NetIF;
class CCharacter;

class CProCirculate
{
  public:
  CProCirculate(NetIF* p) :
	  pCNetIf(p) {}
  virtual ~CProCirculate() {}

  virtual void BeginAction(CCharacter* pCha, DWORD type, void* param, CActionState* pState) {}
  virtual void EndAction(CActionState* pState) {}

  public:
  bool Connect(const char* hostname, unsigned short port, unsigned long timeout);
  void Disconnect(int reason);
  void Login(const char* accounts, const char* password, const char* passport);
  void Logout();
  void BeginPlay(const char* cha);
  void EndPlay();
  void NewCha(const char* chaname, const char* birth, LOOK& look);
  void DelCha(const char* cha, const char szPassword2[]);

  void SynBaseAttribute(CChaAttr* pCAttr);
  void RefreshChaData(long lWorldID, long lHandle);
  void Say(const char* pszContent);

  void SkillUpgrade(short sSkillID, char chAddLv);
  void RequestLeaveExp(char isGet, int LeaveTime, int Position, int putNum);
  void SendCoinInfo(int Position, int sNum);
  void TradeWithYourSelf(BYTE byPageID, BYTE byIndex);
  void InviteInGuild(const char* InviteName); //	Rain.
  void AcceptGuildInviteConfirm(unsigned long chaid);
  void RefuseGuildInviteConfirm(unsigned long chaid);

  protected:
  NetIF* pCNetIf;
};

class CProCirculateCC : public CProCirculate
{
  public:
  CProCirculateCC(NetIF* p) :
	  CProCirculate(p) {}
  virtual void BeginAction(CCharacter* pCha, DWORD type, void* param, CActionState* pState);
  virtual void EndAction(CActionState* pState);
};

class CProCirculateCS : public CProCirculate
{
  public:
  CProCirculateCS(NetIF* p) :
	  CProCirculate(p) {}

  virtual void BeginAction(CCharacter* pCha, DWORD type, void* param, CActionState* pState);
  virtual void EndAction(CActionState* pState);
};

#endif // PROCIRCULATE_H
