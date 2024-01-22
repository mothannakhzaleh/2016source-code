//------------------------------------------------------------------------
//	2005.3.25	Arcol	create this file
//	2005.4.7	Arcol	add function : bool GetNameFormString(const string &str,string &name)
//						add function : string CutFaceText(string &text,size_t cutLimitlen)
//	2005.4.18	Arcol	add function : bool GetNameFormString(const string &str,string &name)
//						add function : string CutFaceText(string &text,size_t cutLimitlen)
//	2005.4.19	Arcol	add function : void ChangeParseSymbol(string &text,int nMaxCount)
//	2005.4.28	Arcol	remove all filter system function and create a filter manager class in the common lib
//------------------------------------------------------------------------

#include "StringLib.h"
#include <mbstring.h>
#include "i18n.h"
#include "MyMemory.h"

string StringLimit(const string& str, size_t len)
{
  if(len <= 3 || len >= str.length()) return str;
  char* buf = new char[len + 5];
  memcpy(buf, str.c_str(), len);
  buf[len]	   = 0;
  buf[len - 2] = buf[len - 1] = '.';
  if(_ismbslead((unsigned char*)buf, (unsigned char*)(buf + len - 3)))
  {
	buf[len - 3] = '.';
  }
  string ret = buf;
  if(buf) delete[] buf;

  return ret;
}

//------------------------------------------------------------------------
//	从字符串中取人物名字，人名最大长度为16个字符
//------------------------------------------------------------------------
bool GetNameFormString(const string& str, string& name)
{
  size_t n = str.find(":");
  if(n > 24) return false;
  name = str.substr(0, n);
  while(n && name[--n] == 0x20)
	name.erase(n);
  if(name.find("<From ") == 0 && name.length() > 7)
  {
	name = name.substr(6, name.length() - 7);
  } else if(name.find("<To ") == 0 && name.length() > 5)
  {
	name = name.substr(4, name.length() - 5);
  }
  if(name.length() <= 16) return true;
  return false;
}

//------------------------------------------------------------------------
//	分割含有表情标记的中文文字，分割后可用于分行显示
//------------------------------------------------------------------------
string CutFaceText(string& text, size_t cutLimitlen)
{
  // modify by ning.yan 20081007 左下角聊天框 系统公告和游戏上面的系统公告 GM喊话  断字处理 begin
  string retStr = text;

  try
  {
	size_t		maxNum	= cutLimitlen;
	const char* resName = CResourceBundleManage::Instance()->GetLocale().getName();
	if(strcmp(resName, "zh_Hans_CN") == 0 || strcmp(resName, "zh_Hant_TW") == 0 || strcmp(resName, "zh_Hant_HK") == 0)
	  maxNum = cutLimitlen / 2;
	if(cutLimitlen <= 0 || text.length() <= maxNum)
	{
	  text.clear();
	  return retStr;
	}

	icu::UnicodeString str = text.c_str();
	int32_t			   lineStarts[10];
	int32_t			   lineEnds[10];

	int32_t maxLines = str.length() / (int32_t)maxNum + 1;
	if(maxLines > 10)
	  maxLines = 10;

	int32_t			   lineNum = CBreakLine::WrapParagraph(str,
														   CResourceBundleManage::Instance()->GetLocale(),
														   (int32_t)maxNum,
														   lineStarts,
														   lineEnds,
														   maxLines);
	char			   lineBuf[200];
	icu::UnicodeString string(str, lineStarts[0], lineEnds[0] - lineStarts[0]);
	string.extract(0, string.length(), lineBuf, sizeof(lineBuf) - 1, 0);
	lineBuf[sizeof(lineBuf) - 1] = 0;
	retStr						 = lineBuf;

	if(retStr.length() > 0)
	{
	  if((*--retStr.end()) == '#')
	  {
		retStr = retStr.substr(0, retStr.length() - 1);
	  }
	}
	if(retStr.length() > 1)
	{
	  if((*--retStr.end()) == '#')
	  {
		retStr = retStr.substr(0, retStr.length() - 1);
	  } else if((*(retStr.end() - 2)) == '#')
	  {
		retStr = retStr.substr(0, retStr.length() - 2);
	  }
	}
	text = text.substr(retStr.length(), text.length() - retStr.length());
  } catch(...)
  {
	retStr = "";
  }

  return retStr;
}

//------------------------------------------------------------------------
//	解析符转换,从0起,例:
//	#00 -> </00>
//	#01 -> </01>
//	#02 -> </02>
//	...到nMaxCount-1
//------------------------------------------------------------------------
void ChangeParseSymbol(string& text, int nMaxCount)
{
  for(int i = 0; i < nMaxCount; i++)
  {
	char szSrc[100];
	char szRpl[100];
	//sprintf(szSrc,"#%.2d",i);
	_snprintf_s(szSrc, sizeof(szSrc), _TRUNCATE, "#%.2d", i);
	//sprintf(szRpl,"</%.2d>",i);
	_snprintf_s(szRpl, sizeof(szRpl), _TRUNCATE, "</%.2d>", i);

	size_t nPos = text.find(szSrc);

	while(nPos != string::npos)
	{
	  text.replace(nPos, strlen(szSrc), szRpl);
	  nPos = text.find(szSrc, nPos + strlen(szRpl));
	}
  }
}

// 将InBuf中的字符串按nWidth插放回车放在OutBuf中
int StringNewLine(char* pOutBuf, int nOutBufSize, unsigned int nWidth, const char* pInBuf, unsigned int nInLen)
{
  // modify by ning.yan 20081007 道具说明断字处理 begin
  if(nWidth == 0 || nInLen == 0)
  {
	if(pOutBuf)
	  pOutBuf[0] = '\0';
	return 0;
  }
  icu::UnicodeString str = pInBuf;
  icu::UnicodeString strDest;
  int32_t			 lineStarts[10];
  int32_t			 lineEnds[10];
  int				 maxNum	 = nWidth;
  const char*		 resName = CResourceBundleManage::Instance()->GetLocale().getName();
  if(strcmp(resName, "zh_Hans_CN") == 0 || strcmp(resName, "zh_Hant_TW") == 0 || strcmp(resName, "zh_Hant_HK") == 0)
	maxNum = maxNum / 2;

  //避免除零错误 -Waiting Add 2009-03-24
  if(maxNum == 0)
  {
	if(pOutBuf)
	  pOutBuf[0] = '\0';
	return 0;
  }

  int32_t maxLines = str.length() / maxNum + 1;

  int32_t lineNum = CBreakLine::WrapParagraph(str,
											  CResourceBundleManage::Instance()->GetLocale(),
											  maxNum,
											  lineStarts,
											  lineEnds,
											  maxLines);
  for(int row = 0; row < lineNum; row++)
  {
	icu::UnicodeString string(str, lineStarts[row], lineEnds[row] - lineStarts[row]);
	strDest += string + '\n'; //加入换行符
  }

  //去掉多余的局部变量、减少一次strcpy -Waiting Add 2009-05-25
  if(pOutBuf)
  {
	int ret		 = strDest.extract(0, strDest.length(), pOutBuf, nOutBufSize, 0);
	pOutBuf[ret] = '\0';
	return ret;
  }
  return 0;
}

const char* StringSplitNum(long nNumber, int nCount, char cSplit)
{
  static char szBuf[256] = {0};
  static char szTmp[256] = {0};

  //sprintf( szBuf, "%d", nNumber );
  _snprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, "%d", nNumber);
  //strcpy( szTmp, szBuf );
  strncpy_s(szTmp, sizeof(szTmp), szBuf, _TRUNCATE);

  int nLen	= (int)strlen(szBuf);
  int nLoop = (nLen - 1) / nCount;
  if(nLoop < 0) return szBuf;

  if(nLoop + nLen > sizeof(szBuf)) return szBuf;

  szBuf[nLen + nLoop] = '\0';

  int nStart  = 0;
  int nTarget = 0;
  for(int i = 0; i < nLoop; i++)
  {
	nStart	= nLen - nCount * (i + 1);
	nTarget = nStart + nLoop - i;
	memcpy(&szBuf[nTarget], &szTmp[nStart], nCount);
	szBuf[nTarget - 1] = cSplit;
  }
  return szBuf;
}
