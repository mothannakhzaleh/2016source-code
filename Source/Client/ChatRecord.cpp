#include "stdafx.h"
#include ".\chatrecord.h"

string CChatRecord::m_strPath = "";

CChatRecord::CChatRecord(void)
{
}

CChatRecord::~CChatRecord(void)
{
}

extern void MakeFileNameValid(char* name);
bool		CChatRecord::Save(const string name, DWORD number, const string chatData)
{
  if(name.length() == 0 || chatData.length() == 0) return false;
  __time64_t t;
  _time64(&t);
  //tm *ltime=_gmtime64(&t);
  tm ltime;
  _gmtime64_s(&ltime, &t);
  char buf[_MAX_PATH + 1];
  char folder[_MAX_PATH + 1];
  _snprintf_s(folder, _countof(folder), _TRUNCATE, "chats\\%d-%d-%d", ltime.tm_year + 1900, ltime.tm_mon + 1, ltime.tm_mday);
  CreateDirectory("chats", NULL);
  CreateDirectory(folder, NULL);
  ofstream chatLog;
  // 改变保存聊天记录方式  modify by ning.yan  20080725 Begin
  //int i=1;
  //for (;i<1000;i++)
  //{
  //	_snprintf_s( buf, _countof( buf ), _TRUNCATE, "\\[%d]%s%03d.txt",number,name.c_str(),i);
  //	m_strPath=folder+string(buf);
  //	if (access(m_strPath.c_str(),0)!=-1) continue;
  //	chatLog.open(m_strPath.c_str(),ios::out);
  //	if (chatLog.is_open()) break;
  //}
  //if (i>=1000)
  //{
  //	return false;
  //}
  sprintf_s(buf, _countof(buf), "\\%s.txt", name.c_str());
  MakeFileNameValid(buf);
  m_strPath = folder + string(buf);
  chatLog.open(m_strPath.c_str(), ios_base::app); // 以附加模式打开文件，新建文件或将数据写到文件尾部
  // End
  chatLog << chatData.c_str();
  chatLog.close();
  return true;
}

string CChatRecord::GetLastSavePath()
{
  return m_strPath;
}
