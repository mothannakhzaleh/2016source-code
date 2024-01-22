/**
 * Copyright (C), 2008-2010.
 * @file  ResourceBundleManage.h
 * @brief 资源管理文件
 * @history
 * 
 * @author Lark.Li
 * @version 1.0
 * @date 2008-11-18
 * @warning 必需使用ICU1.38版本
 * 
 * @todo 因为时间原因放弃了语言的继承性
*/
#pragma once

#include <unicode/resbund.h>            // 资源管理信息
#include <unicode/ucnv.h>               // 字符编码转换
#include <unicode/uclean.h>             // 字符编码转换
#include <unicode/msgfmt.h>             // 格式化字符串
#include <unicode/brkiter.h>            // 断字
#include <unicode/uchar.h>              // 字符类型

#include <map>                          // map
#include <string>

/**
 * @class CFormatParameter 
 * @author Lark.Li
 * @brief 为格式化消息串，所使用的参数封装，避免不同语言版本的参数位置不同错误
*/
class CFormatParameter
{
private:
	icu::Formattable* m_MsgArgs;
	int paraNum;
private:
	CFormatParameter(){}
public:
	CFormatParameter(int paraNum);
	~CFormatParameter();

	/**
	* @brief 取得格式化参数
	* @return Formattable 格式化参数
	*/
	icu::Formattable* GetMsgArgs(){ return m_MsgArgs;} 

	/**
	* @brief 取得参数个数
	* @return int 参数个数
	*/
	int GetParaNum() { return paraNum; }

	/**
	* @brief 设置浮点数参数
	* @param[in]  int  参数位置
	* @param[in]  double  参数值
	*/
	void setDouble(int index, double d);

	/**
	* @brief 设置32位整数参数
	* @param[in]  int  参数位置
	* @param[in]  int32_t  参数值
	*/
	void  setLong(int index, int32_t l);

	/**
	* @brief 设置64位整数参数
	* @param[in]  int  参数位置
	* @param[in]  int64_t  参数值
	*/
	void  setInt64(int index, int64_t ll) ;

	/**
	* @brief 设置日期参数
	* @param[in]  int  参数位置
	* @param[in]  UDate  参数值
	*/
	void  setDate(int index, UDate d) ;

	/**
	* @brief 设置字符串参数
	* @param[in]  int  参数位置
	* @param[in]  UnicodeString  参数值
	*/
	void  setString(int index, const icu::UnicodeString &stringToCopy);
};

/**
 * @class CResourceBundleManage 
 * @author Lark.Li
 * @brief 管理所有的资源字符串
*/
class CResourceBundleManage
{
private:
	CResourceBundleManage(){}
	CResourceBundleManage(const char* configFileName);

public:
	virtual ~CResourceBundleManage(void);

	typedef std::map <std::string, std::string> StringMap;

private:
	char* m_ResDir;				// 资源位置
	char* m_ResLocale;			// 资源语言

	icu::Locale* m_pLocale;			// 区域设定

	StringMap mapRes;
	icu::ResourceBundle* m_pResourceBundle;
	UConverter *m_pConverter;
	int m_MaxSize;

	//int m_LogFlag;

	//FILE* m_LogFile;

    static CResourceBundleManage* _instance;

private:
	UErrorCode ToCodePageString(UConverter *conv, UChar* source, char* target, int destCapacity, int& len);
	bool Init();

public:

 	/**
	* @brief 实例化资源管理器
	* @param[in]  const char*  配置文件名字
    * @exception resource is used before init
    * @exception resource is init twince
    * @return Locale 资源管理器
	*/
   static CResourceBundleManage* Instance(const char* configFileName = NULL);

	/**
	* @brief 取得设定的区域信息
	* @return Locale 区域信息
	*/
	const icu::Locale& GetLocale() { return *m_pLocale; }

	/**
	* @brief 取得区域字符串转换器
	* @return UConverter 字符串转换器
	*/
	const UConverter* GetConverter() { return m_pConverter; }

	/**
	* @brief 取得资源个数
	* @return int 资源个数
	*/
	int GetSize(void);
	
	/**
	* @brief 释放资源
	*/
	void Release(void);

	/**
	* @brief 根据key取到字符串value
	* @param[in]  const char*  字符串的key
	* @return const char* 字符串value
	*/
	const char* LoadResString(const char* key);

	/**
	* @brief 根据key取到字符串value(UnicodeString )
	* @param[in]  const char*  字符串的key
	* @return UnicodeString 字符串value(UnicodeString )
	*/
	icu::UnicodeString LoadUResString(const char* key);

	/**
	* @brief 根据参数格式化字符串
	* @param[in]  const char*  字符串的key
	* @param[in]  CFormatParameter&  输入的参数
	* @param[out]  char[]  根据参数格式化后的字符串
	* @return int 字符串的长度
	*/
	int Format(const char* key, CFormatParameter& parameter, char buffer[]);

	/**
	* @brief 根据参数格式化字符串
	* @param[in]  const char*  字符串的format
	* @param[in]  CFormatParameter&  输入的参数
	* @param[out]  char[]  根据参数格式化后的字符串
	* @return int 字符串的长度
	*/
	int FormatString(const char* formatStr, CFormatParameter& parameter, char buffer[]);
};

/**
 * @class CBreakLine 
 * @author Lark.Li
 * @brief 对字符串进行断行处理
*/
class CBreakLine
{
public:
	/**
	* @brief 断行
	* @param[in]  const UnicodeString&  要处理的字符串
	* @param[in]  const Locale&  设定的区域
	* @param[in]  int32_t 每行的字符数
	* @param[out]  int32_t[] 每行的在原串中的起始位置
	* @param[out]  int32_t[] 每行的在原串中的终止位置
	* @param[in]  int32_t 最大行数
	* @return int 实际的行数
	*/
	static int32_t WrapParagraph(const icu::UnicodeString& s, const icu::Locale& locale, int32_t maxCharsPreLine, int32_t lineStarts[], int32_t lineEnds[], int32_t maxLines);
};
