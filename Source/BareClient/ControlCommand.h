#pragma once



#define COMMAND_LINE_MAX_COUNT 15

class CControlCommand
{
public:
	CControlCommand(void);
	~CControlCommand(void);

	static bool IsAvailable(int index);
	static CString GetCommandShowName(int index);
	static CString GetCommandName(int index);
	static bool HasTarget(int index);
	static int GetParamCounts(int index);
	static int GetDivideStart(int index);
	static CString GetHelpInfo(int index);
	static int GetCommandLineCounts();
	static CString AssembleCommand(int index,CString strName,CString strText);
};
