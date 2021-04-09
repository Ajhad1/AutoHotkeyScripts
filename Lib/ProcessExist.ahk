; Reference/Created By:
;       @Menixator
;       https://autohotkey.com/board/topic/98317-if-process-exist-command/?p=618948

; Func: ProcessExist
;       Checks whether the specified process is present and returns ErrorLevel

; Parameters:
;       Name        - Name of the process. If the PIDOrName parameter is blank, 
;                     the script's own PID is retrieved.

; Returns:
;       Sets ErrorLevel to the Process ID (PID) if a matching process exists, or 0 otherwise and returns it.

; Examples:
;       > if (ProcessExist("PLTHub.exe"))
;       >     MsgBox Process Exists
;       *Output:*
;       > Process Exists

ProcessExist(Name) {
    Process,Exist,%Name%
    return Errorlevel
}
