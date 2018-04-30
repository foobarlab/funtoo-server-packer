#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_INCLUDE_SALTSTACK:-} ]; then
	echo "BUILD_INCLUDE_SALTSTACK was not set. Skipping ..."
	exit 0
else
	if [ "$BUILD_INCLUDE_SALTSTACK" = false ]; then
		echo "BUILD_INCLUDE_SALTSTACK set to FALSE. Skipping ..."
		exit 0
	fi	
fi

# install and configure saltstack for automation
sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
app-admin/salt portage vim-syntax gnupg keyring timelib
DATA
sudo emerge -vt app-admin/salt
sudo emerge -vt app-vim/salt-vim
