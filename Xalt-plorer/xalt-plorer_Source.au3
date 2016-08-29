; Discontinued: Attempting to create a Windows Desktop for Wine is above my skill level and current implimentation is very laggy ctrl wise.

oTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <ButtonConstants.au3>
#Include <Date.au3>
#include <Misc.au3>
Opt('MustDeclareVars', 1)
Opt('GUICloseOnESC', 1)

Global $Shown = False
Global $Msg, $Height, $Width, $Start, $_Halt, $Panel, $__Run, $RunItem, $Time, $RefreshTimer, $__Bar
Global $Clock, $Submit, $RunCmd, $CanelRun, $AllPrograms, $Notepad, $Command, $_Menu, $Frame, $_Pics, $_Vids
Global $Unity, $POS, $Image[2], $DLL, $_Jump, $_MyPC, $_More, $Tasks, $_Docs, $Paper, $_Face, $_User, $_Wall
Global $ID[10], $Setts, $Newer, $__URL, $Tab[999], $Tabs, $Icon[999]

_Main()

Func _Main()

	$DLL = "user32.dll"
	$Tasks = 0
	$Image[0] = @UserProfileDir & "\.face"
	$Image[1] = @ScriptDir & "\image.jpg"

	$RefreshTimer = TimerInit()

	$Panel = GUICreate(""                  ,             @DesktopWidth - 000, @DesktopHeight - 000,                 000,                  000, 0x80000228, 0x00000008)
	$Tab[0] = GUICtrlCreateTab(                                          000,                  000, @DesktopWidth - 000, @DesktopHeight - 020, 0x00000001, 0x00000000)
	$Tab[1] = GUICtrlCreateTabItem("Desktop")
	$Paper = GUICtrlCreatePic($Image[1]    ,                             000,                  020, @DesktopWidth - 000, @DesktopHeight - 040, 0x00000000, 0x00000208)
	$Icon[0] = GUICtrlCreateIcon(@SystemDir & "\shell32.dll", -16, 30, 40, 36, 36)
	$Tab[2] = GUICtrlCreateTabItem("Internet")
	GUICtrlCreateTabItem("")
	$Clock = GUICtrlCreateLabel( _NowTime(),             @DesktopWidth - 080, @DesktopHeight - 020,                 080,                  020, 0x00001201)
	$Start = GUICtrlCreateButton("Start"   ,                             000, @DesktopHeight - 020,                 050,                  020, 0x00000F00, 0x00000028)
	$_Jump = GUICtrlCreateLabel(""         ,                             020, @DesktopHeight - 500,                 260,                  450, 0x00001026, 0x00000020)
	$_User = GUICtrlCreateLabel(@UserName  ,                             280, @DesktopHeight - 450,                 115,                  030, 0x00000201, 0x00000220)
	$_Docs = GUICtrlCreateLabel("Documents",                             280, @DesktopHeight - 415,                 115,                  030, 0x00000201, 0x00000220)
	$_Pics = GUICtrlCreateLabel("Pictures" ,                             280, @DesktopHeight - 380,                 115,                  030, 0x00000201, 0x00000220)
	$_Vids = GUICtrlCreateLabel("Videos"   ,                             280, @DesktopHeight - 345,                 115,                  030, 0x00000201, 0x00000220)
	$_MyPC = GUICtrlCreateLabel("Computer" ,                             280, @DesktopHeight - 290,                 115,                  030, 0x00000201, 0x00000220)
	$Setts = GUICtrlCreateLabel("Settings" ,                             280, @DesktopHeight - 255,                 115,                  030, 0x00000201, 0x00000220)
	$__Run = GUICtrlCreateLabel("Run"      ,                             280, @DesktopHeight - 200,                 115,                  030, 0x00000201, 0x00000220)
	$Newer = GUICtrlCreateLabel("Update"   ,                             280, @DesktopHeight - 165,                 115,                  030, 0x00000201, 0x00000220)
	$_Halt = GUICtrlCreateButton("Shutdown",                             295, @DesktopHeight - 100,                 060,                  030, 0x00000F00, 0x00000228)
	$_More = GUICtrlCreateButton(">"       ,                             355, @DesktopHeight - 100,                 020,                  030, 0x00000F00, 0x00000220)
	$_Menu = GUICtrlCreateLabel(""         ,                             000, @DesktopHeight - 520,                 400,                  500, 0x00001012, 0x00000021)
	$__URL = GUICtrlCreateInput(""         ,             @DesktopWidth / 004,                  002, @DesktopWidth / 002,                  018, 0x00001401, 0x00000220)
	$_Face = GUICtrlCreatePic($Image[0]    ,                             310, @DesktopHeight - 540,                 060,                  060, 0x00000000, 0x00000020)
	$Frame = GUICtrlCreateLabel(""         ,                             305, @DesktopHeight - 545,                 070,                  070, 0x00001012, 0x00000021)
	$__Bar = GUICtrlCreateLabel(""         ,                             000, @DesktopHeight - 020, @DesktopWidth - 000,                  020, 0x00001012)

	GUICtrlSetState($Tab[1], $GUI_SHOW)
	GUICtrlSetState($__URL, $GUI_HIDE)
	GUICtrlSetState($_Menu, $GUI_HIDE)
	GUICtrlSetState($_Halt, $GUI_HIDE)
	GUICtrlSetState($_More, $GUI_HIDE)
	GUICtrlSetState($_Jump, $GUI_HIDE)
	GUICtrlSetState($_User, $GUI_HIDE)
	GUICtrlSetState($_Docs, $GUI_HIDE)
	GUICtrlSetState($_Pics, $GUI_HIDE)
	GUICtrlSetState($_Vids, $GUI_HIDE)
	GUICtrlSetState($_MyPC, $GUI_HIDE)
	GUICtrlSetState($Setts, $GUI_HIDE)
	GUICtrlSetState($__Run, $GUI_HIDE)
	GUICtrlSetState($Newer, $GUI_HIDE)
	GUICtrlSetState($Frame, $GUI_HIDE)
	GUICtrlSetState($_Face, $GUI_HIDE)

	GUISetState()

	While 1
		$Msg = GUIGetMsg()
		Select

			Case TimerDiff($RefreshTimer) >= 1000
				GUICtrlSetData($Clock, _NowTime())
				$RefreshTimer = TimerInit()

			Case $Msg = $_Halt
				PowerOff(0)

			Case $Msg = $Tab[0]
				If $Shown Then Start()

			Case $Msg = $Paper
				If $Shown Then Start()

			Case $Msg = $__Bar
				If $Shown Then Start()

			Case $Msg = $Clock
				If $Shown Then Start()

			Case $Msg = $Panel
				If $Shown Then Start()

			Case $Msg = $Icon[0]
				If $Shown Then Start()

;			Case $Msg = $_More

			Case $Msg = $__URL
				If StringRight(GUICtrlRead($__URL), 2) = "()" Then
					Execute(StringTrimRight(GUICtrlRead($__URL), 2) & "(0)")
				ElseIf StringRight(GUICtrlRead($__URL), 1) = ")" Then
					Execute(GUICtrlRead($__URL))
				Else
					Execute(GUICtrlRead($__URL) & "(0)")
				EndIf
				GUICtrlSetState($__URL, $GUI_HIDE)
				GUICtrlSetData($__URL, "")

			Case $Msg = $__Run Or _IsPressed("11", $DLL)
				GUICtrlSetState($__URL, $GUI_SHOW+$GUI_FOCUS)
				If $Shown Then Start()

			Case $Msg = $Start Or _IsPressed("5B", $DLL) Or _IsPressed("5C", $DLL)
				Start()

			Case Else
				;;;

		EndSelect
	WEnd
EndFunc

Func PowerOff($Param)
	Select

		Case $Param = 0
			Exit(0)

		Case $Param = 1
			Shutdown(26)

		Case Else
			;;;

	EndSelect
EndFunc

Func Start()
	If $Shown Then
		GUICtrlSetState($_Jump, $GUI_HIDE)
		GUICtrlSetState($_User, $GUI_HIDE)
		GUICtrlSetState($_Docs, $GUI_HIDE)
		GUICtrlSetState($_Pics, $GUI_HIDE)
		GUICtrlSetState($_Vids, $GUI_HIDE)
		GUICtrlSetState($_MyPC, $GUI_HIDE)
		GUICtrlSetState($Setts, $GUI_HIDE)
		GUICtrlSetState($__Run, $GUI_HIDE)
		GUICtrlSetState($Newer, $GUI_HIDE)
		GUICtrlSetState($_Halt, $GUI_HIDE)
		GUICtrlSetState($_More, $GUI_HIDE)
		GUICtrlSetState($_Menu, $GUI_HIDE)
		GUICtrlSetState($_Face, $GUI_HIDE)
		GUICtrlSetState($Frame, $GUI_HIDE)
		$Shown = False
		Sleep(100)
	Else
		GUICtrlSetState($_Menu, $GUI_SHOW)
		GUICtrlSetState($Frame, $GUI_SHOW)
		GUICtrlSetState($_Face, $GUI_SHOW)
		GUICtrlSetState($_Halt, $GUI_SHOW)
		GUICtrlSetState($_More, $GUI_SHOW)
		GUICtrlSetState($_Jump, $GUI_SHOW)
		GUICtrlSetState($_User, $GUI_SHOW)
		GUICtrlSetState($_Docs, $GUI_SHOW)
		GUICtrlSetState($_Pics, $GUI_SHOW)
		GUICtrlSetState($_Vids, $GUI_SHOW)
		GUICtrlSetState($_MyPC, $GUI_SHOW)
		GUICtrlSetState($Setts, $GUI_SHOW)
		GUICtrlSetState($__Run, $GUI_SHOW)
		GUICtrlSetState($Newer, $GUI_SHOW)
		$Shown = True
		Sleep(100)
	EndIf
EndFunc
