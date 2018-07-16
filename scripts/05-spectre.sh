#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_SPECTRE:-} ]; then
	echo "BUILD_SPECTRE was not set. Skipping ..."
	exit 0
else
	if [ "$BUILD_SPECTRE" = false ]; then
		echo "BUILD_SPECTRE set to FALSE. Skipping ..."
		exit 0
	else
		echo "BUILD_SPECTRE set to TRUE. Checking GCC version ..."
		gcc_version=`gcc -dumpversion`
		major=`echo $gcc_version | cut -d. -f1`
		minor=`echo $gcc_version | cut -d. -f2`
		revision=`echo $gcc_version | cut -d. -f3`
		echo "You have GCC $major.$minor.$revision installed." 
	fi
fi

# NOTE: cpu microcode firmware was already enabled in funtoo-core

# to fix spectre v2 we need to recompile the kernel with gcc 7.3.1+ (retpoline-aware compiler)
cd /usr/src/linux && sudo make distclean
sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo eclean-kernel -n 1
sudo emerge -vt @module-rebuild

sudo env-update
source /etc/profile

sudo boot-update

# install spectre-metdown-checker
cd /usr/local/src
sudo git clone https://github.com/speed47/spectre-meltdown-checker.git
sudo /usr/local/src/spectre-meltdown-checker/spectre-meltdown-checker.sh -v 2>/dev/null || true

# report current Spectre/Meltdown status
# TODO check status results: probably needs a reboot to load the new kernel and to show up-to-date info
sudo /usr/local/src/spectre-meltdown-checker/spectre-meltdown-checker.sh -v 2>/dev/null || true