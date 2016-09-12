#!/bin/bash
Current=`gnome-power-backlight-helper --get-brightness`
ANS=`zenity --scale --title="Set Brightness" --text="Brightness Level" --min-value=0 --max-value=7 --value=$Current`
pkexec gnome-power-backlight-helper --set-brightness=$ANS
exit 0
