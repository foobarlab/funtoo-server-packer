#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo ego sync

if [ $BUILD_UNRESTRICTED_LICENSES = "true" ]; then
	sudo sed -i 's/ACCEPT_LICENSE=\"\-\* @FREE @BINARY-REDISTRIBUTABLE\"/ACCEPT_LICENSE="*"/g' /etc/portage/make.conf
	sudo cat /etc/portage/make.conf
fi

sudo epro flavor server

# FIXME replace /etc/motd - use a template ...
sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux (server) - Experimental Vagrant box v0.0.2
Build by Foobarlab
DATA

sudo env-update
source /etc/profile

sudo emerge -1v portage

sudo env-update
source /etc/profile
