#include "Stdafx.h"
#include <sys/stat.h>
#include <sys/timeb.h>
#include <time.h>
#include <errno.h>
#include "SceneObjFile.h"
#include "GameConfig.h"
#include "scene.h"
#include "GameApp.h"
#include "SceneObj.h"
#include "SceneObjSet.h"

CSceneObjFile g_ObjFile;

CSceneObjFile::CSceneObjFile()
{
  m_bInitSuccess  = false;
  m_fRdWr		  = NULL;
  m_fAppend		  = NULL;
  m_SSectionIndex = NULL;
}

CSceneObjFile::~CSceneObjFile()
{
  Free();
  //end_RBO();
}

// Added by clp
void CSceneObjFile::_init_RBO(const std::string& filename)
{
  filename_RBO = filename + "rbo";
  RBOinfoList.clear();
  //std::ifstream file ( filename_RBO.c_str() );
  //struct ReallyBigObjectInfo info;
  //while ( file >> info )
  //{
  //	RBOinfoList.insert( info );
  //}
  //file.close();
}

void CSceneObjFile::end_RBO()
{
  _Serialize_RBO();
  //_Serialize_RBO_ToMap();
}

void CSceneObjFile::_Serialize_RBO()
{
  if(!filename_RBO.empty())
  {
	std::ofstream								   file(filename_RBO.c_str());
	std::set<struct ReallyBigObjectInfo>::iterator itr = RBOinfoList.begin();
	std::set<struct ReallyBigObjectInfo>::iterator end = RBOinfoList.end();
	while(itr != end)
	{
	  file << *(itr++);
	}
	file.close();

	//FILE *file = fopen ( filename_RBO.c_str(), "wt" );
	//if( !file )
	//{
	//	return;
	//}

	//std::set < struct ReallyBigObjectInfo >::iterator itr = RBOinfoList.begin();
	//std::set < struct ReallyBigObjectInfo >::iterator end = RBOinfoList.end();
	//while( itr != end )
	//{
	//	file << *(itr++);
	//}
	//fclose ( file );
  }
}

void CSceneObjFile::_Serialize_RBO_ToMap()
{
  SSceneObjInfo infoex[MAX_MAP_SECTION_OBJ];
  CGameScene*	scene	= CGameApp::GetCurScene();
  LETerrain*	terrain = scene->GetTerrain();

  std::set<struct ReallyBigObjectInfo>::iterator itr = RBOinfoList.begin();
  std::set<struct ReallyBigObjectInfo>::iterator end = RBOinfoList.end();

  while(itr != end)
  {
	/*int sectionX = itr->position.x / ( 100.f * terrain->GetSectionWidth() );
		int sectionY = itr->position.y / ( 100.f * terrain->GetSectionHeight() );*/
	int sectionX = (int)(itr->position.x / (100.f * terrain->GetSectionWidth()));
	int sectionY = (int)(itr->position.y / (100.f * terrain->GetSectionHeight()));

	int sectionNumber = sectionY * terrain->GetSectionCntX() + sectionX;

	long sectionObjCount = 0;

	if(ReadSectionObjInfo(sectionNumber, infoex, &sectionObjCount))
	{
	  sectionObjCount++;
	  int RBOIndex = sectionObjCount - 1;
	  //if( RBOIndex <= MAX_MAP_SECTION_OBJ )
	  if(RBOIndex >= 0 && RBOIndex < MAX_MAP_SECTION_OBJ)
	  {
		infoex[RBOIndex].sTypeID = itr->typeID;
		//infoex[RBOIndex].nX         = itr->position.x;
		infoex[RBOIndex].nX			= (int)itr->position.x;
		infoex[RBOIndex].nY			= (int)itr->position.y;
		infoex[RBOIndex].sYawAngle	= (short)itr->orientation.w;
		infoex[RBOIndex].sHeightOff = (short)itr->position.z;
	  }
	  g_ObjFile.WriteSectionObjInfo(sectionNumber, infoex, sectionObjCount);
	}
	++itr;
  }
}

//修正编辑器时因_tfopen_s 不支持共享模式，导致重复开启失败 by Waiting 2009-06-29
long CSceneObjFile::Init(_TCHAR* ptcsFileName, bool bSilence)
{
  long	 lRet = 1;
  long	 lFileSize;
  _TCHAR tcsPrint[256];
  FILE*	 fFile = NULL;

  Free();

  errno_t err_no;
  if(g_Config.m_bEditor)
  {
	_tchmod(ptcsFileName, _S_IWRITE);
	err_no = _tfopen_s(&fFile, ptcsFileName, _TEXT("r+b"));
  } else
	err_no = _tfopen_s(&fFile, ptcsFileName, _TEXT("rb"));

  // Added by clp
  std::string filename(ptcsFileName);
  filename.erase(filename.length() - 3);
  _init_RBO(filename.c_str());

  if(fFile == NULL)
  {
	if(err_no == ENOENT) //No such file or directory
	{
	  if(CreateFile(ptcsFileName) == 0)
	  {
		if(!bSilence)
		{
		  //_stprintf(tcsPrint, _TEXT("%s %s %s"), _TEXT(RES_STRING(CL_LANGUAGE_MATCH_355)), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_356)));
		  _snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT("%s %s %s"), _TEXT(RES_STRING(CL_LANGUAGE_MATCH_355)), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_356)));
		  MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
		}
		lRet = 0;
		goto end;
	  }
	  if(g_Config.m_bEditor)
		err_no = _tfopen_s(&fFile, ptcsFileName, _TEXT("r+b"));
	  else
		err_no = _tfopen_s(&fFile, ptcsFileName, _TEXT("rb"));
	}

	if(fFile == NULL)
	{
	  lRet = 0;
	  goto end;
	}
  }

  fseek(fFile, 0, SEEK_END);
  lFileSize = ftell(fFile);
  fseek(fFile, 0, SEEK_SET);
  fread((void*)&m_SFileHead, sizeof(SFileHead), 1, fFile);
  if(m_SFileHead.lFileSize != lFileSize)
  {
	if(!bSilence)
	{
	  //_stprintf(tcsPrint, _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_357)));
	  _snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_357)));
	  MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
	}
	lRet = 0;
	goto end;
  }
  if(m_SFileHead.lVersion == OBJ_FILE_VER500) //需要版本转换
  {
	fclose(fFile);
	if(ConvertObjFileVer(ptcsFileName) <= 0) //版本转换失败
	{
	  lRet = 0;
	  goto end;
	}

	_tfopen_s(&fFile, ptcsFileName, _TEXT("rb"));
	if(fFile == NULL)
	{
	  if(!bSilence)
	  {
		//_stprintf(tcsPrint, _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_358)));
		_snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_358)));
		MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
	  }
	  lRet = 0;
	  goto end;
	}

	fseek(fFile, 0, SEEK_END);
	lFileSize = ftell(fFile);
	fseek(fFile, 0, SEEK_SET);
	fread((void*)&m_SFileHead, sizeof(SFileHead), 1, fFile);
  }
  if(m_SFileHead.lVersion != OBJ_FILE_VER600)
  {
	if(!bSilence)
	{
	  _snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_340)));
	  MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
	}
	lRet = 0;
	goto end;
  }

  m_SSectionIndex = new(SSectionIndex[m_SFileHead.iSectionCntX * m_SFileHead.iSectionCntY]);
  if(m_SSectionIndex == NULL)
  {
	lRet = 0;
	goto end;
  }
  fread((void*)m_SSectionIndex, sizeof(SSectionIndex), m_SFileHead.iSectionCntX * m_SFileHead.iSectionCntY, fFile);
  m_fRdWr = fFile;
  fFile	  = NULL;

  // 	if( g_Config.m_bEditor )
  // 		_tfopen_s( &m_fRdWr, ptcsFileName, _TEXT("r+b"));
  // 	else
  // 		_tfopen_s( &m_fRdWr, ptcsFileName, _TEXT("rb"));
  //
  // 	if (m_fRdWr == NULL)
  // 	{
  // 		if (!bSilence)
  // 		{
  // 			_snprintf_s(tcsPrint,sizeof(tcsPrint) ,_TRUNCATE , _TEXT("%s %s (%d)"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_339)), GetLastError());
  // 			MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
  // 		}
  // 		lRet = 0;
  // 		goto end;
  // 	}

  // 	if( g_Config.m_bEditor )
  // 		_tfopen_s( &m_fAppend, ptcsFileName, _TEXT("a+b"));
  // 	else
  // 		_tfopen_s( &m_fAppend, ptcsFileName, _TEXT("rb"));
  //
  // 	if (m_fAppend == NULL)
  // 	{
  // 		if (!bSilence)
  // 		{
  // 			_snprintf_s(tcsPrint,sizeof(tcsPrint) ,_TRUNCATE , _TEXT("%s %s"), ptcsFileName, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_359)));
  // 			MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
  // 		}
  // 		lRet = 0;
  // 		goto end;
  // 	}

  m_bInitSuccess = true;

end:
  if(lRet == 0)
  {
	if(m_fRdWr)
	{
	  fclose(m_fRdWr);
	  m_fRdWr = NULL;
	}
	// 		if (m_fAppend)
	// 		{
	// 			fclose(m_fAppend);
	// 			m_fAppend = NULL;
	// 		}
	if(m_SSectionIndex)
	{
	  delete[] m_SSectionIndex;
	  m_SSectionIndex = NULL;
	}
  }
  if(fFile)
	fclose(fFile);

  return lRet;
}
void CSceneObjFile::Free(void)
{
  m_bInitSuccess = false;
  if(m_fRdWr)
  {
	fclose(m_fRdWr);
	m_fRdWr = NULL;
  }
  // 	if (m_fAppend)
  // 	{
  // 		fclose(m_fAppend);
  // 		m_fAppend = NULL;
  // 	}
  if(m_SSectionIndex)
  {
	delete[] m_SSectionIndex;
	m_SSectionIndex = NULL;
  }
}

long CSceneObjFile::CreateFile(_TCHAR* ptcsFileName,
							   int iSectionCntX, int iSectionCntY, int iSectionWidth,
							   int iSectionHeight, int iMaxSectionObjNum)
{
  FILE*			 fFile = NULL;
  SFileHead		 SHead;
  SSectionIndex* lFileSectionIndex = NULL;

  if(g_Config.m_bEditor)
	_tfopen_s(&fFile, ptcsFileName, _TEXT("wb"));
  else
	_tfopen_s(&fFile, ptcsFileName, _TEXT("rb"));
  if(fFile == NULL)
	return 0;

  //_tcscpy(SHead.tcsTitle, _TEXT("HF Object File!"));
  strncpy_s(SHead.tcsTitle, sizeof(SHead.tcsTitle), _TEXT("HF Object File!"), _TRUNCATE);
  SHead.lVersion	   = OBJ_FILE_VER600;
  SHead.lFileSize	   = sizeof(SFileHead) + sizeof(SSectionIndex) * iSectionCntX * iSectionCntY;
  SHead.iSectionCntX   = iSectionCntX;
  SHead.iSectionCntY   = iSectionCntY;
  SHead.iSectionHeight = iSectionHeight;
  SHead.iSectionWidth  = iSectionWidth;
  SHead.iSectionObjNum = iMaxSectionObjNum;

  lFileSectionIndex = new(SSectionIndex[iSectionCntX * iSectionCntY]);
  if(lFileSectionIndex == NULL)
  {
	fclose(fFile);
	return 0;
  }
  memset(lFileSectionIndex, 0, sizeof(SSectionIndex) * iSectionCntX * iSectionCntY);

  fwrite((const void*)&SHead, sizeof(SFileHead), 1, fFile);
  fwrite((const void*)lFileSectionIndex, sizeof(SSectionIndex), iSectionCntX * iSectionCntY, fFile);

  if(fFile)
	fclose(fFile);
  if(lFileSectionIndex)
	delete[] lFileSectionIndex;
  return 1;
}

long CSceneObjFile::ConvertObjFileVer(_TCHAR* ptcsFileName, bool bBackUp) // 从版本500转换到600(物件的绝对坐标转换成相对section的相对坐标)
{
  long			 lRet					   = 2;
  _TCHAR		 tcsBackUpName[_MAX_FNAME] = _TEXT("");
  _TCHAR		 tcsPrint[256];
  long			 i, j;
  long			 lMaxSectionNum;
  FILE*			 fFileOld  = NULL;
  FILE*			 fFileNew  = NULL;
  SSceneObjInfo* pSObjInfo = NULL;
  SFileHead		 SHead;
  SSectionIndex* pSSectionIndex = NULL;
  unsigned long	 ulFileSize;

  //_tcscpy(tcsBackUpName, ptcsFileName);
  strncpy_s(tcsBackUpName, sizeof(tcsBackUpName), ptcsFileName, _TRUNCATE);
  for(i = 0; i < _MAX_FNAME - (long)_tcslen(ptcsFileName); i += 4)
  {
	//_tcscat(tcsBackUpName, _TEXT(".bak"));
	strncat_s(tcsBackUpName, sizeof(tcsBackUpName), _TEXT(".bak"), _TRUNCATE);
	_tfopen_s(&fFileNew, tcsBackUpName, _TEXT("rb"));
	if(fFileNew == NULL)
	  break;
	else
	{
	  fclose(fFileNew);
	  fFileNew = NULL;
	}
  }
  if(i >= _MAX_FNAME - (long)_tcslen(ptcsFileName))
  {
	lRet = -1; // 建立临时文件失败
	goto end;
  }
  if(_trename(ptcsFileName, tcsBackUpName) != 0) //
  {
	lRet = -2; // 文件重命名失败
	goto end;
  }

  _tfopen_s(&fFileOld, tcsBackUpName, _TEXT("rb"));
  if(fFileOld == NULL)
  {
	lRet = -3; // 打开源文件失败
	goto end;
  }

  if(g_Config.m_bEditor)
	_tfopen_s(&fFileNew, ptcsFileName, _TEXT("wb"));
  else
	_tfopen_s(&fFileNew, ptcsFileName, _TEXT("rb"));
  if(fFileNew == NULL)
  {
	lRet = -1; // 建立新文件失败
	goto end;
  }

  fseek(fFileOld, 0, SEEK_END);
  ulFileSize = ftell(fFileOld);
  fseek(fFileOld, 0, SEEK_SET);
  fread(&SHead, sizeof(SFileHead), 1, fFileOld);
  if(SHead.lVersion != OBJ_FILE_VER500) // 不需要转换
  {
	lRet = 1;
	goto end;
  }

  _snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_360)), ptcsFileName);
  MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_361)), 0);

  lMaxSectionNum = SHead.iSectionCntX * SHead.iSectionCntY;
  pSSectionIndex = new SSectionIndex[lMaxSectionNum];
  if(pSSectionIndex == NULL)
  {
	lRet = -4; // 内存分配错误
	goto end;
  }

  pSObjInfo = new SSceneObjInfo[SHead.iSectionObjNum];
  if(pSObjInfo == NULL)
  {
	lRet = -4;
	goto end;
  }

  fread((void*)pSSectionIndex, sizeof(SSectionIndex), lMaxSectionNum, fFileOld);
  fseek(fFileNew, sizeof(SFileHead) + sizeof(SSectionIndex) * lMaxSectionNum, SEEK_SET);

  int nSectionX, nSectionY;
  for(i = 0; i < lMaxSectionNum && ulFileSize >= (unsigned long)ftell(fFileOld); i++)
  {
	if(pSSectionIndex[i].iObjNum > 0) //存在有效数据
	{
	  fseek(fFileOld, pSSectionIndex[i].lObjInfoPos, SEEK_SET);
	  fread(pSObjInfo, sizeof(SSceneObjInfo) * SHead.iSectionObjNum, 1, fFileOld);
	  for(j = 0; j < pSSectionIndex[i].iObjNum; j++)
	  {
		nSectionX = i % SHead.iSectionCntX * SHead.iSectionWidth * 100;
		nSectionY = i / SHead.iSectionCntX * SHead.iSectionHeight * 100;
		pSObjInfo[j].nX -= nSectionX;
		pSObjInfo[j].nY -= nSectionY;
		if(pSObjInfo[j].nY < 0)
		{
		  int nnn = 0;
		}
	  }
	  pSSectionIndex[i].lObjInfoPos = ftell(fFileNew);
	  fwrite(pSObjInfo, sizeof(SSceneObjInfo) * SHead.iSectionObjNum, 1, fFileNew);
	} else
	{
	  pSSectionIndex[i].lObjInfoPos = 0;
	}
  }

  SHead.lVersion  = OBJ_FILE_VER600;
  SHead.lFileSize = ftell(fFileNew);
  fseek(fFileNew, 0, SEEK_SET);
  fwrite((const void*)&SHead, sizeof(SFileHead), 1, fFileNew);
  fwrite((const void*)pSSectionIndex, sizeof(SSectionIndex), lMaxSectionNum, fFileNew);

  if(!bBackUp)
  {
	fclose(fFileOld);
	fFileOld = NULL;
	_tremove(tcsBackUpName);
	//_tcscpy(tcsBackUpName, ptcsFileName);
	strncpy_s(tcsBackUpName, sizeof(tcsBackUpName), ptcsFileName, _TRUNCATE);
  }

end:
  if(lRet == 2)
  {
	_snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_362)), ptcsFileName, tcsBackUpName);
	MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_363)), 0);
  }
  if(fFileOld)
	fclose(fFileOld);
  if(fFileNew)
	fclose(fFileNew);
  if(pSSectionIndex)
	delete[] pSSectionIndex;
  if(pSObjInfo)
	delete[] pSObjInfo;
  return lRet;
}

long CSceneObjFile::ReadSectionObjInfo(int nSectionNO, SSceneObjInfo* SSceneObj, long* lSectionObjNum)
{
  if(!m_bInitSuccess)
	return 0;

  if(nSectionNO >= m_SFileHead.iSectionCntX * m_SFileHead.iSectionCntY)
	return 0;

  if((*lSectionObjNum = m_SSectionIndex[nSectionNO].iObjNum) > 0)
  {
	fseek(m_fRdWr, m_SSectionIndex[nSectionNO].lObjInfoPos, SEEK_SET);
	//      LG("readmap", "Seek Offset [%d %d] = %d\n", nSectionNO % m_SFileHead.iSectionCntX, nSectionNO / m_SFileHead.iSectionCntX, m_SSectionIndex[nSectionNO].lObjInfoPos);
	fread(SSceneObj, sizeof(SSceneObjInfo), m_SSectionIndex[nSectionNO].iObjNum, m_fRdWr);
	// 转换成绝对坐标
	int nSectionX, nSectionY;
	for(int i = 0; i < m_SSectionIndex[nSectionNO].iObjNum; i++)
	{
	  nSectionX = nSectionNO % m_SFileHead.iSectionCntX * m_SFileHead.iSectionWidth * 100;
	  nSectionY = nSectionNO / m_SFileHead.iSectionCntX * m_SFileHead.iSectionHeight * 100;
	  if(SSceneObj[i].nX < 0)
	  {
		int jjj = 0;
	  }
	  SSceneObj[i].nX += nSectionX;
	  SSceneObj[i].nY += nSectionY;
	  SSceneObjInfo* pObj = (SSceneObj + i);
	  if(pObj->GetID() == 0)
	  {
		LG("error", RES_STRING(CL_LANGUAGE_MATCH_364));
	  }
	}
	//
  }

  return 1;
}

long CSceneObjFile::WriteSectionObjInfo(int nSectionNO, SSceneObjInfo* SSceneObj, long lSectionObjNum)
{
  //	FILE	*fFile;

  if(!m_bInitSuccess)
	return 0;

  if(nSectionNO >= m_SFileHead.iSectionCntX * m_SFileHead.iSectionCntY)
	return 0;

  int result;
  m_SSectionIndex[nSectionNO].iObjNum = lSectionObjNum;
  if(lSectionObjNum > 0)
  {
	if(m_SSectionIndex[nSectionNO].lObjInfoPos > 0)
	{
	  //			fFile = m_fRdWr;
	  result = fseek(m_fRdWr, m_SSectionIndex[nSectionNO].lObjInfoPos, SEEK_SET);
	} else
	{
	  m_SSectionIndex[nSectionNO].lObjInfoPos = m_SFileHead.lFileSize;
	  m_SFileHead.lFileSize += sizeof(SSceneObjInfo) * m_SFileHead.iSectionObjNum;
	  result = fseek(m_fRdWr, 0, SEEK_SET);
	  if(result == S_OK)
	  {
		fwrite((const void*)&m_SFileHead, sizeof(SFileHead), 1, m_fRdWr);
		fflush(m_fRdWr);
	  }
	  result = fseek(m_fRdWr, m_SSectionIndex[nSectionNO].lObjInfoPos, SEEK_SET);
	  //			fFile = m_fAppend;
	}
	// 转换成相对坐标
	int nSectionX, nSectionY;
	for(int j = 0; j < m_SSectionIndex[nSectionNO].iObjNum; j++)
	{
	  nSectionX = nSectionNO % m_SFileHead.iSectionCntX * m_SFileHead.iSectionWidth * 100;
	  nSectionY = nSectionNO / m_SFileHead.iSectionCntX * m_SFileHead.iSectionHeight * 100;
	  SSceneObj[j].nX -= nSectionX;
	  SSceneObj[j].nY -= nSectionY;
	}
	//
	// 写入obj信息
	if(result == S_OK)
	{
	  fwrite((const void*)SSceneObj, sizeof(SSceneObjInfo), m_SFileHead.iSectionObjNum, m_fRdWr);
	  fflush(m_fRdWr);
	}
  } else
  {
	m_SSectionIndex[nSectionNO].lObjInfoPos = 0;
  }

  result = fseek(m_fRdWr, sizeof(SFileHead) + sizeof(SSectionIndex) * nSectionNO, SEEK_SET);
  if(result == S_OK)
  {
	fwrite((const void*)(m_SSectionIndex + nSectionNO), sizeof(SSectionIndex), 1, m_fRdWr);
	fflush(m_fRdWr);
  }

  // 临时代码。。。
  //
  long lFileSize;
  result = fseek(m_fRdWr, 0, SEEK_END);
  if(result == S_OK)
  {
	lFileSize = ftell(m_fRdWr);
	if(lFileSize != m_SFileHead.lFileSize)
	{
	  MessageBox(NULL, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_365)), _TEXT(RES_STRING(CL_LANGUAGE_MATCH_25)), 0);
	}
  }
  //

  return 1;
}

long CSceneObjFile::TrimFile(_TCHAR* ptcsFileName, bool bBackUp)
{
  long			 lRet					   = 1;
  _TCHAR		 tcsBackUpName[_MAX_FNAME] = _TEXT("");
  long			 i;
  long			 lPos = 0;
  SFileHead		 SHead;
  long			 lMaxSectionNum;
  FILE *		 fFileOld = NULL, *fFileNew = NULL;
  char*			 pszSectionInfo = NULL;
  SSectionIndex* pSSectionIndex = NULL;
  unsigned long	 ulFileSize;

  //_tcscpy(tcsBackUpName, ptcsFileName);
  strncpy_s(tcsBackUpName, sizeof(tcsBackUpName), ptcsFileName, _TRUNCATE);
  for(i = 0; i < _MAX_FNAME - (long)_tcslen(ptcsFileName); i += 4)
  {
	//_tcscat(tcsBackUpName, _TEXT(".bak"));
	strncat_s(tcsBackUpName, sizeof(tcsBackUpName), _TEXT(".bak"), _TRUNCATE);
	_tfopen_s(&fFileNew, tcsBackUpName, _TEXT("rb"));
	if(fFileNew == NULL)
	  break;
	else
	{
	  fclose(fFileNew);
	  fFileNew = NULL;
	}
  }
  if(i >= _MAX_FNAME - (long)_tcslen(ptcsFileName))
  {
	lRet = -1; // 建立临时文件失败
	goto end;
  }
  if(_trename(ptcsFileName, tcsBackUpName) != 0) //
  {
	lRet = -2; // 文件重命名失败
	goto end;
  }

  _tfopen_s(&fFileOld, tcsBackUpName, _TEXT("rb"));
  if(fFileOld == NULL)
  {
	lRet = -3; // 打开文件失败
	goto end;
  }

  if(g_Config.m_bEditor)
	_tfopen_s(&fFileNew, ptcsFileName, _TEXT("wb"));
  else
	_tfopen_s(&fFileNew, ptcsFileName, _TEXT("rb"));
  if(fFileNew == NULL)
  {
	lRet = -3; // 打开文件失败
	goto end;
  }

  fseek(fFileOld, 0, SEEK_END);
  ulFileSize = ftell(fFileOld);
  fseek(fFileOld, 0, SEEK_SET);
  fread((void*)&SHead, sizeof(SFileHead), 1, fFileOld);
  if(_tcscmp(SHead.tcsTitle, _TEXT("HF Object File!")) != 0 || SHead.lVersion != OBJ_FILE_VER600) // || SHead.lFileSize != i)
  {
	lRet = -4; // 源文件已被破坏或版本错误
	goto end;
  }

  lMaxSectionNum = SHead.iSectionCntX * SHead.iSectionCntY;
  pSSectionIndex = new(SSectionIndex[lMaxSectionNum]);
  if(pSSectionIndex == NULL)
  {
	lRet = -5; // 内存分配错误
	goto end;
  }
  fread((void*)pSSectionIndex, sizeof(SSectionIndex), lMaxSectionNum, fFileOld);
  pszSectionInfo = new(char[sizeof(SSceneObjInfo) * lMaxSectionNum]);
  if(pszSectionInfo == NULL)
  {
	lRet = -5;
	goto end;
  }

  fseek(fFileNew, sizeof(SFileHead) + sizeof(SSectionIndex) * lMaxSectionNum, SEEK_SET);

  for(i = 0; i < lMaxSectionNum && ulFileSize >= (unsigned long)ftell(fFileOld); i++)
  {
	if(pSSectionIndex[i].iObjNum > 0) //存在有效数据
	{
	  fseek(fFileOld, pSSectionIndex[i].lObjInfoPos, SEEK_SET);
	  fread(pszSectionInfo, sizeof(SSceneObjInfo) * SHead.iSectionObjNum, 1, fFileOld);
	  pSSectionIndex[i].lObjInfoPos = ftell(fFileNew);
	  fwrite(pszSectionInfo, sizeof(SSceneObjInfo) * SHead.iSectionObjNum, 1, fFileNew);
	} else
	{
	  pSSectionIndex[i].lObjInfoPos = 0;
	}
  }

  SHead.lFileSize = ftell(fFileNew);
  fseek(fFileNew, 0, SEEK_SET);
  fwrite(&SHead, sizeof(SFileHead), 1, fFileNew);
  fwrite(pSSectionIndex, sizeof(SSectionIndex), lMaxSectionNum, fFileNew);

  if(!bBackUp)
  {
	fclose(fFileOld);
	fFileOld = NULL;
	_tremove(tcsBackUpName);
  }

end:
  if(fFileOld)
	fclose(fFileOld);
  if(fFileNew)
	fclose(fFileNew);
  if(pSSectionIndex)
	delete[] pSSectionIndex;
  if(pszSectionInfo)
	delete[] pszSectionInfo;
  return lRet;
}

long CSceneObjFile::TrimDirectory(_TCHAR* ptcsDirectory, bool bBackUp)
{
  _TCHAR	  tcsFileName[_MAX_FNAME], tcsPath[_MAX_PATH];
  size_t	  lLen;
  _finddata_t c_file;
  long		  hFile;
  _TCHAR*	  ptcsRecordFile = _TEXT("TrimRecord.txt");
  FILE*		  fRecord		 = NULL;
  _timeb	  tTimeBuffer;
  _TCHAR	  tcsPrint[256];

  if(bBackUp)
	_snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_366)), ptcsDirectory);
  else
	_snprintf_s(tcsPrint, sizeof(tcsPrint), _TRUNCATE, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_367)), ptcsDirectory);
  if(IDYES != MessageBox(NULL, tcsPrint, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_361)), MB_YESNO))
	return 1;

  lLen = _tcslen(ptcsDirectory);
  //_tcscpy(tcsPath, ptcsDirectory);
  strncpy_s(tcsPath, sizeof(tcsPath), ptcsDirectory, _TRUNCATE);
  if(tcsPath[lLen - 1] != _TEXT('\\') && tcsPath[lLen - 1] != _TEXT('/'))
  {
	tcsPath[lLen]	  = _TEXT('/');
	tcsPath[lLen + 1] = 0;
  }

  //_stprintf(tcsFileName, _TEXT("%s%s"), tcsPath, ptcsRecordFile);
  _snprintf_s(tcsFileName, sizeof(tcsFileName), _TRUNCATE, _TEXT("%s%s"), tcsPath, ptcsRecordFile);
  if(g_Config.m_bEditor)
	_tfopen_s(&fRecord, tcsFileName, _TEXT("w"));
  else
	_tfopen_s(&fRecord, tcsFileName, _TEXT("rb"));
  if(fRecord == NULL)
	return 0;
  //_ftime(&tTimeBuffer);
  _ftime64_s(&tTimeBuffer);
  char buff[64];
  _ctime64_s(buff, sizeof(buff), &tTimeBuffer.time);
  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_368)), buff);

  //_stprintf(tcsFileName, _TEXT("%s%s"), tcsPath, _TEXT("*.obj"));
  _snprintf_s(tcsFileName, sizeof(tcsFileName), _TRUNCATE, _TEXT("%s%s"), tcsPath, _TEXT("*.obj"));
  if((hFile = (long)_tfindfirst(tcsFileName, &c_file)) == -1L)
  {
	fclose(fRecord);
	return 1;
  } else
  {
	if(!(c_file.attrib & _A_SUBDIR))
	{
	  //_stprintf(tcsFileName, _TEXT("%s%s"), tcsPath, _TEXT(c_file.name));
	  _snprintf_s(tcsFileName, sizeof(tcsFileName), _TRUNCATE, _TEXT("%s%s"), tcsPath, _TEXT(c_file.name));
	  if(c_file.attrib & _A_RDONLY)
		_tchmod(tcsFileName, _S_IREAD | _S_IWRITE);
	  _ftprintf(fRecord, _TEXT("%s:\n"), tcsFileName);
	  switch(TrimFile(tcsFileName, bBackUp))
	  {
	  case 1:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_369)));
		break;
	  case -1:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_370)));
		break;
	  case -2:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_371)));
		break;
	  case -3:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_372)));
		break;
	  case -4:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_373)));
		break;
	  case -5:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_374)));
		break;
	  default:
		_ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_375)));
	  }
	}
	while(_findnext(hFile, &c_file) == 0)
	{
	  if(!(c_file.attrib & _A_SUBDIR))
	  {
		//_stprintf(tcsFileName, _TEXT("%s%s"), tcsPath, _TEXT(c_file.name));
		_snprintf_s(tcsFileName, sizeof(tcsFileName), _TRUNCATE, _TEXT("%s%s"), tcsPath, _TEXT(c_file.name));
		if(c_file.attrib & _A_RDONLY)
		  _tchmod(tcsFileName, _S_IREAD | _S_IWRITE);
		_ftprintf(fRecord, _TEXT("%s:\n"), tcsFileName);
		switch(TrimFile(tcsFileName, bBackUp))
		{
		case 1:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_369)));
		  break;
		case -1:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_370)));
		  break;
		case -2:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_371)));
		  break;
		case -3:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_372)));
		  break;
		case -4:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_373)));
		  break;
		case -5:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_374)));
		  break;
		default:
		  _ftprintf(fRecord, _TEXT(RES_STRING(CL_LANGUAGE_MATCH_375)));
		}
	  }
	}

	_findclose(hFile);
  }

  if(fRecord)
	fclose(fRecord);
  return 1;
}
