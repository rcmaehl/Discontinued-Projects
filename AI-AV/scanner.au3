#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
If FileExists($CmdLine[1] & $CmdLine[2]) Then
	ConsoleWrite("True")
Else
	ConsoleWrite("False")
EndIf
Exit 0
