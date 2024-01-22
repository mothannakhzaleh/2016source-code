#pragma once
#include "roleobject.h"

class CPlayerObject :
	public CRoleObject
{
public:
	CPlayerObject(void);
	virtual ~CPlayerObject(void);

	void SetShipName(CString name);
	void SetMottoName(CString strMotto);
	void SetJobName(CString jobName);
	void SetIconID(DWORD iconID);
	void SetLevel(DWORD level);
	void SetGMLv(DWORD lv);
	void SetGuildID(DWORD dwGuildID);
	void SetGuildName(CString strName);
	void SetGuildMottoName(CString strMottoName);
	void SetPKSide(BYTE bSide);


	CString GetShipName();
	CString GetMottoName();
	CString GetJobName();
	DWORD GetIconID();
	DWORD Getlevel();
	DWORD GetGMLv();
	DWORD GetGuildID();
	CString GetGuildName();
	CString GetGuildMottoName();
	BYTE GetPKSide();


private:
	CString m_strShipName;
	CString m_strMottoName;
	CString m_strJobName;
	CString m_strGuildName;
	CString m_strGuildMottoName;
	DWORD m_dwIconID;
	DWORD m_dwLevel;
	DWORD m_dwGMLv;
	DWORD m_dwGuildID;
	BYTE m_bSide;
};
