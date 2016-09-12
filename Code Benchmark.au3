#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 000)
Global $Msg, $Start, $Trials, $Time, $Results[7], $Output[7], $Status, $Reset, $Tests[2], $Cycle[2]

HotKeySet("{F11}", "Pause")

$Status = False

GUI()

Func GUI()
	GUICreate("Template", 420, 200,  -1,  -1, 0x10CA0080)

	$Start = GUICtrlCreateButton("Start", 010, 170, 200, 20)
	$Reset = GUICtrlCreateButton("Reset", 210, 170, 200, 20)

	GUICtrlCreateLabel("Test"     , 210, 010, 100, 020, 0x00000201)
	GUICtrlCreateLabel("Time (ms)", 310, 010, 100, 020, 0x00000201)
	For $X = 1 To 7 Step 1
		GUICtrlCreateLabel("Test " & $X, 210, 010 + $X * 20, 100, 020, 0x00001201)
		$Output[$X - 1] = GUICtrlCreateLabel(""     , 310, 010 + $X * 20, 100, 20, 0x00001201)
	Next
	GUICtrlCreateGroup("Settings" ,    010, 010, 200, 160)
	GUICtrlCreateLabel("Tests:"   ,    020, 030, 050, 020, 0x00001201)
	GUICtrlCreateLabel("Cycles:"  ,    020, 050, 050, 020, 0x00001201)
	$Tests[0] = GUICtrlCreateSlider(   070, 030, 100, 020)
	$Tests[1] = GUICtrlCreateLabel("", 170, 030, 030, 020, 0x00001201)
	$Cycle[0] = GUICtrlCreateSlider(   070, 050, 100, 020)
	$Cycle[1] = GUICtrlCreateLabel("", 170, 050, 030, 020, 0x00001201)
	GUICtrlSetLimit($Tests[0], 0007, 2)
	GUICtrlSetLimit($Cycle[0], 1000, 0)

	While 1
		$Msg = GUIGetMsg()
		Select

			Case $Msg = -3
				Exit(0)

			Case $Msg = $Start
				If $Status Then
					$Status = False
				Else
					$Status = True
				EndIf

			Case $Msg = $Cycle[0]
				If GUICtrlRead($Cycle[0]) = 0 Then
					GUICtrlSetData($Cycle[1], ChrW(8734))
				Else
					GUICtrlSetData($Cycle[1], GUICtrlRead($Cycle[0]))
				EndIf

			Case $Msg = $Tests[0]
				GUICtrlSetData($Tests[1], GUICtrlRead($Tests[0]))
				$Status = False
				$Trials = 0

			Case $Msg = $Reset
				$Trials = 0
				For $X = 1 To 7 Step 1
					$Results[$X - 1] = ""
					GUICtrlSetData($Output[$X - 1], "")
				Next
				GUICtrlSetData($Cycle[0], 1)
				GUICtrlSetData($Cycle[1], 1)

			Case $Status
				Exec()

			Case Else
				;;;

		EndSelect
	WEnd
EndFunc

Func Exec()
	$Trials += 1
	For $X = 1 To GUICtrlRead($Tests[0]) Step 1
		$Time = TimerInit()
		Execute("Test" & $X & "()")
		$Results[$X - 1] = $Results[$X - 1] + TimerDiff($Time)
		GUICtrlSetData($Output[$X - 1], StringLeft($Results[$X - 1] / $Trials, 12))
		Sleep(1)
	Next
	If GUICtrlRead($Cycle[0]) - 1 = 0 Then
		$Status = False
		ConsoleWrite($Trials)
	Else
		GUICtrlSetData($Cycle[0], GUICtrlRead($Cycle[0]) - 1)
		If Not GUICtrlRead($Cycle[0]) = 0 Then
			GUICtrlSetData($Cycle[1], GUICtrlRead($Cycle[0]))
		EndIf
	EndIf
EndFunc

Func Test1()
EndFunc

Func Test2()
EndFunc

Func Test3()
EndFunc

Func Test4()
EndFunc

Func Test5()
EndFunc

Func Test6()
EndFunc

Func Test7()
EndFunc

Func Pause()
	$Status = False
EndFunc