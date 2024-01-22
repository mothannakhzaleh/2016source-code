#pragma once

#include "CompCommand.h"

enum EChaCtrlType;

class CRoleList
{
public:
	CRoleList(void);
	~CRoleList(void);
	void SetName(CString name);
	void SetShipName(CString name);
	void SetMottoName(CString strMotto);
	void SetJobName(CString jobName);
	void SetLevel(DWORD level);
	void SetLook(const LOOK *sLook);
	void SetCharID(DWORD id);
	void SetWorldID(DWORD id);
	void SetCommID(DWORD id);
	void SetGMLv(DWORD lv);
	void SetCharHandle(DWORD handle);
	void SetCharType(EChaCtrlType type);
	void SetIconID(DWORD icon);
	//void SetState(CRoleObject::eState state);
	void SetRadius(long radius);


	CString GetName();
	CString GetShipName();
	CString GetMottoName();
	CString GetJobName();
	DWORD Getlevel();
	DWORD GetCharID();
	DWORD GetWorldID();
	DWORD GetCommID();
	DWORD GetGMLv();
	DWORD GetCharHandle();
	EChaCtrlType GetCharType();
	DWORD GetIconID();
	//CRoleObject::eState GetState();
	long GetRadius();

private:
	CString m_strName;
	CString m_strShipName;
	CString m_strMottoName;
	CString m_strJobName;
	DWORD m_dwLevel;
	LOOK *m_psLook;
	DWORD m_dwCharID;
	DWORD m_dwWorldID;
	DWORD m_dwCommID;
	DWORD m_dwGMLv;
	DWORD m_dwCharHandle;
	EChaCtrlType m_eType;
	DWORD m_dwIconID;
	//eState m_eState;
	long m_lRadius;
};
