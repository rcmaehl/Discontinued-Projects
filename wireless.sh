#/bin/bash
#
#To do list:
#Account for grep errors
#Add Multicard Support
#Make this a .deb
#
#Enter your cards here with a space between each)
cards=('rtl8192se')
#Don't change anything after this.
card=0
cards+=('null')

until [ ${cards[$card]} = "null" ]; do 
	lsmod | grep -q -i ${cards[$card]}
	if [ $? = "1" ]; then
		gksudo modprobe ${cards[$card]}
		lsmod | grep -q -i ${cards[$card]}
		if [ $? = "1" ]; then
			zenity --error --title="Wi-Fi" --text="Wireless toggle error."
		else
			zenity --info --title="Wi-Fi" --text="Wireless toggled on." --timeout=1
		fi
	else
		zenity --question --title="Wi-Fi" --text="What do you want to do to ${cards[$card]}?" --ok-label="Toggle" --cancel-label="Cycle"
		if [ $? = "1" ]; then
			gksudo rmmod ${cards[$card]}
			gksudo modprobe ${cards[$card]}
		else
			gksudo rmmod ${cards[$card]}
			lsmod | grep -q -i ${cards[$card]}
			if [ $? != "1" ]; then
				zenity --error --title="Wi-Fi" --text="Wireless toggle error."
			else
				zenity --info --title="Wi-Fi" --text="Wireless toggled off" --timeout=1
			fi
		fi
	fi
	card=$card+1
done
exit 0
