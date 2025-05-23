//================================================================
// It must be permitted by Dabo.Zhang that this program is used for
// any purpose in any situation.
// Copyright (C) Dabo.Zhang 2000-2004
// All rights reserved by ZhangDabo.
// This program is written(created) by Zhang.Dabo in 2004.6
// This program is modified recently by Zhang.Dabo in 2004.11
//=================================================================
#ifndef PACKET_H
#define PACKET_H
#include "dstring.h"		//避免冲突，Packet.h头文件本身并不使用。
#include "BaseBuf.h"

_DBC_BEGIN
#pragma pack(push)
#pragma pack(4)

class TcpCommApp;
class RPacket;

enum{em_cmdsize	=sizeof(uShort)};
//==============================================================================================
class WPacket:private rptr<rbuf>
{
	friend class RPacket;
	friend class SNDPacket;
	friend class Sender;
	friend class TcpCommApp;
	friend class RPCMGR;
	friend class OnServeCall;
public:
	WPacket(const WPacket &wpkt)
		:rptr<rbuf>(wpkt),__tca(wpkt.__tca)
		,m_offset(wpkt.m_offset),m_head(wpkt.m_head),m_wpos(wpkt.m_wpos),m_cpos(wpkt.m_cpos)//,m_appendant(wpkt.m_appendant)
	{}
	WPacket(const RPacket &rpk);
	WPacket(const TcpCommApp *tca=0);
	WPacket &operator=(rbuf *bptr);
	WPacket &operator=(const WPacket &wpk);
	WPacket &operator=(const RPacket &rpk);

	WPacket		Duplicate()const;

	bool		WriteCmd(uShort	cmd);
	bool		WriteChar(uChar ch);
	bool		WriteShort(uShort sh);
	bool		WriteLong(uLong lo);
	bool		WriteLongLong(unsigned long long ll);
	bool		WriteSequence(cChar *seq,uShort len);
	bool		WriteString(cChar *str);
	bool		WriteFloat(float fVal);

	operator bool()const			{return rptr<rbuf>::operator bool();}
	uLong		HasData()const		{return (*this)?m_wpos:0;}//返回值：非0，返回已写数据的字节数；0，无数据已写。
	uLong		Size()const			{return	(*this)?(*this)->Size():0;}
	uLong		Head()const			{return m_head;}
private:
	void		WritePktLen()const;
	uLong		BackupSESS()const;
	void		WriteSESS(uLong	ses)const;
	uLong		GetDataLen()const	{return	em_cmdsize +m_wpos;}
	cChar	*	GetDataAddr()const	{return	(*this)->getbuf()+m_offset+m_head;}
	uLong		GetPktLen()const	{return m_head +em_cmdsize +m_wpos;}
	cChar	*	GetPktAddr()const	{return (*this)->getbuf()+m_offset;}

	const TcpCommApp	*	const	__tca;
	uLong					const	m_head;
	volatile uLong					m_offset,m_wpos,m_cpos;
	//volatile bool					m_appendant;
};
//==============================================================================================
class RPacket:private rptr<rbuf>
{
	friend class WPacket;
	friend class Receiver;
	friend class RPCMGR;
public:
	RPacket(const RPacket &rpk)
		:rptr<rbuf>(rpk),__tca(rpk.__tca)
		,m_offset(rpk.m_offset),m_head(rpk.m_head),m_rpos(rpk.m_rpos),m_len(rpk.m_len)
		,m_tickcount(rpk.m_tickcount),m_revrpos(0)
	{}
	RPacket(const WPacket &wpk);

	RPacket(const TcpCommApp *tca=0);
	RPacket &operator=(rbuf	*bptr);
	RPacket	&operator=(const RPacket &rpk);
	RPacket &operator=(const WPacket &wpk);

	uShort		ReadCmd();
	uChar		ReadChar();
	uShort		ReadShort();
	uLong		ReadLong();
	unsigned long long		ReadLongLong();
	cChar *		ReadSequence(uShort &retlen);
	cChar *		ReadString(uShort *len =0);
	float		ReadFloat();

	uChar		ReverseReadChar();
	uShort		ReverseReadShort();
	uLong		ReverseReadLong();
	unsigned long long ReverseReadLongLong();    
	bool		DiscardLast(uLong len);//返回值：true-成功；false-丢弃失败(丢弃的长度大于包所拥有的数据长度，不作任何改变)


	RPacket    Duplicate()const;

	operator bool()const				{return rptr<rbuf>::operator bool();}
	uLong		HasData()const			{return (bool(*this)&&(m_len>(m_head +em_cmdsize)))?(m_len -m_head -em_cmdsize):0;}
	//RemainData()返回值：非0，返回可读数据的字节数；0，无数据可读。
	uLong		RemainData()const		{return (bool(*this)&&(m_len>(m_head +em_cmdsize +m_rpos)))?(m_len -m_head -em_cmdsize -m_rpos):0;}
	uLong		Size()const				{return	(*this)?(*this)->Size():0;}
	uLong		GetDataLen()const		{return	m_len	-m_head;}
	cChar	*	GetDataAddr()const		{return	(*this)->getbuf()+m_offset+m_head;}
	uLong		GetTickCount()const		{return m_tickcount;}

	// 判断是否是正确的包
	bool        IsOK() { return (m_len > m_head); }

private:
	uLong		ReadSESS()const;
	void		RestoreSESS(uLong ses)const;
	void		ReadPktLen();
	void		SetOffset(uLong offset)	{m_offset =offset;}
	uLong		GetOffset()const		{return	m_offset;}
	void		SetPktLen(uLong len)	{m_len	=len;}
	uLong		GetPktLen()const		{return m_len;}
	cChar	*	GetPktAddr()const		{return (*this)->getbuf()+m_offset;}

	const TcpCommApp	*	const	__tca;
	uLong					const	m_head;
	volatile uLong					m_offset,m_rpos,m_len,m_revrpos,m_tickcount;
};

#pragma pack(pop)
_DBC_END

#endif
