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
; test := TrayIcon_GetInfo()
; Loop, % test.MaxIndex()
;     str1 .= test[A_Index].place " - " test[A_Index].idx " - " test[A_Index].process " - " test[A_Index].hwnd " - " test[A_Index].idcmd "`n"
; MsgBox, %str1%

OutputDebug, % DebugIntro() "Google Drive window exists"
if !WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
	OutputDebug, % DebugIntro() "Google Drive is not running"
	OutputDebug, % DebugIntro() "Google Drive is trying to start"
	RunWait, C:\Program Files\Google\Drive\googledrivesync.exe
	OutputDebug, % DebugIntro() "Google Drive started"
} else {
	OutputDebug, % DebugIntro() "Google Drive is running"
}
if WinExist("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
	OutputDebug, % DebugIntro() "Google Drive window exists"
	OutputDebug, % DebugIntro() "Google Drive activating window"
	; WinActivate, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
	TrayIcon_Button("googledrivesync.exe","R")
	TrayIcon_Button("googledrivesync.exe","R")
	TrayIcon_Button("googledrivesync.exe","R")
	OutputDebug, % DebugIntro() "Google Drive waiting for window to exist"
	WinWaitActive, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe, 5
	if !WinActive("Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe") {
		WinRestore, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
		; WinActivate, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
		TrayIcon_Button("googledrivesync.exe","R")
		TrayIcon_Button("googledrivesync.exe","R")
		TrayIcon_Button("googledrivesync.exe","R")
	}
	OutputDebug, % DebugIntro() "Google Drive is sending enter to settings button"
	Sleep 250
	Send, {Enter}
	Sleep, 250
	OutputDebug, % DebugIntro() "Google Drive is sending {Down 4}{Enter} to settings menu"
	Send, {Down 4}{Enter}
	Sleep, 1000
	if WinExist("ahk_class #32768 ahk_exe googledrivesync.exe") {
		OutputDebug, % DebugIntro() "Attempting to close Google Drive Settings Windows"
		WinMinimize, ahk_class #32768 ahk_exe googledrivesync.exe
		WinRestore, ahk_class #32768 ahk_exe googledrivesync.exe
	}
} else {
	OutputDebug, % DebugIntro() "Google Drive script failed"
}
WinClose, Google Drive ahk_class CabinetWClass ahk_exe Explorer.EXE
OutputDebug, % FormatLocalTime() ":`t" A_ScriptName ": Google Drive script is completed"