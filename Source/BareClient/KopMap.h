#pragma once

class CKopMap
{
public:
	CKopMap(void);
	~CKopMap(void);
	void SetName(CString name);
	void SetMainRolePosX(long X);
	void SetMainRolePosY(long Y);
	void SetAngle(int angle);

	CString GetName();
	long GetMainRolePosX();
	long GetMainRolePosY();
	float GetMainRolePosXMeter();
	float GetMainRolePosYMeter();
	int GetAngle();

private:
	CString m_strName;
	long m_lMainRolePosX;
	long m_lMainRolePosY;
	int m_nAngle;
};
