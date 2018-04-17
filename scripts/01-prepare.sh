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

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
app-misc/mc -edit
DATA

sudo epro flavor server

sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux (server) - Vagrant box BUILD_BOX_VERSION - build by Foobarlab
DATA
sudo sed -i 's/BUILD_BOX_VERSION/'"$BUILD_BOX_VERSION"'/g' /etc/motd
sudo cat /etc/motd

sudo env-update
source /etc/profile

sudo emerge -1v portage

sudo env-update
source /etc/profile
