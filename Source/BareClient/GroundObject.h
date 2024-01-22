#pragma once

#include "itemobject.h"
#include "ServerHeader.h"

class CGroundObject :
	public CItemObject
{
public:
	CGroundObject(dbc::RPacket& pk);
	virtual ~CGroundObject(void);

	void SetWorldID(DWORD worldID);
	void SetHandle(DWORD handle);
	void SetPosition(DWORD x, DWORD y);
	void SetAngle(WORD angle);
	void SetAppearCause(EItemAppearType eCause);
	void SetOwnerWorldID(DWORD worldID);

	DWORD GetWorldID();
	DWORD GetHandle();
	DWORD GetPositionX();
	DWORD GetPositionY();
	float GetPositionFloatX();
	float GetPositionFloatY();
	DWORD GetDistanceTo(DWORD x,DWORD y);
	float GetDistanceInFloatTo(DWORD x,DWORD y);
	WORD GetAngle();
	EItemAppearType GetAppearCause();
	CString GetAppearCauseString();
	DWORD GetOwnerWorldID();


private:
	DWORD m_dwWorldID;
	DWORD m_dwHandle;
	DWORD m_dwPosX;
	DWORD m_dwPosY;
	WORD m_nAngle;
	EItemAppearType m_eAppearCause;
	DWORD m_dwOwnerWorldID;

	//No get interface created for the following event data
	DWORD m_dwEventEntityID;				//The ID of the event carrier - meaningless for now
	EChaCtrlType m_eEventEntityType;		//Type of event vector (prop/character..) - meaningless for now
	DWORD m_dwEventID;						//event ID
	CString m_strEventName;					//event name
};
