Set WshShell = CreateObject("WScript.Shell" ) 
WshShell.Run """D:\GITHUB\AHKMakros\F1F2F3F4_program_launcher.exe""", 0 'Must quote command if it has spaces; must escape quotes
WshShell.Run """D:\GITHUB\AHKMakros\luamacros\LuaMacros.exe""", 0 'Must quote command if it has spaces; must escape quotes
Set WshShell = Nothing