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
; F11 : Toggles automatic pasting of FPM stats to clipboard (default: disabled)
; F10 : Blocks Numpad Enter keypress (default: not blocked)
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
blocknumpadenter := 0


SetTimer,checkForWindowChange,500
Return
;-------------------------------------------------------------------------
F12::
	ExitApp
	Return
F11::
	autopastemode := !autopastemode
	if (autopastemode)
		showactiontip("Automatic pasting to clipboard activated")
	else
		showactiontip("Automatic pasting to clipboard disabled")
	Return
F10::
	blocknumpadenter := !blocknumpadenter
	if (blocknumpadenter)
		showactiontip("Numpad ENTER key has been disabled.")
	else
		showactiontip("Numpad ENTER key can now be used again.")
	Return
	
	
$NumpadEnter::
	If ((!getgamewindow()) || (!blocknumpadenter))
	{
		Send,{NumpadEnter}
		Return
	}
	showactiontip("Numpad ENTER was blocked. Push F10 to reenable it.")
	Return
	
$Numpad0::
	numpressed := 0
	Goto numpadcollect
$Numpad1::
	numpressed := 1
	Goto numpadcollect
$Numpad2::
	numpressed := 2
	Goto numpadcollect
$Numpad3::
	numpressed := 3
	Goto numpadcollect
$Numpad4::
	numpressed := 4
	Goto numpadcollect
$Numpad5::
	numpressed := 5
	Goto numpadcollect
$Numpad6::
	numpressed := 6
	Goto numpadcollect
$Numpad7::
	numpressed := 7
	Goto numpadcollect
$Numpad8::
	numpressed := 8
	Goto numpadcollect
$Numpad9::
	numpressed := 9
numpadcollect:
	If (!getgamewindow())
	{
		k := "Numpad" numpressed
		Send,{%k%}
		Return
	}
	curnum := (curnum * 10) + numpressed
	digitindex++
	updatetooltip()
	showactiontip("Current numeric input [" curnum "]")
	Return
	
$NumpadAdd::
	If (!getgamewindow())
	{
		Send {NumpadAdd}
		Return
	}
	pidx := numindex - 1
	if (numindex)
		pnum := numarr%pidx%
	else 
		pnum := 0
	if (curnum<pnum)
	{
		showactiontip("Input fame less than previous fame. Addition rejected")
		Return
	}
	Critical,On
	if (!numindex)
	{
		timearr0 := A_Now
		numarr0 := curnum
	}
	numindex++
	timearr%numindex% := A_Now
	numarr%numindex% := curnum
	Critical,Off
	showactiontip("Number index [" numindex "] added, fame set to [" curnum "].")
	curnum = 0
	updatetooltip()
	Return
	
$NumpadDot::
	If (!getgamewindow())
	{
		Send {NumpadDot}
		Return
	}
	if (digitindex>0) {
		digitindex--
		curnum /= 10
	}
	showactiontip("Current numeric input [" curnum "]")
	Return
	
$NumpadSub::
	If (!getgamewindow())
	{
		Send {NumpadSub}
		Return
	}
	if (numindex>0)
		numindex--
	showactiontip("Number index [" numindex+1 "] removed, fame set to [" curnum "].")
	updatetooltip()

	
	
;-------------------------------------------------------------------------

checkForWindowChange:
	updatetooltip()
	Return
	
removeActionTooltip:
	ToolTip,,,,20
	Return
	
;-------------------------------------------------------------------------
showactiontip(s)
{
	ToolTip,%s%,0,22,20
	SetTimer,removeActionTooltip,-2000
	Return
}
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
	if (!getgamewindow()) {
		ToolTip
		Return
	}
	if (!numindex)
	{
		ToolTip,Initial number input: %curnum%,0,0
		Return
	}
	
	a := numindex
	b := a-1
	cnum := numarr%a%
	ctime := timearr%a%
	pnum := numarr%b%
	ptime := timearr%b%
	
	tc := ctime
	EnvSub,tc,ptime,Seconds
	stc := Round(((cnum-pnum)/(tc/60)),1)
	
	tt := ctime
	EnvSub,tt,timearr0,Seconds
	stt := Round(((cnum-numarr0)/(tt/60)),1)
	
	ToolTip,Fame prev [%pnum%]`, cur [%cnum%]`, fpm [%stc%]`, fpm total [%stt%],0,0
	
	if (autopastemode)
	{
		tcm := Round((tc/60),3)
		clipboard := "Time interval [" tcm "m], fpm interval [" stc "], fpm total [" stt "]"
	}
}
;-------------------------------------------------------------------------






