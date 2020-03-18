#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.
#singleinstance force ;so you can only run 1 script at a time and it doens't bother you about it.

;######## THIS IS THE BEST SCRIPT I'VE EVER WRITTEN. #########

;And also one of the simplest. Basically, If you press the "explorer" key (F1) it will instantly:
; 1. Create an explorer window if one is not already running.
; 2. Open the LAST ACTIVE explorer window if Explorer is not already active
; 3. If you keep pressing the key, it will cycle through Explorer windows in the order they were last activated

;Programs like chrome are a little different. It will open Chrome if it's not already open,
;but when you keep pressing the button, it hits "CTRL TAB" to advance you forwards through your tabs.

;This is all significantly superior to switching between applications by CLICKING on them in the taskbar,
;and also very superior to using WIN 1, WIN 2, WIN 3 etc to switch between applications.

;You will want to tailor this script to launch your own most commonly used applications.
;You can use Window Spy (it comes with autohotkey) to figure out the ahk_exe and ahk_class of your applications.
;There is a video explaining all of this:
; https://www.youtube.com/watch?v=OqyQABySV8k

;If you have a macro keyboard, I reccomend that you add ^ to each of theese shortcuts, and assign you macro
;keys to CTRL F1, CTRL F2 and so on. That way, your Function keys are freed, to be used for other things.




#IfWinActive 

;F1 holds the "BACK" script.
^numpad1::
if WinActive("ahk_class MozillaWindowClass")
	Send ^+{tab} ;CTRL SHIFT TAB is the shortcut for "go to previous tab"
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_class MozillaWindowClass")
	Send ^{PgUp}
if WinActive("ahk_class Notepad++")
	Send ^{PgUp}
if WinActive("ahk_exe slack.exe")
	Send !{up}
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	Send {F12} ;F12 is my shortcut in premiere for "go back"(in bins)
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;ALT LEFT is the explorer shortcut to go "back" or "up" one folder level.
Return


^numpad2::
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass ;You have to make a new group for each application, don't use the same one for all of them!
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
Return


^numpad3::
IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_class MozillaWindowClass")
	Send ^{PgDn}
else
	WinActivate ahk_class MozillaWindowClass
Return

^numpad4::
IfWinNotExist, ahk_exe slack.exe
	Run, C:\Users\%A_UserName%\AppData\Local\slack\Update.exe --processStart "slack.exe", , Normal
if WinActive("ahk_exe slack.exe")
	Send !{down}
else
	WinActivate ahk_exe slack.exe
Return



^numpad5::
IfWinNotExist, ahk_class Notepad++
	Run, notepad++
if WinActive("ahk_class Notepad++")
	Send ^{PgDn}
else
	WinActivate ahk_class Notepad++
Return





^+numpad6::
installDir43v3 = %A_ProgramFiles%\DesignCockpit43 ; USERSPECIFIC
Process, Exist, DesignCockpit43.exe
	If errorLevel = 0
	{
		Run, %installDir43v3%\DesignCockpit43.exe
	}
	else
	{
	GroupAdd, designCockpits, ahk_exe DesignCockpit43.exe
	if WinActive("ahk_exe DesignCockpit43.exe")
		GroupActivate, designCockpits, r
	else
		WinActivate ahk_exe DesignCockpit43.exe
	}
Return



^numpad6::
installDir43v2 = %A_ProgramFiles%\DesignCompiler43 ; USERSPECIFIC
Process, Exist, DesignCompiler.exe
	If errorLevel = 0
	{
		Run, %InstallDir43v2%\DesignCompiler43.exe
	}
	else
	{
	GroupAdd, designCompilers, ahk_exe DesignCompiler43.exe
	if WinActive("ahk_exe DesignCockpit43.exe")
		GroupActivate, designCompilers, r
	else
		WinActivate ahk_exe DesignCockpit43.exe
	}
Return




; I really dont need those shortcuts below


;^numpad6::
;IfWinNotExist, ahk_class Premiere Pro
;	Run, Adobe Premiere Pro.exe
;WinActivate ahk_class Premiere Pro
;Return

;If you want to only launch an application when holding the SHIFT key, you can program it this way:
;F5::WinActivate ahk_class Premiere Pro
;+F5::Run, Adobe Premiere Pro.exe




^r:: Reload


;EXTRA STUFF YOU CAN DELETE

;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
~::
Send !{up}
Return


#IfWinActive
;opens the CLOCK / CALENDAR. Deosn't work all that well.
;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#c::
Send #b{left}{enter}
Return


