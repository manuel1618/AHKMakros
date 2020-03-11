#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#If WinActive("ahk_exe DesignCockpit43.exe") or WinActive("ahk_exe DesignCompiler43.exe") or WinActive("ahk_exe eclipse.exe") 
:*:main  :: 
Send public static void main(String[] args) {{}
Send {Enter}
;Loop 29
;	Send {Right}
;Loop 4
;Send +{Right}
Return

#If WinActive("ahk_exe DesignCockpit43.exe") or WinActive("ahk_exe DesignCompiler43.exe") or WinActive("ahk_exe eclipse.exe") 
:*:if  ::
Send if () {{}
Send {Enter}
Send {Up}
Return

#If WinActive("ahk_exe DesignCockpit43.exe") or WinActive("ahk_exe DesignCompiler43.exe") or WinActive("ahk_exe eclipse.exe") 
:*:elf  ::
Send else if () {{}
Send {Enter}
Send {Up}
Loop 7
	Send {Right}
Return

#If WinActive("ahk_exe DesignCockpit43.exe") or WinActive("ahk_exe DesignCompiler43.exe") or WinActive("ahk_exe eclipse.exe") 
:*:els  ::
Send else {{}
Send {Enter}
Return

#If WinActive("ahk_exe DesignCockpit43.exe") or WinActive("ahk_exe DesignCompiler43.exe") or WinActive("ahk_exe eclipse.exe") 
:*:for  ::
Send for (int i = 0{;} i < {;} i{+}{+}) {{}
Send {Enter}
Send {Up}
Loop 15
	Send {Right}
Return

^r::Reload
