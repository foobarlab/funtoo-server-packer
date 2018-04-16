#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -f ${SCRIPTS}/scripts/kernel.config ]; then
	sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src
fi

sudo emerge -vt sys-kernel/debian-sources
cd /usr/src/linux && sudo make distclean
sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo eclean-kernel -n 1
sudo emerge -vt @module-rebuild

sudo env-update
source /etc/profile

sudo boot-update
