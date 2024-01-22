//=============================================================================
// FileName: Kitbag.cpp
// Creater: ZhangXuedong
// Date: 2004.12.17
// Comment: Kitbag
//=============================================================================

#include "Kitbag.h"
char g_key[9] = "19800216";

int Decrypt(char* buf, int len, const char* enc, int elen)
{
  int i;
  for(i = 0; i < elen; i++)
  {
	buf[i] = enc[i] - g_key[i % 8];
  }
  return i;
}

int Encrypt(char* buf, int len, const char* pwd, int plen)
{
  int i;
  for(i = 0; i < plen; i++)
  {
	buf[i] = pwd[i] + g_key[i % 8];
  }
  return i;
}

int EncryptEx(char* buf, int len)
{
  int i;
  for(i = 0; i < len; i++)
  {
	buf[i] = buf[i] + g_key[i % 8];
  }
  return i;
}

int EncryptExEx(int start, StringPoolL& stringPool, int index)
{
  int len = stringPool[index].Len();

  for(int i = start; i < len; i++)
  {
	stringPool[index][i] = stringPool[index][i] + g_key[(i - start) % 8];
  }
  return 0;
}
