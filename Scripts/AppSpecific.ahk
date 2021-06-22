;  Context-sensitive Documentation: http://ahkscript.org/docs/commands/_If.htm

;  Examples:

;  The following hotkey and hotstring will only be active within Notepad

;  #If WinActive("ahk_class Notepad")
; 	#Space::Msgbox, You pressed Win+Spacebar in Notepad

; 	::btw::by the way

;  #If ; turns off context sensitivity
Notify(Settings.ScriptName " is loading AppSpecific.ahk",,Settings.NotificationTimer,"Style=StandardGray")

#If WinActive("ahk_class Notepad++")
#c::
MsgBox, You pressed Win-C while Notepad is active.
return