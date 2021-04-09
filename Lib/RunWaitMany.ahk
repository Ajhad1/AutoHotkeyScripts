; Reference/Created By:
;       Unknown
;       https://www.autohotkey.com/docs/commands/Run.htm#StdOut

; Func: RunWaitMany
;       run multiple commands and retrieve their output

; Parameters:
;       Commands        - Commands to be run and its output returned. 

; Returns:
;       Output from running command.

; Examples:
;       > MsgBox % RunWaitMany("
;       > echo Put your commands here,
;       > echo each one will be run,
;       > echo and you'll get the output.
;       *Output:*
;       > Put your commands here,
;       > each one will be run,
;       > and you'll get the output.

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; Open cmd.exe with echoing of commands disabled
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; Send the commands to execute, separated by newline
    exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
    ; Read and return the output of all commands
    return exec.StdOut.ReadAll()
}