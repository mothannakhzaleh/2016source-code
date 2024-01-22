//=============================================================================
// FileName: Item.cpp
// Creater: ZhangXuedong
// Date: 2004.09.21
// Comment: CItem class
//=============================================================================

#include "Item.h"
#include "GameCommon.h"
#include "GameAppNet.h"
#include "SubMap.h"
#include "gamedb.h"

_DBC_USING

CItem::CItem()
{T_B
	chValid = 0;
	m_pCItemRecord = 0;
	m_SGridContent.sID = 0;
	m_lFromEntityID = 0;
	m_chSpawType = enumITEM_APPE_NATURAL;
T_E}

void CItem::Initially()
{T_B
	Entity::Initially();

	chValid = 0;
	m_pCItemRecord = 0;
	m_SGridContent.sID = 0;
	m_chSpawType = enumITEM_APPE_NATURAL;
	m_ulStartTick = GetTickCount();
	m_ulOnTick = g_Config.m_lItemShowTime * 1000;
	m_ulProtOnTick = g_Config.m_lItemProtTime * 1000;
	m_ulProtID = 0;
	m_ulProtHandle = 0;
	m_chProtType = enumITEM_PROT_OWN;
T_E}

void CItem::Finally()
{T_B
	if (m_submap)
		m_submap->GoOut(this);
	Entity::Finally();
T_E}

void CItem::OnBeginSeen(CCharacter *pCMainCha)
{T_B
	WPACKET pk =GETWPACKET();
	WRITE_CMD(pk, CMD_MC_ITEMBEGINSEE);
	// 基本数据
	WRITE_LONG(pk, m_ID);							// world ID
	WRITE_LONG(pk, m_lHandle);
	WRITE_LONG(pk, m_pCItemRecord->lID);			// ID
	WRITE_LONG(pk, GetShape().centre.x);			// 当前x位置
	WRITE_LONG(pk, GetShape().centre.y);			// 当前y位置
	WRITE_SHORT(pk, m_sAngle);					// 方向
	WRITE_SHORT(pk, m_SGridContent.sNum);			// 个数
	//
	WRITE_CHAR(pk, m_chSpawType);
	WRITE_LONG(pk, m_lFromEntityID);
	// 事件信息
	WriteEventInfo(pk);

	pCMainCha->ReflectINFof(this,pk);//通告
T_E}

void CItem::OnEndSeen(CCharacter *pCMainCha)
{T_B
	WPACKET pk =GETWPACKET();
	WRITE_CMD(pk, CMD_MC_ITEMENDSEE);
	WRITE_LONG(pk, m_ID);				//ID
	pCMainCha->ReflectINFof(this,pk);	//通告
T_E}

void CItem::Run(dbc::uLong ulCurTick)
{
	if (m_ulProtID != 0)
		if (m_ulProtOnTick != 0 && ulCurTick - m_ulStartTick >= m_ulProtOnTick) // 保护时间消失
			m_ulProtID = 0;

	if (m_ulOnTick != 0 && ulCurTick - m_ulStartTick >= m_ulOnTick)
	{
		// 判断是否船长证明道具
		CItemRecord* pItem = m_pCItemRecord;
		if( pItem != NULL )
		{
			// 判断丢弃船长证明
			if( pItem->sType == enumItemTypeBoat )
			{
				game_db.SaveBoatDelTag( this->GetGridContent()->GetDBParam( enumITEMDBP_INST_ID ), 1 );
			}
		}
		if (!m_submap)
			//LG("道具消失错误", "道具 %s(ID %u，HANDLE %u，位置[%d %d]) 在消失时发现其地图为空\n", GetName(), GetID(), GetHandle(), GetPos().x, GetPos().y);
			LG("Item disappear error", "item %s(ID %u，HANDLE %u，position[%d %d]) when it disappear find the map is null\n", GetName(), GetID(), GetHandle(), GetPos().x, GetPos().y);
		else
		{
			Free();
		}
	}
}

//	yangyinyu	2008-8-18	add	function!
static	char	s_logText[512];

//
#include <string.h>

void	lgtool_PrintGetType(	const	char*	sGetType	)
{
	//strncpy(	s_logText,	sGetType,	512	);
	strncpy_s( s_logText, sizeof(s_logText), sGetType, _TRUNCATE );
};

//
void	lgtool_PrintItem(	
			const	char*	szPlyName,	//	游戏者名字。
			int				iChaId,		//	人物ID号。
			short			sPickupNum,
			CItemRecord*	pItem,		
			SItemGrid*		sig
			)
{
	static	char	sTextEx[512];
	
	//_snprintf(	sTextEx,	512,	"%s;%d;%s;%d;%d;%d;%d;%d;%d;",
	//	szPlyName,			//	玩家名字。
	//	iChaId,				//	人物ID号。
	//	pItem->szName,		//	道具名字。
	//	pItem->sType,		//	道具类型。
	//	sig->sID,			//	道具类型ID。
	//	sig->dwDBID,		//	唯一ID。
	//	sPickupNum,			//	数量。
	//	sig->GetDBParam(0),	//	精练信息。
	//	sig->GetDBParam(1)	//	属性装备ID。
	//	);
	_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%s;%d;%s;%d;%d;%d;%d;%d;%d;",
		szPlyName,			//	玩家名字。
		iChaId,				//	人物ID号。
		pItem->szName,		//	道具名字。
		pItem->sType,		//	道具类型。
		sig->sID,			//	道具类型ID。
		sig->dwDBID,		//	唯一ID。
		sPickupNum,			//	数量。
		sig->GetDBParam(0),	//	精练信息。
		sig->GetDBParam(1)	//	属性装备ID。
		);

	//strcat(	s_logText,	sTextEx	);
	strncat_s( s_logText,sizeof(s_logText), sTextEx,_TRUNCATE);

	//	如果是装备类
	if(	pItem->sType	<	31	)
	{
		struct	aaa
		{
		static	void	printfAttr(	char*	sText,	SItemGrid*	sig,	int	begin,	int	end	)
			{
				for(	int	i	=	begin;	i	<=	end;	i	++	)
				{
					short	attr	=	sig->GetAttr( i );

					if(	attr	)
					{
						//_snprintf(	sTextEx,	512,	"%d-%d,",	i,	attr	);
						_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d-%d,",	i,	attr	);
						//strncat(	sText,	sTextEx,	512	);
						strncat_s( sText,512, sTextEx,_TRUNCATE);
					};
				};
			};
		};

		//	ATTR_COUNT_BASE1    -	ATTR_BOAT_PRICE     
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE1,	ATTR_BOAT_PRICE	);

		//	ATTR_COUNT_BASE2	-	ATTR_BOAT_BCSPD
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE2,	ATTR_BOAT_BCSPD	);

		//	ATTR_COUNT_BASE3    -	ATTR_ITEMC_PDEF     
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE3,	ATTR_ITEMC_PDEF	);

		//	ATTR_COUNT_BASE4	-	ATTR_ITEMV_PDEF
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE4,	ATTR_ITEMV_PDEF	);

		//	ATTR_COUNT_BASE5	-	ATTR_STATEC_PDEF    
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE5,	ATTR_STATEC_PDEF	);

		//	ATTR_COUNT_BASE6	-	ATTR_LHAND_ITEMV    
		aaa::printfAttr(	s_logText,	sig,	ATTR_COUNT_BASE6,	ATTR_LHAND_ITEMV	);

	}
	//	如果是精灵，则记载精灵属性。
	else	if(	pItem->sType	==	59	)
	{
		//	记载精灵的力量，敏捷，体力，精神，专注。
		struct	bbb
		{	
			static	void	printPet(	char*	sText,	SItemGrid*	sig,	int	iAttrId	)
			{
				//_snprintf(	sTextEx,	512,	"%d-%d,",	iAttrId,	sig->GetAttr(	iAttrId	)	);
				_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d-%d,",	iAttrId,	sig->GetAttr(	iAttrId	)	);
				//strncat(	sText,	sTextEx,	512	);
				strncat_s( sText,512, sTextEx,_TRUNCATE);
			};
		};

		//	打印相关的系数。
		for(	int	i	=	ITEMATTR_COE_STR;	i	<=	ITEMATTR_COE_STA;	i	++	)
		{
			bbb::printPet(	s_logText,	sig,	i	);
		}

		//	打印相关的常数。
		for(	int	i	=	ITEMATTR_VAL_STR;	i	<=	ITEMATTR_VAL_STA;	i	++	)
		{
			bbb::printPet(	s_logText,	sig,	i	);
		}

		//	打印精灵技能。
		//_snprintf(	sTextEx,	512,	"%d,",	sig->GetDBParam(	enumITEMDBP_FORGE	)	);
		_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d,",	sig->GetDBParam(	enumITEMDBP_FORGE	)	);
		//strncat(	s_logText,	sTextEx,	512	);
		strncat_s( s_logText,sizeof(s_logText), sTextEx,_TRUNCATE);

		//	打印精灵等级。
		//_snprintf(	sTextEx,	512,	"%d",	sig->GetForgeLv()	);
		_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d",	sig->GetForgeLv()	);
		//strncat(	s_logText,	sTextEx,	512	);
		strncat_s( s_logText,sizeof(s_logText), sTextEx,_TRUNCATE);
	}
	//	如果是宝石，则记录宝石等级和宝石效果。
	else	if(	pItem->sType	==	49	)	//	高超告诉我49是宝石。
	{
		//	打印宝石等级。
		//_snprintf(	sTextEx,	512,	"%d,",	sig->GetForgeLv()	);
		_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d,",	sig->GetForgeLv()	);
		//strncat(	s_logText,	sTextEx,	512	);
		strncat_s( s_logText,sizeof(s_logText), sTextEx,_TRUNCATE);

		//	打印宝石效果。
		//_snprintf(	sTextEx,	512,	"%d,",	sig->GetDBParam(	enumITEMDBP_FORGE	)	);
		_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%d,",	sig->GetDBParam(	enumITEMDBP_FORGE	)	);
		//strncat(	s_logText,	sTextEx,	512	);
		strncat_s( s_logText,sizeof(s_logText), sTextEx,_TRUNCATE);
	}

	//	打印LOG。
	//strncat(	s_logText,	"\n",	512	);
	strncat_s( s_logText,sizeof(s_logText), "\n",_TRUNCATE);

	//	*
	LG("query_item",s_logText	);
};