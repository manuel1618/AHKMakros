If WScript.Arguments.length = 0 Then
   Set objShell = CreateObject("Shell.Application")
   'Pass a bogus argument, say [ uac]
   objShell.ShellExecute "wscript.exe", Chr(34) & _
      WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
	Set WshShell = CreateObject("WScript.Shell" ) 
	WshShell.Run """D:\GITHUB\AHKMakros\luamacros\HOMEPC""", 0 'Must quote command if it has spaces; must escape quotes
	WshShell.Run """D:\GITHUB\AHKMakros\F1F2F3F4_program_launcher.exe""", 0 'Must quote command if it has spaces; must escape quotes
	Set WshShell = Nothing

End If