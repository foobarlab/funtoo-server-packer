#!/bin/bash -e

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${SCRIPTS:-} ]; then
  SCRIPTS=.
fi

chmod +x $SCRIPTS/scripts/*.sh

for script in \
  01-prepare \
  02-kernel \
  03-system-update \
  04-funtoo-upgrade \
  05-spectre-fix \
  06-logging \
  07-cron \
  08-cmdline-tools \
  09-vim \
  10-ansible \
  11-saltstack \
  12-cleanup
do
  echo "**** Running $script ******"
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
