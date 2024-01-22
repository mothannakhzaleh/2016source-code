// main.cpp : Defines the entry point for the console application.
//


#include "gateserver.h"
_DBC_USING;

//#include "ErrorHandler.h"
#include "ConsoleUtils.h"
#include "LicenseManager.h"
#include "instr.h"
#include "SehException.h"
//#include <ExceptionUtil.h>


int main(int argc, char* argv[])
{
  //SEHTranslator translator;

  //SEHTranslator translator;

  //ErrorHandler::Initialize();
  //ErrorHandler::DisableErrorDialogs();
	CResourceBundleManage::Instance("GateServer.loc"); //Add by lark.li 20080130
  SehExceptionBase::InitializeSehTranslator();

  T_B
  ::SetLGDir("GateLogs/log");
  
	ConsoleUtils::StartupVirtualTerminal();
	ConsoleUtils::SetFontColor(35);
	ConsoleUtils::printASCIIArt();
	ConsoleUtils::ResetFontColor();
	SetWindowText(GetConsoleWindow(), "[Yatops] GateServer");
  LicenseManager::verifyLicense();
  
	GateServerApp app;
	app.ServiceStart();

	g_gtsvr->RunLoop();
	app.ServiceStop();

	T_FINAL
  return 0;
}
