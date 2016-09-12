KidSafe is a computer-locking application designed to keep young children from messing something up.

KidSafe will launch a full-screen window that hides the entire desktop, TaskBar, etc. Because the window is blank (except for the unlock entry box; see below for details), clicking it won't have any effect. Small children, who generally enjoy clicking the mouse, can click all they like without damaging anything.
If the appropriate option is set, KidSafe also prevent the system from being shutdown - even if a small child presses the power button, the system won't shut down.
If the appropriate options are set, KidSafe can disable all of the system keys - the Windo
ws key, a combination of the Windows key and any other key, Alt-Tab, Alt-Escape, Ctrl-Escape, and Ctrl-Alt-Delete. This can be very useful, especially if a small kid keeps accidentally opening the Start Menu and selecting items in it: just disable the Windows key and the Ctrl-Escape key combination, and voila! No more Start Menu.

KidSafe's feature disabling is only temporary - even if KidSafe crashes, none of the disabled features will stay disabled. The worst that can happen is that you might need to reboot your computer to restore everything the way it had been before. Even the Task Manager will be restored - unlike some applications, KidSafe's blocking of the Task Manager is only temporary. Even if KidSafe crashes, the Task Manager won't stay locked.

Closing KidSafe is very easy - just type the password into the unlock-box in the middle of the window, then press the ENTER key or the OK button. KidSafe will compare the text you typed to the real password (just in case a little kid might be typing in the passwordbox), and close if the two entries match (the text comparison is case-sensitive, so an password of "PASSWORD" won't match an entry of "password" in the passwordbox). If they don't match, KidSafe will put up an error dialog; close it by hitting the "OK" button. Once the two entries match, KidSafe will close and all of its changes will be undone.
(In Screensaver mode or Hotkey mode, the "OK" button is replaced by two other buttons, "Hide" and "Close")
If there's no password in the preferences file, or the preferences file doesn't exist, KidSafe will automatically close - this is a precaution designed to avoid trapping users in the KidSafe dialog without a way to exit.

KidSafe's configuration file is fairly simple to edit manually as well (except for the password); there are only a handful of values you can edit, and almost all of the values are simple true/false choices.

The configuration file is saved in the Data folder as Prefs.dat; here is its structure.

  [GUI]
  BackgroundGraphic=
  HotKey=
  HotKeyModifierMask=
  Mode=
  TimeOut=
  UsePasswordDialog=
  UseSystemTrayIcon=
  
  [Locks]
  LockAltEscape=
  LockAltTab=
  LockCtrlEscape=
  LockRemovableDevices=
  LockShutdown=
  LockTaskManager=
  LockWindowsKey=
  PutKidSafeOnTop=
  UnlockText=
  
  
BackgroundGraphic - the path to the image used as the background graphic for the KidSafe window. Images in BMP, GIF and JPG/JPEG format are guaranteed to work; other image formats may work, but probably won't unless you have QuickTime installed on your computer. Because of this restriction, only BMP, GIF and JPG/JPEG images are shown in the Options dialog; if you want to use another image type, you'll need to manually edit the configuration file.
If you specify a file that doesn't exist or isn't an image file, KidSafe will use its default background graphic instead.

HotKey - a numerical value from 0 to 255. Specifies the virtual-key code for the KidSafe hotkey. (Unless you're a programmer, you probably don't want to edit this manually; it's easy to break something, and somewhat difficult to get the correct value)

HotKeyModifierMask - a numerical value. Specifies whether the hotkey should include the Ctrl key, the Alt key, the Shift key, the Windows key (also known as the Start key), or a combination of these.

LockAltEscape - true or false. Specifies whether the Alt-Escape key sequence should be disabled or not.

LockAltTab - true or false. Specifies whether the Alt-Tab key sequence should be disabled or not.

LockCtrlEscape - true or false. Specifies whether the Ctrl-Escape key sequence should be disabled or not.

LockRemovableDevices - true or false. Specifies whether removable devices should be prevented from ejecting or not; setting this value to true also prevents the CD tray from being opened.

LockShutdown - true or false. Specifies whether the system shutdown is disabled or not. (Note: even if LockShutdown is set to true, trying to shutdown the computer might close some of your applications. This is a limitation of Windows, not KidSafe)

LockTaskManager - true or false. Specifies whether the Task Manager should be locked or not. (Note that any running Task Manager instances will be closed)

LockWindowsKey - true or false. Specifies whether the Windows key (aka the Start key) should be disabled or not. If set to true, it will also disable all key combinations involving the Windows key, including Windows+R (run a program) and Windows+M (minimize all windows)

Mode - 0, 1 or 2. Specifies whether KidSafe should be in normal mode, screensaver mode or hotkey mode. If set to 0, KidSafe will immediately open its fullscreen window; if set to 1, KidSafe will run in the background and monitor the system. KidSafe will essentially behave like a screensaver, checking for system activity; if the system remains inactive for the number of seconds specified by TimeOut, KidSafe's fullscreen window will open. This could be extremely useful for someone who has to leave their computer periodically, since KidSafe won't activate until the computer's been idle for the time period specified by TimeOut's value. If Mode is set to 2, KidSafe will run in the background and wait for you to press the user-defined hotkey that activates KidSafe.

PutKidSafeOnTop - true or false. Specifies whether the KidSafe window should be placed on top of every window (including the Start Menu and Alt-Tab dialog) or not.

TimeOut - a number value. If Mode is set to 1, KidSafe will run in the background and monitor the system. KidSafe will essentially behave like a screensaver, checking for system activity; if the system remains inactive for the number of seconds specified by TimeOut, KidSafe's fullscreen window will open. This could be extremely useful for someone who has to leave their computer periodically, since KidSafe won't activate until the computer's been idle for the time period specified by TimeOut's value.

Unlocktext - the text you'll need to type in the unlock box to turn KidSafe off. Make sure you'll remember this, because it can't be recovered once you enter it. YOU CAN'T EDIT THIS IN THE Prefs.dat FILE; IT'S SPECIALLY ENCODED IN A NON-RECOVERABLE FORMAT.

UsePasswordDialog - true or false. If set to true, the passwordbox will display a string of asterisks (*) instead of the actual password when you type it. This can be extremely useful if you're trying to stop kids who are old enough to read - they won't be able to see what you're typing.

UseSystemTrayIcon - true or false. If set to true, KidSafe will show its icon in the system tray; double-clicking the tray icon will show the KidSafe window. (The tray icon is only shown in screensaver mode or hotkey mode, since it isn't necessary in normal mode.) The tray icon also serves as a reminder that KidSafe is running.

The default setting for each of these options is false (to be precise, the default setting is false, 0, or nothing, depending on the value type); if you want to lock anything, you'll need to manually set the value of its setting to true. This is a safety limitation designed to avoid accidentally locking something you didn't want locked.





CREDITS:

* agdurrette did a stellar job beta testing and provided a great user's-eye view of KidSafe

* gluxon provided a critical bug report for Vista, and subsequently confirmed the bug fix

* digitxp made some valuable suggestions, provided a great new icon, and pointed out a flaw in KidSafe's PAF compliance

* BuddhaChu made sure KidSafe wasn't violating any trademarks

* Aaron Ballman provided the impressive & powerful Windows Functionality Suite; KidSafe uses code from it in several places.

* d3nn1as provided a critical function to get a file path from a process ID

* babasse created the cool padlock icon (http://www.iconspedia.com/icon/padlocks-1464.html)

* tiarescott created the nice beach background that is KidSafe's default background image (http://www.flickr.com/photos/tiarescott/33505225/sizes/o/)

* Tim Clark, GizmoKid2005 and John T. Haller made some valuable suggestions on making KidSafe more secure (less vulnerable to being abused by malicious users)

* Randy Birch provided the LockRemovableDevices function

* Chris Morgan thoroughly went over the PAF launcher and other files and made several changes, including rewriting the launcher

* Tony Welsh provided the command-line parser (http://evolvedcode.net/content/code_vbcmdline/)

* Duncan Edwards Jones provided the interprocess communication code (http://www.codeproject.com/KB/vbscript/vb6ipc.aspx)

* Alexander Triantafyllou provided the GetRelativePath code (http://freevbcode.com/ShowCode.asp?ID=6137&NoBox=True)

* Robert C. Maehl helped debug versions and hosts the Kidsafe Update page, anti-spam IP gatherer, and redirecting URLs

* weatherkid is doing a good job handling the KidSafe source repository, provided a digital certificate, and helped with several other important tasks

* Onesimus Prime, guinness, webfork, joby_toss, and other The Portable Freeware Collection (http://www.portablefreeware.com) members did an excellent job testing KidSafe, finding bugs, and providing great feedback & feature requests.


Thanks to everyone else who helped with KidSafe; whether big or small, your contribution was valuable in KidSafe's development!