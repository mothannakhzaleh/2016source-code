@echo off

>decompile_output.log 2>&1(
cd client
for %%i in (.\*.res) do ..\derb -e UTF-8 %%i
cd ..

cd server
for %%i in (.\*.res) do ..\derb -e UTF-8 %%i
cd ..
)

:: In case the script was run in console - print file 
cat decompile_output.log