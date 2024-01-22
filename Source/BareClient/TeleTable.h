#pragma once

class CTeleTable
{
public:
	CTeleTable(void);
	~CTeleTable(void);

	static void AddTargetText(CString text);
	static CString GetRandomTeleCommand();

private:
	static CCriticalSection m_Critical_Access;
	static CString m_TeleTable[AUTO_TELE_TABLE_MAXNUM];
	static int m_nMaxCount;
};
