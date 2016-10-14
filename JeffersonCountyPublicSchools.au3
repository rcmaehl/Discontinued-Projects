#NoTrayIcon
Global $WA[5][8], $CP[1], $ID[4]

Main()

Func Main()

	GUICreate("JCPS Work-Arounds", 400, 300, -1, -1)
	GUICtrlCreateTab(0, 0, 400, 300)
	$ID[0] = GUICtrlCreateTabItem("Main")
	$WA[0][0] = GUICtrlCreateButton("Administrator", 010, 040, 100, 020)
	$WA[0][1] = GUICtrlCreateButton("C:\", 010, 070, 100, 020)
	$WA[0][2] = GUICtrlCreateButton("Powershell", 010, 100, 100, 020)
	$WA[0][3] = GUICtrlCreateButton("Command Prompt", 010, 130, 100, 020)
	$WA[0][4] = GUICtrlCreateButton("Task Manager", 010, 160, 100, 020)
	$ID[1] = GUICtrlCreateTabItem("Control Panel")
	$WA[1][0] = GUICtrlCreateButton("Screensaver", 010, 040, 160, 020)
	$WA[1][1] = GUICtrlCreateButton("Windows Features", 010, 070, 160, 020)
	$WA[1][2] = GUICtrlCreateButton("Region and Language", 010, 100, 160, 020)
	$WA[1][3] = GUICtrlCreateButton("Folder Options", 010, 130, 160, 020)
	$WA[1][4] = GUICtrlCreateButton("Power Options", 010, 160, 160, 020)
	$WA[1][5] = GUICtrlCreateButton("Window Color and Appearance", 010, 190, 160, 020)
	$WA[1][6] = GUICtrlCreateButton("Task Scheduler", 010, 220, 160, 020)
	$WA[1][7] = GUICtrlCreateButton("Game Controllers", 010, 250, 160, 020)
	$ID[1] = GUICtrlCreateTabItem("Control Panel 2")
	$WA[2][0] = GUICtrlCreateButton("Indexing Options", 010, 040, 160, 020)
	$WA[2][1] = GUICtrlCreateButton("iSCSI Initiator Properties", 010, 070, 160, 020)
	$WA[2][2] = GUICtrlCreateButton("Mail", 010, 100, 160, 020)
	$WA[2][3] = GUICtrlCreateButton("Offline Files", 010, 130, 160, 020)
	$WA[2][4] = GUICtrlCreateButton("Phone and Modem", 010, 160, 160, 020)
	$WA[2][5] = GUICtrlCreateButton("Scanners and Cameras", 010, 190, 160, 020)
	$WA[2][6] = GUICtrlCreateButton("Set Up a Network", 010, 220, 160, 020)
	$WA[2][7] = GUICtrlCreateButton("Microsoft ODBC Administrator", 010, 250, 160, 020)
	$ID[2] = GUICtrlCreateTabItem("Control Panel 3")
	$WA[3][0] = GUICtrlCreateButton("Get Programs", 010, 040, 160, 020)
	$WA[3][1] = GUICtrlCreateButton("People Near Me", 010, 070, 160, 020)
	$WA[3][2] = GUICtrlCreateButton("Text to Speech", 010, 100, 160, 020)
	$WA[3][3] = GUICtrlCreateButton("Add Printer", 010, 130, 160, 020)
	$WA[3][4] = GUICtrlCreateButton("Desktop Icon Settings", 010, 160, 160, 020)
	$WA[3][5] = GUICtrlCreateButton("Map Network Drive", 010, 190, 160, 020)
	$WA[3][6] = GUICtrlCreateButton("About", 010, 220, 160, 020)
	$WA[3][7] = GUICtrlCreateButton("Users, Contacts, and Groups", 010, 250, 160, 020)
	$ID[3] = GUICtrlCreateTabItem("Control Panel 4")
	$WA[4][0] = GUICtrlCreateButton("Content Advisor", 010, 040, 160, 020)
	$WA[4][1] = GUICtrlCreateButton("Forgotten Password Wizard", 010, 070, 160, 020)
	$WA[4][2] = GUICtrlCreateButton("User Names and Passwords", 010, 100, 160, 020)
	$WA[4][3] = GUICtrlCreateButton("Device Manager", 010, 130, 160, 020)
;	$WA[4][4] = GUICtrlCreateButton("Desktop Icon Settings", 010, 160, 160, 020)
;	$WA[4][5] = GUICtrlCreateButton("Map Network Drive", 010, 190, 160, 020)
;	$WA[4][6] = GUICtrlCreateButton("About", 010, 220, 160, 020)
;	$WA[4][7] = GUICtrlCreateButton("Users, Contacts, and Groups", 010, 250, 160, 020)


	GUICtrlCreateTabItem("")

	GUISetState()

	While 1
		$Msg = GUIGetMsg()
		Select
			Case $Msg = -3
				Exit (0)
			Case $Msg = $WA[0][0]
				FileWrite("C:\add group\groupadd.bat", "net localgroup administrators " & @UserName & " /add")
			Case $Msg = $WA[0][1]
				Run("powershell.exe explorer.exe C:\")
			Case $Msg = $WA[0][2]
				Run("powershell.exe")
			Case $Msg = $WA[0][3]
				Run("powershell.exe command.com")
			Case $Msg = $WA[0][4]
				Run("powershell.exe tasklist; sleep 60")
			Case $Msg = $WA[1][0]
				Run("control.exe desk.cpl,screensaver,@screensaver")
			Case $Msg = $WA[1][1]
				Run("OptionalFeatures.exe")
			Case $Msg = $WA[1][2]
				Run('control.exe /name Microsoft.RegionalAndLanguageOptions /page /p:"formats"')
			Case $Msg = $WA[1][3]
				Run("rundll32.exe shell32.dll,Options_RunDLL 0")
			Case $Msg = $WA[1][4]
				Run("control.exe powercfg.cpl,,3")
			Case $Msg = $WA[1][5]
				Run("control.exe color")
			Case $Msg = $WA[1][6]
				Run("control.exe schedtasks")
			Case $Msg = $WA[1][7]
				Run("control.exe joy.cpl")
			Case $Msg = $WA[2][0]
				Run("control.exe srchadmin.dll")
			Case $Msg = $WA[2][1]
				Run("control.exe iscsicpl.dll,-5001")
			Case $Msg = $WA[2][2]
				Run("control.exe MLCFG32.CPL")
			Case $Msg = $WA[2][3]
				Run("control.exe cscui.dll")
			Case $Msg = $WA[2][4]
				Run("control.exe telephon.cpl,-1")
			Case $Msg = $WA[2][5]
				Run("control.exe sticpl.cpl")
			Case $Msg = $WA[2][6]
				Run("control.exe netsetup.cpl")
			Case $Msg = $WA[2][7]
				Run("control.exe odbccp32.cpl")
			Case $Msg = $WA[3][0]
				Run("control.exe /name Microsoft.GetPrograms")
			Case $Msg = $WA[3][1]
				Run("control /name Microsoft.PeopleNearMe")
			Case $Msg = $WA[3][2]
				Run("control /name Microsoft.TextToSpeech")
			Case $Msg = $WA[3][3]
				Run("rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL AddPrinter")
			Case $Msg = $WA[3][4]
				Run("rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0")
			Case $Msg = $WA[3][5]
				Run("RUNDLL32 SHELL32.DLL,SHHelpShortcuts_RunDLL Connect")
			Case $Msg = $WA[3][6]
				Run("RUNDLL32 SHELL32.DLL,ShellAboutW")
			Case $Msg = $WA[3][7]
				Run("RUNDLL32 dsquery,OpenQueryWindow")
			Case $Msg = $WA[4][0]
				Run("RunDll32.exe msrating.dll,RatingSetupUI")
			Case $Msg = $WA[4][1]
				Run("RunDll32.exe keymgr.dll,PRShowSaveWizardExW")
			Case $Msg = $WA[4][2]
				Run("RunDll32.exe keymgr.dll,KRShowKeyMgr")
			Case $Msg = $WA[4][3]
				Run("rundll32 devmgr.dll DeviceManager_Execute")
;			Case $Msg = $WA[4][4]
;				Run("rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0")
;			Case $Msg = $WA[4][5]
;				Run("RUNDLL32 SHELL32.DLL,SHHelpShortcuts_RunDLL Connect")
;			Case $Msg = $WA[4][6]
;				Run("RUNDLL32 SHELL32.DLL,ShellAboutW")
;			Case $Msg = $WA[4][7]
;				Run("RUNDLL32 dsquery,OpenQueryWindow")
			Case Else
				;;;
		EndSelect
	WEnd
EndFunc   ;==>Main
