#!/bin/bash

###########
# Credits #
###########
#
# Coded by FCoFix.Org - Robert C. Maehl - fcofix@aol.com

#########
# LEGAL #
#########
#
# This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
#
# Licensed Since 2012
#
# This script is not completely stable and should NOT be used in any publicly distributed program or script.
# If you would like to use a stable and optimized version of this in a free non-personal program or script
# please contact the provided email address. FCoFix.Org is NOT responsibile for any damages done to your
# property, whether intellectual or of other type, caused by this script.
#
# Do you really want to have to spend thousands of dollars to get on a plane and have to appear in court?
# Make sure to give us our credit.
#
# Thanks - FCoFix.Org Staff

################
# Autoit Guide #
################
#
# Requirements:
#  Add 'include <_WINE.au3>' in your script
#
# Translation and Information Table:
#  Autoit Function:	UDF Function:		Function:		Handler:		Added for:
#  -------------------------------------------------------------------------------------------------------
#  Bin			_BIN			BIN			Python			General
#  ConsoleWrite		_CONSOLEWRITE(*,0)	CONSOLEWRITE		Bash			Debugging
#  ConsoleWriteError	_CONSOLEWRITE(*,1)	CONSOLEWRITE		Bash			Debugging
#  Dec			_DEC			DEC			Python			General
#  Hex			_HEX			HEX			Python			General
#  Int			_INT			INT			Python			General
#  Run			_RUN			RUN			Bash			General
#  RunWait		_RUNWAIT		RUNWAIT			Bash			General

I=`whoami`
CD="/home/$I/.wine/drive_c/users/$I/Temp"
PID="$CD/winebridge_pid"
LOCK="$CD/winebridge_lock"
STDIN="$CD/winebridge_stdin"
STDOUT="$CD/winebridge_stdout"
VERSION="2.0"
ERRORNUM="$CD/winebridge_errornum"

BIN() {
	python -c "print(bin($1))" >> $STDOUT
}

DEC() {
	python -c "print(int($1))" >> $STDOUT
}

ECHO() {
	echo -en "$*"
}

ERROR() {
	echo -en "$*" >2
}

Fatal() {
	kill -9 `cat "$CD/WB_Executed_PID"`
	kill -9 `cat "$CD/$PID"
`	rm -rf "$CD/{$PID,$LOCK,$STDOUT,$ERRORNUM,WB_Executed_PID}"
	exit 1
}

Help(){
	echo "Usage: Cheese [parameters] Program"
	echo
	echo "Parameters:"
	echo " -h         --help             Display this help. Must be before other parameters."
	echo " -k         --kill             Kills running winebridge instance."
	echo
	echo "Script Requirements:"
	echo " These are not currently checked for. I may add automatic checking in a later version."
	echo " It is the responibility of the user to ensure that the requirements of this script are"
	echo " installed on the system. You can check if these are installed using 'whereis'."
	echo
	echo " Command    Location(s)        What it does:"
	echo " bash       /bin/bash          Enviroment that this script runs under."
	echo " chmod      /bin/chmod         Changes file permissions."
	echo " clear      /usr/bin/clear     Clears the Screen."
	echo " echo       /bin/echo          Displays text."
	echo " kill       /bin/kill          Kills running winebridge instance."
	echo " python2.7  Too many to list   Handles math operations."
	echo " rm         /bin/rm            Deletes files for next use."
	echo
	echo "Bug reporting:"
	echo " This script SHOULD BE bug free. If problems occur check your command line entry and"
	echo " check script requirements. If problems still occur please visit our github."
	echo
	echo "Cheese $VERSION - FCoFix - Robert C. Maehl"
}

HEX() {
	python -c "print(hex($1))" >> $STDOUT
}

INT() {
	python -c "print(int($1))" >> $STDOUT
}

Kill() {
	if [[ -e $PID ]]; then
		kill -9 `cat $PID`
		rm -rf $PID
	else
		echo "WineBridge not running."
	fi
}

Loop() {
	while read -r WINE; do
		case $WINE in
			Bin,*) BIN ${WINE#"Bin,"*};;
			Dec,*) DEC ${WINE#"Dec,"*};;
			Echo,0,*) ECHO ${WINE#"Echo,0,"*};; 	#Change to ConsoleWrite
			Echo,1,*) ERROR ${WINE#"Echo,1,"*};;	#Change to ConsoleWrite
			Hex,*) HEX ${WINE#"Hex,"*};;
			Int,*) INT ${WINE#"Int,"*};;
			Run,*) RUN ${WINE#"Run,"*};;
			*);;				# Handle undefined STDOUT
		esac
#		clean
	done < <(wine $1 2>&1)
}

RUN() {
	echo -e 'echo $PPID >> WB_Executed_PID\n'"$*" > $STDIN
	cat $STDIN
	chmod +x $STDIN
	$STDIN
}
	

RUNWAIT() {
	rm -rf $LOCK $STDOUT $ERRORNUM
	clear
	chmod +x $STDIN
	echo >> $LOCK
	$STDIN >> $STDOUT
	rm -rf $LOCK $STDIN || FATAL
}

while [[ $1 == -* ]]; do
	case "$1" in
		-h|--help) Help; exit 0;;
		-k|--kill) Kill; exit 0;;
		-*) echo "Invalid parameter: $1" 1>&2; exit 1;;
	esac
done
echo $PPID > $PID
Loop $1
