#!/bin/bash


if (($# != 2)); then
	echo "Usage: create_bootable_usbdrive.sh <device> <path/to/ISOfile>"
	echo $'\nYou can see your device with the command: lsblk or sudo fdisk -l, the name is generally /dev/sdX\n'
	exit 1
fi


read -p $'\nEnter the Operating System: For Windows type: windows | For Linux type: linux \n' os

if [ "$os" = "linux" ]; then

	deviceToUmount="${1}1"

	sudo umount "$deviceToUmount"

	echo "Unmounting device..."

	sudo dd bs=4M if="$2" of="$1" status=progress oflag=sync

	echo "Done!"


elif [ "$os" = "windows" ]; then

	sudo add-apt-repository ppa:nilarimogard/webupd8
	
	sudo apt -y update

	sudo apt -y install woeusb

	echo $'\nIstalling woeusb dependencies...\n'

	sudo apt-get -y install devscripts equivs gdebi-core

	deviceToUmount="${1}1"

	sudo umount "$deviceToUmount"

	echo "Unmounting device..."

	sudo woeusb -v --target-filesystem NTFS --device "$2" "$1"
	
	echo $'This script requires woeusb to be installed, install it using the following PPA:\nsudo add-apt-repository ppa:nilarimogard/webupd8\nsudo apt update\nsudo apt install woeusb'

	echo $'\nOr you can check their github page https://github.com/slacka/WoeUSB'

	
	echo "Done!"

fi



