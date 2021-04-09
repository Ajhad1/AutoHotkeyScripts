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
^!r::Reload
