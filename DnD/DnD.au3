#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <Misc.au3>

Global $X, $Y, $W
Global $Msg
Global $Graph
Global $Dir = @ScriptDir & "\Profiles\"
Global $Num
Global $Renew

Global $_GUI[04]
Global $Menu[02], $Item[05], $Dice[40], $Roll[40], $Info[04], $Done[03]
Global $Size[02][04]

$Info[0] = 12
$Info[1] = 11
$Info[2] = 07
$Info[3] = 06
Global $Label[$Info[0] + $Info[1] + $Info[2]][4] = [["Character", 0, 0, 3], _
		["Player"                             , 0, 4, 3], _
		["Class"                              , 2, 0, 1], _
		["Race"                               , 2, 2, 1], _
		["Alignment"                          , 2, 4, 1], _
		["Gender"                             , 2, 6, 1], _
		["Size"                               , 3, 0, 1], _
		["Height"                             , 3, 2, 1], _
		["Weight (lbs)"                       , 3, 4, 1], _
		["Age"                                , 3, 6, 1], _
		["Looks"                              , 4, 0, 3], _
		["Religion"                           , 4, 4, 3], _
		["Hit Points"                         , 1, 0, 1], _
		["Speed"                              , 1, 2, 1], _
		["Touch" & @CRLF & "Armor Class"      , 1, 4, 1], _
		["Flat-Footed" & @CRLF & "Armor Class", 1, 6, 1], _
		["Base" & @CRLF & "Attack Bonus"      , 2, 0, 1], _
		["Spell" & @CRLF & "Resistance"       , 2, 2, 1], _
		["Ailments /" & @CRLF & "Wounds"      , 2, 4, 3], _
		["Copper" & @CRLF & "Pieces"          , 1, 0, 1], _
		["Silver" & @CRLF & "Pieces"          , 1, 2, 1], _
		["Gold" & @CRLF & "Pieces"            , 1, 4, 1], _
		["Platinum" & @CRLF & "Pieces"        , 1, 6, 1], _
		["Character" & @CRLF & "Statistic"    , 2, 0, 2], _
		["Total" & @CRLF & "Score"            , 2, 2, 1], _
		["Base" & @CRLF & "Score"             , 2, 3, 1], _
		["Racial" & @CRLF & "Modifier"        , 2, 4, 1], _
		["Enhancement" & @CRLF & "Bonuses"    , 2, 5, 1], _
		["Misc"                               , 2, 6, 1], _
		["Stat" & @CRLF & "Modifier"          , 2, 7, 1]]
Global $Input[$Info[0] + $Info[1]]
Global $Stats[$Info[3]] = ["Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom", "Charisma"]
Global $Total[$Info[3]]
Global $Start[$Info[3]]
Global $RaceM[$Info[3]]
Global $Bonus[$Info[3]]
Global $_Misc[$Info[3]]
Global $_Modi[$Info[3]]

GUI()

Func GUI()

	$_GUI[00] = GUICreate("D&D Tracking Program" , 600, 330, -01, -01, 0x80C10280, 0x00000010)

	GUISetFont(8.5, 400, 0, "MS Serif")

	$Menu[00] = GUICtrlCreateMenu("&File")
	$Item[00] = GUICtrlCreateMenuItem("&New" , $Menu[00], 1)
				GUICtrlCreateMenuItem(""     , $Menu[00], 2)
	$Item[01] = GUICtrlCreateMenuItem("&Open", $Menu[00], 3)
	$Item[02] = GUICtrlCreateMenuItem("&Save", $Menu[00], 4)
				GUICtrlCreateMenuItem(""     , $Menu[00], 5)
	$Item[03] = GUICtrlCreateMenuItem("E&xit", $Menu[00], 6)
;	$Menu[01] = GUICtrlCreateMenu("&Options")
;	$Item[04] = GUICtrlCreateMenuItem("Clear Inventory", $Menu[01], 1)

	For $Loop = 0 To 1 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 010 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001201)
		$Input[$Loop] = GUICtrlCreateInput("",  $X + 68, $Y, $W, 020, 0x00000301)
	Next

	GUICtrlCreateTab(000, 040, 600, 380, 0x00000040)

	GUICtrlCreateTabItem("Character Profile")

	For $Loop = 2 To 9 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 010 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001201)
		$Input[$Loop] = GUICtrlCreateLabel("", $X + 68, $Y, $W, 020, 0x00001201)
		GUICtrlSetBkColor(-1, 0xFFFFFF)
	Next

	For $Loop = 10 To $Info[0] - 1 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 010 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001201)
		$Input[$Loop] = GUICtrlCreateInput("", $X + 68, $Y, $W, 020, 0x00001301)
		GUICtrlSetBkColor(-1, 0xFFFFFF)
	Next

	GUICtrlCreateLabel("", 5, 170, 590, 5, 0x00001000)

	For $Loop = $Info[0] To $Info[0] + 1 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 160 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001201)
		$Input[$Loop] = GUICtrlCreateInput("",  $X + 68, $Y, $W, 020, 0x00002301)
	Next

	GUISetFont(7, 400, 0, "MS Serif")

	For $Loop = $Info[0] + 2 To $Info[0] + 6 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 160 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001001)
		If $Loop = $Info[0] + 4 Or $Loop = $Info[0] + 5 Then
			$Input[$Loop] = GUICtrlCreateInput("",  $X + 68, $Y, $W, 020, 0x00000301)
		Else
			$Input[$Loop] = GUICtrlCreateInput("",  $X + 68, $Y, $W, 020, 0x00002301)
		EndIf
	Next

	GUICtrlCreateLabel("", 5, 260, 590, 5, 0x00001000)

	For $Loop = $Info[0] + 7 To $Info[0] + $Info[1] - 1 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 250 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, 68, 020, 0x00001001)
		$Input[$Loop] = GUICtrlCreateInput("",  $X + 68, $Y, $W, 020, 0x00002301)
	Next

	GUISetFont(8.5, 400, 0, "MS Serif")

	GUICtrlCreateTabItem("Statistics")

	GUISetFont(7, 400, 0, "MS Serif")
	For $Loop = $Info[0] + $Info[1] To $Info[0] + $Info[1] + $Info[2] - 1 Step 1
		$X = 028 + $Label[$Loop][2] * 068
		$Y = 010 + $Label[$Loop][1] * 030
		$W = 000 + $Label[$Loop][3] * 068
		GUICtrlCreateLabel($Label[$Loop][0], $X, $Y, $W, 020, 0x00001001)
	Next
	For $Loop = 0 To $Info[3] - 1 Step 1
		$Y = 100 + $Loop * 030
		GUICtrlCreateLabel($Stats[$Loop], 028, $Y, 136, 020, 0x00001201)
		$Total[$Loop] = GUICtrlCreateLabel("0", 164, $Y, 68, 020, 0x00001201)
		$Start[$Loop] = GUICtrlCreateInput("0", 232, $Y, 68, 020, 0x00000101)
		$RaceM[$Loop] = GUICtrlCreateLabel("0", 300, $Y, 68, 020, 0x00001201)
		$Bonus[$Loop] = GUICtrlCreateInput("0", 368, $Y, 68, 020, 0x00000101)
		$_Misc[$Loop] = GUICtrlCreateInput("0", 436, $Y, 68, 020, 0x00000101)
		$_Modi[$Loop] = GUICtrlCreateLabel("0", 504, $Y, 68, 020, 0x00001201)
	Next
	$Renew = GUICtrlCreateButton("Calculate Total Values for All Stats", 028, 280, 272, 020)
	$Reset = GUICtrlCreateButton("Reset Values for All Stats", 300, 280, 272, 020)

	GUICtrlCreateTabItem("Dice")
	$Num = 0
	For $Diy = 68 To 98 Step 30
		For $Dix = 30 To 555 Step 30
			$Dice[$Num] = GUICtrlCreateInput("0", $Dix, $Diy + 000, 30, 20, 0x00002301)
			$Roll[$Num] = GUICtrlCreateLabel("0", $Dix, $Diy + 182, 30, 20, 0x00001201)
			$Num += 1
		Next
	Next
	$Num = 0
	$Run = GUICtrlCreateButton("ROLL", 30, 154, 540, 60)

	GUICtrlCreateTabItem("")

	Clear_All_Fields()
	GUISetState()

	Set_Age()
	Set_Height()
	Set_Weight()

	If $CmdLine[0] >= 1 Then Load_Character_Profile()

	While 1
		$Msg = GUIGetMsg(1)
		Switch $Msg[0]
			Case $GUI_EVENT_CLOSE
				If $Msg[1] = $_GUI[00] Then
					Save_Character_Profile(1)
					Exit(0)
				Else
					GUISetState(@SW_HIDE, $Msg[1])
				EndIf

			Case $Done[00]
				GUICtrlSetData($Input[07], GUICtrlRead($Size[00][00]) & GUICtrlRead($Size[00][01]))
				GUISetState(@SW_HIDE, $_GUI[01])

			Case $Done[01]
				GUICtrlSetData($Input[08], GUICtrlRead($Size[01][02]))
				GUISetState(@SW_HIDE, $_GUI[02])

			Case $Done[02]
				GUICtrlSetData($Input[09], GUICtrlRead($Size[01][03]))
				GUISetState(@SW_HIDE, $_GUI[03])

			Case $Item[00]
				Save_Character_Profile(1)
				Clear_All_Fields()

			Case $Item[01]
				Save_Character_Profile(1)
				Load_Character_Profile()

			Case $Item[02]
				Save_Character_Profile(0)

			Case $Item[03]
				Save_Character_Profile(1)
				Exit(0)

			Case $Input[02]
				Update_Class()

			Case $Input[03]
				Update_Race()
				If WinExists($_GUI[01]) Then Set_Height_Limits()

			Case $Input[04]
				Update_Alignment()

			Case $Input[05]
				Update_Gender()

			Case $Input[07]
				GUISetState(@SW_SHOW, $_GUI[01])
				Set_Height_Limits()

			Case $Input[08]
				GUISetState(@SW_SHOW, $_GUI[02])
				Set_Weight_Limits()

			Case $Input[09]
				GUISetState(@SW_SHOW, $_GUI[03])
				Set_Age_Limits()

			Case $Size[01][00]
				Update_Inch_Limits()
				GUICtrlSetData($Size[00][00], GUICtrlRead($Size[01][00]) & "'")
				GUICtrlSetData($Size[00][01], GUICtrlRead($Size[01][01]) & '"')

			Case $Size[01][01]
				GUICtrlSetData($Size[00][01], GUICtrlRead($Size[01][01]) & '"')

			Case $Size[01][02]
				GUICtrlSetData($Size[00][02], GUICtrlRead($Size[01][02]))

			Case $Size[01][03]
				GUICtrlSetData($Size[00][03], GUICtrlRead($Size[01][03]))

			Case $Reset
				Clear_All_Statistics()

			Case $Run
				For $Num = 0 To 39 Step 1
					GUICtrlSetData($Roll[$Num], Random(1, GUICtrlRead($Dice[$Num]), 1))
				Next

			Case $Renew
				Update_Statistics()

			Case Else
				;;;
		EndSwitch
	WEnd
EndFunc

Func Clear_All_Fields()
	For $Loop = 0 To $Info[0] + $Info [1] - 1 Step 1
		GUICtrlSetData($Input[$Loop], "")
	Next
	GUICtrlSetData($Input[02], "Fighter"     )
	GUICtrlSetData($Input[03], "Human"       )
	GUICtrlSetData($Input[04], "True Neutral")
	GUICtrlSetData($Input[06], "Medium"      )
	Clear_All_Statistics()
EndFunc

Func Clear_All_Statistics()
	For $Loop = 0 To $Info[3] - 1 Step 1
		GUICtrlSetData($Total[$Loop], "0")
		GUICtrlSetData($Start[$Loop], "0")
		GUICtrlSetData($RaceM[$Loop], "0")
		GUICtrlSetData($Bonus[$Loop], "0")
		GUICtrlSetData($_Misc[$Loop], "0")
		GUICtrlSetData($_Modi[$Loop], "0")
	Next
EndFunc

Func Load_Character_Profile()
	If $CmdLine[0] >= 1 Then
		If StringRight($CmdLine[1], 5) = ".dndp" Then
			$INI = $Dir & $CmdLine[1]
		Else
			$INI = $Dir & $CmdLine[1] & ".dndp"
		EndIf
		If Not FileExists($INI) Then
			ConsoleWriteError("No Such D&D Profile! Exiting..." & @CRLF)
			Exit(1)
		EndIf
	Else
		$INI = FileOpenDialog("Select Profile to Load", ".\Profiles\", "D&D Profiles (*.dndp)", 1)
	EndIf
	ConsoleWrite("Loading Profile from " & $INI & @CRLF)
	GUICtrlSetData($Input[00],                INIRead($INI, "Main" , "Character"        , ""            ))
	GUICtrlSetData($Input[01],                INIRead($INI, "Main" , "Player"           , ""            ))
	GUICtrlSetData($Input[02],                INIRead($INI, "Info" , "Class"            , "Fighter"     ))
	GUICtrlSetData($Input[03],                INIRead($INI, "Info" , "Race"             , "Human"       ))
	GUICtrlSetData($Input[04],                INIRead($INI, "Info" , "Alignment"        , "True Neutral"))
	GUICtrlSetData($Input[05],                INIRead($INI, "Info" , "Gender"           , ""            ))
	GUICtrlSetData($Input[06],                INIRead($INI, "Info" , "Size"             , "Medium"      ))
	GUICtrlSetData($Input[07],                INIRead($INI, "Info" , "Height"           , "5'0"         ))
	GUICtrlSetData($Input[08],                INIRead($INI, "Info" , "Weight"           , "0 lbs"       ))
	GUICtrlSetData($Input[09],                INIRead($INI, "Info" , "Age"              , "0"           ))
	GUICtrlSetData($Input[10],                INIRead($INI, "Info" , "Looks"            , "Undecided"   ))
	GUICtrlSetData($Input[11],                INIRead($INI, "Info" , "Religion"         , "Undecided"   ))
	GUICtrlSetData($Input[12],                INIRead($INI, "Stats", "Hit Points"       , "0"           ))
	GUICtrlSetData($Input[13],                INIRead($INI, "Stats", "Speed"            , "0"           ))
	GUICtrlSetData($Input[14],                INIRead($INI, "Stats", "Touch AC"         , "0"           ))
	GUICtrlSetData($Input[15],                INIRead($INI, "Stats", "Flat-Footed AC"   , "0"           ))
	GUICtrlSetData($Input[16],                INIRead($INI, "Stats", "Base Attack Bonus", "0"           ))
	GUICtrlSetData($Input[17],                INIRead($INI, "Stats", "Spell Resistance" , "0"           ))
	GUICtrlSetData($Input[18],                INIRead($INI, "Stats", "Ailments / Wounds", "Healthy"     ))
	GUICtrlSetData($Input[19],                INIRead($INI, "Money", "Copper Pieces"    , "0"           ))
	GUICtrlSetData($Input[20],                INIRead($INI, "Money", "Silver Pieces"    , "0"           ))
	GUICtrlSetData($Input[21],                INIRead($INI, "Money", "Gold Pieces"      , "0"           ))
	GUICtrlSetData($Input[22],                INIRead($INI, "Money", "Platinum Pieces"  , "0"           ))
	GUICtrlSetData($Start[00],                INIRead($INI, "Stats", "Base Strength"    , "0"           ))
	GUICtrlSetData($RaceM[00],                INIRead($INI, "Stats", "Race Strength"    , "0"           ))
	GUICtrlSetData($Start[01],                INIRead($INI, "Stats", "Base Dexterity"   , "0"           ))
	GUICtrlSetData($RaceM[01],                INIRead($INI, "Stats", "Race Dexterity"   , "0"           ))
	GUICtrlSetData($Start[02],                INIRead($INI, "Stats", "Base Constitution", "0"           ))
	GUICtrlSetData($RaceM[02],                INIRead($INI, "Stats", "Race Constitution", "0"           ))
	GUICtrlSetData($Start[03],                INIRead($INI, "Stats", "Base Intelligence", "0"           ))
	GUICtrlSetData($RaceM[03],                INIRead($INI, "Stats", "Race Intelligence", "0"           ))
	GUICtrlSetData($Start[04],                INIRead($INI, "Stats", "Base Wisdom"      , "0"           ))
	GUICtrlSetData($RaceM[04],                INIRead($INI, "Stats", "Race Wisdom"      , "0"           ))
	GUICtrlSetData($Start[05],                INIRead($INI, "Stats", "Base Charisma"    , "0"           ))
	GUICtrlSetData($RaceM[05],                INIRead($INI, "Stats", "Race Charisma"    , "0"           ))
EndFunc

Func Save_Character_Profile($Call)
	Switch $Call
		Case 0
			If Not FileExists($Dir) Then DirCreate(".\Profiles")
			ConsoleWrite("Saving Profile to " & $Dir & GUICtrlRead($Input[00]) & ".dndp" & @CRLF)
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "READ!", "Program"          , "D&D Tracking Program - Developer Build File")
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "READ!", "WARNING"          , "Do Not Ever Manually Edit This File."       )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Main" , "Character"        , GUICtrlRead($Input[00])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Main" , "Player"           , GUICtrlRead($Input[01])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Class"            , GUICtrlRead($Input[02])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Race"             , GUICtrlRead($Input[03])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Alignment"        , GUICtrlRead($Input[04])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Gender"           , GUICtrlRead($Input[05])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Size"             , GUICtrlRead($Input[06])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Height"           , GUICtrlRead($Input[07])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Weight"           , GUICtrlRead($Input[08])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Age"              , GUICtrlRead($Input[09])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Looks"            , GUICtrlRead($Input[10])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Info" , "Religion"         , GUICtrlRead($Input[11])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Hit Points"       , GUICtrlRead($Input[12])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Speed"            , GUICtrlRead($Input[13])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Touch AC"         , GUICtrlRead($Input[14])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Flat-Footed AC"   , GUICtrlRead($Input[15])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Attack Bonus", GUICtrlRead($Input[16])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Spell Resistance" , GUICtrlRead($Input[17])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Ailments / Wounds", GUICtrlRead($Input[18])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Money", "Copper Pieces"    , GUICtrlRead($Input[19])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Money", "Silver Pieces"    , GUICtrlRead($Input[20])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Money", "Gold Pieces"      , GUICtrlRead($Input[21])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Money", "Platinum Pieces"  , GUICtrlRead($Input[22])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Strength"    , GUICtrlRead($Start[00])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Strength"    , GUICtrlRead($RaceM[00])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Dexterity"   , GUICtrlRead($Start[01])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Dexterity"   , GUICtrlRead($RaceM[01])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Constitution", GUICtrlRead($Start[02])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Constitution", GUICtrlRead($RaceM[02])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Intelligence", GUICtrlRead($Start[03])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Intelligence", GUICtrlRead($RaceM[03])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Wisdom"      , GUICtrlRead($Start[04])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Wisdom"      , GUICtrlRead($RaceM[04])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Base Charisma"    , GUICtrlRead($Start[05])                      )
			INIWrite($Dir & GUICtrlRead($Input[00]) & ".dndp", "Stats", "Race Charisma"    , GUICtrlRead($RaceM[05])                      )
		Case 1
			If MsgBox(0x00040024, "Save?", "Would you like to save before this action?") = "6" Then
				Save_Character_Profile(0)
			EndIf
		Case Else
			Exit(1)
	EndSwitch
EndFunc

Func Set_Age()
	$_GUI[03] = GUICreate("Weight Adjustment", 300, 080, -01, -01, 0x80C80200, 0x00000088)
	$Size[00][03] = GUICtrlCreateLabel(""    , 260, 010, 030, 020, 0x00001201)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Size[01][03] = GUICtrlCreateSlider(       010, 010, 250, 020, 0x00000001)
	$Done[02] = GUICtrlCreateButton("Ok", 260, 50, 30, 20)
	Set_Age_Limits()
EndFunc

Func Set_Age_Limits()
	Switch GUICtrlRead($Input[03])
		Case "Dwarf"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 450, 043)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 450, 045)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 450, 047)
			EndSwitch
		Case "Elf"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 750, 114)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 750, 116)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 750, 120)
			EndSwitch
		Case "Gnome"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 500, 044)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 500, 046)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 500, 049)
			EndSwitch
		Case "Half-Elf"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 185, 021)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 185, 022)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 185, 023)
			EndSwitch
		Case "Halfling"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 200, 022)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 200, 023)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 200, 024)
			EndSwitch
		Case "Half-Orc"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 080, 015)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 080, 015)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 080, 016)
			EndSwitch
		Case "Human"
			Switch GUICtrlRead($Input[02])
				Case "Barbarian" Or "Rogue" Or "Sorcerer"
					GUICtrlSetLimit($Size[01][03], 110, 016)
				Case "Bard" Or "Fighter" Or "Paladin" Or "Ranger"
					GUICtrlSetLimit($Size[01][03], 110, 016)
				Case "Cleric" Or "Druid" Or "Monk" Or "Wizard"
					GUICtrlSetLimit($Size[01][03], 110, 017)
			EndSwitch
		Case Else
			Exit(1)
	EndSwitch
EndFunc

Func Set_Height()
	$_GUI[01] = GUICreate("Height Adjustment", 300, 100              , -01, -01, 0x80C80200, 0x00000088)
	$Size[00][00] = GUICtrlCreateLabel(""    , 260, 010, 030, 020, 0x00001201)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Size[01][00] = GUICtrlCreateSlider(       010, 010, 250, 020, 0x00000001)
	$Size[00][01] = GUICtrlCreateLabel(""    , 260, 030, 030, 020, 0x00001201)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Size[01][01] = GUICtrlCreateSlider(       010, 030, 250, 020, 0x00000001)
	$Done[00] = GUICtrlCreateButton("Ok", 260, 70, 30, 20)
	GUICtrlSetData($Size[01][00], StringRight(StringLeft(GUICtrlRead($Input[07]), 1), 1))
	GUICtrlSetData($Size[01][01], StringRight(StringLeft(GUICtrlRead($Input[07]), 3), 1))
	GUICtrlSetData($Size[00][00], GUICtrlRead($Size[01][00]) & "'")
	GUICtrlSetData($Size[00][01], GUICtrlRead($Size[01][01]) & '"')
	Set_Height_Limits()
EndFunc

Func Set_Height_Limits()
	Switch GUICtrlRead($Input[03])
		Case "Dwarf"
			GUICtrlSetLimit($Size[01][00], 004, 004)
			GUICtrlSetLimit($Size[01][01], 006, 000)
		Case "Elf"
			GUICtrlSetLimit($Size[01][00], 005, 004)
			GUICtrlSetLimit($Size[01][01], 011, 006)
		Case "Gnome"
			GUICtrlSetLimit($Size[01][00], 003, 003)
			GUICtrlSetLimit($Size[01][01], 006, 000)
		Case "Half-Elf"
			GUICtrlSetLimit($Size[01][00], 006, 005)
			GUICtrlSetLimit($Size[01][01], 011, 000)
		Case "Halfling"
			GUICtrlSetLimit($Size[01][00], 003, 003)
			GUICtrlSetLimit($Size[01][01], 000, 000)
		Case "Half-Orc"
			GUICtrlSetLimit($Size[01][00], 007, 006)
			GUICtrlSetLimit($Size[01][01], 011, 000)
		Case "Human"
			GUICtrlSetLimit($Size[01][00], 006, 005)
			GUICtrlSetLimit($Size[01][01], 011, 000)
		Case Else
			Exit(1)
	EndSwitch
EndFunc

Func Set_Weight()
	$_GUI[02] = GUICreate("Weight Adjustment", 300, 080, -01, -01, 0x80C80200, 0x00000088)
	$Size[00][02] = GUICtrlCreateLabel(""    , 260, 010, 030, 020, 0x00001201)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Size[01][02] = GUICtrlCreateSlider(       010, 010, 250, 020, 0x00000001)
	$Done[01] = GUICtrlCreateButton("Ok", 260, 50, 30, 20)
	GUICtrlSetData($Size[01][02], GUICtrlRead($Input[08]))
	GUICtrlSetData($Size[00][02], GUICtrlRead($Size[01][02]))
	Set_Weight_Limits()
EndFunc

Func Set_Weight_Limits()
	Switch GUICtrlRead($Input[03])
		Case "Dwarf"
			GUICtrlSetLimit($Size[01][02], 250, 125)
		Case "Elf"
			GUICtrlSetLimit($Size[01][02], 135, 095)
		Case "Gnome"
			GUICtrlSetLimit($Size[01][02], 045, 040)
		Case "Half-Elf"
			GUICtrlSetLimit($Size[01][02], 180, 100)
		Case "Halfling"
			GUICtrlSetLimit($Size[01][02], 035, 030)
		Case "Half-Orc"
			GUICtrlSetLimit($Size[01][02], 250, 190)
		Case "Human"
			GUICtrlSetLimit($Size[01][02], 250, 125)
		Case Else
			Exit(1)
	EndSwitch
EndFunc

Func Update_Inch_Limits()
	Switch GUICtrlRead($Input[03])
		Case "Elf"
			If GUICtrlRead($Size[01][00]) = 4 Then
				GUICtrlSetLimit($Size[01][01], 011, 006)
			Else
				GUICtrlSetLimit($Size[01][01], 006, 000)
			EndIf
		Case "Half-Elf"
			If GUICtrlRead($Size[01][00]) = 5 Then
				GUICtrlSetLimit($Size[01][01], 011, 000)
			Else
				GUICtrlSetLimit($Size[01][01], 000, 000)
			EndIf
		Case "Half-Orc"
			If GUICtrlRead($Size[01][00]) = 6 Then
				GUICtrlSetLimit($Size[01][01], 011, 000)
			Else
				GUICtrlSetLimit($Size[01][01], 000, 000)
			EndIf
		Case "Human"
			If GUICtrlRead($Size[01][00]) = 5 Then
				GUICtrlSetLimit($Size[01][01], 011, 000)
			Else
				GUICtrlSetLimit($Size[01][01], 000, 000)
			EndIf
		Case Else
			Exit(1)
	EndSwitch
EndFunc

Func Update_Alignment()
	Switch GUICtrlRead($Input[02])
		Case "Barbarian"
			Switch GUICtrlRead($Input[04])
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case Else
					GUICtrlSetData($Input[04], "Neutral Good")
			EndSwitch
		Case "Bard"
			Switch GUICtrlRead($Input[04])
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case Else
					GUICtrlSetData($Input[04], "Neutral Good")
			EndSwitch
		Case "Cleric"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Druid"
			Switch GUICtrlRead($Input[04])
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case Else
					GUICtrlSetData($Input[04], "Neutral Good")
			EndSwitch
		Case "Fighter"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Monk"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Paladin"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Ranger"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Rogue"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Sorcerer"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case "Wizard"
			Switch GUICtrlRead($Input[04])
				Case "Lawful Good"
					GUICtrlSetData($Input[04], "Neutral Good")
				Case "Neutral Good"
					GUICtrlSetData($Input[04], "Chaotic Good")
				Case "Chaotic Good"
					GUICtrlSetData($Input[04], "Lawful")
				Case "Lawful"
					GUICtrlSetData($Input[04], "True Neutral")
				Case "True Neutral"
					GUICtrlSetData($Input[04], "Chaotic")
				Case "Chaotic"
					GUICtrlSetData($Input[04], "Lawful Evil")
				Case "Lawful Evil"
					GUICtrlSetData($Input[04], "Neutral Evil")
				Case "Neutral Evil"
					GUICtrlSetData($Input[04], "Chaotic Evil")
				Case "Chaotic Evil"
					GUICtrlSetData($Input[04], "Lawful Good")
				Case Else
					GUICtrlSetData($Input[04], "Lawful Good")
			EndSwitch
		Case Else
			Switch GUICtrlRead($Input[04])
				Case "True Neutral"
					GUICtrlSetData($Input[04], "True Neutral")
				Case Else
					GUICtrlSetData($Input[04], "True Neutral")
			EndSwitch
	EndSwitch
EndFunc

Func Update_Class()
	Switch GUICtrlRead($Input[02])
		Case "Barbarian"
			GUICtrlSetData($Input[02], "Bard")
			GUICtrlSetData($Input[04], "Chaotic")
		Case "Bard"
			GUICtrlSetData($Input[02], "Cleric")
			GUICtrlSetData($Input[04], "True Neutral")
		Case "Cleric"
			GUICtrlSetData($Input[02], "Druid")
			GUICtrlSetData($Input[04], "True Neutral")
		Case "Druid"
			GUICtrlSetData($Input[02], "Fighter")
			GUICtrlSetData($Input[04], "True Neutral")
		Case "Fighter"
			GUICtrlSetData($Input[02], "Monk")
			GUICtrlSetData($Input[04], "Lawful")
		Case "Monk"
			GUICtrlSetData($Input[02], "Paladin")
			GUICtrlSetData($Input[04], "Lawful Good")
		Case "Paladin"
			GUICtrlSetData($Input[02], "Ranger")
			GUICtrlSetData($Input[04], "Chaotic Good")
		Case "Ranger"
			GUICtrlSetData($Input[02], "Rogue")
			GUICtrlSetData($Input[04], "Chaotic")
		Case "Rogue"
			GUICtrlSetData($Input[02], "Sorcerer")
			GUICtrlSetData($Input[04], "True Neutral")
		Case "Sorcerer"
			GUICtrlSetData($Input[02], "Wizard")
			GUICtrlSetData($Input[04], "Lawful")
		Case "Wizard"
			GUICtrlSetData($Input[02], "Undecided")
			GUICtrlSetData($Input[04], "True Neutral")
		Case "Undecided"
			GUICtrlSetData($Input[02], "Barbarian")
			GUICtrlSetData($Input[04], "Chaotic")
		Case Else
			GUICtrlSetData($Input[02], "Barbarian")
			GUICtrlSetData($Input[04], "Chaotic")
	EndSwitch
EndFunc

Func Update_Gender()
	Switch GUICtrlRead($Input[05])
		Case "Female"
			GUICtrlSetData($Input[05], "Male")
		Case "Male"
			GUICtrlSetData($Input[05], "Female")
		Case Else
			GUICtrlSetData($Input[05], "Female")
	EndSwitch
EndFunc

Func Update_Race()
	Switch GUICtrlRead($Input[03])
		Case "Dwarf"
			GUICtrlSetData($Input[03], "Elf")
			GUICtrlSetData($Input[06], "Medium")
		Case "Elf"
			GUICtrlSetData($Input[03], "Gnome")
			GUICtrlSetData($Input[06], "Small")
		Case "Gnome"
			GUICtrlSetData($Input[03], "Half-Elf")
			GUICtrlSetData($Input[06], "Medium")
		Case "Half-Elf"
			GUICtrlSetData($Input[03], "Halfling")
			GUICtrlSetData($Input[06], "Small")
		Case "Halfling"
			GUICtrlSetData($Input[03], "Half-Orc")
			GUICtrlSetData($Input[06], "Medium")
		Case "Half-Orc"
			GUICtrlSetData($Input[03], "Human")
			GUICtrlSetData($Input[06], "Medium")
		Case "Human"
			GUICtrlSetData($Input[03], "Elf")
			GUICtrlSetData($Input[06], "Medium")
		Case Else
			GUICtrlSetData($Input[03], "Elf")
			GUICtrlSetData($Input[06], "Medium")
	EndSwitch
EndFunc

Func Update_Statistics()
	Switch GUICtrlRead($Input[03])
		Case "Dwarf"
			GUICtrlSetData($RaceM[00],  "0")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02], "+2")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05], "-2")
		Case "Elf"
			GUICtrlSetData($RaceM[00],  "0")
			GUICtrlSetData($RaceM[01], "+2")
			GUICtrlSetData($RaceM[02], "-2")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
		Case "Gnome"
			GUICtrlSetData($RaceM[00], "-2")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02], "+2")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
		Case "Half-Elf"
			GUICtrlSetData($RaceM[00],  "0")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02],  "0")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
		Case "Halfling"
			GUICtrlSetData($RaceM[00], "-2")
			GUICtrlSetData($RaceM[01], "+2")
			GUICtrlSetData($RaceM[02],  "0")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
		Case "Half-Orc"
			GUICtrlSetData($RaceM[00], "+2")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02],  "0")
			GUICtrlSetData($RaceM[03], "-2")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05], "-2")
		Case "Human"
			GUICtrlSetData($RaceM[00],  "0")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02],  "0")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
		Case Else
			GUICtrlSetData($RaceM[00],  "0")
			GUICtrlSetData($RaceM[01],  "0")
			GUICtrlSetData($RaceM[02],  "0")
			GUICtrlSetData($RaceM[03],  "0")
			GUICtrlSetData($RaceM[04],  "0")
			GUICtrlSetData($RaceM[05],  "0")
	EndSwitch
	For $Loop = 0 To $Info[3] - 1
		GUICtrlSetData($Total[$Loop], GUICtrlRead($Start[$Loop]) + GUICtrlRead($RaceM[$Loop]) + GUICtrlRead($Bonus[$Loop]) + GUICtrlRead($_Misc[$Loop]))
		GUICtrlSetData($_Modi[$Loop], Int(((GUICtrlRead($Start[$Loop]) + GUICtrlRead($RaceM[$Loop])) / 2)) - 5)
	Next
EndFunc