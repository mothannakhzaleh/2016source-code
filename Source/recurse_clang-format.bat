echo ON

SET FOLDER_SET=Common AccountServer GateServer Client GameServer GroupServer Engine ICUHelper Util Server AudioSDL

FOR /D %%a IN (%FOLDER_SET%) DO (
	FOR /F "delims=" %%f in ('dir %%a /b /s ^| find ".h"') do ( clang-format -i -style=file "%%f" )
	FOR /F "delims=" %%f in ('dir %%a /b /s ^| find ".cpp" ') do ( clang-format -i -style=file "%%f" )
)

:: for /R %%f in (*.cpp) do clang-format -i -style=file "%%f"
:: for /R %%f in (*.h) do clang-format -i -style=file "%%f"
:: for /R %%f in (*.hpp) do clang-format -i -style=file "%%f"