; Fame tracking assistant script
;
; Intercepts numpad keys [0,1,2,3,4,5,6,7,8,9,.,+,-] whenever something titled
; "Realm of the Mad God" or "Adobe Flash Player" is in focus.
;
; Intercepted NUMPAD key functions:
; 0-9 : Digit inputs for current fame
;  .  : Deletes current digit
;  +  : Adds currently input number to fame tracker list
;  -  : Removes previously added number from fame tracker list
;
; Intercepted key functions:
; F12 : Kills/Exits script
; F11 : Toggles automatic pasting of FPM stats to clipboard (default off)
;

#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%
Thread,interrupt,0
#KeyHistory 0
#MaxThreads 255
#MaxMem 4095
#MaxThreadsBuffer On
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
;ListLines Off
;SetBatchLines, -1
Process, Priority, , R
SetTitleMatchMode fast
SetKeyDelay, -1, -1, -1
SetMouseDelay, -1
SetWinDelay, -1
SetControlDelay, -1
#Persistent
;-------------------------------------------------------------------------
numindex := 0
digitindex := 0
curnum := 0
curtime := 0
autopastemode := 0


SetTimer,checkForWindowChange,500
Return
;-------------------------------------------------------------------------
F12::
	ExitApp
	Return
F11::
	autopastemode := !autopastemode
	Return
	
Numpad0::
	numpressed := 0
	Goto numpadcollect
Numpad1::
	numpressed := 1
	Goto numpadcollect
Numpad2::
	numpressed := 2
	Goto numpadcollect
Numpad3::
	numpressed := 3
	Goto numpadcollect
Numpad4::
	numpressed := 4
	Goto numpadcollect
Numpad5::
	numpressed := 5
	Goto numpadcollect
Numpad6::
	numpressed := 6
	Goto numpadcollect
Numpad7::
	numpressed := 7
	Goto numpadcollect
Numpad8::
	numpressed := 8
	Goto numpadcollect
Numpad9::
	numpressed := 9
numpadcollect:
	curnum := (curnum * 10) + numpressed
	updatetooltip()
	Return
	
NumpadAdd::
	
	
	
	
	
	
	
	
	
;-------------------------------------------------------------------------

checkForWindowChange:
	updatetooltip()
	
;-------------------------------------------------------------------------

getgamewindow()
{
	IfWinActive,Adobe Flash Player
		Return 1
		
	IfWinActive,Realm of the Mad God
		Return 1
		
	Return 0
}
;-------------------------------------------------------------------------

updatetooltip()
{
	Global
	if (!getgamewindow())
		ToolTip
		Return
	
	if ((!curnum) && (!numindex))
	{
		ToolTip,Fame Tracker is active but no numbers have been added yet,0,0
		Return
	}
	if (!numindex)
	{
		ToolTip,Initial number input: %curnum%,0,0
		Return
	}
	a := numindex - 1
	s := numarr%a%
	
	tc := curtime
	EnvSub,tc,timearr%a%,Seconds
	tc := Round((tc/60),2)
	
	tt := curtime
	EnvSub,tt,timearr0,Seconds
	tt := Round((tt/60),2)
	
	stc := Round((curnum/tc),1)
	stt := Round((curnum/tt),1)
	
	ToolTip,Fame prev [%s%]`, cur [%curnum%]`, fpm [%stc%]`, fpm total [%stt%],0,0
	if (autopastemode)
	{
		clipboard := "Time interval " tc "m, fpm [" stc "], fpm from start [" stt "]"
	}
}
;-------------------------------------------------------------------------






