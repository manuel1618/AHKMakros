#NoEnv
#SingleInstance Force
#Warn ClassOverwrite
SendMode Input
SetBatchLines -1
SetTitleMatchMode 2

;; original found here : https://www.youtube.com/watch?v=u9IhWCyPKso

;; ------------ Here after come the shortcuts -------------------------------------------------------------------------------------------------------------------------------------
TooltipHotkeys := [new HypermeshToolTip("F2", "Auto Vervollständigung", "I love it!")
				 , new HypermeshToolTip("F1", "Help Me", "I pressed F1, so help me!")
				 , new HypermeshToolTip("F4", "Distance Panel", "Measure Distances but also for getting the circle center point")
				 , new HypermeshToolTip("F5", "Mask Panel", "Hide / and show Entities")
				 , new HypermeshToolTip("F11", "Geom QuickEdit", "For fixing Geometry fast and easy")
				 , new HypermeshToolTip("+F11", "Organize", "Move or Copy Entities")
				 , new HypermeshToolTip("^z", "Revert", "I screwed up")
				 , new HypermeshToolTip("F12", "2D Automesh", "Creating 2D Element Meshes on Surfaces")]  ;; <---- watch out, don't forget the ] here at the end of the last line
;; ------------ End of the shortcuts -----------------------------------------------------------------------------------------------------------------------------------------------

^r::Reload

class HypermeshToolTip
{
	static GUI_WIDTH := 400    ;; width of the box
		 , GUI_HEIGHT := 100    ;; height of the box
		 , PADDING := 5         ;; it will be called margin afterwards in the code, but really it's padding (inside margin if you want)
 		 , MARGIN := 50    ;; margin (only used in the ShowDescription)
		 , TEXT_WIDTH := HypermeshToolTip.GUI_WIDTH - 2 * HypermeshToolTip.PADDING
		 , EXE := "ahk_exe hw.exe"
		 , COLOR_SCHEME := {"BACKGROUND": "5f5d5d"    ;; background color, will be set a little bit transparent later on
						  , "SEPARATOR": "313131"	;; color of the line between title and description
						  , "TITLE": "00a9e1"
						  , "DESCRIPTION": "ffc845"}
		, DELAY := 2500		;; how many milliseconds the tooltip is displayed
		
		
;; constructor for the keybind : hotkey, function, description
	__New(keybind, name, description) {
		;; added to display "CTRL+" in place of "^" in, f.i. "^c" which stands for "CTRL+C"
		IfInString, keybind, ^ 
			{
				keybindTXT:= StrReplace(keybind, "^", "CTRL+")
			}	
			else keybindTXT := keybind
			
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
		return WinActive(ahk_exe DesignCockpit43.exe) && !A_CaretX
	}

	;; shows the box
	showDescription(hwnd, keybind) {
		WinGetPos x, y, w, h, % DesignCockpit43.exe
		Gui %hwnd%: Show, % Format("x{} y{} NoActivate", x + HypermeshToolTip.MARGIN, h - HypermeshToolTip.MARGIN - HypermeshToolTip.GUI_HEIGHT )
		
		Send % "{" keybind "}"
	}

	;; hides the box
	hideDescription(hwnd, keybind) {
		sleep, HypermeshToolTip.DELAY ;; wait for the duration of DELAY...
		Gui %hwnd%: Hide ;; ...then hide the box
	}
}

