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
TrayIcon_Button("PLTHub.exe")
Sleep, 250
Send, {Tab}
Sleep, 250
Send, {Up}
Sleep, 250
Send, {Enter}
; Sleep, 250
; Send, {Down}