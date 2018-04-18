#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# logging facility
sudo emerge -vt app-admin/rsyslog
sudo rc-update add rsyslog default

# cron service
sudo emerge -vt sys-process/cronie
sudo rc-update add cronie default

# some commandline helpers/utils
sudo emerge -vt app-shells/bash-completion sys-fs/ncdu sys-process/htop app-misc/screen

# some network related utils:	
sudo emerge -vt net-analyzer/iptraf-ng www-client/links net-ftp/ncftp

# install midnight commander + custom setting:
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
sudo emerge -vt app-portage/ufed app-portage/eix

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

# install and configure ansible for automation
sudo emerge -vt app-admin/ansible
sudo mkdir -p /etc/ansible
cat <<'DATA' | sudo tee -a /etc/ansible/ansible.cfg
# fully disable SSH host key checking, see: https://www.vagrantup.com/docs/provisioning/ansible_local.html
[defaults]
host_key_checking = no
[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes
DATA
