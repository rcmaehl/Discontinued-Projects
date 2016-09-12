#!/bin/bash

#Set Default Variables
active=0
legacy=0
snooze=1
starts="0:00"
release="1.7.1"
testing=0

#Adjust alarm hour if alarm minutes is greater than 59
Adjust_Hour() {
	if (( $m >= 60 )); then
		m=$((10#$m-60))
		h=$((10#$h+1))
	fi
}

#Display Changes
Display_Changes() {
	echo "Changelog for last few revisions:"
	echo ""
	echo "1.7.1   - Improved padding."
	echo "1.7     - Added no snooze option."
	echo "1.6.3   - Improved test mode."
	echo "1.6.2.2 - Minor variable changes."
	echo "1.6.2.1 - Added new error messages."
	echo "1.6.2   - Changed redundant parameter checking."
#	echo "1.6.1.1 - Decreased sleep by 10 milliseconds."
#	echo "1.6.1   - Added Changelog, Minor variable changes."
}

#Display Clock
Display_Clock() {
	clear
	date=`date +%R`
	time=`printf '%02d:%02d\n'  "$h" "$m"`
	echo "AlarmClock $release"
	echo "---------------------------------"
	echo "It is currently:            $date"
	echo "Alarm is set for:           $time"
	echo "---------------------------------"
}

#Display Help
Display_Help() {
	echo "Usage: alarmclock [parameters] hh:mm [media file]"
	echo ""
	echo "Parameters:"
	echo " -c         --changes          Display simplified changelog."
	echo " -h         --help             Display this help. Must be before other parameters."
	echo " -l         --legacy           For old computers. Recommended if problems have occured."
	echo " -n         --snoozeless       Disable Snoozing."
	echo " -t         --test             Sets the alarm to go off instantly."
	echo ""
	echo "Future Parameters:"
	echo " -b         --beep             Use 'beep' instead of a media file."
	echo ""
	echo "Script Requirements:"
	echo " These are not currently checked for. I may add automatic checking in a later version."
	echo " It is the responibility of the user to ensure that the requirements of this script are"
	echo " installed on the system. You can check if these are installed using 'whereis'."
	echo ""
	echo " bash       /bin/bash          Enviroment that this script runs under."
	echo " clear      /usr/bin/clear     Clears the Screen."
	echo " date       /bin/date          Gets the current time."
	echo " echo       /bin/echo          Displays the Clock."
	echo " mplayer    /usr/bin/mplayer   Plays the alarm."
	echo " pkill      /usr/bin/pkill     Prevents redundant mplayers"
	echo " printf     /usr/bin/printf    Ensures proper spacing."
	echo " sleep      /bin/sleep         Prevents the cpu from being at 100% constantly."
	echo " timeout    /usr/bin/timeout   Prevents redundant mplayers."
	echo ""
	echo "Bug reporting:"
	echo " This script IS bug free. If problems occur try the --legacy parameter, check your"
	echo " command line entry, and/or check script requirements. All bugs and errors are caused by"
	echo " the user. The developer of this script does not give support for incompetance and/or"
	echo " stupidity."
	echo ""
	echo "alarmclock $release - FCoFix - Robert C. Maehl"
}

#Alarm Check Loop
Loop() {
	while sleep 0.9; do
		if [[ $(date +%S) = '00' ]]; then
			active=1
			Display_Clock
		fi
		if [[ $(date +%R) = $(printf '%02d:%02d\n'  "$h" "$m") ]]; then
			if [[ $active = 1 ]]; then
				Sound_Alarm
			fi
		fi
	done
}

#Set the alarm
Set_Alarm() {
	h=$((10#${1%:*}))
	m=$((10#${1#*:}))
	if [[ $testing = 1 ]]; then
		active=1
	else
		active=0
	fi
}

#Plays the Alarm
Sound_Alarm() {
	timeout --kill-after=$((60-$(date +%-S))) --signal=9 $((59-$(date +%-S)-$legacy)) mplayer -msglevel all=-1 $alarm -loop 0 &
	sleep 1
	Display_Clock
	if [[ $snooze = 1 ]]; then
		if [[ $testing = 1 ]]; then
			read -p "((Q)uit/(S)nooze): " -t $((58-$(date +%-S)-$legacy)) action || action=None
		else
			read -p "((Q)uit/(R)eset/(S)nooze): " -t $((58-$(date +%-S)-$legacy)) action || action=None
		fi
	else
		if [[ $testing = 1 ]]; then
			read -p "((Q)uit): " -t $((58-$(date +%-S)-$legacy)) action || action=None
		else
			read -p "((Q)uit/(R)eset): " -t $((58-$(date +%-S)-$legacy)) action || action=None
		fi
	fi
	if [[ $action = [Ss]?([Nn][Oo][Oo][Zz][Ee]) ]]; then
		if [[ $snooze = 1 ]]; then
			m=$((10#$m+5))
			Adjust_Hour
		fi
	elif [[ $action = [Rr]?([Ee][Ss][Ee][Tt]) ]]; then
		if [[ $testing = 1 ]]; then
			pkill -9 mplayer
			echo "Reset is not implemented for tests! Quiting instead!" 1>&2
			exit 1
		else
			Set_Alarm $starts
		fi
	elif [[ $action = [Qq]?([Uu][Ii][Tt]) ]]; then
		pkill -9 mplayer
		clear
		exit 0
	elif [[ $action = None ]]; then
		m=$((10#$m+1))
		Adjust_Hour
	fi
	Display_Clock
	pkill -9 mplayer
}

#Check Parameters and if nothing special set the alarm
while [[ $1 == -* ]]; do
	case "$1" in
		-b|--beep) echo "$1 is not yet implemented!" 1>&2; Display_Help; exit 1;;
		-c|--changes) Display_Changes; exit 0;;
		-h|--help) Display_Help; exit 0;;
		-l|--legacy) legacy=10; shift;;
		-n|--snoozeless) snooze=0; shift;;
		-t|--test) testing=1; shift;;
		--) shift; break;;
		-*) echo "Invalid parameter: $1" 1>&2; Display_Help; exit 1;;
	esac
done

if [[ -n $1 ]]; then
	starts=$1
	Set_Alarm $1
elif [[ $testing = "1" ]]; then
	Set_Alarm `date +%R`
else
	echo "Time not declared!" 1>&2
	exit 1
fi

if [[ -n $2 ]]; then
	alarm=$2
else
	alarm=./Sandstorm.mp3
fi

if ! [[ -e $alarm ]]; then
	echo "File not found: $alarm" 1>&2
	exit 1
fi


if (($h < 0 || $h > 23 || $m < 0 || $m > 59)); then
	echo "Invalid Time: $1" 1>&2
	exit 1
fi

Display_Clock && Loop
