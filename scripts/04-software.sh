#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install salt for automation
sudo emerge -vt app-admin/salt

# add support for salt in vim:
sudo emerge -vt app-vim/salt-vim

# DEBUG: show eselect options
sudo eselect
