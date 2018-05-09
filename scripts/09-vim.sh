#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install vim and configure as default editor
sudo emerge -vt app-editors/vim 
sudo eselect editor set vi
sudo eselect vi set vim
# add vim to .bashrc
cat <<'DATA' | sudo tee -a /root/.bashrc
export EDITOR=/usr/bin/vim
DATA
cat <<'DATA' | sudo tee -a ~vagrant/.bashrc
export EDITOR=/usr/bin/vim
DATA
# custom .vimrc
cat <<'DATA' | sudo tee -a /root/.vimrc
" default to no visible whitespace (was enabled in global /etc/vim/vimrc)
setlocal nolist noai

DATA
cat <<'DATA' | sudo tee -a ~vagrant/.vimrc
" default to no visible whitespace (was enabled in global /etc/vim/vimrc)
setlocal nolist noai

DATA
