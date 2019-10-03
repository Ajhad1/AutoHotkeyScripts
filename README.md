# AutoHotkey Boilerplate

A boilerplate to help jumpstart a script for personal productivity

## Goal

- Provide easy access to all the features of AutoHotkey
- Understandable structure for future additions

## Installation

Prerequisite: Install [AutoHotkey](http://ahkscript.org/) from [ahkscript.org](http://ahkscript.org/)

Options:

- `git clone https://github.com/denolfe/AutoHotkey-Boilerplate.git`
- Download the repo and unzip
- Fork to your own repo, then clone or download

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
