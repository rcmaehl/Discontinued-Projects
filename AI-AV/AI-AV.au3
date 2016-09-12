#NoTrayIcon
#include <GUIConstantsEx.au3>

Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 000)
Global $Msg
Global $AIAV, $List, $Scan, $Drives, $Thread[1]
GUI()

Func GUI()
	$AIAV = GUICreate("AI-AV", 320, 200,  -1,  -1, 0x00CA0080)
	$List = GUICtrlCreateCombo(""     , 010, 030, 080, 020, 0x00000003)
	$Scan = GUICtrlCreateButton("Scan", 100, 030, 200, 020)

	For $Loop = 65 To 90 Step 1
		If Not DriveGetType(Chr($Loop) & ":\") = "" Then
			$Drives = $Drives & "|" & Chr($Loop) & ":"
		EndIf
	Next
	GUICtrlSetData($List, $Drives, StringTrimLeft(StringLeft($Drives, 3), 1))
	GUISetState()

	While 1
		$Msg = GUIGetMsg()
		Select

			Case $Msg = $GUI_EVENT_CLOSE
				Exit(0)

			Case StdoutRead($Thread[0]) = "True"
				MsgBox(0x0, "True", "Yes")

			Case $Msg = $Scan
				$Thread[0] = Run("scanner.exe " & GUICtrlRead($List) & " " & "\autorun.inf", "", @SW_HIDE, 0x2)

		EndSelect
	WEnd
EndFunc