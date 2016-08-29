; Discontinued: Updated WineBridge.au3 incompletely without updated WineBridge_Terminal. Not even sure if working.

#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WineBridge.au3>
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 000)
Global $Msg, $STDIN, $STDOUT

GUI()


Func GUI()
	GUICreate("WineBridge Terminal", 600, 400,  -1,  -1, 0x10C60080)
	GUISetFont(8, 500, 0, "Courier New")
	$STDIN = GUICtrlCreateInput("", 000, 380, 600, 020, 0x00800100)
	$STDOUT = GUICtrlCreateEdit("", 000, 000, 600, 380, 0x00800B04, 0x00020000)
	GUICtrlSetBkColor($STDOUT, 0x000000)
	GUICtrlSetBkColor($STDIN, 0x000000)
	GUICtrlSetColor($STDOUT, 0xFFFFFF)
	GUICtrlSetColor($STDIN, 0xFFFFFF)
	GUICtrlSetResizing($STDOUT, 98)
	GUICtrlSetResizing($STDIN, 576)

	While 1
		$Msg = GUIGetMsg()
		WB_STDOUT()
		Select

			Case $Msg = -3
				Exit(0)

			Case $Msg = $STDIN
				If Not Excluded() Then
					GUICtrlSetState($STDIN, $GUI_DISABLE)
					WB_STDIN(GUICtrlRead($STDIN))
					GUICtrlSetData($STDIN, "Running: " & GUICtrlRead($STDIN))
				Else
					GUICtrlSetData($STDIN, "")
				EndIf

			Case Not $WB_STDOUT = ""
				GUICtrlSetData($STDOUT, GUICtrlRead($STDOUT) & $WB_STDOUT)
				GUICtrlSetData($STDIN, "")
				GUICtrlSetState($STDIN, $GUI_ENABLE+$GUI_FOCUS)
				$WB_STDOUT = ""

			Case Else
				;;;

		EndSelect
	WEnd
EndFunc

Func Excluded()
	If GUICtrlRead($STDIN) = "/clear" Or GUICtrlRead($STDIN) = "clear" Then
		GUICtrlSetData($STDOUT, "")
		Return True
	ElseIf GUICtrlRead($STDIN) = "/exit" Then
		Exit(0)
	ElseIf GUICtrlRead($STDIN) = "/help" Then
		GUICtrlSetData($STDOUT, GUICtrlRead($STDOUT) & _
			"WineBridge Terminal 1.0.0.0" & @CRLF & _
			"By: Robert C. Maehl" & @CRLF & @CRLF & _
			"Built-in Commands: " & @CRLF & @CRLF & _
			" /exit   " & @TAB & "Exits WineBridge Terminal  " & @CRLF & _
			" /clear  " & @TAB & "Clear the terminal screen  " & @CRLF & _
			" /help   " & @TAB & "Displays this help info    " & @CRLF & _
			" /version" & @TAB & "Displays WineBridge version")
		Return True
	ElseIf GUICtrlRead($STDIN) = "" Then
		Return True
	Else
		Return False
	EndIf
EndFunc
