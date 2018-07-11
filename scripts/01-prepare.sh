#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo ego sync

if [ $BUILD_UNRESTRICTED_LICENSES = "true" ]; then
	sudo cp -f /etc/portage/make.conf /etc/portage/make.conf.bak
	sudo sed -i 's/ bindist / -bindist /g' /etc/portage/make.conf
	sudo sed -i 's/ACCEPT_LICENSE=\"\-\* @FREE @BINARY-REDISTRIBUTABLE\"/ACCEPT_LICENSE="*"/g' /etc/portage/make.conf
	sudo cat /etc/portage/make.conf
fi

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
app-misc/mc -edit
app-admin/rsyslog gnutls
DATA

sudo epro flavor server
sudo epro list

sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux (BUILD_BOX_NAME) - Vagrant box BUILD_BOX_VERSION
DATA
sudo sed -i 's/BUILD_BOX_NAME/'"$BUILD_BOX_NAME"'/g' /etc/motd
sudo sed -i 's/BUILD_BOX_VERSION/'"$BUILD_BOX_VERSION"'/g' /etc/motd
sudo cat /etc/motd

sudo env-update
source /etc/profile

sudo emerge -1v portage

sudo env-update
source /etc/profile
