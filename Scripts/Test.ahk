#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run, *RunAs powershell.exe -ExecutionPolicy Bypass -command "Set-MpPreference -DisableRealtimeMonitoring $false"
; Run, C:\Program Files\advancedrun-x64\AdvancedRun.exe /EXEFilename "C:\Users\ajhad\Documents\AHKScripts\disable_defender.bat" /RunAs 8 /Run