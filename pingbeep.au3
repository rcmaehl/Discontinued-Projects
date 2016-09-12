;Discontinued: Shits and giggles project

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Change2CUI=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Local $iExitCode = 0
$iExitCode = _Main()
Exit $iExitCode

Func _Main()

	Local $iPing = 32767, $sInputBox = "", $bCheckl = False
	Local $sText = "Please enter the IP Address of the Wireless Router in the format of ###.###.###.###"

	While 1

		$sInputBox = _AskIP($sText)

		If $sInputBox = "" Then
			$sText = "Previous IP was Blank! Please enter the IPv4 Address of the Wireless Router in the format of ###.###.###.###"
			ContinueLoop
		ElseIf Not StringRegExp($sInputBox,"^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$") Then
			$sText = "Previous IP was Invalid! Please enter the IPv4 Address of the Wireless Router in the format of ###.###.###.###"
			ContinueLoop
		Else
			ExitLoop
		EndIf

	WEnd

	While 1
		$iPing = Ping($sInputBox)
		ConsoleWrite($iPing & @CRLF)
		$iPing += 37
		If $iPing = 37 Then $iPing = 32767
		Beep($iPing, 500)
	WEnd

EndFunc

Func _AskIP($sPrompt = "Please enter the IPv4 Address of the Wireless Router in the format of ###.###.###.###")
	$sInputBox = InputBox("Enter IP", $sPrompt, "192.168.0.1")
	Return $sInputBox
EndFunc
