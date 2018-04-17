#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install ansible for automation
sudo emerge -vt app-admin/ansible

# install salt for automation
sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
app-admin/salt portage vim-syntax gnupg keyring timelib
DATA
sudo emerge -vt app-admin/salt
sudo emerge -vt app-vim/salt-vim
