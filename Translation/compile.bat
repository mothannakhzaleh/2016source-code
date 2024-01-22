@echo off

>compile_output.log 2>&1(
cd client
for %%i in (.\*.txt) do ..\genrb -e UTF-8 %%i
cd ..

cd server
for %%i in (.\*.txt) do ..\genrb -e UTF-8 %%i
cd ..
)

:: In case the script was run in console - print file 
type compile_output.log