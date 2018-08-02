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

# mail transport agent
sudo emerge -vt mail-mta/postfix
