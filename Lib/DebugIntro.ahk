; Reference/Created By:
;       @Alejandro Colon
;       https://github.com/Ajhad1/AutoHotkeyScripts

; Func: DebugIntro
;     Adds a useful Intro to debug output which includes formatted time and script name.

; Parameters: None

; Returns:
;     On success the formatted time and script name, otherwise an empty string.

; Examples:
;     > value := DebugIntro()
;     > MsgBox %value%
;     *Output:*
;     > 2021/04/29 10:10:03 => PowerModeChanges.ahk: 

return % (FormatLocalTime() " => " A_ScriptName ": ")