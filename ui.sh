#!/bin/bash
maxx=$((`tput cols`-1))
setx=0
maxy=$((`tput lines`-1))
sety=0

menu0() {
	clear
	echo "TY Game Functions Demos"
	echo ""
	echo " 1) Movement"
	echo ""
	echo " 2) Quit"
	read -sn 1 -p "" action
	case $action in
		1) menu1;;
		2) clear; exit 0;;
		*) menu0;;
	esac
}

menu1() {
	clear
	echo "TTY Game Movement Demos"
	echo ""
	echo " 1) Turn Based"
	echo " 2) Live Action"
	echo ""
	echo " 3) Back"
	read -sn 1 -p "" action
	case $action in
		1) show1;;
		2) show2;;
		3) menu0;;
		*) menu1;;
	esac
}

show1() {
	while true; do
		clear
		ymove
		read -sn 1 action
		case $action in
			q) menu1;;
			a) setx=$(($setx - 1));;
			w) sety=$(($sety + 1));;
			d) setx=$(($setx + 1));;
			s) sety=$(($sety - 1));;
		esac
	done
}

show2() {
	while true; do
		clear
		ymove
		read -sn 1 -t 0.01 action
		case $action in
			q) menu1;;
			a) setx=$(($setx - 1));;
			w) sety=$(($sety + 1));;
			d) setx=$(($setx + 1));;
			s) sety=$(($sety - 1));;
		esac
	done
}

xmove() {
	if [[ $setx -gt -1 && $setx -lt $maxx ]]; then
		xspace=0
		while ! [[ $xspace -eq $maxx ]]; do
			if [[ $xspace -eq $setx ]]; then
				echo -n "*"
			else
				echo -n ' '
			fi
			xspace=$(($xspace+1))
		done
	elif [[ $setx -lt 0 ]]; then
		setx=0
		clear
		ymove
	elif [[ $setx -gt $(($maxx-1)) ]]; then
		setx=$(($maxx-1))
		clear
		ymove
	fi
}

ymove() {
	if [[ $sety -gt -1 && $sety -lt $maxy ]]; then
		yspace=0
		while ! [[ $yspace -eq $maxy ]]; do
			if ! [[ $yspace -eq $sety ]]; then
				echo ""
			else
				xmove
			fi
		yspace=$(($yspace+1))
		done
	elif [[ $sety -lt 0 ]]; then
		sety=0
		clear
		ymove
	elif [[ $sety -gt $maxy ]]; then
		sety=$(($maxy - 1))
		clear
		ymove
	fi
}
menu0
