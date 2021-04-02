# AutoHotkey Boilerplate

A boilerplate to help jumpstart a script for personal productivity

## Goal

- Provide easy access to all the features of AutoHotkey
- Understandable structure for future additions

## Installation

Prerequisite: Install [AutoHotkey](http://ahkscript.org/) from [ahkscript.org](http://ahkscript.org/)

To get these scripts working on your computer, follow these steps:

1. __Install AutoHotKey__<br>
You can [download it here](https://www.autohotkey.com/download/)

2. __Clone this repo__<br>
`git clone https://github.com/Ajhad1/AutoHotkeyScripts.git`

3. __Duplicate the `AutoHotKey.ahk` file to the Documents folder__<br>
When AutoHotKey starts up, it looks for a file named `AutoHotKey.ahk` in your Documents folder.  So duplicate the file by that name, and point it to where you cloned this repo in Step 2.

```AutoHotKey
AutoHotKeyDir := "C:\Users\ajhad\Documents\GitHub\AutoHotkeyScripts"         ; <--- Edit this to point to your path
Run, %A_AhkPath% "%AutoHotKeyDir%\Main.ahk", %AutoHotKeyDir%
```

4. __Set AutoHotKey to run at startup__<br>
Create a shortcut to AutoHotKey (`C:\Program Files\AutoHotkey\AutoHotkey.exe`).  Then open the Windows Run utility (<kbd>Win</kbd>+<kbd>R</kbd>) and type `shell:startup` to open your Startup folder.  Then paste the AutoHotKey shortcut in this folder.

## Usage

1. Edit `Settings.ini` as needed
2. Run `Main.ahk`

## Structure

    .
    |-- Main.ahk
    |-- Settings.ini
    |-- Scripts\
    |   |-- AppSpecific.ahk
    |   |-- Functions.ahk
    |   |-- HotStrings.ahk
    |   `-- Hotkeys.ahk
    |-- Lib\
    `-- Util\

## Customization

### Hotkeys.ahk

Universal shortcuts

```ahk
; Ctrl+Alt+R to reload entire script
^!r::Reload
```

[Hotkey Docs](http://ahkscript.org/docs/Hotkeys.htm)

### Hotstrings.ahk

Auto-expanding Hotstrings are stored here

```ahk
; Single Line
::btw::by the way

; Multi-Line
::btw::
    MsgBox You typed "btw".
Return
```

[Hotstrings Docs](http://ahkscript.org/docs/Hotstrings.htm)

### Functions.ahk

Re-usable functions, automatically loaded by Main.ahk

```ahk
 Add(x, y)
 {
     return x + y
 }
 ```

 [Function Docs](http://ahkscript.org/docs/Functions.htm)

### AppSpecific.ahk

This file is organizing application specific shortcut or hotstrings. This is achieved using [#If](https://www.autohotkey.com/docs/commands/_If.htm) or [#IfWin directives](https://www.autohotkey.com/docs/commands/_IfWinActive.htm)

```ahk
; Control+Click selection in Notepad++ only
#IfWinActive ahk_class Notepad++
	^LButton::
		Send {LButton 2}
		Return
#IfWinActive
```
