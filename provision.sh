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
  05-logging \
  06-cron \
  07-cmdline-tools \
  08-vim \
  09-ansible \
  10-saltstack \
  11-cleanup
do
  echo "**** Running $script ******"
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
