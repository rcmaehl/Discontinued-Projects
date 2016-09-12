clear
while [ 1 == 1 ]; do
	clear
	echo TTY Sensor Monitor - 1.0.0.1
	echo Created by Robert C. Maehl
	echo ---------------------------------------------
	echo CPU Coretemp
	sudo sensors coretemp-isa-0000
	echo Power Tempature
	sudo sensors acpitz-virtual-0
#	sudo psad --status-summary
	sleep 1.5
	if [ -e $HOME/Desktop/ssr ]; then
		exit 0
	fi
done
