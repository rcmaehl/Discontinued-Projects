; #WineBridge Global @error Values# ==============================================================================================
; -512 to 1023 ..; Reserved for AutoIt Command Exit Codes
; 1024 ..........; Success
; 1025 ..........; General Failure
; 1026 ..........; Syntax Error
; 1027 to 1149 ..; Reserved for Bash/Program Exit Codes
; 1150 ..........; Command not Executable
; 1151 ..........; Command not Found
; 1152 to 1279 ..; Reserved for Bash/Program Exit Codes
; 1280 ..........; WineBridge in use
; 1281 ..........; Invalid Function Input
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_BIN
; Description ...: Passes a number to Linux and returns the binary value
; Syntax ........: WB_BIN($WB_STDIN)
; Parameters ....: $WB_STDIN            - Interger to convert
; Return values .: Binary value
; ...............; 0 And Non-Zero @error
; Author ........: Robert C. Maehl
; Modified ......: 02/15/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_HEX
; Example .......: No
; ===============================================================================================================================
Func WB_BIN($WB_STDIN)
	If Not FileExists(@TempDir & "\winebridge_lock") Then
		If IsInt($WB_STDIN) Then
			FileWrite(@TempDir & "\winebridge_stdin", "python -c 'print(bin(" & $WB_STDIN & "))'")
			While 1
				If FileExists(@TempDir & "\winebridge_stdout") And Not FileExists(@TempDir & "\winebridge_lock") Then
					Sleep(10)
					Return StringTrimLeft(FileRead(@TempDir & "\winebridge_stdout"), 2)
					FileDelete(@TempDir & "\winebridge_stdout")
					ExitLoop
				EndIf
			WEnd
		Else
			Return 0
			SetError(1281)
		EndIf
	Else
		Return 0
		SetError(1280)
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_HEX
; Description ...: Passes a number to Linux and returns the hex value
; Syntax ........: WB_HEX($WB_STDIN)
; Parameters ....: $WB_STDIN            - Interger to convert
; Return values .: Hex value
; ...............; 0 And Non-Zero @error
; Author ........: Robert C. Maehl
; Modified ......: 02/15/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_BIN
; Example .......: No
; ===============================================================================================================================
Func WB_HEX($WB_STDIN)
	If Not FileExists(@TempDir & "\winebridge_lock") Then
		If IsInt($WB_STDIN) Then
			FileWrite(@TempDir & "\winebridge_stdin", "python -c 'print(hex(" & $WB_STDIN & "))'")
			While 1
				If FileExists(@TempDir & "\winebridge_stdout") And Not FileExists(@TempDir & "\winebridge_lock") Then
					Sleep(10)
					Return StringTrimLeft(FileRead(@TempDir & "\winebridge_stdout"), 2)
					FileDelete(@TempDir & "\winebridge_stdout")
					ExitLoop
				EndIf
			WEnd
		Else
			Return 0
			SetError(1281)
		EndIf
	Else
		Return 0
		SetError(1280)
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_RUN
; Description ...: Passes a command to Linux and returns the Linux-side PPID
; Syntax ........: WB_RUN($WB_STDIN)
; Parameters ....: $WB_STDIN            - Command to execute
; Return values .: Command PPID
; ...............; 0 And Non-Zero @error
; Author ........: Robert C. Maehl
; Modified ......: 02/15/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_RUNWAIT
; Example .......: No
; ===============================================================================================================================
Func WB_RUN($WB_STDIN)
	If Not FileExists(@TempDir & "\winebridge_lock") Then
		FileWrite(@TempDir & "\winebridge_stdin", "echo $PPID >> WB_Executed_PID" & @CRLF & $WB_STDIN)
		Sleep(100)
		Return FileRead(@TempDir & "\WB_Executed_PID")
	Else
		Return 0
		SetError(1280)
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_RUNWAIT
; Description ...: Passes a command to Linux and returns it's exit code
; Syntax ........: WB_RUNWAIT($WB_STDIN)
; Parameters ....: $WB_STDIN            - Command to execute
; ...............; $WB_STDOUT           - Read STDOUT (True or False)
; Return values .: Exit Code
; ...............; STDOUT and @error Exit Code
; ...............; Non-Zero @error
; Author ........: Robert C. Maehl
; Modified ......: 02/15/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_RUN
; Example .......: No
; ===============================================================================================================================
Func WB_RUNWAIT($WB_STDIN, $WB_STDOUT)
	If Not FileExists(@TempDir & "\winebridge_lock") Then
		FileWrite(@TempDir & "\winebridge_stdin", $WB_STDIN & @CRLF & "echo $((1024+$?)) > ./winebridge_errornum")
		While 1
			If FileExists(@TempDir & "\winebridge_stdout") And Not FileExists(@TempDir & "\winebridge_lock") Then
				Sleep(10)
				If $STDOUT Then
					Return FileRead(@TempDir & "\winebridge_stdout")
					SetError(FileRead(@TempDir & "\winebridge_errornum"))
					ConsoleWrite(@error)
				Else
					Return FileRead(@TempDir & "\winebridge_errornum")
				EndIf
				FileDelete(@TempDir & "\winebridge_stdout")
				ExitLoop
			EndIf
		WEnd
	Else
		Return 0
		SetError(1280)
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_START
; Description ...: Enables usage of WineBridge
; Syntax ........: WB_START()
; Return values .: None
; Author ........: Robert C. Maehl
; Modified ......: 03/14/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_STATUS, WB_STOP
; Example .......: No
; ===============================================================================================================================

; Pending Creation

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_STATUS
; Description ...: Checks the Status of WineBridge
; Syntax ........: WB_STATUS()
; Return values .: Not Running
; ...............; In use
; ...............; Available
; Author ........: Robert C. Maehl
; Modified ......: 03/14/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_START, WB_STOP
; Example .......: No
; ===============================================================================================================================
Func WB_STATUS()
	If FileExists(@TempDir & "\winebridge_pid") Then
		If FileExists(@TempDir & "\winebridge_lock") Then
			Return "In use"
		Else
			Return "Available"
		EndIf
	Else
		Return "Not Running"
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: WB_STOP
; Description ...: Disables usage of WineBridge
; Syntax ........: WB_STOP()
; Return values .: None
; Author ........: Robert C. Maehl
; Modified ......: 03/14/2012
; Remarks .......: Requires Winebridge to be running on Linux
; Related .......: WB_START, WB_STATUS
; Example .......: No
; ===============================================================================================================================

; Pending Creation