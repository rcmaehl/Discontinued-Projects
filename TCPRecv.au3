#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
If _Singleton("URSafe Server", 1) = 0 Then Exit

#include <Date.au3>
#include <GuiListBox.au3>
#include <GuiListView.au3>
#include <Misc.au3>

Dim $array[100][2],$f

TCPStartup()

$MainSocket = TCPListen("127.0.0.1", 5309)

If $MainSocket = -1 Then
	TCPShutdown()
	Exit(1)
EndIf

GUICreate("Server", 400, 200, 0, 0)
	$Events = GUICtrlCreateListView("", 10, 10, 380, 180)
		_GUICtrlListView_AddColumn($Events, "Time Stamp" , 140)
		_GUICtrlListView_AddColumn($Events, "Source IP", 140)
		_GUICtrlListView_AddColumn($Events, "Length", 95)
GUISetState()

While 1
    $Msg = GUIGetMsg()
    If $Msg = $GUI_EVENT_CLOSE Then
        ExitLoop
    EndIf
    For $r = 0 to UBound($array) - 1
        If $array[$r][0] <> "" Then
            $recv = TCPRecv($array[$r][0], 1000000)
            If $recv <> "" Then
				If StringInStr($recv, "$", 0, 2) Then
					$data = StringSplit($recv,"$")
					$Now = _Now()
					_GUICtrlListView_InsertItem($Events, $Now, 0)
					_GUICtrlListView_AddSubItem($Events, 0, $data[1], 1, 1)
					_GUICtrlListView_AddSubItem($Events, 0, StringLen($data[2]) & " Characters", 2, 1)
					FileWriteLine(@DesktopDir & "\Feedback.txt", $Now & _
						" From " & $data[1] & _
						" Msg: " & $data[2])
				Else

				EndIf
            EndIf
        EndIf
    Next
    Newclient()
WEnd
TCPShutdown()
Exit(0)

Func Newclient()
    $ConnectedSocket = TCPAccept($MainSocket)
    If $ConnectedSocket <> -1 Then
        $array[$f][0] = $ConnectedSocket
        $f += 1
    EndIf
EndFunc