#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# cron service
sudo emerge -vt sys-process/cronie
sudo rc-update add cronie default
