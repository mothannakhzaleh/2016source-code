#ifndef __SEH_EXCEPTION_H
#define __SEH_EXCEPTION_H
#include <windows.h>
#include <string>
using namespace std;
////////////////////////////////////////////////////////////////////////////////
class SehExceptionBase : public std::exception
{
  // ³õÊ¼»¯º¯Êý
  public:
  static void InitializeSehTranslator();

};


#endif