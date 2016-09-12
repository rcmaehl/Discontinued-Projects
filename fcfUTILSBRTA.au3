If _Singleton("FCF_UTILS",1) = 0 Then Exit
#NoTrayIcon
#include <Misc.au3>
#include <Crypt.au3>
#include <GuiConstantsEx.au3>
#include <Date.au3>

ProgressOn( "Please Wait", "Collecting System Info...", "Starting...")

	ProgressSet( 5, "Started...")
	ProgressSet( 11, "Preparing for Variables...")

	Opt('MustDeclareVars', 1)

	ProgressSet( 16, "Prepared...")
	ProgressSet( 21, "Disabling Close on ESC...")

	Opt('GUICloseOnESC', 0)

	ProgressSet( 26, "Close on ESC Disabled...")
	ProgressSet( 32, "Preparing For GUI...")
	ProgressSet( 37, "Loading Variables...")

		;Msg Variable
		Local $Msg
		;Unseen Variables
		Local $hKey, $PixFixWin, $CPUUsage, $Date, $Time, $AvgCPU, $Collected, $CPUTotal, $WINE, $RefreshTimerA, $RefreshTimerB, $RAMCollected, $RAM, $AvgRAM, $RAMTotal
		Local $Ran1, $Ran2, $Ran3, $Ran4, $Ran5, $Ran6, $StressInit, $StressTimer, $Numbers, $Download, $Exists, $Del, $DID, $DIfS, $Typeperf, $Ver
		Local $Line1, $Line2, $Line3, $Line4, $Line5, $Line6, $Line7, $Line8, $Line9, $TypePerfPID, $DIT, $DIS, $DIC, $DIN, $DII, $DIfSP
		;Seen Variables
		Local $Credits, $CreditsOK, $DriveInfo, $DrivesOK, $DrivesGO
		;Menu Variables
		Local $FileMenu, $DriveMenu, $DisplayMenu, $ToolsMenu, $ETCMenu, $CPUMenu, $HelpMenu, $SaveItem, $DriveInfoItem, $CreditsItem, $USBHijack, $StressItem, $PixelFixItem, $ContextMenu, $ExitItem, $RecycleItem, $RefreshItem, $RefreshContext
		;Main Tab Variables
		Local $MainTab, $LiveMonitoring, $TimeLabel, $OSVersion, $OSServicePack, $Language, $DisplayWLabel, $DisplayHLabel, $DisplayDLabel, $DisplayRLabel, $DisplaysLabel
		;CPU and RAM Tab Variables
		Local $RAMUsage, $AvgRAMBar
		Local $CPU, $AvgCPUBar, $WINECPUMsg, $WINEAvgCPUBarMsg
		Local $RGB1, $RGB2, $RGB3, $RGB4, $RGB5, $RGB6, $RGB7, $RGB8, $RGB9, $RGB10, $RGB11, $RGB12, $RGB13, $RGB14, $RGB15, $RGB16, $RGB17, $RGB18
		Local $CGB1, $CGB2, $CGB3, $CGB4, $CGB5, $CGB6, $CGB7, $CGB8, $CGB9, $CGB10, $CGB11, $CGB12, $CGB13, $CGB14, $CGB15, $CGB16, $CGB17, $CGB18
		;Network Tab Variables
		Local $IP1, $IP2, $IP3, $IP4, $DNSDomain, $Domain, $Server
		;Drives Tab Variables
		Local $DriveAType, $DriveBType, $DriveCType, $DriveDType, $DriveEType, $DriveFType, $DriveGType, $DriveHType, $DriveIType, $DriveJType, $DriveKType, $DriveLType
		Local $DriveMType, $DriveNType, $DriveOType, $DrivePType, $DriveQType, $DriveRType, $DriveSType, $DriveTType, $DriveUType, $DriveVType, $DriveWType, $DriveXType, $DriveYType, $DriveZType
		Local $DriveATypeLabel, $DriveBTypeLabel, $DriveCTypeLabel, $DriveDTypeLabel, $DriveETypeLabel, $DriveFTypeLabel, $DriveGTypeLabel, $DriveHTypeLabel, $DriveITypeLabel, $DriveJTypeLabel, $DriveKTypeLabel, $DriveLTypeLabel
		Local $DriveMTypeLabel, $DriveNTypeLabel, $DriveOTypeLabel, $DrivePTypeLabel, $DriveQTypeLabel, $DriveRTypeLabel, $DriveSTypeLabel, $DriveTTypeLabel, $DriveUTypeLabel, $DriveVTypeLabel, $DriveWTypeLabel, $DriveXTypeLabel, $DriveYTypeLabel, $DriveZTypeLabel
		Local $DriveAFree, $DriveBFree, $DriveCFree, $DriveDFree, $DriveEFree, $DriveFFree, $DriveGFree, $DriveHFree, $DriveIfree, $DriveJFree, $DriveKFree, $DriveLFree 
		Local $DriveMFree, $DriveNFree, $DriveOFree, $DrivePFree, $DriveQFree, $DriveRFree, $DriveSFree, $DriveTFree, $DriveUFree, $DriveVFree, $DriveWFree, $DriveXFree, $DriveYFree, $DriveZFree
		Local $DriveAFreePos, $DriveBFreePos, $DriveCFreePos, $DriveDFreePos, $DriveEFreePos, $DriveFFreePos, $DriveGFreePos, $DriveHFreePos, $DriveIfreePos, $DriveJFreePos, $DriveKFreePos, $DriveLFreePos
		Local $DriveMFreePos, $DriveNFreePos, $DriveOFreePos, $DrivePFreePos, $DriveQFreePos, $DriveRFreePos, $DriveSFreePos, $DriveTFreePos, $DriveUFreePos, $DriveVFreePos, $DriveWFreePos, $DriveXFreePos, $DriveYFreePos, $DriveZFreePos
		Local $DriveAEject, $DriveBEject, $DriveCEject, $DriveDEject, $DriveEEject, $DriveFEject, $DriveGEject, $DriveHEject, $DriveIEject
		Local $DriveJEject, $DriveKEject, $DriveLEject, $DriveMEject, $DriveNEject, $DriveOEject, $DrivePEject, $DriveQEject, $DriveREject, $DriveSEject, $DriveTEject, $DriveUEject, $DriveVEject, $DriveWEject, $DriveXEject, $DriveYEject, $DriveZEject
		Local $DriveALoad, $DriveBLoad, $DriveCLoad, $DriveDLoad, $DriveELoad, $DriveFLoad, $DriveGLoad, $DriveHLoad, $DriveILoad, $DriveJLoad, $DriveKLoad, $DriveLLoad, $DriveMLoad, $DriveNLoad, $DriveOLoad
		Local $DrivePLoad, $DriveQLoad, $DriveRLoad, $DriveSLoad, $DriveTLoad, $DriveULoad, $DriveVLoad, $DriveWLoad, $DriveXLoad, $DriveYLoad, $DriveZLoad
		;Etc Tab Variable
		Local $RUN, $Browse, $BrowseFile, $PixFixInt, $Submit, $KillPID, $ExecKillPID, $Kill, $ExecKill, $Encrypt, $Decrypt, $EncryptString, $DecryptString, $PixFixTimer
		Local $Edit, $EditBrowse, $EditFile, $EditSubmit, $Format_Drive, $Format_FS, $Format_Mode, $Format_AUS
		;Variables End

	ProgressSet( 42, "Variables Loaded...")
	ProgressSet( 47, "Checking if running in WINE...")

		If @DesktopRefresh = 0 Then 
			$WINE = True
			$LiveMonitoring = "Some Unavailable"
		Else
			ProgressSet( 47, "Preparing Encyrption...")
			_Crypt_Startup()
			$hKey=_Crypt_DeriveKey("F(F_U71|1713$_1337_3|\|(RYP710|\|_K3Y",$CALG_RC4)
			$WINE = False
			$LiveMonitoring = "Enabled"
			$Ver = "1.0.1.0"
			ProgressSet( 53, "Encryption Loaded...")
		EndIf

	ProgressSet( 63, "WINE Check Complete...")
	ProgressSet( 68, "Loading Monitors...")

		If @OSVersion = "WIN_VISTA" Or @OSVersion = "WIN_7" Or @OSVersion = "WIN_XP" Then
			If Not $WINE Then 
				FileDelete(@TempDir & "\cpu.csv")
				Run('typeperf "\Processor(_Total)\% Processor Time" -y -si 00:00:00 -o ' & @TempDir & '\cpu.csv')
				WinWait( "[Class:ConsoleWindowClass]", "", 10)
				Sleep(200)
				WinSetState( "[Class:ConsoleWindowClass]", "", @SW_HIDE)
			EndIf
		EndIf

	ProgressSet( 74, "Monitors Loaded...")
	ProgressSet( 79, "Coverting Values to English...")

		$RAMUsage = MemGetStats()
		$RefreshTimerA = TimerInit()
		$RefreshTimerB = TimerInit()
		If @OSServicePack = "" Then $OSServicePack = "Original Version"
		If Not @OSServicePack = "" Then $OSServicePack = @OSServicePack
		If @OSVersion = "WIN_7" Then $OSVersion = "Windows 7"
		If @OSVersion = "WIN_VISTA" Then $OSVersion = "Windows Vista"
		If @OSVersion = "WIN_2008R2" Then $OSVersion = "Windows 2008 R2"
		If @OSVersion = "WIN_2008" Then $OSVersion = "Windows 2008"
		If @OSVersion = "WIN_XP" Then $OSVersion = "Windows XP"
		If @OSVersion = "WIN_2003" Then $OSVersion = "Windows 2003"
		If @OSVersion = "WIN_2000" Then $OSVersion = "Windows 2000"
		If StringTrimLeft(@OSLang, 2) = "01" Then $Language = "Arabic"
		If StringTrimLeft(@OSLang, 2) = "04" Then $Language = "Chinese"
		If StringTrimLeft(@OSLang, 2) = "13" Then $Language = "Dutch"
		If StringTrimLeft(@OSLang, 2) = "09" Then $Language = "English"
		If StringTrimLeft(@OSLang, 2) = "0c" Then $Language = "French"
		If StringTrimLeft(@OSLang, 2) = "07" Then $Language = "German"
		If StringTrimLeft(@OSLang, 2) = "10" Then $Language = "Italian"
		If StringTrimLeft(@OSLang, 2) = "0a" Then $Language = "Spanish"
		If $WINE Then $OSVersion = "Wine Windows"
		If $WINE Then $OSServicePack = "Virtual"

	ProgressSet( 84, "Values Converted...")
	ProgressSet( 89, "Getting Device Info...")

	DateTime()
	DriveInfo()

	ProgressSet( 99, "Device Info Collected...")
	ProgressSet( 100, "DONE!", "Loading GUI...")

ProgressOff()

_Main()

Func _Main()

	GUICreate("FCoFix Info + Utilites - Version " & $Ver, 400, 455, -1, -1, 0x00CA0080)
		GUISetFont(8, 400, 0, "Lucida Console")
		$ContextMenu = GUICtrlCreateContextMenu()
			$RefreshContext = GUICtrlCreateMenuItem("Refresh", $ContextMenu)
		$FileMenu = GUICtrlCreateMenu("File")
			$SaveItem = GUICtrlCreateMenuItem("Save", $FileMenu)
			$RefreshItem = GUICtrlCreateMenuItem("Refresh", $FileMenu)
			GUICtrlCreateMenuItem("", $FileMenu)
			$ExitItem = GUICtrlCreateMenuItem("Exit", $FileMenu)
		$ToolsMenu = GUICtrlCreateMenu("Utilites")
			$DriveMenu = GUICtrlCreateMenu("Drives", $ToolsMenu)
				$RecycleItem = GUICtrlCreateMenuItem("Delete Trash Files", $DriveMenu)
				$DriveInfoItem = GUICtrlCreateMenuItem("Details on Drive...", $DriveMenu)
			$DisplayMenu = GUICtrlCreateMenu( "Display", $ToolsMenu)
				$PixelFixItem = GUICtrlCreateMenuItem( "Pixel Fixer", $DisplayMenu)
			$CPUMenu = GUICtrlCreateMenu("CPU", $ToolsMenu)
				$StressItem = GUICtrlCreateMenuItem( "Stress Test", $CPUMenu)
			$ETCMenu = GUICtrlCreateMenu("Etc", $ToolsMenu)
				$USBHijack = GUICtrlCreateMenuItem("Remove USB Hijack Risks", $ETCMenu)
		$HelpMenu = GUICtrlCreateMenu("About")
			$CreditsItem = GUICtrlCreateMenuItem( "Credits", $HelpMenu)
		GUICtrlCreateLabel("Clock:", 0, 420, 250, 15, 0x1000)
		$TimeLabel = GUICtrlCreateLabel($date & "  " & $time, 250, 420, 150, 15, 0x1001)
		GUICtrlSetDefBkColor(0xFFFFFF)

		GUICtrlCreateTab(0, 0, 400, 419, 0x0148)
			$Maintab = GUICtrlCreateTabItem("Main")

				GUICtrlCreateLabel("User Name", 10, 25, 250, 25)
				GUICtrlCreateLabel("Computer Name:", 10, 50, -1, -1)
				GUICtrlCreateLabel("OS Language:", 10, 75, -1, -1)
				GUICtrlCreateLabel("Current OS:", 10, 100, -1, -1)
				GUICtrlCreateLabel("Service Pack:", 10, 125, -1, -1)
				GUICtrlCreateLabel("OS Build:", 10, 150, -1, -1)
				GUICtrlCreateLabel("Home Drive:", 10, 175, -1, -1)
				GUICtrlCreateLabel("Install Directory:", 10, 200, -1, -1)
				GUICtrlCreateLabel("Program Files Directory:", 10, 225, -1, -1)
				GUICtrlCreateLabel("Display Width:", 10, 250, -1, -1)
				GUICtrlCreateLabel("Display Height:", 10, 275, -1, -1)
				GUICtrlCreateLabel("Display Depth:", 10, 300, -1, -1)
				GUICtrlCreateLabel("Display Refresh:", 10, 325, -1, -1)
				GUICtrlCreateLabel("Display Simplified:", 10, 350, -1, -1)
				GUICtrlCreateLabel("Live Monitoring Status:", 10, 375, -1, -1)
				GUICtrlCreateInput(@UserName, 260, 25, 135, 20, 0x0801)
				GUICtrlCreateInput(@ComputerName, 260, 50, 135, 20, 0x0801)
				GUICtrlCreateInput($Language, 260, 75, 135, 20, 0x0801)
				GUICtrlCreateInput($OSVersion & " " & @OSArch, 260, 100, 135, 20, 0x0801)
				GUICtrlCreateInput($OSServicePack, 260, 125, 135, 20, 0x0801)
				GUICtrlCreateInput(@OSBuild, 260, 150, 135, 20, 0x0801)
				GUICtrlCreateInput(StringUpper(@HomeDrive) & "\", 260, 175, 135, 20, 0x0801)
				GUICtrlCreateInput(StringUpper(@WindowsDir) & "\", 260, 200, 135, 20, 0x0801)
				GUICtrlCreateInput(StringUpper(@ProgramFilesDir) & "\", 260, 225, 135, 20, 0x0801)
				$DisplayWLabel = GUICtrlCreateInput(@DesktopWidth & " Pixels", 260, 250, 135, 20, 0x0801)
				$DisplayHLabel = GUICtrlCreateInput(@DesktopHeight & " Pixels", 260, 275, 135, 20, 0x0801)
				$DisplayDLabel = GUICtrlCreateInput(@DesktopDepth & " Bits", 260, 300, 135, 20, 0x0801)
				$DisplayRLabel = GUICtrlCreateInput(@DesktopRefresh & " Hz", 260, 325, 135, 20, 0x0801)
				$DisplaySLabel = GUICtrlCreateInput(@DesktopWidth & " x " & @DesktopHeight & " @ " & @DesktopRefresh & " Hz", 260, 350, 135, 20, 0x0801)
				$TypePerf = GUICtrlCreateInput($LiveMonitoring, 260, 375, 135, 20, 0x0801)

		GUICtrlCreateTab(-1, -1, 400, 419)
			GUICtrlCreateTabItem("Drives")

;				GUICtrlSetDefBkColor(0x090909)
				GUICtrlCreateLabel("A:\", 10, 025)
				GUICtrlCreateLabel("B:\", 10, 040)
				GUICtrlCreateLabel("C:\", 10, 055)
				GUICtrlCreateLabel("D:\", 10, 070)
				GUICtrlCreateLabel("E:\", 10, 085)
				GUICtrlCreateLabel("F:\", 10, 100)
				GUICtrlCreateLabel("G:\", 10, 115)
				GUICtrlCreateLabel("H:\", 10, 130)
				GUICtrlCreateLabel("I:\", 10, 145)
				GUICtrlCreateLabel("J:\", 10, 160)
				GUICtrlCreateLabel("K:\", 10, 175)
				GUICtrlCreateLabel("L:\", 10, 190)
				GUICtrlCreateLabel("M:\", 10, 205)
				GUICtrlCreateLabel("N:\", 10, 220)
				GUICtrlCreateLabel("O:\", 10, 235)
				GUICtrlCreateLabel("P:\", 10, 250)
				GUICtrlCreateLabel("Q:\", 10, 265)
				GUICtrlCreateLabel("R:\", 10, 280)
				GUICtrlCreateLabel("S:\", 10, 295)
				GUICtrlCreateLabel("T:\", 10, 310)
				GUICtrlCreateLabel("U:\", 10, 325)
				GUICtrlCreateLabel("V:\", 10, 340)
				GUICtrlCreateLabel("W:\", 10, 355)
				GUICtrlCreateLabel("X:\", 10, 370)
				GUICtrlCreateLabel("Y:\", 10, 385)
				GUICtrlCreateLabel("Z:\", 10, 400)
				$DriveATypeLabel = GUICtrlCreateLabel($DriveAType, 75, 025, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveBTypeLabel = GUICtrlCreateLabel($DriveBType, 75, 040, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveCTypeLabel = GUICtrlCreateLabel($DriveCType, 75, 055, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveDTypeLabel = GUICtrlCreateLabel($DriveDType, 75, 070, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveETypeLabel = GUICtrlCreateLabel($DriveEType, 75, 085, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveFTypeLabel = GUICtrlCreateLabel($DriveFType, 75, 100, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveGTypeLabel = GUICtrlCreateLabel($DriveGType, 75, 115, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveHTypeLabel = GUICtrlCreateLabel($DriveHType, 75, 130, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveITypeLabel = GUICtrlCreateLabel($DriveIType, 75, 145, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveJTypeLabel = GUICtrlCreateLabel($DriveJType, 75, 160, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveKTypeLabel = GUICtrlCreateLabel($DriveKType, 75, 175, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveLTypeLabel = GUICtrlCreateLabel($DriveLType, 75, 190, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveMTypeLabel = GUICtrlCreateLabel($DriveMType, 75, 205, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveNtypeLabel = GUICtrlCreateLabel($DriveNType, 75, 220, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveOTypeLabel = GUICtrlCreateLabel($DriveOType, 75, 235, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DrivePTypeLabel = GUICtrlCreateLabel($DrivePType, 75, 250, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveQTypeLabel = GUICtrlCreateLabel($DriveQType, 75, 265, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveRTypeLabel = GUICtrlCreateLabel($DriveRType, 75, 280, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveSTypeLabel = GUICtrlCreateLabel($DriveSType, 75, 295, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveTTypeLabel = GUICtrlCreateLabel($DriveTType, 75, 310, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveUTypeLabel = GUICtrlCreateLabel($DriveUType, 75, 325, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveVTypeLabel = GUICtrlCreateLabel($DriveVType, 75, 340, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveWTypeLabel = GUICtrlCreateLabel($DriveWType, 75, 355, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveXTypeLabel = GUICtrlCreateLabel($DriveXType, 75, 370, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveYTypeLabel = GUICtrlCreateLabel($DriveYType, 75, 385, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveZTypeLabel = GUICtrlCreateLabel($DriveZType, 75, 400, 75, 15, 0x1201)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveAFreePos = GUICtrlCreateProgress(180, 025, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveBFreePos = GUICtrlCreateProgress(180, 040, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveCFreePos = GUICtrlCreateProgress(180, 055, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveDFreePos = GUICtrlCreateProgress(180, 070, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveEFreePos = GUICtrlCreateProgress(180, 085, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveFFreePos = GUICtrlCreateProgress(180, 100, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveGFreePos = GUICtrlCreateProgress(180, 115, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveHFreePos = GUICtrlCreateProgress(180, 130, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveIfreePos = GUICtrlCreateProgress(180, 145, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveJFreePos = GUICtrlCreateProgress(180, 160, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveKFreePos = GUICtrlCreateProgress(180, 175, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveLFreePos = GUICtrlCreateProgress(180, 190, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveMFreePos = GUICtrlCreateProgress(180, 205, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveNFreePos = GUICtrlCreateProgress(180, 220, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveOFreePos = GUICtrlCreateProgress(180, 235, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DrivePFreePos = GUICtrlCreateProgress(180, 250, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveQFreePos = GUICtrlCreateProgress(180, 265, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveRFreePos = GUICtrlCreateProgress(180, 280, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveSFreePos = GUICtrlCreateProgress(180, 295, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveTFreePos = GUICtrlCreateProgress(180, 310, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveUFreePos = GUICtrlCreateProgress(180, 325, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveVFreePos = GUICtrlCreateProgress(180, 340, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveWFreePos = GUICtrlCreateProgress(180, 355, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveXFreePos = GUICtrlCreateProgress(180, 370, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveYFreePos = GUICtrlCreateProgress(180, 385, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DriveZFreePos = GUICtrlCreateProgress(180, 400, 180, 15, 0x01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				If Not $DriveAType = "" Then GUICtrlSetData($DriveAFreePos, $DriveAFree)
				If Not $DriveBType = "" Then GUICtrlSetData($DriveBFreePos, $DriveBFree)
				If Not $DriveCType = "" Then GUICtrlSetData($DriveCFreePos, $DriveCFree)
				If Not $DriveDType = "" Then GUICtrlSetData($DriveDFreePos, $DriveDFree)
				If Not $DriveEType = "" Then GUICtrlSetData($DriveEFreePos, $DriveEFree)
				If Not $DriveFType = "" Then GUICtrlSetData($DriveFFreePos, $DriveFFree)
				If Not $DriveGType = "" Then GUICtrlSetData($DriveGFreePos, $DriveGFree)
				If Not $DriveHType = "" Then GUICtrlSetData($DriveHFreePos, $DriveHFree)
				If Not $DriveIType = "" Then GUICtrlSetData($DriveIfreePos, $DriveIfree)
				If Not $DriveJType = "" Then GUICtrlSetData($DriveJFreePos, $DriveJFree)
				If Not $DriveKType = "" Then GUICtrlSetData($DriveKFreePos, $DriveKFree)
				If Not $DriveLType = "" Then GUICtrlSetData($DriveLFreePos, $DriveLFree)
				If Not $DriveMType = "" Then GUICtrlSetData($DriveMFreePos, $DriveMFree)
				If Not $DriveNType = "" Then GUICtrlSetData($DriveNFreePos, $DriveNFree)
				If Not $DriveOType = "" Then GUICtrlSetData($DriveOFreePos, $DriveOFree)
				If Not $DrivePType = "" Then GUICtrlSetData($DrivePFreePos, $DrivePFree)
				If Not $DriveQType = "" Then GUICtrlSetData($DriveQFreePos, $DriveQFree)
				If Not $DriveRType = "" Then GUICtrlSetData($DriveRFreePos, $DriveRFree)
				If Not $DriveSType = "" Then GUICtrlSetData($DriveSFreePos, $DriveSFree)
				If Not $DriveTType = "" Then GUICtrlSetData($DriveTFreePos, $DriveTFree)
				If Not $DriveUType = "" Then GUICtrlSetData($DriveUFreePos, $DriveUFree)
				If Not $DriveVType = "" Then GUICtrlSetData($DriveVFreePos, $DriveVFree)
				If Not $DriveWType = "" Then GUICtrlSetData($DriveWFreePos, $DriveWFree)
				If Not $DriveXType = "" Then GUICtrlSetData($DriveXFreePos, $DriveXFree)
				If Not $DriveYType = "" Then GUICtrlSetData($DriveYFreePos, $DriveYFree)
				If Not $DriveZType = "" Then GUICtrlSetData($DriveZFreePos, $DriveZFree)
				If $DriveAType = "CDROM" Then $DriveAEject = GUICtrlCreateButton("E", 370, 025, -1, 15)
				If $DriveBType = "CDROM" Then $DriveBEject = GUICtrlCreateButton("E", 370, 040, -1, 15)
				If $DriveCType = "CDROM" Then $DriveCEject = GUICtrlCreateButton("E", 370, 055, -1, 15)
				If $DriveDType = "CDROM" Then $DriveDEject = GUICtrlCreateButton("E", 370, 070, -1, 15)
				If $DriveEType = "CDROM" Then $DriveEEject = GUICtrlCreateButton("E", 370, 085, -1, 15)
				If $DriveFType = "CDROM" Then $DriveFEject = GUICtrlCreateButton("E", 370, 100, -1, 15)
				If $DriveGType = "CDROM" Then $DriveGEject = GUICtrlCreateButton("E", 370, 115, -1, 15)
				If $DriveHType = "CDROM" Then $DriveHEject = GUICtrlCreateButton("E", 370, 130, -1, 15)
				If $DriveIType = "CDROM" Then $DriveIEject = GUICtrlCreateButton("E", 370, 145, -1, 15)
				If $DriveJType = "CDROM" Then $DriveJEject = GUICtrlCreateButton("E", 370, 160, -1, 15)
				If $DriveKType = "CDROM" Then $DriveKEject = GUICtrlCreateButton("E", 370, 175, -1, 15)
				If $DriveLType = "CDROM" Then $DriveLEject = GUICtrlCreateButton("E", 370, 190, -1, 15)
				If $DriveMType = "CDROM" Then $DriveMEject = GUICtrlCreateButton("E", 370, 205, -1, 15)
				If $DriveNType = "CDROM" Then $DriveNEject = GUICtrlCreateButton("E", 370, 220, -1, 15)
				If $DriveOType = "CDROM" Then $DriveOEject = GUICtrlCreateButton("E", 370, 235, -1, 15)
				If $DrivePType = "CDROM" Then $DrivePEject = GUICtrlCreateButton("E", 370, 250, -1, 15)
				If $DriveQType = "CDROM" Then $DriveQEject = GUICtrlCreateButton("E", 370, 265, -1, 15)
				If $DriveRType = "CDROM" Then $DriveREject = GUICtrlCreateButton("E", 370, 280, -1, 15)
				If $DriveSType = "CDROM" Then $DriveSEject = GUICtrlCreateButton("E", 370, 295, -1, 15)
				If $DriveTType = "CDROM" Then $DriveTEject = GUICtrlCreateButton("E", 370, 310, -1, 15)
				If $DriveUType = "CDROM" Then $DriveUEject = GUICtrlCreateButton("E", 370, 325, -1, 15)
				If $DriveVType = "CDROM" Then $DriveVEject = GUICtrlCreateButton("E", 370, 340, -1, 15)
				If $DriveWType = "CDROM" Then $DriveWEject = GUICtrlCreateButton("E", 370, 355, -1, 15)
				If $DriveXType = "CDROM" Then $DriveXEject = GUICtrlCreateButton("E", 370, 370, -1, 15)
				If $DriveYType = "CDROM" Then $DriveYEject = GUICtrlCreateButton("E", 370, 385, -1, 15)
				If $DriveZType = "CDROM" Then $DriveZEject = GUICtrlCreateButton("E", 370, 400, -1, 15)
				If $DriveAType = "CDROM" Then $DriveALoad = GUICtrlCreateButton("L", 385, 025, -1, 15)
				If $DriveBType = "CDROM" Then $DriveBLoad = GUICtrlCreateButton("L", 385, 040, -1, 15)
				If $DriveCType = "CDROM" Then $DriveCLoad = GUICtrlCreateButton("L", 385, 055, -1, 15)
				If $DriveDType = "CDROM" Then $DriveDLoad = GUICtrlCreateButton("L", 385, 070, -1, 15)
				If $DriveEType = "CDROM" Then $DriveELoad = GUICtrlCreateButton("L", 385, 085, -1, 15)
				If $DriveFType = "CDROM" Then $DriveFLoad = GUICtrlCreateButton("L", 385, 100, -1, 15)
				If $DriveGType = "CDROM" Then $DriveGLoad = GUICtrlCreateButton("L", 385, 115, -1, 15)
				If $DriveHType = "CDROM" Then $DriveHLoad = GUICtrlCreateButton("L", 385, 130, -1, 15)
				If $DriveIType = "CDROM" Then $DriveILoad = GUICtrlCreateButton("L", 385, 145, -1, 15)
				If $DriveJType = "CDROM" Then $DriveJLoad = GUICtrlCreateButton("L", 385, 160, -1, 15)
				If $DriveKType = "CDROM" Then $DriveKLoad = GUICtrlCreateButton("L", 385, 175, -1, 15)
				If $DriveLType = "CDROM" Then $DriveLLoad = GUICtrlCreateButton("L", 385, 190, -1, 15)
				If $DriveMType = "CDROM" Then $DriveMLoad = GUICtrlCreateButton("L", 385, 205, -1, 15)
				If $DriveNType = "CDROM" Then $DriveNLoad = GUICtrlCreateButton("L", 385, 220, -1, 15)
				If $DriveOType = "CDROM" Then $DriveOLoad = GUICtrlCreateButton("L", 385, 235, -1, 15)
				If $DrivePType = "CDROM" Then $DrivePLoad = GUICtrlCreateButton("L", 385, 250, -1, 15)
				If $DriveQType = "CDROM" Then $DriveQLoad = GUICtrlCreateButton("L", 385, 265, -1, 15)
				If $DriveRType = "CDROM" Then $DriveRLoad = GUICtrlCreateButton("L", 385, 280, -1, 15)
				If $DriveSType = "CDROM" Then $DriveSLoad = GUICtrlCreateButton("L", 385, 295, -1, 15)
				If $DriveTType = "CDROM" Then $DriveTLoad = GUICtrlCreateButton("L", 385, 310, -1, 15)
				If $DriveUType = "CDROM" Then $DriveULoad = GUICtrlCreateButton("L", 385, 325, -1, 15)
				If $DriveVType = "CDROM" Then $DriveVLoad = GUICtrlCreateButton("L", 385, 340, -1, 15)
				If $DriveWType = "CDROM" Then $DriveWLoad = GUICtrlCreateButton("L", 385, 355, -1, 15)
				If $DriveXType = "CDROM" Then $DriveXLoad = GUICtrlCreateButton("L", 385, 370, -1, 15)
				If $DriveYType = "CDROM" Then $DriveYLoad = GUICtrlCreateButton("L", 385, 385, -1, 15)
				If $DriveZType = "CDROM" Then $DriveZLoad = GUICtrlCreateButton("L", 385, 400, -1, 15)

		GUICtrlCreateTab(-1, -1, 400, 419)
			GUICtrlCreateTabItem("CPU and RAM")

				GUICtrlCreateLabel("CPU Usage", 10, 25, 265, 15)
				$WINECPUMsg = GUICtrlCreateInput("", 120, 25, 275, 15, 0x0801)
				GUICtrlCreateLabel("Avg. CPU Usage", 10, 50, 265, 15)
				$WINEAvgCPUBarMsg = GUICtrlCreateInput("", 120, 50, 275, 15, 0x0801)
				GUICtrlCreateLabel("RAM Usage", 10, 75, 270, 15)
				GUICtrlCreateLabel("Avg. RAM Usage", 10, 100, 270, 15)
				GUICtrlCreateLabel("CPU Arch", 10, 125, 270, 15)
				GUICtrlCreateLabel("Total RAM", 10, 150, 270, 15)
				GUICtrlCreateLabel("Total PageFile", 10, 175, 270, 15)
				GUICtrlCreateLabel("Total Virtual", 10, 200, 270, 15)
				$CPU = GUICtrlCreateProgress(120, 25, 275, -1, 0x01)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$AvgCPUBar = GUICtrlCreateProgress(120, 50, -1, -1, 0x01)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RAM = GUICtrlCreateProgress(120, 75, -1, -1, 0x01)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$AvgRAMBar = GUICtrlCreateProgress(120, 100, -1, -1, 0x01)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateInput(@CPUArch, 275, 125, 120, 20, 0x0A01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateInput(Round($RAMUsage[1]/1048576, 2) & " GB", 275, 150, 120, 20, 0x0A01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateInput(Round(($RAMUsage[3]-$RAMUsage[1])/1048576, 2) & " GB", 275, 175, 120, 20, 0x0A01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateInput(Round($RAMUsage[3]/1048576, 2) & " GB", 275, 200, 120, 20, 0x0A01)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				If $WINE Then
					GUICtrlSetState($CPU, $GUI_HIDE)
					GUICtrlSetState($WINECPUMsg, $GUI_SHOW)
					GUICtrlSetState($AvgCPUBar, $GUI_HIDE)
					GUICtrlSetState($WINEAvgCPUBarMsg, $GUI_SHOW)
				Else
					GUICtrlSetState($WINECPUMsg, $GUI_HIDE)
					GUICtrlSetState($WINEAvgCPUBarMsg, $GUI_HIDE)
				EndIf
				GUICtrlCreateLabel( " C P U", 20, 230, 8, 50, 0x01)
				$CGB1 = GUICtrlCreateProgress(20, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB2 = GUICtrlCreateProgress(40, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB3 = GUICtrlCreateProgress(60, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB4 = GUICtrlCreateProgress(80, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB5 = GUICtrlCreateProgress(100, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB6 = GUICtrlCreateProgress(120, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB7 = GUICtrlCreateProgress(140, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB8 = GUICtrlCreateProgress(160, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB9 = GUICtrlCreateProgress(180, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB10 = GUICtrlCreateProgress(200, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB11 = GUICtrlCreateProgress(220, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB12 = GUICtrlCreateProgress(240, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB13 = GUICtrlCreateProgress(260, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB14 = GUICtrlCreateProgress(280, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB15 = GUICtrlCreateProgress(300, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB16 = GUICtrlCreateProgress(320, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB17 = GUICtrlCreateProgress(340, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$CGB18 = GUICtrlCreateProgress(360, 230, 20, 80, 0x05)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateLabel( " C P U", 382, 230, 8, 50, 0x01)
				GUICtrlCreateLabel( " R A M", 10, 320, 8, 50, 0x01)
				$RGB1 = GUICtrlCreateProgress(20, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB2 = GUICtrlCreateProgress(40, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB3 = GUICtrlCreateProgress(60, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB4 = GUICtrlCreateProgress(80, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB5 = GUICtrlCreateProgress(100, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB6 = GUICtrlCreateProgress(120, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB7 = GUICtrlCreateProgress(140, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB8 = GUICtrlCreateProgress(160, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB9 = GUICtrlCreateProgress(180, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB10 = GUICtrlCreateProgress(200, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB11 = GUICtrlCreateProgress(220, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB12 = GUICtrlCreateProgress(240, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB13 = GUICtrlCreateProgress(260, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB14 = GUICtrlCreateProgress(280, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB15 = GUICtrlCreateProgress(300, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB16 = GUICtrlCreateProgress(320, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB17 = GUICtrlCreateProgress(340, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$RGB18 = GUICtrlCreateProgress(360, 320, 20, 80, 0x05)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				GUICtrlCreateLabel( " R A M", 382, 320, 8, 50, 0x01)

		GUICtrlCreateTab(-1, -1, 400, 419)
			GUICtrlCreateTabItem("Network")

				GUICtrlCreateLabel("IP 1:", 10, 25, 240, 25)
				GUICtrlCreateLabel("IP 2:", 10, 50, -1, -1)
				GUICtrlCreateLabel("IP 3:", 10, 75, -1, -1)
				GUICtrlCreateLabel("IP 4:", 10, 100, -1, -1)
				GUICtrlCreateLabel("DNS Domain:", 10, 125, -1, -1)
				GUICtrlCreateLabel("Domain:", 10, 150, -1, -1)
				GUICtrlCreateLabel("Server:", 10, 175, -1, -1)
				$IP1 = GUICtrlCreateInput(@IPAddress1, 255, 25, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$IP2 = GUICtrlCreateInput(@IPAddress2, 255, 50, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$IP3 = GUICtrlCreateInput(@IPAddress3, 255, 75, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$IP4 = GUICtrlCreateInput(@IPAddress4, 255, 100, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$DNSDomain = GUICtrlCreateInput(@LogonDNSDomain, 255, 125, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$Domain = GUICtrlCreateInput(@LogonDomain, 255, 150, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$Server = GUICtrlCreateInput(@LogonServer, 255, 175, 140, 20, 0x0801)
				GUICtrlSetBkColor( -1, 0xFFFFFF)

		GUICtrlCreateTab(-1, -1, 400, 419)
			GUICtrlCreateTabItem("Etc")

				GUICtrlCreateLabel("Run:", 10, 25)
				$RUN = GUICtrlCreateInput("", 70, 25, 220, 20, 0x1080)
				GUICtrlSetBkColor( -1, 0xFFFFFF)
				$Browse = GUICtrlCreateButton("...", 295, 25, 50, 20)
				$Submit = GUICtrlCreateButton("Run", 345, 25, 50, 20)
				GUICtrlCreateLabel("Edit:", 10, 50)
				$Edit = GUICtrlCreateInput("", 70, 50, 220, 20, 0x1080)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$EditBrowse = GUICtrlCreateButton("...", 295, 50, 50, 20)
				$EditSubmit = GUICtrlCreateButton("Edit", 345, 50, 50, 20)
				GUICtrlCreateLabel("Kill PID:", 10, 75)
				$KillPID = GUICtrlCreateInput("", 70, 75, 270, 20, 0x3000)
				GUICtrlSetLimit($KillPID, 4)
				$ExecKillPID = GUICtrlCreateButton("Kill", 345, 75, 50, 20)
				GUICtrlCreateLabel("Kill Task:", 10, 100)
				$Kill = GUICtrlCreateInput("", 70, 100, 270, 20, 0x1080)
				$ExecKill = GUICtrlCreateButton("Kill", 345, 100, 50, 20)
				GUICtrlCreateLabel("Encrypt:", 10, 125)
				$EncryptString = GUICtrlCreateInput("", 70, 125, 270, 20, 0x1080)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$Encrypt = GUICtrlCreateButton("Go", 345, 125, 50, 20)
				GUICtrlCreateLabel("Decrypt:", 10, 150)
				$DecryptString = GUICtrlCreateInput("", 70, 150, 270, 20, 0x1080)
				If Not $WINE Then GUICtrlSetBkColor( -1, 0xFFFFFF)
				$Decrypt = GUICtrlCreateButton("Go", 345, 150, 50, 20)
;				GUICtrlCreateLabel("Format:", 10, 200)
;				$Format_Drive = GUICtrlCreateCombo("A" , 60, 200, 30, 20, 0x0003)
;				GUICtrlSetData(-1, "B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|")
;				$Format_FS = GUICtrlCreateCombo("FAT" , 100, 200, 60, 20, 0x0003)
;				GUICtrlSetData(-1, "UDF|NTFS|FAT32|exFAT|")
;				$Format_Mode = GUICtrlCreateCombo("QUICK", 230, 200, 60, 20, 0x0003)
;				GUICtrlSetData(-1, "SECURE|")
;				$Format_AUS = GUICtrlCreateCombo("512", 170, 200, 50, 20, 0x0003)
;				GUICtrlSetData(-1, "1024|2048|4096|8192|")

		GUISetState(@SW_SHOW)
		GUICtrlSetState($MainTab, $GUI_FOCUS)
		GUICtrlSetState($MainTab, $GUI_DEFBUTTON)
		GUICtrlSetState($MainTab, $GUI_ENABLE)
		GUICtrlSetState($MainTab, $GUI_SHOW)
		$RAMUsage = MemGetStats()
		$RAMCollected = $RAMCollected+1
		$RAMTotal = Round($RAMUsage[0]+$RAMTotal)
		$AvgRAM = Round($RAMTotal/$RAMCollected)
		GUICtrlSetData($AvgRAMBar, $AvgRAM)
		GUICtrlSetData($RAM, Round($RAMUsage[0], 0))
		If Not $WINE Then
			$CPUUsage = Round(StringTrimRight(StringTrimLeft(FileReadLine(@TempDir & "\cpu.csv", -1), 27), 1), 0)
			$Collected = $Collected+1
			$CPUTotal = Round($CPUUsage+$CPUTotal)
			$AVGCPU = Round($CPUTotal/$Collected)
			GUICtrlSetData($CPU, $CPUUsage)
			GUICtrlSetData($AvgCPUBar, $AvgCPU)
		Else
			GUICtrlSetState($Edit, $GUI_DISABLE)
			GUICtrlSetState($EditBrowse, $GUI_DISABLE)
			GUICtrlSetState($EditSubmit, $GUI_DISABLE)
			GUICtrlSetState($EncryptString, $GUI_DISABLE)
			GUICtrlSetState($Encrypt, $GUI_DISABLE)
			GUICtrlSetState($DecryptString, $GUI_DISABLE)
			GUICtrlSetState($Decrypt, $GUI_DISABLE)
		EndIf

	GUISetState()
	While 1
		$Msg = GUIGetMsg()
		Select
			Case $Msg = $ExitItem Or $Msg = $GUI_EVENT_CLOSE
				If Not $WINE Then
					$TypePerfPID = ProcessExists( "typeperf.exe")
					ProcessClose($TypePerfPID)
					Sleep(500)
					FileDelete(@TempDir & "\cpu.csv")
					_Crypt_DestroyKey($hKey)
					_Crypt_Shutdown()
				EndIf
				Exit

			Case TimerDIff($RefreshTimerA) >= 1000
				$RefreshTimerA = TimerInit()
				DateTime()
				$RAMUsage = MemGetStats()
				$RAMCollected = $RAMCollected+1
				$RAMTotal = Round($RAMUsage[0]+$RAMTotal)
				$AvgRAM = Round($RAMTotal/$RAMCollected)
				GUICtrlSetData($AvgRAMBar, $AvgRAM)
				GUICtrlSetData($RAM, Round($RAMUsage[0], 0))
				GUICtrlSetData($RGB1, GUICtrlRead($RGB2))
				GUICtrlSetData($RGB2, GUICtrlRead($RGB3))
				GUICtrlSetData($RGB3, GUICtrlRead($RGB4))
				GUICtrlSetData($RGB4, GUICtrlRead($RGB5))
				GUICtrlSetData($RGB5, GUICtrlRead($RGB6))
				GUICtrlSetData($RGB6, GUICtrlRead($RGB7))
				GUICtrlSetData($RGB7, GUICtrlRead($RGB8))
				GUICtrlSetData($RGB8, GUICtrlRead($RGB9))
				GUICtrlSetData($RGB9, GUICtrlRead($RGB10))
				GUICtrlSetData($RGB10, GUICtrlRead($RGB11))
				GUICtrlSetData($RGB11, GUICtrlRead($RGB12))
				GUICtrlSetData($RGB12, GUICtrlRead($RGB13))
				GUICtrlSetData($RGB13, GUICtrlRead($RGB14))
				GUICtrlSetData($RGB14, GUICtrlRead($RGB15))
				GUICtrlSetData($RGB15, GUICtrlRead($RGB16))
				GUICtrlSetData($RGB16, GUICtrlRead($RGB17))
				GUICtrlSetData($RGB17, GUICtrlRead($RGB18))
				GUICtrlSetData($RGB18, Round($RAMUsage[0], 0))
				If ProcessExists("typeperf.exe") Then
					If Not $WINE Then
						GUICtrlSetData($typeperf, "Enabled")
						$CPUUsage = Round(StringTrimRight(StringTrimLeft(FileReadLine(@TempDir & "\cpu.csv", -1), 27), 1), 0)
						$Collected = $Collected+1
						$CPUTotal = Round($CPUUsage+$CPUTotal)
						$AVGCPU = Round($CPUTotal/$Collected)
						GUICtrlSetData($CPU, $CPUUsage)
						GUICtrlSetData($AvgCPUBar, $AvgCPU)
						GUICtrlSetData($CGB1, GUICtrlRead($CGB2))
						GUICtrlSetData($CGB2, GUICtrlRead($CGB3))
						GUICtrlSetData($CGB3, GUICtrlRead($CGB4))
						GUICtrlSetData($CGB4, GUICtrlRead($CGB5))
						GUICtrlSetData($CGB5, GUICtrlRead($CGB6))
						GUICtrlSetData($CGB6, GUICtrlRead($CGB7))
						GUICtrlSetData($CGB7, GUICtrlRead($CGB8))
						GUICtrlSetData($CGB8, GUICtrlRead($CGB9))
						GUICtrlSetData($CGB9, GUICtrlRead($CGB10))
						GUICtrlSetData($CGB10, GUICtrlRead($CGB11))
						GUICtrlSetData($CGB11, GUICtrlRead($CGB12))
						GUICtrlSetData($CGB12, GUICtrlRead($CGB13))
						GUICtrlSetData($CGB13, GUICtrlRead($CGB14))
						GUICtrlSetData($CGB14, GUICtrlRead($CGB15))
						GUICtrlSetData($CGB15, GUICtrlRead($CGB16))
						GUICtrlSetData($CGB16, GUICtrlRead($CGB17))
						GUICtrlSetData($CGB17, GUICtrlRead($CGB18))
						GUICtrlSetData($CGB18, $CPUUsage)
					EndIf
				EndIf
				If Not ProcessExists("typeperf.exe") Then GUICtrlSetData($typeperf, "Some Disabled")
				GUICtrlSetData($TimeLabel, $Date & "  " & $Time)

			Case $Msg = $StressItem
				MsgBox(0x40010, "Instructions", "The program will automatically" & @CRLF & "close after 30 seconds.")
				$StressInit = "YES"
				$Numbers = GUICreate( "Numbers", 125, 136, -1, -1, 0x10020080)
				$Line1 = GUICtrlCreateLabel( "", 2, 0, 125, 12)
				$Line2 = GUICtrlCreateLabel( "", 2, 12, 125, 12)
				$Line3 = GUICtrlCreateLabel( "", 2, 24, 125, 12)
				$Line4 = GUICtrlCreateLabel( "", 2, 36, 125, 12)
				$Line5 = GUICtrlCreateLabel( "", 2, 48, 125, 12)
				$Line6 = GUICtrlCreateLabel( "", 2, 60, 125, 12)
				$Line7 = GUICtrlCreateLabel( "", 2, 72, 125, 12)
				$Line8 = GUICtrlCreateLabel( "", 2, 84, 125, 12)
				$Line9 = GUICtrlCreateLabel( "", 2, 96, 125, 12)
				$StressTimer = TimerInit()

			Case $StressInit = "YES"
				If TimerDiff($StressTimer) >= 30000 Then
					$StressInit = "No"
					GUIDelete($Numbers)
				Else
					$Ran1 = Random(0000000000, 9999999999, 1)
					$Ran2 = Random(0000000000, 9999999999, 1)
					$Ran3 = Random(0000000000, 9999999999, 1)
					$Ran4 = Random(0000000000, 9999999999, 1)
					$Ran5 = Random(0000000000, 9999999999, 1)
					$Ran6 = Random(0000000000, 9999999999, 1)
					GUICtrlSetData( $Line1, $Ran1 & $Ran2)
					GUICtrlSetData( $Line2, $Ran3 & $Ran4)
					GUICtrlSetData( $Line3, $Ran5 & $Ran6)
					GUICtrlSetData( $Line4, $Ran5 & $Ran2)
					GUICtrlSetData( $Line5, $Ran1 & $Ran4)
					GUICtrlSetData( $Line6, $Ran3 & $Ran6)
					GUICtrlSetData( $Line7, $Ran3 & $Ran2)
					GUICtrlSetData( $Line8, $Ran5 & $Ran4)
					GUICtrlSetData( $Line9, $Ran1 & $Ran6)
				EndIf

			Case $Msg = $PixelFixItem
				MsgBox(0x40010, "Instructions", "Move the mouse to move the flashing window around" & @CRLF & "to find stuck pixels, keep it there to fix the stuck pixel(s)." & @CRLF & "The flashing window will automatically close after 30 seconds.")
				$PixFixInt = "YES"
				$PixFixWin = GUICreate("Pixel Fix", 200, 200, -1, -1, 0x90020088)
				$PixFixTimer = TimerInit()

			Case $PixFixInt = "YES"
				If TimerDiff($PixFixTimer) >= 30000 Then
					$PixFixInt = "NO"
					GUIDelete($PixFixWin)
				Else
					GUISetBkColor(Random(0,16777215), $PixFixWin)
					Sleep(50)
					WinMove("Pixel Fix", "", MouseGetPos(0), MouseGetPos(1))
				EndIf

			Case $Msg = $CreditsItem
				$Credits = GUICreate( "Credits", 200, 100, -1, -1, 0x10C00000)
				GUICtrlCreateLabel("FCoFix Info + Utilites - Version " & $Ver, 10, 10)
				GUICtrlCreateLabel("Created By:", 10, 35, 60)
				GUICtrlCreateLabel("The FCoFix Organization", 70, 35, 220)
				GUICtrlCreateLabel("Robert C. Maehl", 70, 50, 220)
				$CreditsOK = GUICtrlCreateButton("OK", 145, 75, 50, 20)

			Case $Msg = $DriveInfoItem
				$DriveInfo = GUICreate( "Drive Info", 300, 200, -1, -1, 0x10C00000)
				GUICtrlCreateLabel("Select a Drive's Drive Letter for Its Info:", 10, 10, 200, 20)
				$DID = GUICtrlCreateCombo("" , 220, 10, 70, 20, 0x0003)
				GUICtrlSetData($DID, "|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|")
				$DIN = GUICtrlCreateLabel("Label", 10, 40, 100, 20, 0x1C01)
				$DIS = GUICtrlCreateLabel("Status", 120, 40, 100, 20, 0x1C01)
				$DIfS = GUICtrlCreateLabel("Format", 230, 40, 60, 20, 0x1C01)
				$DIT = GUICtrlCreateLabel("Type", 10, 70, 100, 20, 0x1C01)
				$DIC = GUICtrlCreateLabel("Size", 120, 70, 70, 20, 0x1C01)
				$DII = GUICtrlCreateInput("Serial Number", 200, 70, 90, 20, 0x0801)
				$DIfSP = GUICtrlCreateProgress(10, 100, 280, 20)
				$DrivesOK = GUICtrlCreateButton("OK", 245, 175, 50, 20)
				$DrivesGO = GUICtrlCreateButton("GO", 195, 175, 50, 20)

			Case $Msg = $DrivesGO and WinExists("Drive Info", "")
				GUICtrlSetData( $DIfSP, Round((DriveSpaceTotal(GUICtrlRead($DID) & ":\")-DriveSpaceFree(GUICtrlRead($DID) & ":\"))/DriveSpaceTotal(GUICtrlRead($DID) & ":\")*100, 0))
				GUICtrlSetData( $DIN, DriveGetLabel(GUICtrlRead($DID) & ":\"))
				If DriveGetLabel(GUICtrlRead($DID) & ":\") = "" Then GUICtrlSetData( $DIN, "No Label Set")
				GUICtrlSetData( $DIT, DriveGetType(GUICtrlRead($DID) & ":\") & " Device")
				GUICtrlSetData( $DIfS, DriveGetFileSystem(GUICtrlRead($DID) & ":\"))
				GUICtrlSetData( $DIS, DriveStatus(GUICtrlRead($DID) & ":\"))
				If Round(DriveSpaceTotal(GUICtrlRead($DID) & ":\"), 0) < 1024 Then GUICtrlSetData( $DIC, "< 1 GB")

				GUICtrlSetData( $DII, DriveGetSerial(GUICtrlRead($DID) & ":\"))
				If DriveStatus(GUICtrlRead($DID) & ":\") = "INVALID" Then
					GUICtrlSetData( $DIN, "Label")
					GUICtrlSetData( $DIT, "Type")
					GUICtrlSetData( $DIfS, "Format")
					GUICtrlSetData( $DIC, "Size")
					GUICtrlSetData( $DII, "Serial Number")
					GUICtrlSetData( $DIfSP, 0)
				EndIf
				If GUICtrlRead($DID) = "" Then
					GUICtrlSetData( $DIS, "Status")
					GUICtrlSetData( $DIN, "Label")
					GUICtrlSetData( $DIT, "Type")
					GUICtrlSetData( $DIfS, "Format")
					GUICtrlSetData( $DIC, "Size")
					GUICtrlSetData( $DII, "Serial Number")
					GUICtrlSetData( $DIfSP, 0)
				EndIf

			Case $Msg = $DrivesOK and WinExists("Drive Info", "")
				GUIDelete($DriveInfo)

			Case $Msg = $CreditsOK and WinExists("Credits", "")
				GUIDelete($Credits)

			Case $Msg = $USBHijack
				$exists = FileExists("A:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("A:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on A:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("A:\*Autorun.inf*")

				$exists = FileExists("B:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("B:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on B:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("B:\*Autorun.inf*")

				$exists = FileExists("C:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("C:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on C:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("C:\*Autorun.inf*")

				$exists = FileExists("D:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("D:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on D:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("D:\*Autorun.inf*")

				$exists = FileExists("E:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("E:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on E:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("E:\*Autorun.inf*")

				$exists = FileExists("F:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("F:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on F:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("F:\*Autorun.inf*")

				$exists = FileExists("G:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("G:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on G:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("G:\*Autorun.inf*")

				$exists = FileExists("H:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("H:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on H:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("H:\*Autorun.inf*")

				$exists = FileExists("I:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("I:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on I:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("I:\*Autorun.inf*")

				$exists = FileExists("J:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("J:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on J:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("J:\*Autorun.inf*")

				$exists = FileExists("K:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("K:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on K:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("K:\*Autorun.inf*")

				$exists = FileExists("L:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("L:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on L:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("L:\*Autorun.inf*")

				$exists = FileExists("M:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("M:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on M:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("M:\*Autorun.inf*")

				$exists = FileExists("N:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("N:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on N:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("N:\*Autorun.inf*")

				$exists = FileExists("O:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("O:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on O:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("O:\*Autorun.inf*")

				$exists = FileExists("P:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("P:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on P:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("P:\*Autorun.inf*")

				$exists = FileExists("Q:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("Q:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on Q:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("Q:\*Autorun.inf*")

				$exists = FileExists("R:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("R:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on R:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("R:\*Autorun.inf*")

				$exists = FileExists("S:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("S:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on S:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("S:\*Autorun.inf*")

				$exists = FileExists("T:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("T:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on T:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("T:\*Autorun.inf*")

				$exists = FileExists("U:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("U:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on U:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("U:\Autorun.inf*")

				$exists = FileExists("V:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("V:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on V:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("V:\*Autorun.inf*")

				$exists = FileExists("W:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("W:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on W:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("W:\*Autorun.inf*")

				$exists = FileExists("X:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("X:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on X:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("X:\*Autorun.inf*")

				$exists = FileExists("Y:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("Y:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on Y:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("Y:\*Autorun.inf*")	

				$exists = FileExists("Z:\autorun.inf")
				If $exists = 1 Then FileSetAttrib("Z:\*Autorun.inf*", "-RASH")
				If $exists = 1 Then $del = MsgBox(0x40024, "!", "Delete Virus" & @CRLF & @CRLF &  "AR.INF.RISK on Z:\ ?")
				If $exists = 1 And $del = 6 Then FileDelete("Z:\*Autorun.inf*")

			Case $Msg = $RecycleItem
				FileRecycleEmpty()
				FileSetAttrib( @WindowsDir & "\Temp\*", "-RASHOT", 1)
				FileDelete( @WindowsDir & "\Temp\*")
				FileSetAttrib( @AppDataCommonDir & "\Microsoft\Windows Defender\Scans\History\Results\Resource\*", "-RASHOT", 1)
				FileDelete( @AppDataCommonDir & "\Microsoft\Windows Defender\Scans\History\Results\Resource\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Temporary Internet Files\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Temporary Internet Files\*")
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Temporary Internet Files\*\*")
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Temporary Internet Files\*\*\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Mozilla\Firefox\Profiles\*\cache\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Mozilla\Firefox\Profiles\*\cache\*")
				FileSetAttrib( @UserProfileDir & "\Local Settings\Temporary Internet Files\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Local Settings\Temporary Internet Files\*")
				FileSetAttrib( @UserProfileDir & "\Cookies\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Cookies\*")
				FileSetAttrib( @UserProfileDir & "\Local Settings\History\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Local Settings\History\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\History\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\History\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\index.dat", "-RASHOT")
				FileDelete( @UserProfileDir & "\Appdata\index.dat")
				FileSetAttrib( @UserProfileDir & "\AppData\Local\Temp\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\AppData\Local\Temp\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Explorer\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\Explorer\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\WER\ReportArchive\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Windows\WER\ReportArchive\*")
				FileSetAttrib( @UserProfileDir & "\Appdata\Local\Microsoft\Terminal Server Client\Cache\*", "-RASHOT", 1)
				FileDelete( @UserProfileDir & "\Appdata\Local\Microsoft\Terminal Server Client\Cache\*")
				FileSetAttrib( @AppDataCommonDir & "\Microsoft\Windows\WER\ReportArchive\*", "-RASHOT", 1)
				FileDelete( @AppDataCommonDir & "\Microsoft\Windows\WER\ReportArchive\*")
				FileSetAttrib( @AppDataDir & "\Microsoft\Office\Recent\*", "-RASHOT", 1)
				FileDelete( @AppDataDir & "\Microsoft\Office\Recent\*")
				FileSetAttrib( @AppDataDir & "\Sun\Java\Deployment\Cache\*", "-RASHOT", 1)
				FileDelete( @AppDataDir & "\Sun\Java\Deployment\Cache\*")
				FileSetAttrib( @AppDataDir & "\Mozilla\Firefox\Profiles\downloads.sqlite", "-RASHOT")
				FileDelete( @AppDataDir & "\Mozilla\Firefox\Profiles\downloads.sqlite")
				FileSetAttrib( @AppDataDir & "\Microsoft\Windows\Cookies\*", "-RASHOT", 1)
				FileDelete( @AppDataDir & "\Microsoft\Windows\Cookies\*")
				FileSetAttrib( @AppDataDir & "\Microsoft\Windows\Recent\*", "-RASHOT", 1)
				FileDelete( @AppDataDir & "\Microsoft\Windows\Recent\*")
				DriveInfo()
				SetDriveData()

			Case $Msg = $Encrypt
				GUICtrlSetData( $DecryptString, _Crypt_EncryptData(GUICtrlRead($EncryptString), $hKey,$CALG_USERKEY))
				ClipPut( _Crypt_EncryptData(GUICtrlRead($EncryptString), $hKey,$CALG_USERKEY))
				GUICtrlSetData( $EncryptString, "")
				MsgBox(0x40020, "!", "The Encrypted String can be viewed below and has been copied to the clipboard")

			Case $Msg = $Decrypt
				GUICtrlSetData( $EncryptString, BinaryToString(_Crypt_DecryptData(GUICtrlRead($DecryptString), $hKey,$CALG_USERKEY)))
				ClipPut(  BinaryToString(_Crypt_DecryptData(GUICtrlRead($DecryptString), $hKey,$CALG_USERKEY)))
				GUICtrlSetData( $DecryptString, "")
				MsgBox(0x40020, "!", "The Decrypted String can be viewed above and has been copied to the clipboard")

			Case $Msg = $ExecKill
				ProcessClose(GUICtrlRead($Kill))
				GUICtrlSetData($Kill, "Atempting to Kill " & GUICtrlRead($Kill) & "...")
				Sleep(250)
				GUICtrlSetData($Kill, "")

			Case $Msg = $ExecKillPID
				ProcessClose(GUICtrlRead($KillPID))
				GUICtrlSetData($KillPID, "Atempting to Kill " & GUICtrlRead($KillPID) & "...")
				Sleep(250)
				GUICtrlSetData($KillPID, "")

			Case $Msg = $Submit
				ShellExecute(_WinAPI_ExpandEnvironmentStrings(GUICtrlRead($RUN)), "", "", "open")
				GUICtrlSetData($RUN, "Starting " & GUICtrlRead($RUN) & "...")
				Sleep(250)
				GUICtrlSetData($RUN, "")

			Case $Msg = $EditSubmit
				ShellExecute(_WinAPI_ExpandEnvironmentStrings(GUICtrlRead($edit)), "", "", "edit")
				GUICtrlSetData($edit, "")

			Case $Msg = $Browse
				$BrowseFile = FileOpenDialog( "Choose Program to Run", @ScriptDir, "Program (*.exe;*.bat;*.com;*.pif)", 1)
				If not @error then Run($BrowseFile)

			Case $Msg = $EditBrowse
				$EditFile = FileOpenDialog( "Choose File to Edit", @ScriptDir, "All Files (*.*)|Autoit Script (*.au3)|Batch File (*.bat)|Settings File (*.ini;*inf;*reg)|Text File (*.txt;*rtf;*.log)|Web Page (*.html;*.htm;*.php)|Word File (*.doc)", 1)
				If not @error then ShellExecute($EditFile, "", "", "edit")

			Case $Msg = $RefreshItem Or _IsPressed("74") Or $Msg = $RefreshContext Or TimerDIff($RefreshTimerB) >= 60000
				$RefreshTimerB = TimerInit()
				DriveInfo()
				GUICtrlSetData($IP1, @IPAddress1)
				GUICtrlSetData($IP2, @IPAddress2)
				GUICtrlSetData($IP3, @IPAddress3)
				GUICtrlSetData($IP4, @IPAddress4)
				GUICtrlSetData($DNSDomain, @LogonDNSDomain)
				GUICtrlSetData($Domain, @LogonDomain)
				GUICtrlSetData($Server, @LogonServer)
				GUICtrlSetData($DisplayWLabel, @DesktopWidth & " Pixels")
				GUICtrlSetData($DisplayHLabel, @DesktopHeight & " Pixels")
				GUICtrlSetData($DisplayDLabel, @DesktopDepth & " Bits")
				GUICtrlSetData($DisplayRLabel, @DesktopRefresh & " Hz")
				GUICtrlSetData($DisplaysLabel, @DesktopWidth & " x " & @DesktopHeight & " @ " & @DesktopRefresh & " Hz")
				SetDriveData()

			Case $Msg = $DriveAEject
				CDTray("A:", "Open")

			Case $Msg = $DriveBEject
				CDTray("B:", "Open")

			Case $Msg = $DriveCEject
				CDTray("C:", "Open")

			Case $Msg = $DriveDEject
				CDTray("D:", "Open")

			Case $Msg = $DriveEEject
				CDTray("E:", "Open")

			Case $Msg = $DriveFEject
				CDTray("F:", "Open")

			Case $Msg = $DriveGEject
				CDTray("G:", "Open")

			Case $Msg = $DriveHEject
				CDTray("H:", "Open")

			Case $Msg = $DriveIEject
				CDTray("I:", "Open")

			Case $Msg = $DriveJEject
				CDTray("J:", "Open")

			Case $Msg = $DriveKEject
				CDTray("K:", "Open")

			Case $Msg = $DriveLEject
				CDTray("L:", "Open")

			Case $Msg = $DriveMEject
				CDTray("M:", "Open")

			Case $Msg = $DriveNEject
				CDTray("N:", "Open")

			Case $Msg = $DriveOEject
				CDTray("O:", "Open")

			Case $Msg = $DrivePEject
				CDTray("P:", "Open")

			Case $Msg = $DriveQEject
				CDTray("Q:", "Open")

			Case $Msg = $DriveREject
				CDTray("R:", "Open")

			Case $Msg = $DriveSEject
				CDTray("S:", "Open")

			Case $Msg = $DriveTEject
				CDTray("T:", "Open")

			Case $Msg = $DriveUEject
				CDTray("U:", "Open")

			Case $Msg = $DriveVEject
				CDTray("V:", "Open")

			Case $Msg = $DriveWEject
				CDTray("W:", "Open")

			Case $Msg = $DriveXEject
				CDTray("X:", "Open")

			Case $Msg = $DriveYEject
				CDTray("Y:", "Open")

			Case $Msg = $DriveZEject
				CDTray("Z:", "Open")

			Case $Msg = $DriveALoad
				CDTray("A:", "Closed")

			Case $Msg = $DriveBLoad
				CDTray("B:", "Closed")

			Case $Msg = $DriveCLoad
				CDTray("C:", "Closed")

			Case $Msg = $DriveDLoad
				CDTray("D:", "Closed")

			Case $Msg = $DriveELoad
				CDTray("E:", "Closed")

			Case $Msg = $DriveFLoad
				CDTray("F:", "Closed")

			Case $Msg = $DriveGLoad
				CDTray("G:", "Closed")

			Case $Msg = $DriveHLoad
				CDTray("H:", "Closed")

			Case $Msg = $DriveILoad
				CDTray("I:", "Closed")

			Case $Msg = $DriveJLoad
				CDTray("J:", "Closed")

			Case $Msg = $DriveKLoad
				CDTray("K:", "Closed")

			Case $Msg = $DriveLLoad
				CDTray("L:", "Closed")

			Case $Msg = $DriveMLoad
				CDTray("M:", "Closed")

			Case $Msg = $DriveNLoad
				CDTray("N:", "Closed")

			Case $Msg = $DriveOLoad
				CDTray("O:", "Closed")

			Case $Msg = $DrivePLoad
				CDTray("P:", "Closed")

			Case $Msg = $DriveQLoad
				CDTray("Q:", "Closed")

			Case $Msg = $DriveRLoad
				CDTray("R:", "Closed")

			Case $Msg = $DriveSLoad
				CDTray("S:", "Closed")

			Case $Msg = $DriveTLoad
				CDTray("T:", "Closed")

			Case $Msg = $DriveULoad
				CDTray("U:", "Closed")

			Case $Msg = $DriveVLoad
				CDTray("V:", "Closed")

			Case $Msg = $DriveWLoad
				CDTray("W:", "Closed")

			Case $Msg = $DriveXLoad
				CDTray("X:", "Closed")

			Case $Msg = $DriveYLoad
				CDTray("Y:", "Closed")

			Case $Msg = $DriveZLoad
				CDTray("Z:", "Closed")

		EndSelect
	WEnd
EndFunc

Func DateTime()
	$Time = _NowTime()
	$Date = _NowDate()
EndFunc

Func DriveInfo()
	$DriveAType = DriveGetType("a:\")
	$DriveBType = DriveGetType("b:\")
	$DriveCType = DriveGetType("c:\")
	$DriveDType = DriveGetType("d:\")
	$DriveEType = DriveGetType("e:\")
	$DriveFType = DriveGetType("f:\")
	$DriveGType = DriveGetType("g:\")
	$DriveHType = DriveGetType("h:\")
	$DriveIType = DriveGetType("i:\")
	$DriveJType = DriveGetType("j:\")
	$DriveKType = DriveGetType("k:\")
	$DriveLType = DriveGetType("l:\")
	$DriveMType = DriveGetType("m:\")
	$DriveNType = DriveGetType("n:\")
	$DriveOType = DriveGetType("o:\")
	$DrivePType = DriveGetType("p:\")
	$DriveQType = DriveGetType("q:\")
	$DriveRType = DriveGetType("r:\")
	$DriveSType = DriveGetType("s:\")
	$DriveTType = DriveGetType("t:\")
	$DriveUType = DriveGetType("u:\")
	$DriveVType = DriveGetType("v:\")
	$DriveWType = DriveGetType("w:\")
	$DriveXType = DriveGetType("x:\")
	$DriveYType = DriveGetType("y:\")
	$DriveZType = DriveGetType("z:\")
	$DriveAFree = Round((DriveSpaceTotal( "a:\" )-DriveSpaceFree(" a:\" ))/DriveSpaceTotal( "a:\" )*100, 0)
	$DriveBFree = Round((DriveSpaceTotal( "b:\" )-DriveSpaceFree( "b:\" ))/DriveSpaceTotal( "b:\" )*100, 0)
	$DriveCFree = Round((DriveSpaceTotal( "c:\" )-DriveSpaceFree( "c:\" ))/DriveSpaceTotal( "c:\" )*100, 0)
	$DriveDFree = Round((DriveSpaceTotal( "d:\" )-DriveSpaceFree( "d:\" ))/DriveSpaceTotal( "d:\" )*100, 0)
	$DriveEFree = Round((DriveSpaceTotal( "e:\" )-DriveSpaceFree( "e:\" ))/DriveSpaceTotal( "e:\" )*100, 0)
	$DriveFFree = Round((DriveSpaceTotal( "f:\" )-DriveSpaceFree( "f:\" ))/DriveSpaceTotal( "f:\" )*100, 0)
	$DriveGFree = Round((DriveSpaceTotal( "g:\" )-DriveSpaceFree( "g:\" ))/DriveSpaceTotal( "g:\" )*100, 0)
	$DriveHFree = Round((DriveSpaceTotal( "h:\" )-DriveSpaceFree( "h:\" ))/DriveSpaceTotal( "h:\" )*100, 0)
	$DriveIfree = Round((DriveSpaceTotal( "i:\" )-DriveSpaceFree( "i:\" ))/DriveSpaceTotal( "i:\" )*100, 0)
	$DriveJFree = Round((DriveSpaceTotal( "j:\" )-DriveSpaceFree( "j:\" ))/DriveSpaceTotal( "j:\" )*100, 0)
	$DriveKFree = Round((DriveSpaceTotal( "k:\" )-DriveSpaceFree( "k:\" ))/DriveSpaceTotal( "k:\" )*100, 0)
	$DriveLFree = Round((DriveSpaceTotal( "l:\" )-DriveSpaceFree( "l:\" ))/DriveSpaceTotal( "l:\" )*100, 0)
	$DriveMFree = Round((DriveSpaceTotal( "m:\" )-DriveSpaceFree( "m:\" ))/DriveSpaceTotal( "m:\" )*100, 0)
	$DriveNFree = Round((DriveSpaceTotal( "n:\" )-DriveSpaceFree( "n:\" ))/DriveSpaceTotal( "n:\" )*100, 0)
	$DriveOFree = Round((DriveSpaceTotal( "o:\" )-DriveSpaceFree( "o:\" ))/DriveSpaceTotal( "o:\" )*100, 0)
	$DrivePFree = Round((DriveSpaceTotal( "p:\" )-DriveSpaceFree( "p:\" ))/DriveSpaceTotal( "p:\" )*100, 0)
	$DriveQFree = Round((DriveSpaceTotal( "q:\" )-DriveSpaceFree( "q:\" ))/DriveSpaceTotal( "q:\" )*100, 0)
	$DriveRFree = Round((DriveSpaceTotal( "r:\" )-DriveSpaceFree( "r:\" ))/DriveSpaceTotal( "r:\" )*100, 0)
	$DriveSFree = Round((DriveSpaceTotal( "s:\" )-DriveSpaceFree( "s:\" ))/DriveSpaceTotal( "s:\" )*100, 0)
	$DriveTFree = Round((DriveSpaceTotal( "t:\" )-DriveSpaceFree( "t:\" ))/DriveSpaceTotal( "t:\" )*100, 0)
	$DriveUFree = Round((DriveSpaceTotal( "u:\" )-DriveSpaceFree( "u:\" ))/DriveSpaceTotal( "u:\" )*100, 0)
	$DriveVFree = Round((DriveSpaceTotal( "v:\" )-DriveSpaceFree( "v:\" ))/DriveSpaceTotal( "v:\" )*100, 0)
	$DriveWFree = Round((DriveSpaceTotal( "w:\" )-DriveSpaceFree( "w:\" ))/DriveSpaceTotal( "w:\" )*100, 0)
	$DriveXFree = Round((DriveSpaceTotal( "x:\" )-DriveSpaceFree( "x:\" ))/DriveSpaceTotal( "x:\" )*100, 0)
	$DriveYFree = Round((DriveSpaceTotal( "y:\" )-DriveSpaceFree( "y:\" ))/DriveSpaceTotal( "y:\" )*100, 0)
	$DriveZFree = Round((DriveSpaceTotal( "z:\" )-DriveSpaceFree( "z:\" ))/DriveSpaceTotal( "z:\" )*100, 0)
EndFunc

Func SetDriveData()
	GUICtrlSetData($DriveAFreePos, $DriveAFree)
	GUICtrlSetData($DriveBFreePos, $DriveBFree)
	GUICtrlSetData($DriveCFreePos, $DriveCFree)
	GUICtrlSetData($DriveDFreePos, $DriveDFree)
	GUICtrlSetData($DriveEFreePos, $DriveEFree)
	GUICtrlSetData($DriveFFreePos, $DriveFFree)
	GUICtrlSetData($DriveGFreePos, $DriveGFree)
	GUICtrlSetData($DriveHFreePos, $DriveHFree)
	GUICtrlSetData($DriveIfreePos, $DriveIfree)
	GUICtrlSetData($DriveJFreePos, $DriveJFree)
	GUICtrlSetData($DriveKFreePos, $DriveKFree)
	GUICtrlSetData($DriveLFreePos, $DriveLFree)
	GUICtrlSetData($DriveMFreePos, $DriveMFree)
	GUICtrlSetData($DriveNFreePos, $DriveNFree)
	GUICtrlSetData($DriveOFreePos, $DriveOFree)
	GUICtrlSetData($DrivePFreePos, $DrivePFree)
	GUICtrlSetData($DriveQFreePos, $DriveQFree)
	GUICtrlSetData($DriveRFreePos, $DriveRFree)
	GUICtrlSetData($DriveSFreePos, $DriveSFree)
	GUICtrlSetData($DriveTFreePos, $DriveTFree)
	GUICtrlSetData($DriveUFreePos, $DriveUFree)
	GUICtrlSetData($DriveVFreePos, $DriveVFree)
	GUICtrlSetData($DriveWFreePos, $DriveWFree)
	GUICtrlSetData($DriveXFreePos, $DriveXFree)
	GUICtrlSetData($DriveYFreePos, $DriveYFree)
	GUICtrlSetData($DriveZFreePos, $DriveZFree)
	GUICtrlSetData($DriveATypeLabel, $DriveAType)
	GUICtrlSetData($DriveBTypeLabel, $DriveBType)
	GUICtrlSetData($DriveCTypeLabel, $DriveCType)
	GUICtrlSetData($DriveDTypeLabel, $DriveDType)
	GUICtrlSetData($DriveETypeLabel, $DriveEType)
	GUICtrlSetData($DriveFTypeLabel, $DriveFType)
	GUICtrlSetData($DriveGTypeLabel, $DriveGType)
	GUICtrlSetData($DriveHTypeLabel, $DriveHType)
	GUICtrlSetData($DriveITypeLabel, $DriveIType)
	GUICtrlSetData($DriveJTypeLabel, $DriveJType)
	GUICtrlSetData($DriveKTypeLabel, $DriveKType)
	GUICtrlSetData($DriveLTypeLabel, $DriveLType)
	GUICtrlSetData($DriveMTypeLabel, $DriveMType)
	GUICtrlSetData($DriveNTypeLabel, $DriveNType)
	GUICtrlSetData($DriveOTypeLabel, $DriveOType)
	GUICtrlSetData($DrivePTypeLabel, $DrivePType)
	GUICtrlSetData($DriveQTypeLabel, $DriveQType)
	GUICtrlSetData($DriveRTypeLabel, $DriveRType)
	GUICtrlSetData($DriveSTypeLabel, $DriveSType)
	GUICtrlSetData($DriveTTypeLabel, $DriveTType)
	GUICtrlSetData($DriveUTypeLabel, $DriveUType)
	GUICtrlSetData($DriveVTypeLabel, $DriveVType)
	GUICtrlSetData($DriveWTypeLabel, $DriveWType)
	GUICtrlSetData($DriveXTypeLabel, $DriveXType)
	GUICtrlSetData($DriveYTypeLabel, $DriveYType)
	GUICtrlSetData($DriveZTypeLabel, $DriveZType)

	If $DriveAType = "CDROM" Then
		GUICtrlSetState($DriveALoad, $GUI_ENABLE)
		GUICtrlSetState($DriveAEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveALoad, $GUI_DISABLE)
		GUICtrlSetState($DriveAEject, $GUI_DISABLE)
	EndIf

	If $DriveBType = "CDROM" Then
		GUICtrlSetState($DriveBLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveBEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveBLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveBEject, $GUI_DISABLE)
	EndIf

	If $DriveCType = "CDROM" Then
		GUICtrlSetState($DriveCLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveCEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveCLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveCEject, $GUI_DISABLE)
	EndIf

	If $DriveDType = "CDROM" Then
		GUICtrlSetState($DriveDLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveDEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveDLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveDEject, $GUI_DISABLE)
	EndIf

	If $DriveEType = "CDROM" Then
		GUICtrlSetState($DriveELoad, $GUI_ENABLE)
		GUICtrlSetState($DriveEEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveELoad, $GUI_DISABLE)
		GUICtrlSetState($DriveEEject, $GUI_DISABLE)
	EndIf

	If $DriveFType = "CDROM" Then
		GUICtrlSetState($DriveFLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveFEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveFLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveFEject, $GUI_DISABLE)
	EndIf

	If $DriveGType = "CDROM" Then
		GUICtrlSetState($DriveGLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveGEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveGLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveGEject, $GUI_DISABLE)
	EndIf

	If $DriveHType = "CDROM" Then
		GUICtrlSetState($DriveHLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveHEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveHLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveHEject, $GUI_DISABLE)
	EndIf

	If $DriveIType = "CDROM" Then
		GUICtrlSetState($DriveILoad, $GUI_ENABLE)
		GUICtrlSetState($DriveIEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveILoad, $GUI_DISABLE)
		GUICtrlSetState($DriveIEject, $GUI_DISABLE)
	EndIf

	If $DriveJType = "CDROM" Then
		GUICtrlSetState($DriveJLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveJEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveJLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveJEject, $GUI_DISABLE)
	EndIf

	If $DriveKType = "CDROM" Then
		GUICtrlSetState($DriveKLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveKEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveKLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveKEject, $GUI_DISABLE)
	EndIf

	If $DriveLType = "CDROM" Then
		GUICtrlSetState($DriveLLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveLEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveLLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveLEject, $GUI_DISABLE)
	EndIf

	If $DriveMType = "CDROM" Then
		GUICtrlSetState($DriveMLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveMEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveMLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveMEject, $GUI_DISABLE)
	EndIf

	If $DriveNType = "CDROM" Then
		GUICtrlSetState($DriveNLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveNEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveNLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveNEject, $GUI_DISABLE)
	EndIf

	If $DriveOType = "CDROM" Then
		GUICtrlSetState($DriveOLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveOEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveOLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveOEject, $GUI_DISABLE)
	EndIf

	If $DrivePType = "CDROM" Then
		GUICtrlSetState($DrivePLoad, $GUI_ENABLE)
		GUICtrlSetState($DrivePEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DrivePLoad, $GUI_DISABLE)
		GUICtrlSetState($DrivePEject, $GUI_DISABLE)
	EndIf

	If $DriveQType = "CDROM" Then
		GUICtrlSetState($DriveQLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveQEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveQLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveQEject, $GUI_DISABLE)
	EndIf

	If $DriveRType = "CDROM" Then
		GUICtrlSetState($DriveRLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveREject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveRLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveREject, $GUI_DISABLE)
	EndIf

	If $DriveSType = "CDROM" Then
		GUICtrlSetState($DriveSLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveSEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveSLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveSEject, $GUI_DISABLE)
	EndIf

	If $DriveTType = "CDROM" Then
		GUICtrlSetState($DriveTLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveTEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveTLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveTEject, $GUI_DISABLE)
	EndIf

	If $DriveUType = "CDROM" Then
		GUICtrlSetState($DriveULoad, $GUI_ENABLE)
		GUICtrlSetState($DriveUEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveULoad, $GUI_DISABLE)
		GUICtrlSetState($DriveUEject, $GUI_DISABLE)
	EndIf

	If $DriveVType = "CDROM" Then
		GUICtrlSetState($DriveVLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveVEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveVLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveVEject, $GUI_DISABLE)
	EndIf

	If $DriveWType = "CDROM" Then
		GUICtrlSetState($DriveWLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveWEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveWLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveWEject, $GUI_DISABLE)
	EndIf

	If $DriveXType = "CDROM" Then
		GUICtrlSetState($DriveXLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveXEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveXLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveXEject, $GUI_DISABLE)
	EndIf

	If $DriveYType = "CDROM" Then
		GUICtrlSetState($DriveYLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveYEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveYLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveYEject, $GUI_DISABLE)
	EndIf

	If $DriveZType = "CDROM" Then
		GUICtrlSetState($DriveZLoad, $GUI_ENABLE)
		GUICtrlSetState($DriveZEject, $GUI_ENABLE)
	Else
		GUICtrlSetState($DriveZLoad, $GUI_DISABLE)
		GUICtrlSetState($DriveZEject, $GUI_DISABLE)
	EndIf
EndFunc