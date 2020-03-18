;Multiple ClipBoards
GetFromClipboard()
{ 
  ClipSaved := ClipboardAll ;Save the clipboard
  Clipboard = ;Empty the clipboard
  SendInput {^}c
  ;NewClipboard := Trim(Clipboard)
  ; StringReplace, NewClipboard, NewClipBoard, `r`n, `n, All ;comment this in to remove whitespace automaticaly
  Clipboard := ClipSaved ;Restore the clipboard
  ClipSaved = ;Free the memory in case the clipboard was very large.
  return NewClipboard
}


^!1::
ClipBoard_1 := GetFromClipboard()
Return

^!2::
ClipBoard_2 := GetFromClipboard()
Return

^!3::
ClipBoard_3 := GetFromClipboard()
Return

!1::
SendInput {Raw}%ClipBoard_1%
Return

!2::
SendInput {Raw}%ClipBoard_2%
Return

!3::
SendInput {Raw}%ClipBoard_3%
Return

^r::Reload


