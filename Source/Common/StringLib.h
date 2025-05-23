#pragma once

#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers
// Windows Header Files:
#include <windows.h>

#include <string>
using namespace std;

string StringLimit(const string& str, size_t len);
bool   GetNameFormString(const string& str, string& name);
string CutFaceText(string& text, size_t cutLimitlen);
//void ReplaceText(string &text,const string strRpl);
//void FilterText(string &text,vector<char*> *p_strFilterTxt);
void ChangeParseSymbol(string& text, int nMaxCount);

//将InBuf中的字符串按nWidth插放回车放在pOutBuf中
//已强化函数内部安全及效率，外部直接调用即可，需传入pOutBuf长度 -Waiting Modify 2009-05-25
int StringNewLine(char* pOutBuf, int nOutBufSize, unsigned int nWidth, const char* pInBuf, unsigned int nInLen);

//将一个数字的字符串szBuf，按nCount插入分隔符cSplit
const char* StringSplitNum(long nNumber, int nCount = 3, char cSplit = ',');
