@echo ---------- Process Renamer Install ----------
@echo. 
@echo off
set /p chromePath="Please enter the Chrome path (whitout quotes): "
set PINTASKBAR="%USERPROFILE%\Desktop\ProcessRenamer\script.vbs"
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\ProcessRenamer\ProcessRenamer.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Windows\System32\cmd.exe" >> %SCRIPT%
echo oLink.Arguments = "/c """"%USERPROFILE%\Desktop\ProcessRenamer\ProcessRenamer.cmd"" ""%chromePath%""""" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
cscript /nologo %PINTASKBAR% /target:"ProcessRenamer.lnk" /folder:"C:\Users\ufc113.lima\Desktop\ProcessRenamer"
cscript /nologo %PINTASKBAR% /target:"chrome.exe" /folder:"%chromePath%"

del %SCRIPT%
