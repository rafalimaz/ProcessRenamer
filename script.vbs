Dim strFolder, strExecutable
Set objShell = CreateObject("Shell.Application")

strFolder = "C:\Users\ufc113.lima\Desktop\ProcessRenamer"
strExecutable = "ProcessRenamer.lnk"

Set objFolder = objShell.Namespace(strFolder)
Set objFolderItem = objFolder.ParseName(strExecutable)

Set colVerbs = objFolderItem.Verbs

'uncomment this section to display the available verbs
' For Each objVerb In colVerbs
' 	If objVerb <> "" Then
' 		WScript.Echo objVerb
' 	End If
' Next

'Loop through the verbs and if PIN is found then 'DoIt' (execute)
blnOptionFound = False
For Each objVerb In colVerbs
	If Replace(objVerb.name, "&", "") = "Pin to Taskbar" Then
		objVerb.DoIt
		blnOptionFound = True
		WScript.Echo "The application '" & strExecutable & "' was just Pinned to the Taskbar."
	End If
Next

if blnOptionFound = false then
	WScript.Echo "The application '" & strExecutable & "' was already pinned to the Taskbar."
end if