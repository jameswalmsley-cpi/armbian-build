#!/bin/bash

# arguments: $RELEASE $LINUXFAMILY $BOARD $BUILD_DESKTOP
#
# This is the image customization script

# NOTE: It is copied to /tmp directory inside the image
# and executed there inside chroot environment
# so don't reference any files that are not already installed

# NOTE: If you want to transfer files between chroot and host
# userpatches/overlay directory on host is bind-mounted to /tmp/overlay in chroot
# The sd card's root path is accessible via $SDCARD variable.
#

export DEBIAN_FRONTEND=noninteractive

RELEASE=$1
LINUXFAMILY=$2
BOARD=$3
BUILD_DESKTOP=$4

Main() {
	case $RELEASE in
		stretch)
			# your code here
			# InstallOpenMediaVault # uncomment to get an OMV 4 image
			;;
		buster)
			# your code here
			;;
		bullseye)
			# your code here
			;;
		bionic)
			# your code here
			;;
		focal)
			# your code here
			;;
		jammy)
			# your code here
			init_chargepoint_rootfs
			;;
	esac
} # Main


init_chargepoint_rootfs() {
	echo 'alias cp.h="env GIT_WORK_TREE=$HOME GIT_DIR=$HOME/.config/chargepoint/.dot-files.git' >> /etc/skel/.bashrc
	echo 'alias cp.r="env GIT_WORK_TREE=/ GIT_DIR=$HOME/.config/chargepoint/.root.dot-files.git' >> /etc/skel/.bashrc
	cp /tmp/overlay/cp-setup /usr/bin
	apt-get -y install curl git neovim fish
	curl https://goteleport.com/static/install.sh | bash -s 14.3.3
    curl -d "accept_license_agreement=accepted&submit=Download+software" -X POST -O "https://www.segger.com/downloads/jlink/JLink_Linux_arm64.deb"
	apt-get -y install ./JLink_Linux_arm64.deb
	rm ./JLink_Linux_arm64.deb
}

Main "$@"
