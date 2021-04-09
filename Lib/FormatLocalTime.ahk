; Reference/Created By:
;       @Alejandro Colon
;       https://github.com/Ajhad1/AutoHotkeyScripts

; Func: FormatLocalTime
;     Format Time based on a custom time string

; Parameters: None

; Returns:
;     On success the current time using the set time string, otherwise an empty string.

; Examples:
;     > value := FormatLocalTime()
;     > MsgBox %value%
;     *Output:*
;     > 2021/04/29 10:10:03

FormatTime, localTime,,yyyy/MM/dd HH:mm:ss
    return localTime