#ifndef DRSTRING_H
#define DRSTRING_H

#define _CRT_SECURE_NO_DEPRECATE
#pragma warning(disable:4996)

#include <string.h>
#include <stdlib.h>
#include "DBCCommon.h"
#include "BaseBuf.h"

_DBC_BEGIN
#pragma pack(push)
#pragma pack(4)
//=================================================================
class rstrbuf:public rbuf
{
public:
	rstrbuf(uLong size):rbuf(size){}
	void Initially(){InitRCount(1);*(short*)getbuf()=0;}
};
//=================================================================
class rstring
{
public:
	rstring():m_buf(0),m_overwrite(true){};						//缺省构造
	rstring(cChar *str):m_buf(0),m_overwrite(true)				//串构造
	{
		SetSize(uLong(strlen(str))+1);
		if(m_buf) strcpy(m_buf->getbuf(),str);
	}
	rstring(cwChar *str):m_buf(0),m_overwrite(true)				//宽串构造
	{
		SetSize(wctmbcpy((char*)0,str)+1);
		if(m_buf) wctmbcpy(m_buf->getbuf(),str);
	}
	explicit rstring(int i):m_buf(0),m_overwrite(true)			//整数构造
	{
		char l_str[21];
		itoa(i,l_str,10);

		SetSize(uLong(strlen(l_str))+1);
		if(m_buf)
			strcpy(m_buf->getbuf(),l_str);
	}
	rstring(const rstring &str):m_buf(0),m_overwrite(false)		//拷贝构造
	{
		m_buf	=str.m_buf;
		if(m_buf) m_buf->adopt();
	}
	~rstring(){Free();}									//析构函数

	rstring& operator=(cChar *str)
	{
		m_overwrite =true;
		SetSize(uLong(strlen(str))+1);
		if(m_buf) strcpy(m_buf->getbuf(),str);
		return *this;
	}
	rstring& operator=(int i)
	{
		char l_str[21];
		itoa(i,l_str,10);

		*this =l_str;
		return *this;
	}
	rstring& operator=(const rstring& str)		//赋值符
	{
		Free();
		m_overwrite	=false;
		m_buf	=str.m_buf;
		if(m_buf) m_buf->adopt();
		return *this;
	}
	uLong Size()const				{return !m_buf?1:m_buf->Size();}
	inline uLong SetSize(uLong)const;
	uLong length()const				{return !m_buf?0:uLong(strlen(m_buf->getbuf()));}
	void SetOverwrite(bool flag)	{m_overwrite =flag;}

	cuChar* c_ustr()const{return (cuChar*)operator cChar*();}
	cChar*  c_str()	const{return operator cChar*();}
	operator cChar*()const{return !m_buf?"":m_buf->getbuf();}
	char operator[](uLong i)const{return *(c_str()+i);}

	friend rstring& operator+=(rstring& str1,cChar *str2);
	friend rstring& operator+=(rstring& str1,const rstring& str2);
private:
	void Free()const{if(m_buf){m_buf->discard();m_buf=0;}}

	mutable	rstrbuf	*volatile	m_buf;
	mutable bool				m_overwrite;//配合SetSize使用
	static	PreAllocHeapPtr<rstrbuf> m_heap;
};
//==内联成员定义============================================================
inline uLong rstring::SetSize(uLong size)const
{
	if(Size()<size)
	{
		rstrbuf *l_buf;
		l_buf	=m_heap.Get(size);;
		if(!m_overwrite)strcpy(l_buf->getbuf(),*this);
		m_overwrite	=false;
		Free();
		m_buf =l_buf;
	}else if(size<=1)Free();	//为空就把自己释放
	return Size();
}
//==友元比较操作符定义============================================================
inline bool operator>(const rstring&str1,cChar*str2)
{
	return strcmp(str1,str2)>0;
}
inline bool operator>(cChar*str1,const rstring&str2)
{
	return strcmp(str1,str2)>0;
}
inline bool operator>(const rstring&str1,const rstring&str2)
{
	return strcmp(str1,str2)>0;
}
inline bool operator==(const rstring&str1,cChar*str2)
{
	return !strcmp(str1,str2);
}
inline bool operator==(cChar*str1,const rstring&str2)
{
	return !strcmp(str1,str2);
}
inline bool operator==(const rstring&str1,const rstring&str2)
{
	return !strcmp(str1,str2);
}
//==友元连接操作符+=定义============================================================
inline rstring& operator+=(rstring& str1,cChar *str2)
{
	str1.SetOverwrite(false);
	str1.SetSize(str1.length()+strlen(str2)+1);
	strcat(str1.m_buf->getbuf(),str2);

	return str1;
}
inline rstring& operator+=(rstring& str1,int i)
{
	char l_str[21];
	itoa(i,l_str,10);

	return str1+=l_str;
}
inline rstring& operator+=(rstring& str1,const rstring& str2)
{
	str1.SetOverwrite(false);
	str1.SetSize(str1.length()+str2.length()+1);
	strcat(str1.m_buf->getbuf(),str2);

	return str1;
}
//==友元连接操作符+定义============================================================
inline const rstring operator+ (const rstring&str1,cChar *str2)
{
	rstring	l_str =str1;
	l_str+=str2;
	return l_str;
}

inline const rstring operator+ (cChar *str1,const rstring&str2)
{
	rstring	l_str =str1;
	l_str+=str2;
	return l_str;
}

inline const rstring operator+ (const rstring&str1,const rstring&str2)
{
	rstring	l_str =str1;
	l_str+=str2;
	return l_str;
}
//==友元连接操作符<<定义============================================================
inline rstring& operator<<(rstring&str1,int i)				{return str1+=i;}
inline rstring& operator<<(rstring&str1,cChar* str2)		{return str1+=str2;}
inline rstring& operator<<(rstring&str1,const rstring& str2){return str1+=str2;}

#pragma pack(pop)
_DBC_END

#endif
