#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install ansible for automation
sudo emerge -vt app-admin/ansible

# configure ansible
sudo mkdir -p /etc/ansible
cat <<'DATA' | sudo tee -a /etc/ansible/ansible.cfg
# fully disable SSH host key checking, see: https://www.vagrantup.com/docs/provisioning/ansible_local.html
[defaults]
host_key_checking = no

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes

DATA
