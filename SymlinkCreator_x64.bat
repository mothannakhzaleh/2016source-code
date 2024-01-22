echo Based on deguix build script: 
echo https://gitlab.com/deguix/top-recode
echo 

@echo off

rem From https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
set "ADMIN=n"
net session >nul 2>&1
if "%errorLevel%" == "0" (
    set "ADMIN=y"
)

:: (fix for Windows 8+) Change directory to the one script is on
cd /d %~dp0 

set ROOT_DIR=%cd%
set CLIENT_SYSTEM_DIR=%ROOT_DIR%\Client\System
set SERVER_DIR=%ROOT_DIR%\Server
set SOURCE_DIR=%ROOT_DIR%\Source
set RESOURCE_DIR=%ROOT_DIR%\Resource
set CLIENT_SCRIPTS_DIR=%ROOT_DIR%\Client\scripts
set TRANSLATION_DIR=%ROOT_DIR%\Translation
set ICU_LIB_DIR=%SOURCE_DIR%\ICU\lib\x64\
set ICU_LIB_DIR_x86=%SOURCE_DIR%\ICU\lib\Win32\
set LICENSE_DIR=%SOURCE_DIR%\licensecc\projects\


cd %SERVER_DIR%
call :MKLINK_DIFFNAME "GateServer_x64_Release.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "AccountServer_x64_Release.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "GameServer_x64_Release.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "GroupServer_x64_Release.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"

call :MKLINK_DIFFNAME "GateServer_x64_Debug.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "AccountServer_x64_Debug.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "GameServer_x64_Debug.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"
call :MKLINK_DIFFNAME "GroupServer_x64_Debug.lic" "%LICENSE_DIR%\Yatops Server\licenses\ServerPermanentLicense.lic"

cd %TRANSLATION_DIR%
call :MKLINK "%ICU_LIB_DIR%\Release\derb.exe"
call :MKLINK "%ICU_LIB_DIR%\Release\genrb.exe"
call :MKLINK "%ICU_LIB_DIR%\Release\icuuc72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icuin72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icutu72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icudt72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icuio72.dll"
:: Compile resource files before creating symlink based on them
call compile.bat

cd %CLIENT_SYSTEM_DIR%
call :MKLINK "%SOURCE_DIR%\LuaJIT\lib\x64\lua51.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Release\icuuc70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Release\icuin70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Release\icutu70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Release\icudt70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Release\icuio70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Debug\icuuc70d.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Debug\icuin70d.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Debug\icutu70d.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Debug\icudt70.dll"
call :MKLINK "%ICU_LIB_DIR_x86%\Debug\icuio70d.dll"

call :MKLINK_DIFFNAME "en_US.res" "%TRANSLATION_DIR%\client\en_US.res"
call :MKLINK_DIFFNAME "Game.loc" "%TRANSLATION_DIR%\Locale.loc"

cd %SERVER_DIR%\
call :MKLINK "%SOURCE_DIR%\LuaJIT\lib\x64\lua51.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icuuc72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icuin72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icutu72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icudt72.dll"
call :MKLINK "%ICU_LIB_DIR%\Release\icuio72.dll"
call :MKLINK_DIFFNAME "en_US.res" "%TRANSLATION_DIR%\server\en_US.res"
call :MKLINK_DIFFNAME "AccountServer.loc" "%TRANSLATION_DIR%\Locale.loc"
call :MKLINK_DIFFNAME "GameServer.loc" "%TRANSLATION_DIR%\Locale.loc"
call :MKLINK_DIFFNAME "GateServer.loc" "%TRANSLATION_DIR%\Locale.loc"
call :MKLINK_DIFFNAME "GroupServer.loc" "%TRANSLATION_DIR%\Locale.loc"


cd %SERVER_DIR%\
call :MKLINK_DIR "%RESOURCE_DIR%"

:: Shared resources Client <--> Server
cd %CLIENT_SCRIPTS_DIR%\table
call :MKLINK "%RESOURCE_DIR%\Skillinfo.txt"
call :MKLINK "%RESOURCE_DIR%\Characterinfo.txt"
call :MKLINK "%RESOURCE_DIR%\Iteminfo.txt"
call :MKLINK "%RESOURCE_DIR%\AreaSet.txt"
call :MKLINK "%RESOURCE_DIR%\SkillEff.txt"
call :MKLINK "%RESOURCE_DIR%\ShipInfo.txt"
call :MKLINK "%RESOURCE_DIR%\ShipItemInfo.txt"
call :MKLINK "%RESOURCE_DIR%\Hairs.txt"


:: Required files to run tests with
cd %SOURCE_DIR%\Catch2Tests
call :MKLINK "%RESOURCE_DIR%\Iteminfo.txt"

echo Finished.
pause
:exit
@echo on
exit /B

rem Procedure definitions

rem Makes additional checks on mklink to make sure script doesn't spit errors non-stop
rem Also prevents script execution if files are missing
rem Also deletes old link if admin to make sure x86/x64 links are appropriate
:MKLINK
	if exist %~nx1 (
		if %ADMIN%==y (
			del /F /Q %~nx1
			mklink %~nx1 %1
		)
	) else (
		if %ADMIN%==n (
			goto :FILE_DOESNT_EXIST
		) else mklink %~nx1 %1
	)
	exit /B
	
:MKLINK_DIFFNAME
	if exist %1 (
		if %ADMIN%==y (
			del /F /Q %1
			mklink %1 %2
		)
	) else (
		if %ADMIN%==n (
			goto :FILE_DOESNT_EXIST
		) else mklink %1 %2
	)
	exit /B
	
:MKLINK_DIFFNAME_J
	if exist %1 (
		if %ADMIN%==y (
			rmdir /S /Q %1
			mklink /J %1 %2
		)
	) else (
		if %ADMIN%==n (
			goto :FILE_DOESNT_EXIST
		) else mklink /J %1 %2
	)
	exit /B

:MKLINK_DIR
	if exist %~nx1 (
		if %ADMIN%==y (
			rmdir /Q /S %~nx1
			mklink /D %~nx1 %1
		)
	) else (
		if %ADMIN%==n (
			goto :FILE_DOESNT_EXIST
		) else mklink /D %~nx1 %1
	)
	exit /B

rem https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
:NORMALIZEPATH
  set "RETVAL=%~dpfn1"
  exit /B

:FILE_DOESNT_EXIST
	call :NORMALIZEPATH %2
	echo "File %RETVAL% doesn't exist! Run the script as admin for the symlinking to work!"
	pause
	exit