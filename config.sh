#!/bin/bash

export BUILD_BOX_NAME="funtoo-server"
export BUILD_BOX_VERSION="0.0.7"	# FIXME: put this into separate file to read from (see stage 3 build)

export BUILD_PARENT_BOX_NAME="funtoo-core"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="foobarlab/funtoo-core"
export BUILD_PARENT_BOX_VAGRANTCLOUD_VERSION="0.1.1"

export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

export BUILD_BOX_PROVIDER="virtualbox"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

export BUILD_BOX_DESCRIPTION="$BUILD_BOX_NAME build @$(date --iso-8601=seconds)"

export BUILD_UNRESTRICTED_LICENSES="false"	# set to true to allow all licenses (if true then vagrant cloud upload is disabled)

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
