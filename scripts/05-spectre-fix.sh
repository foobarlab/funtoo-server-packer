#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_SPECTRE_FIX:-} ]; then
	echo "BUILD_SPECTRE_FIX was not set. Skipping ..."
	exit 0
else
	if [ "$BUILD_SPECTRE_FIX" = false ]; then
		echo "BUILD_SPECTRE_FIX set to FALSE. Skipping ..."
		exit 0
	else
		echo "BUILD_SPECTRE_FIX set to TRUE. You will need CPU/Microcode support and a retpoline-aware GCC version (7.3.1+ recommended) for this to work ..."
		gcc_version=`gcc -dumpversion`
		major=`echo $gcc_version | cut -d. -f1`
		minor=`echo $gcc_version | cut -d. -f2`
		revision=`echo $gcc_version | cut -d. -f3`
		echo "You have GCC $major.$minor.$revision installed."
	fi	
fi

# install spectre-metdown-checker to verify applied fixes
cd /usr/local/src
sudo git clone https://github.com/speed47/spectre-meltdown-checker.git
sudo /usr/local/src/spectre-meltdown-checker/spectre-meltdown-checker.sh

# to fix spectre v2 we need to recompile the kernel with gcc 7.3.1+
cd /usr/src/linux && sudo make distclean
sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo eclean-kernel -n 1
sudo emerge -vt @module-rebuild

sudo env-update
source /etc/profile

sudo boot-update

# FIXME most likely needs a reboot to load the new kernel and to show up-to-date info, TODO move to vagrantfile internal script
sudo /usr/local/src/spectre-meltdown-checker/spectre-meltdown-checker.sh
