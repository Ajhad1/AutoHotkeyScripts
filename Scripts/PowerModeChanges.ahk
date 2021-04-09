; Reference/Created By:
;       @Alejandro Colon
;       https://github.com/Ajhad1/AutoHotkeyScripts

OutputDebug, % DebugIntro() A_ScriptName " starting --------------------"
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Ignore ; If already running do nothing
#WinActivateForce
DetectHiddenWindows, On
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
OutputDebug, % DebugIntro() "Env Setup"

IniRead, prevRun, %A_ScriptDir%\Vars.ini, Vars, prevRun, 1 ; prevRun is the previous run status where 0 is unplugged and 1 is plugged in

OutputDebug, % DebugIntro() "Getting Plugged Status"
acLineStatus := GetPluggedStatus()
; VarSetCapacity(powerstatus, 1+1+1+1+4+4)
; success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

; acLineStatus:=ReadInteger(&powerstatus,0,1,false)
; if (acLineStatus != 0 and acLineStatus != 1)
; 	acLineStatus := 0

if (acLineStatus = 0 and prevRun = 1) {
	OutputDebug, % DebugIntro() "Computer is not plugged in"
	OutputDebug, % DebugIntro() "Changing Resolution"
    ChangeResolution(32,1920,1080,60)
	OutputDebug, % DebugIntro() "Turning off Bluetooth"
	Run, PowerShell.exe -ExecutionPolicy Bypass -Command "./bluetooth.ps1 -BluetoothStatus Off",, "Hide" ; https://superuser.com/questions/1494499/modify-a-powershell-that-receive-argument-on-off-to-start-stop-service-to-a-scri
	OutputDebug, % DebugIntro() "Stopping Executables"
	OutputDebug, % DebugIntro() "--------------------"
	OutputDebug, % DebugIntro() "Stopping PLTHub.exe"
	Process, Close, PLTHub.exe
	GroupAdd, PLTHub, ahk_exe PLTHub.exe
	WinKill, ahk_group PLTHub
	OutputDebug, % DebugIntro() "Stopping SpokesUpdateService.exe"
	Process, Close, SpokesUpdateService.exe
	OutputDebug, % DebugIntro() "Stopping VirtualDesktop.Service.exe"
	Process, Close, VirtualDesktop.Service.exe
	OutputDebug, % DebugIntro() "Stopping XboxAppServices.exe"
	Process, Close, XboxAppServices.exe
	OutputDebug, % DebugIntro() "Stopping OriginThinSetupInternal.exe"
	Process, Close, OriginThinSetupInternal.exe
	OutputDebug, % DebugIntro() "Stopping OriginWebHelperService.exe"
	Process, Close, OriginWebHelperService.exe
	OutputDebug, % DebugIntro() "Stopping OVRServer_x64.exe"
	Process, Close, OVRServer_x64.exe
	OutputDebug, % DebugIntro() "Stopping OVRRedir.exe"
	Process, Close, OVRRedir.exe
	OutputDebug, % DebugIntro() "Stopping OVRServiceLauncher.exe"
	Process, Close, OVRServiceLauncher.exe
	OutputDebug, % DebugIntro() "Stopping MsMpEng.exe"
	Process, Close, MsMpEng.exe
	OutputDebug, % DebugIntro() "--------------------"
	if !(acLineStatus = prevRun) {
		OutputDebug, % DebugIntro() "Starting GoogleDrivePauseToggle()"
		GoogleDrivePauseToggle()
	}
	OutputDebug, % DebugIntro() "Getting Defender Disabled Status"
	; https://docs.microsoft.com/en-us/powershell/module/defender/get-mppreference?view=windowsserver2019-ps
	defenderStatus := % RunWaitMany("
		(
    	PowerShell.exe -ExecutionPolicy Bypass -Command $Preferences = Get-MpPreference; $Preferences.DisableRealtimeMonitoring 
    	)") 
	OutputDebug, % DebugIntro() "Defender Disabled Status is " defenderStatus
	if defenderStatus contains False
		OutputDebug, % DebugIntro() "Turning off Defender"
	if defenderStatus contains False
		Run, *RunAs powershell.exe -ExecutionPolicy Bypass -command "Set-MpPreference -DisableRealtimeMonitoring $true" ; https://docs.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=windowsserver2019-ps
	if WinExist("ahk_group PLTHub")
		OutputDebug, % DebugIntro() "Waiting on Plantronics Hub to close"
	WinWaitClose, ahk_group PLTHub
} else if (acLineStatus = 1 and prevRun = 0) {
	OutputDebug, % DebugIntro() "Computer is plugged in"
	PLTHubCreated := False
	if !ProcessExist("PLTHub.exe") {
		OutputDebug, % DebugIntro() "Starting Plantronics Hub"
		Run, C:\Program Files (x86)\Plantronics\Spokes3G\PLTHub.exe,, "Hide"
		PLTHubCreated := True
	}
	OutputDebug, % DebugIntro() "Changing Resolution"
	ChangeResolution(32,1920,1080,240)
	OutputDebug, % DebugIntro() "Turning on Bluetooth"
	Run, PowerShell.exe -ExecutionPolicy Bypass -Command "./bluetooth.ps1 -BluetoothStatus On",, "Hide" ; https://superuser.com/questions/1494499/modify-a-powershell-that-receive-argument-on-off-to-start-stop-service-to-a-scri
	if (PLTHubCreated) {
		OutputDebug, % DebugIntro() "Waiting on Plantronics Hub"
		WinWait, ahk_exe PLTHub.exe
		PostMessage, 0x0112, 0xF060,,, ahk_exe PLTHub.exe
	}
	if !(acLineStatus = prevRun) {
		OutputDebug, % DebugIntro() "Starting GoogleDrivePauseToggle()"
		GoogleDrivePauseToggle()
	}
	OutputDebug, % DebugIntro() "Getting Defender Disabled Status"
	; https://docs.microsoft.com/en-us/powershell/module/defender/get-mppreference?view=windowsserver2019-ps
	defenderStatus := % RunWaitMany("
		(
    	PowerShell.exe -ExecutionPolicy Bypass -Command $Preferences = Get-MpPreference; $Preferences.DisableRealtimeMonitoring
    	)")
	OutputDebug, % DebugIntro() "Defender Disabled Status is " defenderStatus
	if defenderStatus contains True 
		OutputDebug, % DebugIntro() "Turning on Defender"
	if defenderStatus contains True 
		Run, *RunAs powershell.exe -ExecutionPolicy Bypass -command "Set-MpPreference -DisableRealtimeMonitoring $false",, "Min" ; https://docs.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=windowsserver2019-ps
}
OutputDebug, % DebugIntro() A_ScriptName " completed --------------------"
IniWrite, prevRun=%acLineStatus%, %A_ScriptDir%\Vars.ini, Vars
ExitApp
	
ChangeResolution( cD, sW, sH, rR ) { ; https://www.tcg.com/blog/quickly-change-windows-10-resolution-with-autohotkey/
	VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36)
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM ),
	NumPut(0x5c0000,dM,40)
	NumPut(cD,dM,104), NumPut(sW,dM,108), NumPut(sH,dM,112), NumPut(rR,dM,120)
	Return DllCall( "ChangeDisplaySettingsA", UInt,&dM, UInt,0 )
}

GetPluggedStatus() { ; https://autohotkey.com/board/topic/7022-acbattery-status/
	VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

	acLineStatusTemp:=ReadInteger(&powerstatus,0,1,false)
	if (acLineStatusTemp != 0 and acLineStatusTemp != 1)
		acLineStatusTemp := 0
	
	return % acLineStatusTemp
}

ReadInteger( p_address, p_offset, p_size, p_hex=true ) { ; https://www.tcg.com/blog/quickly-change-windows-10-resolution-with-autohotkey/
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

; RunWaitOne(command) { ; https://www.autohotkey.com/docs/commands/Run.htm#StdOut
;     ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
;     shell := ComObjCreate("WScript.Shell")
;     ; Execute a single command via cmd.exe
;     exec := shell.Exec(ComSpec " /C " command)
;     ; Read and return the command's output
;     return exec.StdOut.ReadAll()
; }

; RunWaitMany(commands) { ; https://www.autohotkey.com/docs/commands/Run.htm#StdOut
;     shell := ComObjCreate("WScript.Shell")
;     ; Open cmd.exe with echoing of commands disabled
;     exec := shell.Exec(ComSpec " /Q /K echo off")
;     ; Send the commands to execute, separated by newline
;     exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
;     ; Read and return the output of all commands
;     return exec.StdOut.ReadAll()
; }

; ProcessExist(Name){
; 	Process,Exist,%Name%
; 	return Errorlevel
; }

GoogleDrivePauseToggle() {
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
		WinActivate, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
		WinWaitActive, Backup and Sync ahk_class wxWindowNR ahk_exe googledrivesync.exe
		OutputDebug, % DebugIntro() "Google Drive is sending enter to settings button"
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
}

; DebugIntro() ; Returns Debug Intro which includes Local Time and Script name
; {
; 	return % (FormatLocalTime() "=> " A_ScriptName ": ")
; }

; FormatLocalTime() ; Returns current time as local time
; {
;     FormatTime, localTime,,MM/dd/yyyy HH:mm:ss
;     return localTime
; }