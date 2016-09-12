; Discontinued: Non-sensical program.
#NoTrayIcon
;Coded by FCoFix.org - Robert C. Maehl
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
Global $Rows
Global $X, $Msg
Global $Loop = False
$Y = 10

If $CmdLine[0] = 1 Then
	$Rows = Int($CmdLine[1])
	If $Rows < 2 Then
		$Rows = 2
	EndIf
Else
	$Rows = 2
EndIf

Global $Input[$Rows]
Global $Output[$Rows][8]

HotKeySet("{F1}", "Sample")

GUI()
Func GUI()

	GUICreate("Binary", 400, 20 + $Rows * 20, -1, -1)
	GUISetFont(8, 400, 0, "Courier New")
	$Renew = GUICtrlCreateButton("Update", 335, 10, 55, 20)
	$Clear = GUICtrlCreateButton("Clear", 335, 30, 55, 20)
	GUISetFont(7, 400, 0, "MS Sans Serif")
	GUICtrlSetDefBkColor(0xFFFFFF)
	For $Loop0 = 0 To $Rows - 1 Step 1
		$Input[$Loop0] = GUICtrlCreateInput("00000000", 10, $Y, 55, 20, 0x00002201)
		$X = 100
		For $Loop1 = 0 To 7 Step 1
			$Output[$Loop0][$Loop1] = GUICtrlCreateLabel("", $X, $Y, 20, 20, 0x00001000)
			$X += 25
		Next
		$Y += 20
	Next

	GUISetState()

	While 1
		$Msg = GUIGetMsg()
		Select

			Case $Msg = $GUI_EVENT_CLOSE
				Exit(0)

			Case $Msg = $Renew
				For $Loop2 = 0 To $Rows - 1 Step 1
					If StringLen(GUICtrlRead($Input[$Loop2])) = 8 Then
						For $Loop3 = 0 To 7 Step 1
							If StringRight(StringLeft(GUICtrlRead($Input[$Loop2]), $Loop3 + 1), 1) = "1" Then
								GUICtrlSetBkColor($Output[$Loop2][$Loop3], 0x000000)
							ElseIf StringRight(StringLeft(GUICtrlRead($Input[$Loop2]), $Loop3 + 1), 1) = "0" Then
								GUICtrlSetBkColor($Output[$Loop2][$Loop3], 0xFFFFFF)
							Else
								GUICtrlSetData($Input[$Loop2], "00000000")
							EndIf
						Next
					Else
						GUICtrlSetData($Input[$Loop2], "00000000")
					EndIf
				Next

			Case $Msg = $Clear
				For $Loop4 = 0 To $Rows - 1 Step 1
					For $Loop5 = 0 To 7 Step 1
						GUICtrlSetBkColor($Output[$Loop4][$Loop5], 0xFFFFFF)
					Next
					GUICtrlSetData($Input[$Loop4], "00000000")
				Next

		EndSelect
	WEnd
EndFunc

Func Sample()
	If $Loop Then
		For $Loop2 = 0 To $Rows - 1 Step 1
			GUICtrlSetStyle($Input[$Loop2], 0x00002201)
		Next
	Else
		For $Loop2 = 0 To $Rows - 1 Step 1
			GUICtrlSetStyle($Input[$Loop2], 0x00002A01)
		Next
	EndIf
	$Loop = Not $Loop
	SampleLoop()
EndFunc

Func SampleLoop()
	While $Loop
		For $Loop2 = 0 To $Rows - 1 Step 1
			GUICtrlSetData($Input[$Loop2], Random(0, 1, 1) & Random(0, 1, 1) & Random(0, 1, 1) & Random(0, 1, 1) & _
				Random(0, 1, 1) & Random(0, 1, 1) & Random(0, 1, 1) & Random(0, 1, 1))
			For $Loop3 = 0 To 7 Step 1
				If StringRight(StringLeft(GUICtrlRead($Input[$Loop2]), $Loop3 + 1), 1) = "1" Then
					GUICtrlSetBkColor($Output[$Loop2][$Loop3], 0x000000)
				Else
					GUICtrlSetBkColor($Output[$Loop2][$Loop3], 0xFFFFFF)
				EndIf
			Next
		Next
	WEnd
EndFunc