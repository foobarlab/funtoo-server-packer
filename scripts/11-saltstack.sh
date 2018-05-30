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
# FIXME we want openssl with explicit "bindist" flag, which did not work; proposed package.use USE flag below:
## required by dev-python/m2crypto-0.27.0-r1::python-modules-kit[-libressl]
## required by dev-python/soappy-0.12.22::python-modules-kit[ssl]
## required by dev-python/twisted-17.9.0::python-modules-kit[soap,python_targets_python2_7]
## required by www-servers/tornado-4.5.1::net-kit
## required by app-admin/salt-2018.3.0::nokit
## required by app-admin/salt (argument)
#>=dev-libs/openssl-1.0.2o-r2 -bindist
DATA
sudo emerge -vt app-admin/salt app-vim/salt-vim
