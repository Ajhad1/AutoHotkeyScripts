#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinActivate, ahk_class wxWindowNR ahk_exe googledrivesync.exe
WinWait, ahk_class wxWindowNR ahk_exe googledrivesync.exe,, 3
if WinExist(["ahk_class wxWindowNR ahk_exe googledrivesync.exe"]) {
    Send, Settings, {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
    Sleep, 1000
    if WinExist(["ahk_class wxWindowNR ahk_exe googledrivesync.exe", "Resume"]) {
        Send, "Resume", {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
        Sleep, 250
        WinClose, ahk_class wxWindowNR ahk_exe googledrivesync.exe
    }
}

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
    ; return exec.StdOut
}

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; Open cmd.exe with echoing of commands disabled
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; Send the commands to execute, separated by newline
    exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
    ; Read and return the output of all commands
    return exec.StdOut.ReadAll()
}