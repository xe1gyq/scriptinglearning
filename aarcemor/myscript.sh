#!/bin/sh

set -x

LOCATION=$1
VERSION=$2
FILETYPE=$3

# Variables kernel.org

WGET=wget
KERNELORG_PATH="https://www.kernel.org/pub/linux/kernel/v3.x/"
KERNELORG_FILE="linux-"
KERNELORG_VERSION=$VERSION
KERNELORG_FILETYPE=".tar."$FILETYPE

# Variables directory structure
DIRECTORY_ROOT=`pwd`
DIRECTORY_KERNELORG=$DIRECTORY_ROOT/kernelorg
DIRECTORY_OFFICIAL=$DIRECTORY_ROOT/official
DIRECTORY_TEMPORAL=$DIRECTORY_ROOT/temporal

download() {
  cd $DIRECTORY_KERNELORG
  echo "$KERNELORG_PATH$KERNELORG_FILE$KERNELORG_VERSION$KERNELORG_FILETYPE"
  wget $KERNELORG_PATH$KERNELORG_FILE$KERNELORG_VERSION$KERNELORG_FILETYPE
  cd $DIRECTORY_ROOT
}

directory_create() {
  test -d $DIRECTORY_KERNELORG || mkdir $DIRECTORY_KERNELORG
  test -d $DIRECTORY_OFFICIAL || mkdir $DIRECTORY_OFFICIAL
  test -d $DIRECTORY_TEMPORAL || mkdir $DIRECTORY_TEMPORAL
}

directory_cleanup() {
 echo
}

download
directory_create
directory_cleanup

# End of file
