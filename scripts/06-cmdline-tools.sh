#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# some commandline helpers/utils
sudo emerge -vt app-shells/bash-completion sys-fs/ncdu sys-process/htop app-misc/screen sys-apps/mlocate

# some network related utils
sudo emerge -vt net-analyzer/iptraf-ng www-client/links net-ftp/ncftp mail-client/mutt

# install midnight commander + custom setting
sudo emerge -vt app-misc/mc
cat <<'DATA' | sudo tee -a /root/.bashrc
# restart mc with last used folder
. /usr/libexec/mc/mc.sh

DATA
cat <<'DATA' | sudo tee -a ~vagrant/.bashrc
# restart mc with last used folder
. /usr/libexec/mc/mc.sh

DATA

# gentoo/funtoo related helper tools
sudo emerge -vt app-portage/ufed app-portage/eix app-portage/flaggie
