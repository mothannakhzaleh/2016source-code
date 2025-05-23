//add by ALLEN 2007-10-19
#include "StdAfx.h"
#include "UIChurchChallenge.h"
#include "UINpcTalkForm.h"

namespace GUI
{

CChurchChallengeMgr::CChurchChallengeMgr(void) :
	frmChurchSale(0), btnPriceUp(0), _pNumberBox(0), _nPrice(0), labInfoShow1(0), labInfoShow2(0), labInfoShow3(0)
{
}

CChurchChallengeMgr::~CChurchChallengeMgr(void)
{
}

bool CChurchChallengeMgr::Init()
{
#if ENABLE_CHURCHCHALLENGE

  frmChurchSale = CFormMgr::s_Mgr.Find("frmChurchSale");
  if(!frmChurchSale) return false;

  btnPriceUp = dynamic_cast<CTextButton*>(frmChurchSale->Find("btnPriceUp"));
  if(!btnPriceUp) return false;
  btnPriceUp->evtMouseClick = _evtChallengeButtonDown;

  labInfoShow1 = dynamic_cast<CLabelEx*>(frmChurchSale->Find("labInfoShow1"));
  if(!labInfoShow1) return false;

  labInfoShow2 = dynamic_cast<CLabelEx*>(frmChurchSale->Find("labInfoShow2"));
  if(!labInfoShow2) return false;

  labInfoShow3 = dynamic_cast<CLabelEx*>(frmChurchSale->Find("labInfoShow3"));
  if(!labInfoShow3) return false;

#endif

  return true;
}

void CChurchChallengeMgr::CloseForm()
{
}

void CChurchChallengeMgr::SetChallenge(const stChurchChallenge* pInfo)
{
  _stInfo = *pInfo;
}

void CChurchChallengeMgr::ShowForm(bool bShow)
{
  if(frmChurchSale)
  {
	if(bShow)
	{
	  frmChurchSale->SetPos(100, 100);
	  frmChurchSale->Refresh();

	  btnPriceUp->SetIsEnabled(!!_stInfo.sChurchID);

	  char szBuf[256] = {0};
	  if(labInfoShow1) labInfoShow1->SetCaption(_stInfo.szChaName);
	  if(labInfoShow2) labInfoShow2->SetCaption(g_pGameApp->GetCurScene()->GetMainCha()->getName());
	  if(labInfoShow3) labInfoShow3->SetCaption(StringSplitNum(_stInfo.nCurPrice, 3, ','));
	}

	frmChurchSale->SetIsShow(bShow);
  }
}

// 询问竞拍价格
void CChurchChallengeMgr::ChallengePriceAsk(void)
{
  _pNumberBox = g_stUIBox.ShowNumberBox(_evtChallengeNumInput, -1, RES_STRING(CL_LANGUAGE_MATCH_936), true); // "请输入竟拍价格"

  char szBuf[32] = {0};
  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", _stInfo.nCurPrice + _stInfo.nMinbid);
  _pNumberBox->edtNumber->SetCaption(szBuf);
}

// 确认竞拍价格
void CChurchChallengeMgr::CheckChallengePrice(void)
{
  if(_pNumberBox)
  {
	_nPrice = g_stChurchChallenge._pNumberBox->GetNumber();
	if(_nPrice >= _stInfo.nCurPrice + _stInfo.nMinbid)
	{
	  char szBuf[256] = {0};
	  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_940), _nPrice); // "确定竟拍价格 %d"
	  g_stUIBox.ShowSelectBox(_evtChallengeNumCheck, szBuf, true);
	} else
	{
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_937), _stInfo.nCurPrice + _stInfo.nMinbid); //"不得低于最低价 %d"
	}
  }
}

// 通知服务器
void CChurchChallengeMgr::NetSendChallenge(void)
{
  CS_AutionBidup(g_stUINpcTalk.GetNpcId(), _stInfo.sChurchID, _nPrice);
}

void CChurchChallengeMgr::_evtChallengeButtonDown(CGuiData* pSender, int x, int y, DWORD key)
{
  g_stChurchChallenge.ChallengePriceAsk();
}

void CChurchChallengeMgr::_evtChallengeNumInput(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes)
	return;

  g_stChurchChallenge.CheckChallengePrice();
}

void CChurchChallengeMgr::_evtChallengeNumCheck(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes)
	return;

  g_stChurchChallenge.NetSendChallenge();
}

} // namespace GUI
