;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 一键打包
; 
; gaochao.morgen@gmail.com
; 2016/12/09
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
#SingleInstance force
#NoEnv

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                     用户需更改                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Config := {}
Config.AppName     := "CmdMarkdownBackup"
Config.AppIcon     := A_ScriptDir . "\source\resources\Cmd.ico"
Config.LoaderIcon  := A_ScriptDir . "\source\resources\Loader.ico"
Config.WinRarPath  := "C:\Program Files\WinRAR"
Config.Ahk2ExePath := "C:\Program Files\AutoHotkey\Compiler"

for key, value in Config
{
	if (key = "AppName")
		continue

	IfNotExist, %value%
	{
		MsgBox, %key% 不存在，当前值为 %value%
		ExitApp
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                       环境变量                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetWorkingDir, %A_ScriptDir%\source\

WinRarPath := Config["WinRarPath"]
Ahk2ExePath := Config["Ahk2ExePath"]
EnvGet, Paths, PATH
EnvSet, PATH, %WinRarPath%`;%Ahk2ExePath%`;%Paths%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                       打包流程                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 将应用程序由ahk编译为exe
Loop, %A_ScriptDir%\scripts\*.ahk
{
	StringReplace, ExeName, A_LoopFileFullPath, .ahk, .exe

	CompileCmd := "Ahk2Exe.exe"
	CompileCmd .= " /in "
	CompileCmd .= A_LoopFileFullPath
	CompileCmd .= " /out "
	CompileCmd .= ExeName
	CompileCmd .= " /icon "
	CompileCmd .= Config["AppIcon"]

	; MsgBox, %CompileCmd%
	RunWait, cmd /c %CompileCmd%,, Hide
}

; 将Loader.ahk编译为Loader.exe
Loop, %A_ScriptDir%\Loader.ahk
{
	StringReplace, ExeName, A_LoopFileFullPath, .ahk, .exe

	CompileCmd := "Ahk2Exe.exe"
	CompileCmd .= " /in "
	CompileCmd .= A_LoopFileFullPath
	CompileCmd .= " /out "
	CompileCmd .= ExeName
	CompileCmd .= " /icon "
	CompileCmd .= Config["LoaderIcon"]

	; MsgBox, %CompileCmd%
	RunWait, cmd /c %CompileCmd%,, Hide
}

; 一键打包
AppName := Config["AppName"]
if A_Is64bitOS
	AppName .= "-x64.exe"
else
	AppName .= "-x86.exe"

PackageCmd := "WinRAR a -r -sfx "	; WinRAR SFX
PackageCmd .= "-x*.ahk "			; Exclude *.ahk
PackageCmd .= "-z..\conf\xfs.conf "	; WinRAR config file
PackageCmd .= "-iicon"				; Icon
PackageCmd .= Config["AppIcon"]
PackageCmd .= " ..\release\"		; Output
PackageCmd .= AppName
PackageCmd .= " *"					; Source files

; MsgBox, %PackageCmd%
RunWait, cmd /c %PackageCmd%,, Hide

MsgBox, 打包完成，应用程序位于release目录

ExitApp

