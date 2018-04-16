#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# DEBUG: skipped for faster testing
exit 0

# FIXME: check if we got a new kernel.config in scripts folder and copy that to /usr/src/kernel.config

# force kernel compile
sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo eclean-kernel -n 1
sudo emerge -vt @module-rebuild

sudo env-update
source /etc/profile

# force boot-update
sudo boot-update
