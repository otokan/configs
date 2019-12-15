nextRow := 0
global previousSlot := 1
global currentSlot := 1


#IfWinActive, ahk_class GLFW30

$1::
	Slot(1)
return
$2::
	Slot(2)
return
$3::
	Slot(3)
return
$4::
	Slot(4)
return
$5::
	Slot(5)
return
$6::
	Slot(6)
return
$7::
	Slot(7)
return
$8::
	Slot(8)
return
$9::
	Slot(9)
return

$WheelDown::
	Slot( Mod(currentSlot + 1, 10) )
return

$WheelUp::
	Slot( Mod(currentSlot - 1, 10) )
return

F9::
	Slot(previousSlot)
return

Slot(slot) {
	Send % slot
	previousSlot := currentSlot
	currentSlot := slot
}
; ctrl alt r
^!r::
	SendInput {Ctrl Down}s{Ctrl Up}
	Reload
return







; hold left button
	LButton::
		SendInput, {LButton Down}
		Sleep, 200 ; Let the user let up the mouse button
		Keywait, LButton, D
		SendInput,{LButton Up}
	return
	F1::Hotkey, $LButton, toggle


; hold right button
	RButton::
		SendInput, {RButton Down}
		Sleep, 200 ; Let the user let up the mouse button
		Keywait, RButton, D
		SendInput,{RButton Up}
	return
	F2::Hotkey, $RButton, toggle

;; place torch
	`::
	SendInput, 9
	Sleep, 200
	SendInput {RButton}
	Sleep, 200
	SendInput, 1
return
		r::
	SendInput 7
	SendInput {Esc}
	SendInput 7
return


	CapsLock::
		SendInput e
		Sleep, 75
		MouseMove % 956, 570 + ( nextRow * 40 ), 0
		SendInput 1{Esc}1
		;SendInput {Esc}
		;SendInput 1
		nextRow := nextRow + 1
		nextRow := Mod( nextRow, 3 )
return

Hotkey, $RButton, toggle
Hotkey, $LButton, toggle

;Esc::ExitApp ; Emergency exit
