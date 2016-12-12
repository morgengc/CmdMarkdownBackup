;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 启动scripts里面的程序
; 
; gaochao.morgen@gmail.com
; 2016/12/09
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
#SingleInstance force
#NoEnv
#NoTrayIcon

SetTitleMatchMode 2     ; 避免需要指定如下所示的文件的完整路径
SetWorkingDir %A_ScriptDir%\scripts\

EnvGet, Paths, PATH
EnvSet, PATH, %A_ScriptDir%\3rd`;%Paths%	; 设置环境变量

; 遍历scripts目录下的exe文件，但只运行第一个
Loop, %A_ScriptDir%\scripts\*.exe
{
	RunWait, %A_LoopFileName%

	ExitApp
}

ExitApp
