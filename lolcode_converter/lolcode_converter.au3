Global $Line = 1

While 1
	$CODE = FileReadLine("./lolcode.lol", $Line)
	Select
		Case StringReplace($CODE, "	", "") = "HAI"
			FileWrite("./lolcode.au3", ";Begin File" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 08) = "IM IN YR"
			FileWrite("./lolcode.au3", "While 1" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 11) = "IM OUTTA YR"
			FileWrite("./lolcode.au3", "WEnd" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 07) = "VISIBLE"
			FileWrite("./lolcode.au3", "ConsoleWrite(" & StringTrimLeft(StringReplace($CODE, "	", ""), 8) & " & @CRLF)" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 07) = "KTHXBYE"
			FileWrite("./lolcode.au3", "Exit(0)" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 04) = "KTHX"
			FileWrite("./lolcode.au3", "ExitLoop" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 04) = "ENUF"
			FileWrite("./lolcode.au3", "ExitLoop" & @CRLF)
		Case StringLeft(StringReplace($CODE, "	", ""), 03) = "BTW"
			FileWrite("./lolcode.au3", ";" & StringTrimLeft(StringReplace($CODE, "	", ""), 4) & @CRLF)
		Case StringReplace($CODE, "	", "") = ""
			FileWrite("./lolcode.au3", @CRLF)
		Case $CODE = -1
			Exit(0)
		Case Else
			Exit(1)
	EndSelect
	$Line += 1
WEnd