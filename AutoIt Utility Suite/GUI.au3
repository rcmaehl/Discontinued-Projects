If _Singleton("FCF_UTILS",1) = 0 Then Exit
#NoTrayIcon
#include <Misc.au3>
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

		Local $Group
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
		;Drives Tab Variables
		Local $DriveCFree, $DriveCFreePos
		;Etc Tab Variable
		Local $RUN, $Browse, $BrowseFile, $PixFixInt, $Submit, $KillPID, $ExecKillPID, $Kill, $ExecKill, $Encrypt, $Decrypt, $EncryptString, $DecryptString, $PixFixTimer
		Local $Edit, $EditBrowse, $EditFile, $EditSubmit, $Format_Drive, $Format_FS, $Format_Mode, $Format_AUS
		;Variables End

	ProgressSet( 42, "Variables Loaded...")
	ProgressSet( 47, "Checking if running in WINE...")
	
		$WINE = False
		;Add Wine Detection Here
	
	ProgressSet( 63, "WINE Check Complete...")
	ProgressSet( 68, "Loading Monitors...")

;		If @OSVersion = "WIN_VISTA" Or @OSVersion = "WIN_7" Then
;			If Not $WINE Then 
;				FileDelete(@TempDir & "\cpu.csv")
;				Run('typeperf "\Processor(_Total)\% Processor Time" -y -si 00:00:00 -o ' & @TempDir & '\cpu.csv')
;				WinWait( "[Class:ConsoleWindowClass]", "", 10)
;				Sleep(200)
;				WinSetState( "[Class:ConsoleWindowClass]", "", @SW_HIDE)
;			EndIf
;		EndIf

	ProgressSet( 74, "Monitors Loaded...")
	ProgressSet( 79, "Coverting Values to English...")

		$RAMUsage = MemGetStats()
		$RefreshTimerA = TimerInit()
		$RefreshTimerB = TimerInit()
		
		If IsAdmin() Then
			$Group = "Administrator"
		Else
			$Group = "Normal User"
		EndIf
		
		If @OSServicePack = "" Then
			$OSServicePack = "Original"
		Else
			$OSServicePack = @OSServicePack
		EndIf

		If @OSVersion = "WIN_7" Then
			$OSVersion = "Windows 7"
		ElseIf @OSVersion = "WIN_VISTA" Then
			$OSVersion = "Windows Vista"
		ElseIf @OSVersion = "WIN_2008R2" Then
			$OSVersion = "Windows 2008 R2"
		ElseIf @OSVersion = "WIN_2008" Then
			$OSVersion = "Windows 2008"
		ElseIf @OSVersion = "WIN_XP" Then
			$OSVersion = "Windows XP"
		ElseIf @OSVersion = "WIN_2003" Then
			$OSVersion = "Windows 2003"
		ElseIf @OSVersion = "WIN_2000" Then
			$OSVersion = "Windows 2000"
		Else
			$OSVersion = "Unknown"
		EndIf

		If StringTrimLeft(@OSLang, 2) = "01" Then
			$Language = "Arabic"
		ElseIf StringTrimLeft(@OSLang, 2) = "04" Then
			$Language = "Chinese"
		ElseIf StringTrimLeft(@OSLang, 2) = "13" Then
			$Language = "Dutch"
		ElseIf StringTrimLeft(@OSLang, 2) = "09" Then
			$Language = "English"
		ElseIf StringTrimLeft(@OSLang, 2) = "0c" Then
			$Language = "French"
		ElseIf StringTrimLeft(@OSLang, 2) = "07" Then
			$Language = "German"
		ElseIf StringTrimLeft(@OSLang, 2) = "10" Then
			$Language = "Italian"
		ElseIf StringTrimLeft(@OSLang, 2) = "0a" Then
			$Language = "Spanish"
		Else
			$Language = "Unknown"
		EndIf

;		If $WINE Then $OSVersion = "Wine Windows"
;		If $WINE Then $OSServicePack = "Virtual"

	ProgressSet( 84, "Values Converted...")
	ProgressSet( 89, "Getting Device Info...")

	DateTime()
	DriveInfo()

	ProgressSet( 99, "Device Info Collected...")
	ProgressSet( 100, "DONE!", "Loading GUI...")

ProgressOff()

_Main()

Func _Main()

	GUICreate("AutoIt Utility Suite " & $Ver, 800, 540, -1, -1, 0x00CA0080)
		GUISetFont(10, 400, 0, "Courier New")
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
		GUISetBkColor(0x86ABD9)
		GUICtrlCreateLabel("Clock:", 0, 505, 250, 15, 0x1000)
		$TimeLabel = GUICtrlCreateLabel($date & "  " & $time, 250, 505, 150, 15, 0x1001)

		GUICtrlCreateTab(0, 0, 800, 550, 0x0148)
			$Maintab = GUICtrlCreateTabItem("System Info")
			
				GUICtrlCreateGroup("Operating System", 5, 25, 790, 65)
				GUICtrlCreateLabel("You Are Running", 15, 45, 770, 20, 0x1801)

				GUICtrlCreateGroup("User Info", 5, 95, 390, 65)
				GUICtrlCreateLabel("User Name", 15, 115, 200, 20, 0x1000)
				GUICtrlCreateLabel("Account Type", 15, 135, 200, 20, 0x1000)

				GUICtrlCreateGroup("Main Drive - " & @HomeDrive & "\", 405, 95, 390, 65)
				GUICtrlCreateLabel("Drive Summary", 415, 115, 200, 20, 0x1000)
				GUICtrlCreateLabel("Drive Usage Level", 415, 135, 200, 20, 0x1000)

				GUICtrlCreateGroup("Display Info", 5, 165, 260, 105)
				GUICtrlCreateLabel("Display Height", 15, 185, 120, 20, 0x1000)
				GUICtrlCreateLabel("Display Width", 15, 205, 120, 20, 0x1000)
				GUICtrlCreateLabel("Display Refresh", 15, 225, 120, 20, 0x1000)
				GUICtrlCreateLabel("Display Colors", 15, 245, 120, 20, 0x1000)

				GUICtrlCreateGroup("Network Info", 270, 165, 260, 105)
				GUICtrlCreateLabel("Computer Name", 280, 185, 120, 20, 0x1000)
				GUICtrlCreateLabel("Primary IP", 280, 205, 120, 20, 0x1000)
				GUICtrlCreateLabel("Secondary IP", 280, 225, 120, 20, 0x1000)
				GUICtrlCreateLabel("Logon Server", 280, 245, 120, 20, 0x1000)

				GUICtrlCreateGroup("CPU and RAM Info", 535, 165, 260, 105)

				GUICtrlSetDefBkColor(0xFFFFFF)
				GUISetFont(8, 550, 0, "Lucida Console")
				
				GUICtrlCreateInput($OSVersion & " " & @OSArch & " " & $OSServicePack & " " & $Language & " Version installed in " & @WindowsDir, 15, 65, 770, 20, 0x0801)
				
				GUICtrlCreateInput(@UserName, 220, 115, 165, 20, 0x0801)
				GUICtrlCreateInput($Group, 220, 135, 165, 20, 0x0801)
				
				GUICtrlCreateInput(DriveGetType(@HomeDrive & "\") & " - " & DriveGetFileSystem(@HomeDrive & "\"), 620, 115, 165, 20, 0x0801)
				$DriveCFreePos = GUICtrlCreateProgress(620, 135, 165, 20, 0x01)

				GUICtrlCreateInput(@DesktopHeight & " Pixels", 140, 185, 115, 20, 0x0801)
				GUICtrlCreateInput(@DesktopWidth & " Pixels", 140, 205, 115, 20, 0x0801)
				GUICtrlCreateInput(@DesktopRefresh & " Hz", 140, 225, 115, 20, 0x0801)
				GUICtrlCreateInput(@DesktopDepth & " Bits", 140, 245, 115, 20, 0x0801)

				GUICtrlCreateInput(@ComputerName, 405, 185, 115, 20, 0x0801)
				GUICtrlCreateInput(@IPAddress1, 405, 205, 115, 20, 0x0801)
				GUICtrlCreateInput(@IPAddress2, 405, 225, 115, 20, 0x0801)
				GUICtrlCreateInput(@LogonServer, 405, 245, 115, 20, 0x0801)

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
				SetDriveData()

		EndSelect
	WEnd
EndFunc

Func DateTime()
	$Time = _NowTime()
	$Date = _NowDate()
EndFunc

Func DriveInfo()
	$DriveCFree = Round((DriveSpaceTotal( @HomeDrive & "\" )-DriveSpaceFree( @HomeDrive & "\" ))/DriveSpaceTotal( @HomeDrive & "\" )*100, 0)
EndFunc

Func SetDriveData()
	GUICtrlSetData($DriveCFreePos, $DriveCFree)
EndFunc