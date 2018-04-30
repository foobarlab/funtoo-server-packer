#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_UPGRADE_FUNTOO:-} ]; then
	echo "BUILD_UPGRADE_FUNTOO was not set. Skipping ..."
	exit 0
else
	if [ "$BUILD_UPGRADE_FUNTOO" = false ]; then
		echo "BUILD_UPGRADE_FUNTOO set to FALSE. Skipping ..."
		exit 0
	fi	
fi

cat <<'DATA' | sudo tee -a /etc/ego.conf

# upgrade funtoo to 1.2 branch, see: https://forums.funtoo.org/topic/1608-12-funtoo-linux-release/
core-kit = 1.2-prime
security-kit = 1.2-prime
kde-kit = 5.12-prime
media-kit = 1.2-prime
java-kit = 1.2-prime
ruby-kit = 1.2-prime
haskell-kit = 1.2-prime
lisp-scheme-kit = 1.2-prime
lang-kit = 1.2-prime
dev-kit = 1.2-prime
desktop-kit = 1.2-prime

DATA

sudo cat /etc/ego.conf

# FIXME if we already have gcc-6.4.0 installed (see funtoo-core box) we probably do not need to recompile (simple world update should be sufficient)

sudo ego sync
sudo emerge -u1 gcc
sudo emerge -u1 glibc libnsl libtirpc rpcsvc-proto
sudo emerge -uvtDN @system
sudo emerge -uvtDN @world
sudo emerge @preserved-rebuild
sudo revdep-rebuild --library 'libstdc++.so.6' -- --exclude sys-devel/gcc

sudo etc-update --preen
sudo env-update
source /etc/profile
