#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon32.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=1.4.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;-------------------------------------------------------------------------
#CS

SOURCE CODE FOR URSafe 1.4.0.0.0

Todo List

1. Add Improved Error Handling
2. Improve Performance
3. Add Options for almost everything <- Add at least 1 per release version
4. Enable changing of hotkeys <- Implement by 1.5.0.0
5. Add changing of background from inside URSafe

Logging Codes

==I== - Info
=EL0= - Error not caused by user
=EL1= - Error caused by missing data
=EL2= - Error caused by user
=EL3= - Critial Error

#CE

;What To Include When Compiling
#include <Constants.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <INet.au3>
#include <Misc.au3>
#include <Process.au3>
#include <String.au3>

#include <Array.au3>

;Allow Only One Instance
If _Singleton("URSafe", 0) = 0 Then Exit

;Set Main Options
Opt('GUICloseOnESC', 000)
Opt('MustDeclareVars', 1)
Opt('GUIEventOptions', 1)
Opt('GUIResizeMode', 802)
Opt('TrayAutoPause', 000)

;Set Tray Options
TraySetClick(0)
TraySetIcon(@ScriptFullPath, -1)

Global $Settings[2][5][6][2]

;Declare Variables
Global $Port
Global $WinXY
Global $Msg, $TrayMsg

Global $Time[6], $Debug, $Runs[3]

Global $_Block[3] = [False,False,False]
Global $__Mode[1] = ["Tiny"]
Global $_Start[3] = [False,False,False]
Global $Status[3] = [False,False,False]
Global $_Timer[3] = [TimerInit(),TimerInit(),10000]

Global $_Clock[2]
Global $Detail[1]
Global $GUI[3]
Global $_Image[1]
Global $_Input[2]
Global $Item_Block[4]
Global $Item__Mode[3]
Global $Item_Reset[3]
Global $Item_Start[3]
Global $Menu[7]
Global $Ran[2]
Global $Toggle[1]

Global $Item_Hide, $Item_Exit
Global $Item_Info, $Item_Math
Global $Item__Man, $Item_Mood
Global $Item_Update

Global $CreditsOK

Global $Start_Update, $Start_Locked, $Pass_Saved, $Password

Global $Update_File, $Version_File

Const $Version[3] = ["1.4.0.0", "1.4.0.0.0", False]

Const $DLL = DllOpen("user32.dll")
Const $INI = @ScriptDir & "\settings.ini"
Const $LOG = @ScriptDir & "\URSafe.log"

$Pass_Saved = False

;Log_Event(0)
;HotKeySet("{F11}","Status")
;Display_Default_GUI()

Cache_Setting_File()
Cache_Setting_File_Values()
Exit(0)

Func Change_Settings($Event)
	FileSetAttrib($INI, "-RSH")
	Switch $Event

		Case 0
			ContinueCase

		Case 1
			If Not $_Block[0] Then
				GUICtrlSetState($Item_Block[1], $GUI_CHECKED)
				INIWrite($INI, "Blocking", "Command Prompt", "True")
				$_Block[0] = True
			ElseIf Not ($Event = 0) Then
				GUICtrlSetState($Item_Block[1], $GUI_UNCHECKED)
				INIWrite($INI, "Blocking", "Command Prompt", "False")
				$_Block[0] = False
			EndIf
			If $Event = 0 Then ContinueCase

		Case 2
			If Not $_Block[1] Then
				GUICtrlSetState($Item_Block[2], $GUI_CHECKED)
				INIWrite($INI, "Blocking", "Shutdown", "True")
				$_Block[1] = True
			ElseIf Not ($Event = 0) Then
				GUICtrlSetState($Item_Block[2], $GUI_UNCHECKED)
				INIWrite($INI, "Blocking", "Shutdown", "False")
				$_Block[1] = False
			EndIf
			If $Event = 0 Then ContinueCase

		Case 3
			If Not $_Block[2] Then
				GUICtrlSetState($Item_Block[3], $GUI_CHECKED)
				INIWrite($INI, "Blocking", "Task Manager", "True")
				$_Block[2] = True
			ElseIf Not ($Event = 0) Then
				GUICtrlSetState($Item_Block[3], $GUI_UNCHECKED)
				INIWrite($INI, "Blocking", "Task Manager", "False")
				$_Block[2] = False
			EndIf

		Case 4
			If Not $_Start[0] Then
				GUICtrlSetState($Item_Start[0], $GUI_CHECKED)
				INIWrite($INI, "Main", "Lock on Start", "True")
				$_Start[0] = True
			Else
				GUICtrlSetState($Item_Start[0], $GUI_UNCHECKED)
				INIWrite($INI, "Main", "Lock on Start", "False")
				$_Start[0] = False
			EndIf

		Case 5
			If Not $_Start[1] Then
				GUICtrlSetState($Item_Start[1], $GUI_CHECKED)
				INIWrite($INI, "Main", "Minimize on Start", "True")
				$_Start[1] = True
			Else
				GUICtrlSetState($Item_Start[1], $GUI_UNCHECKED)
				INIWrite($INI, "Main", "Minimize on Start", "False")
				$_Start[1] = False
			EndIf

		Case 6
			If Not $_Start[2] Then
				GUICtrlSetState($Item_Start[2], $GUI_CHECKED)
				INIWrite($INI, "Main", "Update on Start", "True")
				$_Start[2] = True
			Else
				GUICtrlSetState($Item_Start[2], $GUI_UNCHECKED)
				INIWrite($INI, "Main", "Update on Start", "False")
				$_Start[2] = False
			EndIf

		Case 7
			INIWrite($INI, "Main", "Default Program Mode", $__Mode[0])

		Case Else
			Log_Event(15)

	EndSwitch
	FileSetAttrib($INI, "+RSH")
EndFunc

Func Change_URSafe_Status()
	WinSetState($GUI[0], "", @SW_SHOW)
	If $Status[2] Then
		Leave_Feedback()
	ElseIf $Status[0] Then
		If GUICtrlRead($_Input[0]) = "" Then
			Log_Event(11)
		ElseIf $Status[1] Then
			If GUICtrlRead($_Input[0]) = Execute($Ran[0]^3-$Ran[1]) Then
				Log_Event(7)
				$Status[1] = False
				GUICtrlSetData($_Input[0], $Password)
				Status()
			Else
				Log_Event(13)
				GUICtrlSetData($_Input[0], "")
			EndIf
		ElseIf GUICtrlRead($_Input[0]) == $Password Or GUICtrlRead($_Input[0]) == $Password & "-reset" Then
			Log_Event(3)
			_MouseTrap()
			$Status[0] = False
			GUISetStyle(0x10C20200, 0x00000000, $GUI[0])
			If GUICtrlRead($_Input[0]) == $Password & "-reset" Then
				Log_Event(8)
				FileSetAttrib($INI, "-RSH")
				INIWrite($INI, "Encrypted", "Password", "4E554C")
				FileSetAttrib($INI, "+RSH")
				$Pass_Saved = False
			EndIf
			GUICtrlSetData($_Input[0], "")
			If $Pass_Saved Then
				GUICtrlSetState($_Input[0], $GUI_DISABLE)
				GUICtrlSetData($_Input[0], $Password)
			Else
				GUICtrlSetState($_Input[0], $GUI_FOCUS)
			EndIf
			GUICtrlSetData($Detail[0], "Enter Password to Lock")
			GUICtrlSetData($Toggle[0], "Lock")
			GUICtrlSetState($Menu[0], $GUI_ENABLE)
			GUICtrlSetState($Menu[1], $GUI_ENABLE)
			GUICtrlSetState($Item_Info, $GUI_ENABLE)
			GUICtrlSetState($Item__Man, $GUI_ENABLE)
			GUICtrlSetState($Item_Mood, $GUI_ENABLE)
			GUICtrlSetState($Item_Math, $GUI_DISABLE)
			Change_Window_Size()
		Else
			GUICtrlSetData($_Input[0], "")
			Log_Event(14)
		EndIf
	ElseIf GUICtrlRead($_Input[0]) = "" Then
		Log_Event(12)
	Else
		Log_Event(2)
		$_Timer[0] = TimerInit()
		If _HexToString(INIRead($INI, "Encrypted", "Password", "4E554C")) = "NUL" Then
			If MsgBox(0x00040024, "Set as Default?", "Use this password from now on?") = "6" Then
				FileSetAttrib($INI, "-RSH")
				INIWrite($INI, "Encrypted", "Password", _StringToHex(GUICtrlRead($_Input[0])))
				FileSetAttrib($INI, "+RSH")
				$Pass_Saved = True
			EndIf
		EndIf
		_MouseTrap(0, 0, @DesktopWidth, 180)
		GUICtrlSetData($Detail[0], "Enter Password to Unlock")
		GUICtrlSetData($Toggle[0], "Unlock")
		GUICtrlSetState($Menu[0], $GUI_DISABLE)
		GUICtrlSetState($Menu[1], $GUI_DISABLE)
		GUICtrlSetState($Item_Info, $GUI_DISABLE)
		GUICtrlSetState($Item__Man, $GUI_DISABLE)
		GUICtrlSetState($Item_Mood, $GUI_DISABLE)
		GUICtrlSetState($Item_Math, $GUI_ENABLE)
		$Password = GUICtrlRead($_Input[0])
		GUICtrlSetData($_Input[0], "")
		If $Pass_Saved Then
			GUICtrlSetState($_Input[0], $GUI_ENABLE+$GUI_FOCUS)
		Else
			GUICtrlSetState($_Input[0], $GUI_FOCUS)
		EndIf
		$Status[0] = True
		GUISetState(@SW_HIDE, $GUI[0])
		WinMove($GUI[0], "", 0, 0, @DesktopWidth, @DesktopHeight)
		GUISetStyle(0x00000200, 0x00000008, $GUI[0])
		GUISetState(@SW_SHOW, $GUI[0])
	EndIf
EndFunc

Func Change_Window_Size($Size)
	GUISetState(@SW_HIDE, $GUI[0])
	Switch $Size

		Case "Multi"
			WinMove($GUI[0], "", (@DesktopWidth * 0) - 000, (@DesktopHeight * 2) - 000, @DesktopWidth * 2, @DesktopHeight * 2)
			GUICtrlSetState($Item__Mode[2], $GUI_CHECKED)

		Case "Full"
			WinMove($GUI[0], "", (@DesktopWidth * 0) - 000, (@DesktopHeight * 0) - 000, @DesktopWidth * 1, @DesktopHeight * 2)
			GUICtrlSetState($Item__Mode[1], $GUI_CHECKED)

		Case Else
			WinMove($GUI[0], "", (@DesktopWidth / 4) - 000, (@DesktopHeight / 6) - 000, @DesktopWidth / 2, @DesktopHeight / 3)
			GUICtrlSetState($Item__Mode[0], $GUI_CHECKED)

	EndSwitch
	GUISetState(@SW_SHOW, $GUI[0])
EndFunc

Func Disply_Credits_GUI()
	$GUI[1] = GUICreate("Credits", 220, 220, -1, -1, 0x10000200, 0x00000008)
		GUICtrlCreateLabel("Contributers:"    , 010, 010, 090, 020)
		GUICtrlCreateLabel("Guinness"         , 120, 010, 090, 020)
		GUICtrlCreateLabel("Sleepydvdr"       , 120, 030, 090, 020)
		GUICtrlCreateLabel("Original Idea:"   , 010, 050, 090, 020)
		GUICtrlCreateLabel("Computerfreaker"  , 120, 050, 090, 020)
		GUICtrlCreateLabel("Original Program:", 010, 070, 090, 020)
		GUICtrlCreateLabel("KidSafe"          , 120, 070, 090, 020)
		GUICtrlCreateLabel("URSafe Coding:"   , 010, 090, 090, 020)
		GUICtrlCreateLabel("Robert C. Maehl"  , 120, 090, 090, 020)
		GUICtrlCreateLabel("URSafe Testing:"  , 010, 110, 090, 020)
		GUICtrlCreateLabel("TheCyberShocker"  , 120, 110, 090, 020)
		GUICtrlCreateLabel("Web Hosting:"     , 010, 130, 090, 020)
		GUICtrlCreateLabel("E10Host"          , 120, 130, 090, 020)
		GUICtrlCreateLabel("Google Code"      , 120, 150, 090, 020)
		$CreditsOK = GUICtrlCreateButton("OK" , 180, 170, 030, 020)
EndFunc

Func Display_Default_GUI()
	$GUI[0] = GUICreate("URSafe - Version " & $Version[0], @DesktopWidth, @DesktopHeight, 0, 0, 0x00C20200, 0x00000000)
		$Menu[0] = GUICtrlCreateMenu("&File")
			$Item_Hide = GUICtrlCreateMenuItem("&Minimize"             , $Menu[0], 1, 0)
						 GUICtrlCreateMenuItem(""                      , $Menu[0], 2, 0)
			$Item_Exit = GUICtrlCreateMenuItem("E&xit"                 , $Menu[0], 3, 0)
		$Menu[1] = GUICtrlCreateMenu("&Options")
			$Menu[2] = GUICtrlCreateMenu("Default Mode"                , $Menu[1],    1)
				$Item__Mode[0] = GUICtrlCreateMenuItem("Tiny"          , $Menu[2],    1)
				$Item__Mode[1] = GUICtrlCreateMenuItem("Full"          , $Menu[2], 2, 1)
				$Item__Mode[2] = GUICtrlCreateMenuItem("Multi"         , $Menu[2], 3, 1)
			$Menu[3] = GUICtrlCreateMenu("Don't Allow"                 , $Menu[1],    2)
				$Item_Block[0] = GUICtrlCreateMenuItem("Any"           , $Menu[3], 1, 0)
								 GUICtrlCreateMenuItem(""              , $Menu[3], 2, 0)
				$Item_Block[1] = GUICtrlCreateMenuItem("Command Prompt", $Menu[3], 3, 0)
				$Item_Block[2] = GUICtrlCreateMenuItem("Shutdown"      , $Menu[3], 4, 0)
				$Item_Block[3] = GUICtrlCreateMenuItem("Task Manager"  , $Menu[3], 5, 0)
			$Menu[4] = GUICtrlCreateMenu("On Startup"                  , $Menu[1],    3)
				$Item_Start[0] = GUICtrlCreateMenuItem("Lock URSafe"   , $Menu[4], 1, 0)
				$Item_Start[1] = GUICtrlCreateMenuItem("Minimize/Hide" , $Menu[4], 2, 0)
				$Item_Start[2] = GUICtrlCreateMenuItem("Update URSafe" , $Menu[4], 3, 0)
			$Menu[5] = GUICtrlCreateMenu("Refresh Every"               , $Menu[1],    4)
				$Item_Reset[0] = GUICtrlCreateMenuItem("05 seconds"    , $Menu[5], 1, 1)
				$Item_Reset[1] = GUICtrlCreateMenuItem("10 seconds"    , $Menu[5], 2, 1)
				$Item_Reset[2] = GUICtrlCreateMenuItem("20 seconds"    , $Menu[5], 3, 1)
						   GUICtrlCreateMenuItem(""                    , $Menu[1], 5, 0)
			$Item_Update = GUICtrlCreateMenuItem("Update"              , $Menu[1], 6, 0)
		$Menu[6] = GUICtrlCreateMenu("&Help")
			$Item_Info = GUICtrlCreateMenuItem("&About"                , $Menu[6], 1, 0)
			$Item__Man = GUICtrlCreateMenuItem("Documentation"         , $Menu[6], 2, 0)
			$Item_Mood = GUICtrlCreateMenuItem("Leave Feedback"        , $Menu[6], 3, 0)
						 GUICtrlCreateMenuItem(""                      , $Menu[6], 3, 0)
			$Item_Math = GUICtrlCreateMenuItem("Math Unlock"           , $Menu[6], 4, 0)

	$_Image[0] = GUICtrlCreatePic(@ScriptDir & "\pic.jpg"      , @DesktopWidth - (@DesktopWidth / 1), 000, (@DesktopWidth / 1), @DesktopHeight, 0x00000000, 0x00000200)
	$_Clock[0] = GUICtrlCreateLabel(_NowTime()                 , @DesktopWidth - (@DesktopWidth / 8), 000, (@DesktopWidth / 8),            020, 0x00001001, 0x00000228)
	$_Clock[1] = GUICtrlCreateLabel(_NowDate()                 , @DesktopWidth - (@DesktopWidth / 8), 020, (@DesktopWidth / 8),            020, 0x00001001, 0x00000228)
	$_Input[0] = GUICtrlCreateInput(""                         ,                                 050, 060,                 230,            020, 0x00000160, 0x00000228)
	$_Input[1] = GUICtrlCreateInput(""                         ,                                 280, 040,                 050,            020, 0x00000104, 0x00000028)
	$Detail[0] = GUICtrlCreateLabel("Enter Password to Lock"   ,                                 050, 040,                 230,            020, 0x00001001, 0x00000228)
	$Toggle[0] = GUICtrlCreateButton("Lock"                    ,                                 280, 060,                 050,            020, 0x0000B300, 0x00000228)
	If $Version[2] Then
		$Debug = GUICtrlCreateLabel("", @DesktopWidth - (@DesktopWidth / 8), 40, @DesktopWidth / 8, 40, 0x00001000, 0x00000228)
	EndIf

	GUICtrlSetResizing($_Clock[0], 768)
	GUICtrlSetResizing($_Clock[1], 800)
	GUICtrlSetResizing($Debug, 800)
	GUICtrlSetState($_Input[1], $GUI_DISABLE)
	GUISetStyle(0x10C20200, 0x00000000, $GUI[0])

	Update_Settings_File()
	Startup()

	GUISetState(@SW_SHOW, $GUI[0])

	While 1
		If TimerDiff($_Timer[1]) >= 1000 Then
			GUICtrlSetData($_Clock[0], _NowTime())
			$_Timer[1] = TimerInit()
			If $Version[2] Then
				GUICtrlSetData($Debug, "Status:" & @TAB & @TAB & StringLeft(($Time[1] / 1000) / $Runs[0], 7) & @CRLF & _
				"Protection:" & @TAB & StringLeft(($Time[3] / 1000) / $Runs[1], 7))
			EndIf
		EndIf
		$Msg = GUIGetMsg()
		$TrayMsg = TrayGetMsg()
		Select

			Case $Msg = $Item_Exit
				DllClose($DLL)
				Log_Event(1)
				Exit(0)

			Case $Msg = $Item_Info
				Credits()

			Case $Msg = $Item_Math
				MathUnlock()

			Case $Msg = $Item_Mood
				Feedback()

			Case $Msg = $Item_Update
				Update()

			Case $Msg = $Toggle[0]
				$Time[0] = TimerInit()
				Status()
				$Time[1] += TimerDiff($Time[0])
				$Runs[0] += 1

			Case $Status[0]
				$Time[2] = TimerInit()
				Protection()
				$Time[3] += TimerDiff($Time[2])
				$Runs[1] += 1

			Case $Msg = $Item_Reset[0]
				$_Timer[2] = 5000

			Case $Msg = $Item_Reset[1]
				$_Timer[2] = 10000

			Case $Msg = $Item_Reset[2]
				$_Timer[2] = 20000

			Case $Msg = $Item_Block[0]
				Settings(0)

			Case $Msg = $Item_Block[1]
				Settings(1)

			Case $Msg = $Item_Block[2]
				Settings(2)

			Case $Msg = $Item_Block[3]
				Settings(3)

			Case $Msg = $Item_Start[0]
				Settings(4)

			Case $Msg = $Item_Start[1]
				Settings(5)

			Case $Msg = $Item_Start[2]
				Settings(6)

			Case $Msg = $Item__Mode[0]
				$__Mode[0] = "Tiny"
				Change_Window_Size()
				Settings(7)

			Case $Msg = $Item__Mode[1]
				$__Mode[0] = "Full"
				Change_Window_Size()
				Settings(7)

			Case $Msg = $Item__Mode[2]
				$__Mode[0] = "Multi"
				Change_Window_Size()
				Settings(7)

			Case $TrayMsg = $Tray_Event_PrimaryDouble
				WinSetState($GUI[0], "", @SW_SHOW)
				Change_Window_Size()

			Case $Msg = $Item_Hide Or $Msg = $GUI_EVENT_MINIMIZE
			WinSetState($GUI[0], "", @SW_HIDE)

			Case $Msg = $Item__Man
				ShellExecute("http://code.google.com/p/kidsafe/wiki/")

			Case $Msg = $CreditsOK And WinExists("Credits", "")
				GUIDelete($GUI[1])

;			Anything Not Listed Above
			Case Else
				;;;

		EndSelect
	WEnd
EndFunc

Func Update_Settings_File()
	If Not FileExists($INI) Then
		INIWrite($INI, "#URSafe Settings#", ""                    , $Version[1])
		INIWrite($INI, "Main"             , "Default Program Mode", "Tiny"     )
		INIWrite($INI, "Main"             , "Lock on Start"       , "False"    )
		INIWrite($INI, "Main"             , "Minimize on Start"   , "False"    )
		INIWrite($INI, "Main"             , "Update on Start"     , "False"    )
		INIWrite($INI, "Blocking"         , "Command Prompt"      , "False"    )
		INIWrite($INI, "Blocking"         , "Shutdown"            , "False"    )
		INIWrite($INI, "Blocking"         , "Task Manager"        , "False"    )
		INIWrite($INI, "Encrypted"        , "Password"            , "4E554C"   )
		FileSetAttrib($INI, "+R")
	ElseIf Not (StringTrimLeft(FileReadLine($INI, 2), 1) == $Version[1]) Then
		ProgressOn("Converting Old Settings", "Converting Settings for version " & $Version[0], "Starting")
		ProgressSet(010, "Changing Attributes")
		FileSetAttrib($INI, "-RSH")
		ProgressSet(020, "Adding New Values")
		If INIRead($INI, "Main", "Minimize on Start", "Fail") == "Fail" Then
			INIWrite($INI, "Main", "Minimize on Start", "False")
		EndIf
		If INIRead($INI, "Main", "Default Program Mode", "Fail") == "Fail" Then
			INIWrite($INI, "Main", "Default Program Mode", "Tiny")
			GUICtrlSetState($Item__Mode[0], $GUI_CHECKED)
		EndIf
		ProgressSet(030, "Converting any changed settings")
		If Not (INIRead($INI, "Blocking", "Taskmgr", "Fail") == "Fail") Then
			INIWrite($INI, "Blocking", "Task Manager", INIRead($INI, "Blocking", "Taskmgr", "False"))
			INIDelete($INI, "Blocking", "Taskmgr")
		EndIf
		ProgressSet(050, "Purging any removed settings")
		If Not (INIRead($INI, "Main", "Kill LogonUI", "Fail") == "Fail") Then
			INIDelete($INI, "Main", "Kill LogonUI")
		EndIf
		If Not (INIRead($INI, "#URSafe Settings#", "Version", "Fail") == "Fail") Then
			INIDelete($INI, "#URSafe Settings#", "Version")
		EndIf
		ProgressSet(070, "Finishing Changes")
		INIDelete($INI, "#URSafe Settings#", "")
		INIWrite($INI, "#URSafe Settings#", "", $Version[1])
		ProgressSet(090, "Changing Attributes")
		FileSetAttrib($INI, "+RSH")
		ProgressSet(100, "Done")
		Sleep(1000)
		ProgressOff()
	EndIf
EndFunc

Func Update_URSafe()
	Log_Event(4)
	ProgressOn("URSafe Updater", "Please Wait", "Getting Latest Version Number.")
	$Version_File = StringTrimRight(BinaryToString(InetRead("http://www.fcofix.org/mirror/ursupdate.txt")), 1)
	ProgressSet(33, "Comparing Latest Version to Local Version", "Checking")
	If $Version[2] Then
		If StringTrimLeft($Version_File, 5) > StringReplace($Version[1], ".", "") Then
			ProgressSet(66, "Opening Source to Version " & StringTrimLeft($Version_File, 5), "Opening")
			ShellExecute("http://code.google.com/p/kidsafe/source/browse/")
		Else
			ProgressSet(66, "No Developer Build Available.", "Up to date")
			Sleep(500)
		EndIf
	Else
		If StringTrimRight($Version_File, 6) > StringReplace($Version[0], ".", "") Then
			ProgressSet(66, "Downloading Update to Version " & StringTrimRight($Version_File, 6), "Downloading")
			$Update_File = InetGet("http://www.fcofix.org/mirror/ursafe.exe", @ScriptDir & "\URSafe_Setup.exe", 1, 0)
			InetClose($Update_File)
		Else
			ProgressSet(66, "No Update Needed.", "Up to date")
			Sleep(500)
		EndIf
	EndIf
	ProgressSet(100, "Done", "Closing")
	Sleep(1000)
	ProgressOff()
	Log_Event(5)
EndFunc

Func Leave_Feedback()
	If Not $Status[2] Then
		TCPStartup()
		If @error Then
			MsgBox(0x00040110, "Error", "Failed Communications Startup.")
			Log_Event(10)
		EndIf
		Ping("74.141.211.110", 500)
		If @error Then
			MsgBox(0x00040110, "Error", "Feedback Server Offline; Try again later," & @CRLF & _
				"or Check for Updates for new server IP.")
			Log_Event(9)
			TCPShutdown()
		Else
			$Port = TCPConnect("74.141.211.110", 5309)
			If @error Then
				MsgBox(0x00040110, "Error", "Failed at capturing port.")
				Log_Event(9)
				TCPShutdown()
			Else
				TCPSend($Port, _GetIP() & "$" & "Checking Connection" & "$")
				If @error Then
					MsgBox(0x00040110, "Error", "Feedback Server Offline." & @CRLF & "Please try again later.")
					Log_Event(9)
					TCPShutdown()
				Else
					$Status[2] = True
					GUICtrlSetData($Detail[0], "Enter Your Feedback Below")
					GUICtrlSetData($Toggle[0], "Submit")
					If $__Mode[0] = "Tiny" Then
						GUICtrlSetPos($_Input[1], 50, 60, 230, 60)
					Else
						GUICtrlSetPos($_Input[1], 50, 60, 230, 100)
					EndIf
					GUICtrlSetPos($_Input[0], 280, 40, 50, 20)
					GUICtrlSetState($_Input[0], $GUI_ENABLE+$GUI_FOCUS)
					GUICtrlSetStyle($_Input[0], 0x00000160, 0x00000028)
					GUICtrlSetStyle($_Input[1], 0x00200104, 0x00000228)
					If Not $Pass_Saved Then
						GUICtrlSetState($_Input[0], $GUI_DISABLE)
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		If StringIsASCII(GUICtrlRead($_Input[1])) And _
		Not (StringLen(GUICtrlRead($_Input[1])) < 0004) And _
		Not (StringLen(GUICtrlRead($_Input[1])) > 5000) And _
		Not StringInStr(GUICtrlRead($_Input[1]), "fuck", 0) And _
		Not StringInStr(GUICtrlRead($_Input[1]), "shit", 0) And _
		Not StringInStr(GUICtrlRead($_Input[1]), "crap", 0) Then
			TCPSend($Port, _GetIP() &  "$" & StringReplace(GUICtrlRead($_Input[1]), "$", "(Money sign)") & "$")
			If @error Then
				MsgBox(0x00041010, "Error", "Failed at sending data." & @CRLF & "Please try again later.")
				Log_Event(9)
			Else
				MsgBox(0x00041040, "Thanks", "Thank you for your feedback!")
				Log_Event(6)
			EndIf
			$Status[2] = False
			GUICtrlSetData($Detail[0], "Enter Password to Lock")
			GUICtrlSetData($_Input[1], "")
			GUICtrlSetData($Toggle[0], "Lock")
			GUICtrlSetPos($_Input[0], 50, 60, 230, 20)
			GUICtrlSetPos($_Input[1], 280, 40, 50, 20)
			GUICtrlSetState($_Input[1], $GUI_DISABLE+$GUI_ONTOP)
			GUICtrlSetStyle($_Input[1], 0x00000004, 0x00000028)
			GUICtrlSetStyle($_Input[0], 0x00000160, 0x00000228)
			If Not $Pass_Saved Then
				GUICtrlSetState($_Input[0], $GUI_ENABLE+$GUI_FOCUS)
			EndIf
			TCPShutdown()
		Else
			MsgBox(0x00040110, "Error", "Please revise your feedback.")
		EndIf
	EndIf
EndFunc

Func Log_Event($Event)
	Switch $Event

		Case 0
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Opened")

		Case 1
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Closed")

		Case 2
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Locked")

		Case 3
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Unlocked")

		Case 4
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Updater Executed")

		Case 5
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Updater Finished Executing")

		Case 6
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Feedback Sent")

		Case 7
			FileWriteLine($Log, "==I== " & _Now() & " : " & "Math Unlock Succeeded, Answer: " & Execute($Ran[0]^3-$Ran[1]))

		Case 8
			FileWriteLine($Log, "==I== " & _Now() & " : " & "URSafe Saved Pass Reset To None")

		Case 9
			FileWriteLine($Log, "=EL0= " & _Now() & " : " & "Communications Failure - Client Side")

		Case 10
			FileWriteLine($Log, "=EL0= " & _Now() & " : " & "Communications Failure - Server Side")

		Case 11
			FileWriteLine($Log, "=EL1= " & _Now() & " : " & "No Unlock Password Specified, Not unlocking.")

		Case 12
			FileWriteLine($Log, "=EL1= " & _Now() & " : " & "No Lock Password Specified, Not Locking.")

		Case 13
			FileWriteLine($Log, "=EL2= " & _Now() & " : " & "Math Unlock Failed." & _
				"Input: " & GUICtrlRead($_Input[0]) & " Answer: " & Execute($Ran[0]^3-$Ran[1]))

		Case 14
			FileWriteLine($Log, "=EL2= " & _Now() & " : " & "Incorrect Password")

		Case 15
			FileWriteLine($Log, "=EL3= " & _Now() & " : " & "ERROR 0x01 Occured")

		Case 16
			FileWriteLine($Log, "=EL3= " & _Now() & " : " & "ERROR 0x02 Occured")

		Case Else
			Log_Event(16)

	EndSwitch
EndFunc

Func MathUnlock()
	If Not $Status[1] Then
		$Status[1] = True
		Global $Ran[2] = [Random(20, 50, 1), Random(1000, 8000, 1)]
		GUICtrlSetData($Detail[0], "What is " & $Ran[0] & " cubed minus " & $Ran[1] & "?")
	Else
		GUICtrlSetData($Detail[0], "Enter Password to Unlock")
		$Status[1] = False
	EndIf
EndFunc

Func Protection()
	If TimerDIff($_Timer[0]) >= $_Timer[2] Or _IsPressed("5B", $DLL) Or _IsPressed("5C", $DLL) Then
		$_Timer[0] = TimerInit()
		_MouseTrap()
		Sleep(100)
		_MouseTrap(0, 0, @DesktopWidth, 180)
	EndIf
	$WinXY = WinGetPos($GUI[0])
	If $WinXY[0] <> 0 Or $WinXY[1] <> 0 Or Not BitAND(WinGetState($GUI[0]), 8) Then
		WinMove($GUI[0], "", 0, 0, @DesktopWidth, @DesktopHeight)
		WinActivate($GUI[0])
	EndIf
	If ProcessExists("cmd.exe"     ) And $_Block[0] Then ProcessClose("cmd.exe"    )
	If ProcessExists("command.com" ) And $_Block[0] Then ProcessClose("command.com")
	If ProcessExists("shutdown.exe") And $_Block[1] Then _RunDOS("shutdown /a"     )
	If ProcessExists("taskmgr.exe" ) And $_Block[2] Then ProcessClose("taskmgr.exe")
	For $I = 65 to 90
		If DriveGetType(Chr($I) & ":") = "CDROM" Then CDTray(Chr($I) & ":", "closed")
	Next
EndFunc

Func Prepare_URSafe()
	Change_Window_Size($Settings[0][2][2][0])
	For $Loop0 = 3 To $Settings[0][2][1][0] + 1 Step 1
		If $Settings[0][2][$Loop0][1] = "True" Then
			GUICtrlSetState($Item_Start[$Loop0 - 3], $GUI_CHECKED)
			$_Start[$Loop0 - 3] = True
		EndIf
	Next
	If INIRead($INI, "Blocking", "Command Prompt", "False") = "True" Then
		GUICtrlSetState($Item_Block[1], $GUI_CHECKED)
		$_Block[0] = True
	EndIf
	If INIRead($INI, "Blocking", "Shutdown", "False") = "True" Then
		GUICtrlSetState($Item_Block[2], $GUI_CHECKED)
		$_Block[1] = True
	EndIf
	If INIRead($INI, "Blocking", "Task Manager", "False") = "True" Then
		GUICtrlSetState($Item_Block[3], $GUI_CHECKED)
		$_Block[2] = True
	EndIf
	GUICtrlSetData($_Input[0], _HexToString(INIRead($INI, "Encrypted", "Password", "4E554C")))
	If GUICtrlRead($_Input[0]) = "NUL" Then
		GUICtrlSetData($_Input[0], "")
	Else
		$Pass_Saved = True
		GUICtrlSetState($_Input[0], $GUI_DISABLE)
		If INIRead($INI, "Main", "Lock on Start", "False") = "True" Then Status()
	EndIf
	GUICtrlSetState($Item_Reset[1], $GUI_CHECKED)
	GUICtrlSetState($Item_Math, $GUI_DISABLE)
EndFunc

Func Change_File_Attributes($File, $Attributes)
	Switch $File
		Case 0
			Switch $Attributes
				Case 0
					FileSetAttrib($INI, "-R")
				Case 1
					FileSetAttrib($INI, "+R")
			EndSwitch
		Case 1
			Switch $Attributes
				Case 0
					FileSetAttrib($LOG, "-R")
				Case 1
					FileSetAttrib($LOG, "+R")
			EndSwitch
	EndSwitch
EndFunc

Func Cache_Setting_File()
;	Section Count
	$Settings[0][0][0][0] = 4

#CS Template for this function:
	Commented Section #
	Constant of Section Name
	Constant of Section Field Count
	Constant of Section's First Field
	Constant of Section's First Field's Default Value
	Constant of Section's Second Field
	Constant of Section's Second Field's Default Value
	...
#CE

;	Section 1
	$Settings[0][1][0][0] = "#URSafe Settings#"
	$Settings[0][1][1][0] = 1
	$Settings[0][1][2][0] = ""
	$Settings[0][1][2][1] = $Version[1]
	;Section 2
	$Settings[0][2][0][0] = "Main"
	$Settings[0][2][1][0] = 4
	$Settings[0][2][2][0] = "Default Size"
	$Settings[0][2][2][1] = "Tiny"
	$Settings[0][2][3][0] = "Lock on Start"
	$Settings[0][2][3][1] = "False"
	$Settings[0][2][4][0] = "Minimize on Start"
	$Settings[0][2][4][1] = "False"
	$Settings[0][2][5][0] = "Update On Start"
	$Settings[0][2][5][1] = "False"
	;Section 3
	$Settings[0][3][0][0] = "Blocking"
	$Settings[0][3][1][0] = 4
	$Settings[0][3][2][0] = "CD Trays"
	$Settings[0][3][2][1] = "False"
	$Settings[0][3][3][0] = "Command Prompt"
	$Settings[0][3][3][1] = "False"
	$Settings[0][3][4][0] = "System Shutdown"
	$Settings[0][3][4][1] = "False"
	$Settings[0][3][5][0] = "Task Manager"
	$Settings[0][3][5][1] = "False"
	;Setting 4
	$Settings[0][4][0][0] = "Encrypted"
	$Settings[0][4][1][0] = 1
	$Settings[0][4][2][0] = "Password"
	$Settings[0][4][2][1] = "4E554C"
EndFunc

Func Cache_Setting_File_Values()
	For $Loop0 = 1 To $Settings[0][0][0][1] Step 1
		For $Loop1 = 2 To $Settings[0][$Loop0][1][0] + 1 Step 1
			$Settings[1][$Loop0][$Loop1][0] = INIRead($INI, $Settings[0][$Loop0][0][0], $Settings[0][$Loop0][$Loop1][0], $Settings[0][$Loop0][$Loop1][1])
		Next
	Next
EndFunc

Func Write_Settings_File()
	Change_File_Attributes(0,0)
	FileDelete($INI)
	INIWrite($INI, "#URSafe Settings#", ""                    , $Version[1])
	INIWrite($INI, "Main"             , "Default Program Mode", "Tiny"     )
	INIWrite($INI, "Main"             , "Lock on Start"       , "False"    )
	INIWrite($INI, "Main"             , "Minimize on Start"   , "False"    )
	INIWrite($INI, "Main"             , "Update on Start"     , "False"    )
	INIWrite($INI, "Blocking"         , "Command Prompt"      , "False"    )
	INIWrite($INI, "Blocking"         , "Shutdown"            , "False"    )
	INIWrite($INI, "Blocking"         , "Task Manager"        , "False"    )
	INIWrite($INI, "Encrypted"        , "Password"            , "4E554C"   )
	Change_File_Attributes(0,1)
EndFunc