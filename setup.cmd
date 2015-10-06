@echo ---------- Process Renamer Install ----------
@echo. 
@echo off
SET me=%~n0
SET parent=%~dp0

set /p chromePath="Please enter the Chrome path (whitout quotes): "
set PINTASKBAR="%~dp0\script.vbs"
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%~dp0\ProcessRenamer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Windows\System32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/c """"%~dp0\ProcessRenamer.cmd"" ""%chromePath%""""" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
cscript /nologo %PINTASKBAR% /target:"ProcessRenamer.lnk" /folder:"%~dp0"
cscript /nologo %PINTASKBAR% /target:"chrome.exe" /folder:"%chromePath%"

del %SCRIPT%
