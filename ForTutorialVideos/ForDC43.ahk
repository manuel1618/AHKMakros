#NoEnv
#SingleInstance Force
#Warn ClassOverwrite
SendMode Input
SetBatchLines -1
SetTitleMatchMode 2


;; original found here : https://www.autohotkey.com/boards/viewtopic.php?f=76&t=61880&hilit=premiere
;; comments, some additions and removals : krea.city : https://www.youtube.com/channel/UCzDZYbPaUkQd2zUN_ZdJbYg

;; ------------ Here after come the shortcuts -------------------------------------------------------------------------------------------------------------------------------------
TooltipHotkeys := [new ToolTip("^1", "AutoCorrect", "Suggestions how to resolve an error")
				 , new ToolTip("^Space", "AutoComplete", "Only lazy programmers type much")
				 , new ToolTip("^f", "Search", "Search and you shall recieve")
				 , new ToolTip("^c", "Copy", "Copy this item")
				 , new ToolTip("^d", "Delete line", "")
				 , new ToolTip("^v", "Paste", "Paste this item")
				 , new ToolTip("Enter", "Enter", "Smash it!")
				 , new ToolTip("^Left", "Faster move cursor", "Cause faster is better")
				 , new ToolTip("^Right", "Faster move cursor", "Cause faster is better")
				 , new ToolTip("^Down", "Faster move cursor", "Cause faster is better")
				 , new ToolTip("^Up", "Faster move cursor", "Cause faster is better")
				 , new ToolTip("^+Left", "Faster mark", "Cause faster is better")
				 , new ToolTip("^+Right", "Faster mark", "Cause faster is better")
				 , new ToolTip("^+Down", "Faster mark", "Cause faster is better")
				 , new ToolTip("^+Up", "Faster mark", "Cause faster is better")
				 , new ToolTip("^!Up", "Copy Line Upwards", "Pretty awesome shortcut")
				 , new ToolTip("^!Down", "Copy Line Downwards", "Pretty awesome shortcut")
				 , new ToolTip("!Down", "Move Line Downwards", "Ah I love it!")
				 , new ToolTip("!Up", "Move Line Upwards", "Ah I love it!")
				 , new ToolTip("^BS", "Delete Faster", "")
				 , new ToolTip("^Delete", "Delete Faster", "")
				 , new ToolTip("^Home", "Top of the File", "")
				 , new ToolTip("Home", "Beginning of the Line", "")
				 , new ToolTip("^s", "Save", "Save, for God's sake save!")
				 , new ToolTip("^z", "UnDo", "I screwed Up! Sorry :-D")]  ;; <---- watch out, don't forget the ] here at the end of the last line
;; ------------ End of the shortcuts -----------------------------------------------------------------------------------------------------------------------------------------------

class ToolTip
{
	static GUI_WIDTH := 700    ;; width of the box
		 , GUI_HEIGHT := 100    ;; height of the box
		 , PADDING := 5         ;; it will be called margin afterwards in the code, but really it's padding (inside margin if you want)
 		 , MARGIN := 50    ;; margin (only used in the ShowDescription)
		 , TEXT_WIDTH := ToolTip.GUI_WIDTH - 2 * ToolTip.PADDING
		 , EXE := "ahk_exe DesignCockpit43.exe"
		 , COLOR_SCHEME := {"BACKGROUND": "1D1D1D"    ;; background color, will be set a little bit transparent later on
						  , "SEPARATOR": "313131"	;; color of the line between title and description
						  , "TITLE": "2D8CEB"
						  , "DESCRIPTION": "A7A7A7"}
		, DELAY := 1500		;; how many milliseconds the tooltip is displayed
		
		
;; constructor for the keybind : hotkey, function, description
	__New(keybind, name, description) {
		;; added to display "CTRL+" in place of "^" in, f.i. "^c" which stands for "CTRL+C"
		
		keybindTXT := keybind
		IfInString, keybind, ^ 
			{
				keybindTXT:= StrReplace(keybind, "^", "CTRL+")
			}	
		IfInString, keybind, !
			{
				keybindTXT:= StrReplace(keybind, "!", "Alt+")
			}	
		IfInString, keybind, +
			{
				keybindTXT:= StrReplace(keybind, "+", "Shift+")
			}	
		
	
		Gui New, +AlwaysOnTop -Caption +ToolWindow +Hwndhwnd
		Gui Color, % this.COLOR_SCHEME.BACKGROUND
		Gui Margin, % this.PADDING, % this.PADDING ;; this Margin thing should be called Padding as it this the margin inside the gui...
		
		;; Name of the function called by shortcut, second argument in the Tooltip
		Gui Font, S20 ;; size of the Title. You have to style the text in the first place, before populating with the title value
		Gui Add, Text, % "c" this.COLOR_SCHEME.TITLE, % name ;; color of the title + The second argument of the Tooltip
		
		;; display the used shortcut in parenthesis, underlined
		Gui Add, Text, % "x+m yp c" this.COLOR_SCHEME.TITLE, % "("
		Gui Font, Underline
		Gui Add, Text, % "x+2 yp c" this.COLOR_SCHEME.TITLE, % keybindTXT
		Gui Font, Norm
		Gui Add, Text, % "x+2 yp c" this.COLOR_SCHEME.TITLE, % ")"
		
		;; Separator and description of what the shortcut does
		Gui Font, S12
		Gui Add, Progress, % Format("xm h2 w{1:} Background{2:} c{2:}", this.TEXT_WIDTH, this.COLOR_SCHEME.SEPARATOR), 100
		Gui Add, Text, % Format("w{1:} Background{2:} c{2:}", this.TEXT_WIDTH, this.COLOR_SCHEME.DESCRIPTION), % description
		Gui Show, % Format("w{} Hide", this.GUI_WIDTH)
		
		;; Get the whole thing to render with a little bit of transparency. 230 is almost opaque (255), the less you have, the most transparent you get
		Gui, +Lastfound
		WinSet, TransColor, this.COLOR_SCHEME.BACKGROUND 230

		;; some dark magic you don't need to touch to preserve the balance of the Force
		hiddenWindowsSetting := A_DetectHiddenWindows
		DetectHiddenWindows On
		WinGetPos, , , , h, % "ahk_id " hwnd
		DetectHiddenWindows % hiddenWindowsSetting
		Gui Add, Progress, % Format("h{} w1 x0 y0 Background{3:} c{3:}", h, this.TEXT_WIDTH, this.COLOR_SCHEME.SEPARATOR), 100
		Gui Add, Progress, % Format("h1 w{} x0 y0 Background{2:} c{2:}", this.GUI_WIDTH, this.COLOR_SCHEME.SEPARATOR), 100
		Gui Add, Progress, % Format("h{} w1 x{} y0 Background{3:} c{3:}", h, this.GUI_WIDTH - 1, this.COLOR_SCHEME.SEPARATOR), 100
		Gui Add, Progress, % Format("h1 w{} x0 y{} Background{3:} c{3:}", this.GUI_WIDTH, h - 1, this.COLOR_SCHEME.SEPARATOR), 100
		keybind := Format("{:L}", keybind) ;; align Left
		this.keybind := keybind
		this.hwnd := hwnd
		
		fn := this.hideDescription.Bind("", hwnd, keybind) ;; calls the hideDescription method, that hides the box...
		Hotkey % Format("~{} Up", keybind), % fn ;; ...when hotkey is released
		
		;; If Premiere is active, activate the hotkeys that will invoke the showDescription function (see below)
		fn := this.showCondition := this.isPremiereActive.Bind("")
		Hotkey If, % fn
			fn := this.showDescription.Bind("", hwnd, keybind) ;; calls the showDescription method, that displays the box
			Hotkey % keybind, % fn
		Hotkey If
		

	}
	
	;; Destructor, when hotkey is released
	__Delete() {
		Hotkey % Format("~{} Up", this.keybind), Off
		fn := this.showCondition
		Hotkey If, % fn
			Hotkey % this.keybind, Off
		Hotkey If
		
	}

	;; check if the executable in the EXE static are active
	isPremiereActive() {
		return WinActive(ToolTip.EXE)
	}

	;; shows the box
	showDescription(hwnd, keybind) {
		WinGetPos x, y, w, h, % ToolTip.EXE
		Gui %hwnd%: Show, % Format("x{} y{} NoActivate", x + ToolTip.MARGIN, h - ToolTip.MARGIN - ToolTip.GUI_HEIGHT )
		
		
		modifierkeys := ["Space","Enter","Up","Down","Left","Right","BS","Tab","Insert","Home","PgUp","PgDn","Delete","End"]
		for index, key in modifierkeys
		{
			
			IfInString, keybind, %key%
			{
				keyM = {%key%}
				StringReplace, keybindWithModifiers, keybind, %key%, %keyM%
				Break
			}
			else 
			{
				keybindWithModifiers := keybind
			}
		}
		;MsgBox %keybindWithModifiers%
		Send %keybindWithModifiers%
	}

	;; hides the box
	hideDescription(hwnd, keybind) {
		sleep, ToolTip.DELAY ;; wait for the duration of DELAY...
		Gui %hwnd%: Hide ;; ...then hide the box
	}
}