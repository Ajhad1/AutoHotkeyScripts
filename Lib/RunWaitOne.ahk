; Reference/Created By:
;       Unknown
;       https://www.autohotkey.com/docs/commands/Run.htm#StdOut

; Func: RunWaitOne
;       run a command and retrieve its output

; Parameters:
;       Command        - Command to be run and its output returned. 

; Returns:
;       Output from running command.

; Examples:
;       > MsgBox % RunWaitOne("dir " A_ScriptDir)
;       *Output:*
;       > Dir Contents

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}