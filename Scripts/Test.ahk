#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinActivate, ahk_class wxWindowNR ahk_exe googledrivesync.exe
WinWait, ahk_class wxWindowNR ahk_exe googledrivesync.exe
Send, Settings, {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
Sleep, 250
if WinExist(["ahk_class wxWindowNR ahk_exe googledrivesync.exe", "Pause"]) {
    Send, Pause, {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
    Sleep, 250
}
; Send, Settings, {Tab}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
; Send, Settings, {Tab}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
