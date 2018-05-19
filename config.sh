#!/bin/bash

export BUILD_BOX_NAME="funtoo-server"
export BUILD_BOX_VERSION="0.2.5"

export BUILD_PARENT_BOX_NAME="funtoo-core"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="foobarlab/funtoo-core"
export BUILD_PARENT_BOX_VAGRANTCLOUD_VERSION="0.1.13"

export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

export BUILD_BOX_PROVIDER="virtualbox"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

export BUILD_BOX_DESCRIPTION="$BUILD_BOX_NAME build @$(date --iso-8601=seconds)"

export BUILD_UNRESTRICTED_LICENSES="false"	# set to true to allow all licenses (if true then vagrant cloud upload is disabled)

export BUILD_UPDATE_KERNEL=true
export BUILD_UPGRADE_FUNTOO=true	# if true, Funtoo will be upgraded to 1.2 (non-default), includes gcc 7.3.1
export BUILD_SPECTRE_FIX=true		# if true, force re-compile of kernel (will need BUILD_UPGRADE_FUNTOO set to true for gcc 7.3.1)

export BUILD_INCLUDE_ANSIBLE=true
export BUILD_INCLUDE_SALTSTACK=true

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
