#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#If WinActive("ahk_exe Notepad++.exe") 
:*:for  :: 
Send for x in range(,):
Send {Enter}
Send {Tab}
SendRaw #do something
Send {Enter}
Send {Up}
Loop 2
Send {Left}
Return










^r::Reload
