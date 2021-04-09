; Reference/Created By:
;       @Alejandro Colon
;       https://github.com/Ajhad1/AutoHotkeyScripts

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
#WinActivateForce
DetectHiddenWindows, On
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Pausing Google Drive ---------------------------------------"
GoogleDrive("Pause")
OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive Paused ----------------------------------------"

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

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}

FormatLocalTime()  ; Returns current time as local time
{
    FormatTime, localTime,,MM/dd/yyyy HH:mm:ss
    return localTime
}

GoogleDrive(statusVar) {
	if (statusVar != "Resume" and statusVar != "Pause") {
		OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Value provided to GoogleDrive function invalid"
	} else {
		if !WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is not running"
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is trying to start"
			RunWait, C:\Program Files\Google\Drive\googledrivesync.exe
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive started"
		} else {
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is running"
		}
		if WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive window exists"
			WinActivate, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
			WinWaitActive, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is sending enter to settings button"
			Send, {Enter}
			Sleep, 250
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is sending {Down 4}{Enter} to settings menu"
            Send, {Down 4}{Enter}
            Sleep, 1000
            if WinExist("ahk_class #32768 ahk_exe googledrivesync.exe") {
				OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Attempting to close Google Drive Settings Windows"
				WinMinimize, ahk_class #32768 ahk_exe googledrivesync.exe
				WinRestore, ahk_class #32768 ahk_exe googledrivesync.exe
			}
            ; OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is waiting for settings menu"
            ; WinWait, ahk_class #32768 ahk_exe googledrivesync.exe, %statusVar%
			; if WinExist("ahk_class #32768 ahk_exe googledrivesync.exe", statusVar) {
			; 	OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive " statusVar " button exists"
			; 	OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive is sending enter to " statusVar " button"
			; 	Sleep, 250
            ;     Send, statusVar, {Enter}, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
			; 	Sleep, 250
			; 	if WinExist("ahk_class #32768 ahk_exe googledrivesync.exe") {
			; 		OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Attempting to close Google Drive Settings Windows"
			; 		WinMinimize
			; 		WinRestore
			; 	}
			; 	if WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
			; 		OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Attempting to close Google Drive Main Windows"
			; 		; WinMinimize
			; 		; WinRestore
			; 	}
			; } else {
			; 	OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive " statusVar " button does not exist"
			; 	if WinExist("ahk_class #32768 ahk_exe googledrivesync.exe") {
			; 		OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Attempting to close Google Drive Settings Windows"
			; 		WinMinimize
			; 		WinRestore
			; 	}
			; 	if WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
			; 		OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Attempting to close Google Drive Main Windows"
			; 		; WinMinimize
			; 		; WinRestore
			; 	}
			; }
		} else {
			OutputDebug, % FormatLocalTime() ": " A_ScriptName ": Google Drive script failed"
		}
		WinClose, Google Drive ahk_class CabinetWClass ahk_exe Explorer.EXE
		OutputDebug, % FormatLocalTime() ":`t" A_ScriptName ": Google Drive script is completed"
	}
}