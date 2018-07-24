#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_UPDATE_KERNEL:-} ]; then
	echo "BUILD_UPDATE_KERNEL was not set. Skipping kernel install ..."
	exit 0
else
	if [ "$BUILD_UPDATE_KERNEL" = false ]; then
		echo "BUILD_UPDATE_KERNEL set to FALSE. Skipping kernel install ..."
		exit 0
	fi
fi

if [ -f ${SCRIPTS}/scripts/kernel.config ]; then
	sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src
fi

sudo emerge -vt sys-kernel/debian-sources
cd /usr/src/linux && sudo make distclean

# apply 'make olddefconfig' on 'kernel.config' in case kernel config is outdated
sudo cp /usr/src/kernel.config /usr/src/kernel.config.old
sudo mv -f /usr/src/kernel.config /usr/src/linux/.config
sudo make olddefconfig
sudo mv -f /usr/src/linux/.config /usr/src/kernel.config

sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo eclean-kernel -n 1
sudo emerge -vt @module-rebuild

sudo env-update
source /etc/profile

sudo boot-update
