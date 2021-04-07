#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; https://autohotkey.com/board/topic/7022-acbattery-status/
; https://www.tcg.com/blog/quickly-change-windows-10-resolution-with-autohotkey/
; https://docs.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=windowsserver2019-ps
; https://docs.microsoft.com/en-us/powershell/module/defender/get-mppreference?view=windowsserver2019-ps
; https://superuser.com/questions/1494499/modify-a-powershell-that-receive-argument-on-off-to-start-stop-service-to-a-scri

VarSetCapacity(powerstatus, 1+1+1+1+4+4)
success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

acLineStatus:=ReadInteger(&powerstatus,0,1,false)

if (acLineStatus = 0) {
    ChangeResolution(32,1920,1080,60)
	Run, PowerShell.exe -ExecutionPolicy Bypass -Command "./bluetooth.ps1 -BluetoothStatus Off",, "Hide"
	Process, Close, PLTHub.exe
	Process, Close, VirtualDesktop.Service.exe
	Process, Close, XboxAppServices.exe
	Process, Close, OriginThinSetupInternal.exe
	Process, Close, OriginWebHelperService.exe
	Process, Close, OVRServer_x64.exe
	Process, Close, OVRRedir.exe
	Process, Close, OVRServiceLauncher.exe
	Process, Close, MsMpEng.exe
	WinActivate, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	WinWait, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	Send, Settings, {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	Sleep, 250
	if WinExist(["ahk_class wxWindowNR ahk_exe googledrivesync.exe", "Pause"]) {
		Send, "Pause", {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
		Sleep, 250
	}
	defenderStatus := % RunWaitMany("
		(
    	PowerShell.exe -ExecutionPolicy Bypass -Command $Preferences = Get-MpPreference; $Preferences.DisableRealtimeMonitoring
    	)")
	if defenderstatus contains False
		Run, *RunAs powershell.exe -ExecutionPolicy Bypass -command "Set-MpPreference -DisableRealtimeMonitoring $true"
} else {
	Run, C:\Program Files (x86)\Plantronics\Spokes3G\PLTHub.exe
	ChangeResolution(32,1920,1080,240)
	Run, PowerShell.exe -ExecutionPolicy Bypass -Command "./bluetooth.ps1 -BluetoothStatus On",, "Hide"
	WinWait, ahk_exe PLTHub.exe
	PostMessage, 0x0112, 0xF060,,, ahk_exe PLTHub.exe
	WinActivate, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	WinWait, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	Send, Settings, {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
	Sleep, 250
	if WinExist(["ahk_class wxWindowNR ahk_exe googledrivesync.exe", "Resume"]) {
		Send, "Resume", {Enter}, ahk_class wxWindowNR ahk_exe googledrivesync.exe
		Sleep, 250
	}
	defenderStatus := % RunWaitMany("
		(
    	PowerShell.exe -ExecutionPolicy Bypass -Command $Preferences = Get-MpPreference; $Preferences.DisableRealtimeMonitoring
    	)")
	if defenderstatus contains True
		Run, *RunAs powershell.exe -ExecutionPolicy Bypass -command "Set-MpPreference -DisableRealtimeMonitoring $false",, "Min"
}
ExitApp
	
ChangeResolution( cD, sW, sH, rR ) {
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36)
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM ),
	NumPut(0x5c0000,dM,40)
	NumPut(cD,dM,104), NumPut(sW,dM,108), NumPut(sH,dM,112), NumPut(rR,dM,120)
	Return DllCall( "ChangeDisplaySettingsA", UInt,&dM, UInt,0 )
}

ReadInteger( p_address, p_offset, p_size, p_hex=true ) {
	value = 0
	old_FormatInteger := a_FormatInteger
	if ( p_hex )
		SetFormat, integer, hex
	else
		SetFormat, integer, dec
	loop, %p_size%
		value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
	SetFormat, integer, %old_FormatInteger%
	return, value
}

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
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