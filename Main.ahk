#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#WinActivateForce
#SingleInstance force
#Persistent
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include *i %A_ScriptDir%\Scripts\Functions.ahk
#Include %A_ScriptDir%\Util\Init.ahk
#Include %A_ScriptDir%\Util\ParseSettings.ahk
#Include %A_ScriptDir%\Util\TrayMenu.ahk

If (Settings.StartupNotification)
	Notify(Settings.ScriptName " Started",,Settings.NotificationTimer,"Style=StandardGray")

If (Settings.CL3) {
	Run, %A_ScriptDir%\Util\CL3\cl3.ahk
	Notify(Settings.ScriptName " started CL3",,Settings.NotificationTimer,"Style=StandardGray")
}
Else
{
	DetectHiddenWindows, On 
	WinClose, %A_ScriptDir%\Util\CL3\cl3.ahk ahk_class AutoHotkey
}

If (Settings.UseAutoCorrect) {
    Notify(Settings.ScriptName " started AutoCorrect",,Settings.NotificationTimer,"Style=StandardGray")
	Run, %A_ScriptDir%\Util\AutoCorrect.ahk
}
Else
{
	DetectHiddenWindows, On 
	WinClose, %A_ScriptDir%\Util\AutoCorrect.ahk ahk_class AutoHotkey
}

; #Include *i %A_ScriptDir%\Scripts\Hotkeys.ahk
#Include *i %A_ScriptDir%\Scripts\AppSpecific.ahk
#Include *i %A_ScriptDir%\Scripts\HotStrings.ahk

If (Settings.StartupNotification)
	Notify(Settings.ScriptName " Startup Complete",,Settings.NotificationTimer,"Style=StandardGray")

If (Settings.PowerModeChangesOnStartup and Settings.SleepActivate) {
    Notify(Settings.ScriptName " is setting " Settings.SleepTimeMin " minute timer for PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
    ; SleepTime := Settings.SleepTimeMin*60*1000
    ; SetTimer, PowerModeChanges, %SleepTime%
    ; return
} else if (Settings.SleepActivate) {
    Notify(Settings.ScriptName " is setting " Settings.SleepTimeMin " minute timer for PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
    ; SleepTime := Settings.SleepTimeMin*60*1000
    ; SetTimer, PowerModeChanges, %SleepTime%
    return
} else if (Settings.PowerModeChangesOnStartup) {
    Notify(Settings.ScriptName " running PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
    ; RunWait, %A_ScriptDir%\Scripts\PowerModeChanges.ahk
    Notify(Settings.ScriptName " finished PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
}

; PowerModeChanges:
; Notify(Settings.ScriptName " running PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
; RunWait, %A_ScriptDir%\Scripts\PowerModeChanges.ahk
; Notify(Settings.ScriptName " finished PowerModeChanges",,Settings.NotificationTimer,"Style=StandardGray")
; return