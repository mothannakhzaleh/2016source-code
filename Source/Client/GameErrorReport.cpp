#include "stdafx.h"
//#include "CallStack.h"
#include "SehException.h"
#include "GameErrorReport.h"
#include "shellapi.h"
string GetTimeStamp()
{
  char		 buf[32];
  SYSTEMTIME l_st;
  GetLocalTime(&l_st);
  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%04d-%02d-%02d %02d.%02d.%02d.%03d",
			  l_st.wYear,
			  l_st.wMonth,
			  l_st.wDay,
			  l_st.wHour,
			  l_st.wMinute,
			  l_st.wSecond,
			  l_st.wMilliseconds);
  return buf;
}

BOOL CheckDxVersion(DWORD& ver) // 版本核对
{
  BOOL			 ret	  = 1;
  MPISystemInfo* sys_info = 0;

  LEGUIDCreateObject((DR_VOID**)&sys_info, DR_GUID_SYSTEMINFO);
  if(SUCCEEDED(sys_info->CheckDirectXVersion())) // 查看版本
  {
	ver = sys_info->GetDirectXVersion();

	if(ver < DX_VERSION_8_1) //判断版本是否正确
	{
	  ret = 0;
	}
  }
  sys_info->Release();

  return ret;
}

static void WriteSystemInfo(FILE* fp)
{
  try
  {
	OSVERSIONINFOEX osvi;
	BOOL			bOsVersionInfoEx;

	// Try calling GetVersionEx using the OSVERSIONINFOEX structure.
	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
	if(!(bOsVersionInfoEx = GetVersionEx((OSVERSIONINFO*)&osvi)))
	{
	  // If OSVERSIONINFOEX doesn't work, try OSVERSIONINFO.
	  osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	  if(!GetVersionEx((OSVERSIONINFO*)&osvi))
		bOsVersionInfoEx = FALSE;
	}

	string mOSStringSimple = "Unknown Windwos Ver";
	if(bOsVersionInfoEx)
	{
	  switch(osvi.dwPlatformId)
	  {
	  case VER_PLATFORM_WIN32_NT:
	  {
		// Test for the product.
		if(osvi.dwMajorVersion <= 4)
		  mOSStringSimple = "Microsoft Windows NT ";
		else if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 0)
		  mOSStringSimple = "Microsoft Windows 2000 ";
		else if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 1)
		  mOSStringSimple = "Microsoft Windows XP ";
		else if(osvi.dwMajorVersion == 5 && osvi.dwMinorVersion == 2)
		{
		  if(osvi.wProductType == VER_NT_WORKSTATION)
			mOSStringSimple = "Microsoft Windows XP x64 Edition ";
		  else
			mOSStringSimple = "Microsoft Windows Server 2003 ";
		} else if(osvi.dwMajorVersion == 6 && osvi.dwMinorVersion == 0)
		{
		  if(osvi.wProductType == VER_NT_WORKSTATION)
			mOSStringSimple = "Microsoft Windows Vista ";
		  else
			mOSStringSimple = "Microsoft Windows Vista Server ";
		} else // Use the registry on early versions of Windows NT.
		  mOSStringSimple += "Unknown Windows NT";
	  }
	  break;

	  case VER_PLATFORM_WIN32_WINDOWS:
		// Test for the Windows 95 product family.
		if(osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 0)
		{
		  mOSStringSimple = "Microsoft Windows 95 ";
		  if(osvi.szCSDVersion[1] == 'C' || osvi.szCSDVersion[1] == 'B')
			mOSStringSimple += "OSR2 ";
		}
		if(osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 10)
		{
		  mOSStringSimple = "Microsoft Windows 98 ";
		  if(osvi.szCSDVersion[1] == 'A')
			mOSStringSimple += "SE ";
		}
		if(osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 90)
		  mOSStringSimple = "Microsoft Windows Millennium Edition ";
		break;
	  }
	  fprintf(fp, "%s\r\n", mOSStringSimple.c_str());
	}
	DWORD dx_ver = DX_VERSION_X_X;
	if(CheckDxVersion(dx_ver))
	{
	  fprintf(fp, "DirectX Ver:%X\r\n", dx_ver);

	  D3DCAPS8 caps;
	  if(g_Render.GetDevice())
	  {
		g_Render.GetDevice()->GetDeviceCaps(&caps);

		//fprintf(fp, "DeviceType %X\r\n", caps.DeviceType);
		//fprintf(fp, "AdapterOrdinal %X\r\n", caps.AdapterOrdinal);
		//fprintf(fp, "Caps %X\r\n", caps.Caps);
		//fprintf(fp, "Caps2 %X\r\n", caps.Caps2);
		//fprintf(fp, "Caps3 %X\r\n", caps.Caps3);
		//fprintf(fp, "PresentationIntervals %X\r\n", caps.PresentationIntervals);

		//fprintf(fp, "CursorCaps %X\r\n", caps.CursorCaps);
		//fprintf(fp, "DevCaps %X\r\n", caps.DevCaps);

		//fprintf(fp, "PrimitiveMiscCaps %X\r\n", caps.PrimitiveMiscCaps);
		//fprintf(fp, "RasterCaps %X\r\n", caps.RasterCaps);
		//fprintf(fp, "ZCmpCaps %X\r\n", caps.ZCmpCaps);
		//fprintf(fp, "SrcBlendCaps %X\r\n", caps.SrcBlendCaps);
		//fprintf(fp, "DestBlendCaps %X\r\n", caps.DestBlendCaps);
		//fprintf(fp, "AlphaCmpCaps %X\r\n", caps.AlphaCmpCaps);
		//fprintf(fp, "ShadeCaps %X\r\n", caps.ShadeCaps);
		//fprintf(fp, "TextureCaps %X\r\n", caps.TextureCaps);
		//fprintf(fp, "TextureFilterCaps %X\r\n", caps.TextureFilterCaps);

		//fprintf(fp, "CubeTextureFilterCaps %X\r\n", caps.CubeTextureFilterCaps);
		//fprintf(fp, "VolumeTextureFilterCaps %X\r\n", caps.VolumeTextureFilterCaps);
		//fprintf(fp, "TextureAddressCaps %X\r\n", caps.TextureAddressCaps);
		//fprintf(fp, "VolumeTextureAddressCaps %X\r\n", caps.VolumeTextureAddressCaps);

		//fprintf(fp, "LineCaps %X\r\n", caps.LineCaps);
		//fprintf(fp, "MaxTextureWidth %X\r\n", caps.MaxTextureWidth);
		//fprintf(fp, "MaxTextureHeight %X\r\n", caps.MaxTextureHeight);

		//fprintf(fp, "MaxVolumeExtent %X\r\n", caps.MaxVolumeExtent);
		//fprintf(fp, "MaxTextureRepeat %X\r\n", caps.MaxTextureRepeat);
		//fprintf(fp, "MaxTextureAspectRatio %X\r\n", caps.MaxTextureAspectRatio);
		//fprintf(fp, "MaxAnisotropy %X\r\n", caps.MaxAnisotropy);
		//fprintf(fp, "MaxVertexW %f\r\n", caps.MaxVertexW);
		//fprintf(fp, "GuardBandLeft %f\r\n", caps.GuardBandLeft);
		//fprintf(fp, "GuardBandTop %f\r\n", caps.GuardBandTop);
		//fprintf(fp, "GuardBandRight %f\r\n", caps.GuardBandRight);
		//fprintf(fp, "GuardBandBottom %f\r\n", caps.GuardBandBottom);
		//fprintf(fp, "ExtentsAdjust %f\r\n", caps.ExtentsAdjust);
		//fprintf(fp, "StencilCaps %X\r\n", caps.StencilCaps);
		//fprintf(fp, "FVFCaps %X\r\n", caps.FVFCaps);
		//fprintf(fp, "TextureOpCaps %X\r\n", caps.TextureOpCaps);
		//fprintf(fp, "MaxTextureBlendStages %X\r\n", caps.MaxTextureBlendStages);
		//fprintf(fp, "MaxSimultaneousTextures %X\r\n", caps.MaxSimultaneousTextures);
		//fprintf(fp, "VertexProcessingCaps %X\r\n", caps.VertexProcessingCaps);
		//fprintf(fp, "MaxActiveLights %X\r\n", caps.MaxActiveLights);
		//fprintf(fp, "MaxUserClipPlanes %X\r\n", caps.MaxUserClipPlanes);
		//fprintf(fp, "MaxVertexBlendMatrices %X\r\n", caps.MaxVertexBlendMatrices);
		//fprintf(fp, "MaxVertexBlendMatrixIndex %X\r\n", caps.MaxVertexBlendMatrixIndex);
		//fprintf(fp, "MaxPointSize %f\r\n", caps.MaxPointSize);
		//fprintf(fp, "MaxPrimitiveCount %X\r\n", caps.MaxPrimitiveCount);
		//fprintf(fp, "MaxVertexIndex %X\r\n", caps.MaxVertexIndex);
		//fprintf(fp, "MaxStreams %X\r\n", caps.MaxStreams);
		//fprintf(fp, "MaxStreamStride %X\r\n", caps.MaxStreamStride);
		fprintf(fp, "VS:%X PS:%X\r\n", caps.VertexShaderVersion, caps.PixelShaderVersion);
		fprintf(fp, "MaxVertexShaderConst %X\r\n", caps.MaxVertexShaderConst);
		fprintf(fp, "MaxPixelShaderValue %f\r\n", caps.MaxPixelShaderValue);
	  }
	}
  } catch(...)
  {
	fprintf(fp, "GetDeviceCaps error\r\n");
  }
}

extern short g_sClientVer;
void		 GameErrorReport(const char* format, ...)
{
  char buf[1000];
  if(format && format[0])
  {
	va_list args;
	va_start(args, format);
	_vsnprintf_s(buf, sizeof(buf), _TRUNCATE, format, args);
	va_end(args);
	strncat_s(buf, _countof(buf), "\n", _TRUNCATE);
  } else
	buf[0] = '\0';

  string info = buf;
  if(strstr(buf, "Call Stack:\n") == NULL)
	//AddCallingFunctionName(info, 2);

  info += GetTimeStamp();
  info += '\n';

  std::string szFileName;
  LG_GetDir(szFileName);
  szFileName += "\\exception.txt";

  HANDLE hMutex = CreateMutex(NULL, false, "GameErrorReport_mutex");
  if(GetLastError() == ERROR_ALREADY_EXISTS)
  {
	CloseHandle(hMutex);
	return;
  }

  FILE* fp		= NULL;
  BOOL	bWrited = FALSE;
  if(fopen_s(&fp, szFileName.c_str(), "a+") == 0)
  {
	//		string banner = "------------------------------------------------------------------\n";
	//		fwrite(banner.c_str(),banner.length(),1,fp);

	//		if( buf[0] )
	//			fwrite(buf,strlen(buf),1,fp);
	if(info.length())
	  fwrite(info.c_str(), info.length(), 1, fp);
	WriteSystemInfo(fp);
	fclose(fp);
	bWrited = TRUE;
  }

  CloseHandle(hMutex);

  if(!CResourceBundleManage::Instance())
	return;

  if(!bWrited)
	return;

  static BOOL s_bReported = FALSE;
  if(s_bReported)
	return;
  s_bReported = TRUE;

  //string cmd;
  //cmd.append("system/errorreport.exe ");
  //cmd.append(RES_STRING(CL_LANGUAGE_MATCH_0));
  //cmd.append(" ");

  //MessageBox(NULL, info.c_str(), "Kop Error", 0);
  /*char buff[10];
	memset(buff, 0, sizeof(buff));
	_itoa_s(g_sClientVer, buff, _countof(buff), 10);
	cmd.append(buff);
	WinExec(cmd.c_str(), SW_SHOW);*/
}

void GameErrorLog(const char* format, ...)
{
  if(NULL == format)
	return;

  char	  buf[1000];
  va_list args;
  va_start(args, format);
  _vsnprintf_s(buf, sizeof(buf), _TRUNCATE, format, args);
  va_end(args);

  if(!buf[0])
	return;

  if(buf[strlen(buf) - 1] != '\n')
	strncat_s(buf, _countof(buf), "\n", _TRUNCATE);
  HANDLE hMutex = CreateMutex(NULL, false, "GameErrorReport_mutex");
  if(GetLastError() == ERROR_ALREADY_EXISTS)
  {
	CloseHandle(hMutex);
	return;
  }

  std::string szFileName;
  LG_GetDir(szFileName);
  szFileName += "\\exception.txt";
  FILE* fp;
  if(fopen_s(&fp, szFileName.c_str(), "a+") == 0)
  {
	//MessageBox(NULL, buf, "Error", MB_OK | MB_ICONERROR);
	fwrite(buf, strlen(buf), 1, fp);
	fclose(fp);
  }
  CloseHandle(hMutex);
}

void GameErrorClear()
{
  // 	HANDLE  hMutex = CreateMutex(NULL, false, "GameErrorReport_mutex");
  // 	if( GetLastError()==ERROR_ALREADY_EXISTS )
  // 	{
  // 		CloseHandle(hMutex);
  // 		return;
  // 	}
  //
  // 	string	szDir;
  // 	LG_GetDir(szDir);
  // 	string szOld = szDir + "\\exception.txt";
  // 	string szNew = szDir + "\\exception_";
  // 	szNew += GetTimeStamp();
  // 	szNew += ".txt";
  // 	rename(szOld.c_str(), szNew.c_str());
  // 	CloseHandle(hMutex);
}