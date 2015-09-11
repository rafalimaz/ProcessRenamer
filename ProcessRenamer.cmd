:: Process Renamer 1.0
:: Created by Rafael de Lima

@echo off 

SETLOCAL ENABLEDELAYEDEXPANSION

SET me=%~n0
SET parent=%~dp0

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
	exit /B
) else ( 
	goto gotAdmin
	exit /B
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 "%1"", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	goto mainFunction
	exit /B
	
:mainFunction
	FOR /F "delims=" %%I IN (%1) DO SET chromePath=%%I
	FOR /R "%chromePath%" %%f IN (*1.exe) DO (
		For %%A in ("%%f") do (
			Set folder=%%~dpA
			Set name=%%~nxA
		)
		
		TASKKILL /F /IM !name!
		SET newProcessName=chrome%random%1.exe
		::SET newProcessName=chrome9.exe
		ren "%%f" !newProcessName!
		Start "title" "%chromePath%\!newProcessName!"
		exit /B
	)
	
:--------------------------------------


	
