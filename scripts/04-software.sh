#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install salt for automation
sudo emerge -vt app-admin/salt
sudo emerge -vt app-vim/salt-vim

# FIXME configure saltstack

# DEBUG: show eselect options
sudo eselect
