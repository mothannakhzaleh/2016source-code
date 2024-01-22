#include ".\i18n.h"

const char* ConvertResString(const char* str)
{
  std::string key(str);

  if('#' == *key.begin() && '#' == *key.rbegin())
  {
	std::string temp = key.substr(1, key.size() - 2);
	return CResourceBundleManage::Instance()->LoadResString(temp.c_str());
  }

  return str;
}
