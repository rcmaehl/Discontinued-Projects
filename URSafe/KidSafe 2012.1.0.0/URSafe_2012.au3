#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon32.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=2012.1.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
;-------------------------------------------------------------------------
#include <Date.au3>
#include <Misc.au3>
#include <GUIConstantsEx.au3>

If Not _Singleton("URSafe", 0) Then Exit(1)

Opt('GUICloseOnESC', 000)
Opt('MustDeclareVars', 1)
Opt('GUIEventOptions', 1)
Opt('GUIResizeMode', 802)
Opt('TrayAutoPause', 000)

TraySetClick(0)
TraySetIcon(@ScriptFullPath, -1)

Global $Msg
Global $GUI[2], $Opt[7], $Tab[4], $Ref[3]
Global $Item[3], $Menu[3], $Done[2]
Global $Clock[3], $Image[1], $Input[2], $Label[1], $State[1], $Style[10], $Timer[2]

Global $CX = @DesktopWidth - 100
Global $DX = @DesktopWidth
Global $DY = @DesktopHeight

Const $DLL = DllOpen("user32.dll")
Const $INI = @ScriptDir & "\settings.ini"
Const $LOG = @ScriptDir & "\URSafe.log"
Const $PIC = @ScriptDir & "\data\pic.jpg"

Const $Version[3] = ["2012.1.0.0", "2012.1.0.0", True]

Global $Settings[2][5][7][2]

Start_Set_Styles()
Start_Create_GUI()
Cache_Setting_File()
Start_Create_Options()
Start_Update_Controls()
Cache_Setting_File_Values()

GUISetState(@SW_SHOW, $GUI[0])

Do_On_Events()

Func Start_Set_Styles()
	$Style[0] = 0x00000000 ;Standard Default Style And Extended Default Style
	$Style[1] = 0x80C20200 ;Standard Window Style of $WS_POPUP + $WS_CAPTION + $WS_MINIMIZEBOX + $DS_SETFOREGROUND
	$Style[2] = 0x00000121 ;Standard Input Style of $ES_CENTER + $ES_NOHIDESEL + $ES_PASSWORD
	$Style[3] = 0x00000021 ;Standard Input Style of $ES_CENTER + $ES_NOHIDESEL
	$Style[4] = 0x00001201 ;Standard Label Style of $SS_CENTER + $SS_CENTERIMAGE + $SS_SUNKEN
	$Style[5] = 0x00000F00 ;Standard Button Style of $BS_CENTER + $BS_VCENTER
	$Style[6] = 0x00000008 ;Extended Style of $WS_EX_TOPMOST
	$Style[7] = 0x00000088 ;Extended Style of $WS_EX_TOPMOST + $WS_EX_TOOLWINDOW
	$Style[8] = 0x80C80000 ;Standard Window Style of $WS_POPUP + $WS_CAPTION
	$Style[9] = 0x00001001 ;Standard Label Style of $SS_CENTER + $SS_SUNKEN
EndFunc

Func Start_Create_GUI()
	$GUI[0] = GUICreate("URSafe - Version ", $DX, $DY, 0, 0, $Style[1], $Style[6])
	$Menu[0] = GUICtrlCreateMenu("&File")
	$Menu[1] = GUICtrlCreateMenu("&Tools")
	$Menu[2] = GUICtrlCreateMenu("&About")
	$Item[0] = GUICtrlCreateMenuItem("E&xit", $Menu[0], 1)
	$Item[1] = GUICtrlCreateMenuItem("&Options", $Menu[1], 1)
	$Item[2] = GUICtrlCreateMenuItem("&Credits", $Menu[2], 1)
	$Image[0] = GUICtrlCreatePic($PIC        ,                 000, 000, $DX, $DY, $Style[0], $Style[0])
	$Clock[0] = GUICtrlCreateLabel(_NowDate(),                 $CX, 000, 100, 020, $Style[4], $Style[0])
	$Clock[1] = GUICtrlCreateLabel(_NowTime(),                 $CX, 020, 100, 020, $Style[4], $Style[0])
	$Clock[2] = GUICtrlCreateLabel(""        ,                 $CX, 040, 100, 040, $Style[9], $Style[0])
	$Input[0] = GUICtrlCreateInput(""                        , 030, 050, 200, 020, $Style[2], $Style[0])
	$Input[1] = GUICtrlCreateInput(""                        , 030, 050, 200, 020, $Style[3], $Style[0])
	$Label[0] = GUICtrlCreateLabel("Enter Password to Unlock", 030, 030, 200, 020, $Style[4], $Style[0])
	$State[0] = GUICtrlCreateButton("Lock"                   , 230, 050, 050, 020, $Style[5], $Style[0])
EndFunc

Func Start_Create_Options()
	$GUI[1] = GUICreate("URSafe - Options", 300, 200, -1, -1, $Style[8], $Style[7])
	$Tab[0] = GUICtrlCreateTab(0, 0, 300, 160)
	$Tab[1] = GUICtrlCreateTabItem("Blocking")
	$Ref[0] = GUICtrlCreateGroup("Don't Allow"  , 010, 030, 280, 110)
	$Tab[2] = GUICtrlCreateTabItem("Window")
	$Ref[1] = GUICtrlCreateGroup("Locked Mode"  , 010, 030, 280, 050)
;	$Opt[0] = GUICtrlCreateRadio("Tray"         , 015, 050, 080, 020) ;Commented out until later
	$Opt[1] = GUICtrlCreate Radio("Normal"      , 105, 050, 080, 020)
	$Opt[2] = GUICtrlCreateRadio("Multiple"     , 195, 050, 080, 020)
	$Ref[2] = GUICtrlCreateGroup("Unlocked Mode", 010, 090, 280, 050)
	$Opt[3] = GUICtrlCreateRadio("Small"        , 015, 110, 080, 020)
	$Opt[4] = GUICtrlCreateRadio("Normal"       , 105, 110, 080, 020)
	$Opt[5] = GUICtrlCreateRadio("Multiple"     , 195, 110, 080, 020)
	$Tab[3] = GUICtrlCreateTabItem("")
	$Done[0] = GUICtrlCreateButton("Save"       , 240, 165, 050, 030)
	$Done[1] = GUICtrlCreateButton("Reset"      , 010, 165, 050, 030)
EndFunc

;Func Update_Info()
;	If TimerDiff($Timer[1]) >= 1000 Then
;		GUICtrlSetData($Clock[0], _NowTime())
;		$Timer[1] = TimerInit()
;		If $Version[2] Then
;			GUICtrlSetData($Clock[2], "Status:" & @TAB & @TAB & StringLeft(($Time[1] / 1000) / $Runs[0], 7) & @CRLF & _
;					"Protection:" & @TAB & StringLeft(($Time[3] / 1000) / $Runs[1], 7))
;		EndIf
;	EndIf
;EndFunc

Func Start_Update_Controls()
	GUICtrlSetResizing($Clock[0], 768)
	GUICtrlSetResizing($Clock[1], 800)
	GUICtrlSetResizing($Image[0], 102)
	GUICtrlSetState($Clock[2], $GUI_HIDE)
	GUICtrlSetState($Input[1], $GUI_HIDE)
;	GUICtrlSetTip($Opt[0], "Only Blocks Programs")
	GUICtrlSetTip($Opt[2], "URSafe is the size four Desktops")
	GUICtrlSetTip($Opt[5], "URSafe is the size four Desktops")
	GUICtrlSetTip($Opt[1], "URSafe is the size of the Desktop")
	GUICtrlSetTip($Opt[4], "URSafe is the size of the Desktop")
	GUICtrlSetTip($Opt[3], "URSafe is half the size of the Desktop")
EndFunc

Func Do_On_Events()
	While 1
		$Msg = GUIGetMsg(1)
		Switch $Msg[0]
			Case $GUI_EVENT_CLOSE
				If $Msg[1] = $GUI[1] Then
					GUISetState(@SW_HIDE, $GUI[1])
					GUISetState(@SW_ENABLE, $GUI[0])
				EndIf

			Case $Item[0]
				Exit(0)

			Case $Item[1]
				GUISetState(@SW_SHOW, $GUI[1])
				GUISetState(@SW_DISABLE, $GUI[0])

			Case $Done[0]
				Write_Settings_File(1)

			Case $Done[1]
				Write_Settings_File(0)

			Case Else
				;;;
		EndSwitch
	WEnd
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
	$Settings[0][2][1][0] = 5
	$Settings[0][2][2][0] = "Background Image"
	$Settings[0][2][2][1] = $PIC
	$Settings[0][2][3][0] = "Default Size"
	$Settings[0][2][3][1] = "Tiny"
	$Settings[0][2][4][0] = "Lock on Start"
	$Settings[0][2][4][1] = False
	$Settings[0][2][5][0] = "Minimize on Start"
	$Settings[0][2][5][1] = False
	$Settings[0][2][6][0] = "Update On Start"
	$Settings[0][2][6][1] = False
	;Section 3
	$Settings[0][3][0][0] = "Blocking"
	$Settings[0][3][1][0] = 4
	$Settings[0][3][2][0] = "CD Trays"
	$Settings[0][3][2][1] = False
	$Settings[0][3][3][0] = "Command Prompt"
	$Settings[0][3][3][1] = False
	$Settings[0][3][4][0] = "System Shutdown"
	$Settings[0][3][4][1] = False
	$Settings[0][3][5][0] = "Task Manager"
	$Settings[0][3][5][1] = False
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

Func Write_Settings_File($Set)
	Change_File_Attributes(0,0)
	FileDelete($INI)
	For $Loop0 = 1 To $Settings[0][0][0][0] Step 1
		For $Loop1 = 2 To $Settings[0][$Loop0][1][0] + 1 Step 1
			INIWrite($INI, $Settings[$Set][$Loop0][0][0], $Settings[$Set][$Loop0][$Loop1][0], $Settings[$Set][$Loop0][$Loop1][1])
		Next
	Next
	Change_File_Attributes(0,1)
EndFunc

Func Change_File_Attributes($File, $Attributes)
	Switch $File
		Case 0
			Switch $Attributes
				Case 0
					FileSetAttrib($INI, "-RSH")

				Case 1
					FileSetAttrib($INI, "+R")
			EndSwitch

		Case 1
			Switch $Attributes
				Case 0
					FileSetAttrib($LOG, "-RSH")

				Case 1
					FileSetAttrib($LOG, "+R")
			EndSwitch
	EndSwitch
EndFunc