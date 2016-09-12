Global $sInput, $sReturn

$sReturn = _MathCreate()
$sInput = MsgBox(0x0, "_MathCreate() by guinness", "Solve the following simple equation: " & @LF & $sReturn)
If @error Then
   Exit
EndIf
If _MathSolve($sReturn) == $sInput Then
   MsgBox(64, "Correct", "You solved the equation.")
EndIf
ConsoleWrite($sReturn & " is " & _MathSolve($sReturn) & @CRLF)

Func _MathCreate()
   Local $aArray[5][2] = [[4, 2], _
         ["ADD", "+"], _
         ["MINUS", "-"], _
         ["MULTIPLY", "*"], _
         ["DIVIDE", "/"]], $iItem, $sString
   For $A = 1 To 2
      $iItem = Random(1, 4, 1)
      $sString &= " " & Random(1, 300, 1) & " " & $aArray[$iItem][1]
   Next
   $sString = StringStripWS(StringTrimRight($sString, 1), 3)
   Return $sString
EndFunc   ;==>_MathCreate

Func _MathSolve($sString)
   Return Execute($sString)
EndFunc   ;==>_MathSolve
