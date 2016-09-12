#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon32.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=2012.1.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;-------------------------------------------------------------------------
#include <Date.au3>
#include <Misc.au3>

If Not _Singleton("URSafe", 0) Then Exit(1)

Opt('GUICloseOnESC', 000)
Opt('MustDeclareVars', 1)
Opt('GUIEventOptions', 1)
Opt('GUIResizeMode', 802)
Opt('TrayAutoPause', 000)

TraySetClick(0)
TraySetIcon(@ScriptFullPath, -1)

Create_GUI(0)

Func Create_GUI($Which)
	Switch $Which
		Case 0
			$GUI[0] = GUICreate("URSafe - Version " & $Version[0], @DesktopWidth, @DesktopHeight, 0, 0, 0x00C20200, 0x00000000)
				$Menu[0] = GUICtrlCreateMenu("&File")
					$Item_Hide = GUICtrlCreateMenuItem("&Minimize"             , $Menu[0], 1, 0)
								 GUICtrlCreateMenuItem(""                      , $Menu[0], 2, 0)
					$Item_Exit = GUICtrlCreateMenuItem("E&xit"                 , $Menu[0], 3, 0)
				$Menu[1] = GUICtrlCreateMenu("&Options")
					$Menu[2] = GUICtrlCreateMenu("Default Mode"                , $Menu[1],    1)
						$Item__Mode[0] = GUICtrlCreateMenuItem("Tiny"          , $Menu[2], 1, 1)
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
		Case 1
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
		Case Else
			;;;
	EndSwitch
EndFunc

;	Update_Settings_File()
;	Startup()

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
