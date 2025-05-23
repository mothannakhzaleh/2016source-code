//=============================================================================
// FileName: Event.h
// Creater: ZhangXuedong
// Date: 2005.10.11
// Comment: Event
//=============================================================================

#ifndef EVENT_H
#define EVENT_H

#include "dbccommon.h"

#define defMAX_EVENT_NAME_LEN	256

/**
 * @class CEvent 
 * @author 
 * @brief 事件封装
 *
 */
class CEvent
{
public:
	CEvent() {Init();}

	void Init(void)
	{
		m_usID = 0;
		m_usTouchType = 0;
		m_usExecType = 0;
		m_pTableRec = 0;
		//m_szName[0] = '\0';
		memset(m_szName, 0, sizeof(m_szName));
	}

	void	SetID(dbc::uShort usID) { m_usID = usID; }
	void	SetTouchType(dbc::uShort usTchTpe) { m_usTouchType = usTchTpe; }
	void	SetExecType(dbc::uShort usExcTpe) { m_usExecType = usExcTpe; }
	void	SetTableRec(void *pTblRec) { m_pTableRec = pTblRec; }
	void	SetName(dbc::cChar *cszName) 
	{
		if (!cszName) 
			return; 
		/*strncpy(m_szName, cszName, defMAX_EVENT_NAME_LEN - 1)*/
		strncpy_s(m_szName, sizeof(m_szName), cszName,_TRUNCATE); 
		m_szName[defMAX_EVENT_NAME_LEN -1] = '\0';
	}

	dbc::uShort	GetID(void) { return m_usID; }
	dbc::uShort	GetTouchType(void) { return m_usTouchType; }
	dbc::uShort	GetExecType(void) { return m_usExecType; }
	void* GetTableRec(void) { return m_pTableRec; }
	const dbc::Char* GetName(void) const { return m_szName; }

	void	WriteInfo(WPACKET &pk);

protected:

private:
	dbc::uShort	m_usID;			// 编号
	dbc::uShort	m_usTouchType;	// 触发类型
	dbc::uShort	m_usExecType;	// 执行类型
	void		*m_pTableRec;
	dbc::Char	m_szName[defMAX_EVENT_NAME_LEN];		// 名称

};

inline void CEvent::WriteInfo(WPACKET &pk)
{
	WRITE_SHORT(pk, m_usID);
	WRITE_STRING(pk, m_szName);
}

#endif // EVENT_H