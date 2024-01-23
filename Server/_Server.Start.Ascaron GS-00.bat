::start GameServer.exe GameServer00.cfg
@echo off
color B
title Satisfy GameServer
echo  ------------------------------------------------------
echo  [ Starting aso bootup progress...                    ]
echo  [ Checking for old log files...                      ]
if exist "log" (echo  [ Old log files were found...                        ] & goto DelLogs) else (echo  [ No old logs were found... Skipping logs deletion.. ])

:afterUpdater
echo  [ Analyzis progress done... Starting up the GameServer.. ]
CD Server
start  GameServer_x64_Debug.exe GameServer.cfg
echo  ------------------------------------------------------
timeout /t 5
exit
:DelLogs
@ECHO OFF
FOR /D %%x IN (log*) DO (rd /s /q "%%x")

IF EXIST "LOG" (rd /s /q "LOG")>nul 2>nul
IF EXIST "logfile" (rd /s /q "logfile")>nul 2>nul
::EXIT
echo  [ Successfully deleted the old log files...          ]

goto afterUpdater