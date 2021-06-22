;  Hotkey Documentation: http://ahkscript.org/docs/Hotkeys.htm

;  Examples:

;  #n::Run, Notepad

;  #n::
;     Run, Notepad
;  Return

;  Modifiers:
;    ^ - Ctrl
;    ! - Alt
;    + - Shift
;    # - Win

Notify(Settings.ScriptName " is loading HotKeys.ahk",,Settings.NotificationTimer,"Style=StandardGray")

; Reload entire script
^!+r::Reload  ; Ctrl+Alt+r

; Hibernate computer
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
^!+h::DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)

; Run notepad++
#n::
if WinExist(ahk_class Notepad++) {
    Reload
    WinClose, ahk_class Notepad++
}
else
{
    Run Notepad++
}
return

#If WinActive("ahk_class Notepad++")
#c::
MsgBox, You pressed Win-C while Notepad is active.
return