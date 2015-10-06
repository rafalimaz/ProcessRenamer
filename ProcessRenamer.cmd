:: Process Renamer 1.0
:: Created by Rafael de Lima

@echo off 

SETLOCAL ENABLEDELAYEDEXPANSION
SET me=%~n0
SET parent=%~dp0

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
	
	if not exist "%chromePath%\chrome*1.exe" (
		copy "%chromePath%\chrome.exe" "%chromePath%\chrome1.exe"
	)
	
	FOR /R "%chromePath%" %%f IN (*1.exe) DO (
		For %%A in ("%%f") do (
			Set folder=%%~dpA
			Set name=%%~nxA
		)
		
		TASKKILL /F /IM !name!
		SET newProcessName=chrome%random%1.exe
		ren "%%f" !newProcessName!
		
		cscript /nologo mkshortcut.vbs /target:"%chromePath%\!newProcessName!" /shortcut:"%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome"
		::Start "" /wait /b "%chromePath%\!newProcessName!"
		::runas "/trustlevel:0x20000" "%chromePath%\!newProcessName!" //TODO: make start from command for basic user
		exit /B
	)	
:--------------------------------------


	
