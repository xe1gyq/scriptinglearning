#!/bin/bash

set -x 

##Script arguments
location=$1
version=$2
type=$3

#var="internet"


echo "Work directory: \n$PWD"

setenv WORK_DIR $PWD/
mkdir original_directoy
mkdir temporal_directory
mkdir official_directory

#echo $location
if [$1 = "internet"]; 
then
	echo "internet location detected"
	cd original_directory
	wget "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version$type"
	cd $WORK_DIR
else 
	echo "internet location NOT detected"
	cp $WORK_DIR/linux-3* $WORK_DIR/original_directory
	cd $WORK_DIR
fi

cp -r $WORK_DIR/original_directory/linux-3* $WORK_DIR/temporal_directory
cd $WORK_DIR/temporal_directory/
tar -xf linux-3*
 ## At this point we have uncompressed linux files (copied or downloaded) in our temporal_dir

cd $WORK_DIR/
touch stats.pre
echo "*************************** stats.pre file ***************************" >> stats.pre
touch stats.post
echo "*************************** stats.pre file ***************************" >> stats.pre

## Pre-Process
cd $WORK_DIR/temporal_directory
echo "Number of README's:" >> $WORK_DIR/stats.pre && ls -R | grep -c "README" 
echo "Number of Kconfig:" >> $WORK_DIR/stats.pre && ls -R | grep -c "Kconfig"
echo "Number of Kbuild:" >> $WORK_DIR/stats.pre && ls -R | grep -c "Kbuild"
echo "Number of Makefiles:" >> $WORK_DIR/stats.pre && ls -R | grep -c "Makefile"
echo "Number of .c:" >> $WORK_DIR/stats.pre && ls -R | grep -c ".c"
echo "Number of .h:" >> $WORK_DIR/stats.pre && ls -R | grep -c ".h"
echo "Number of .pl:" >> $WORK_DIR/stats.pre && ls -R | grep -c ".pl"
echo "Total Number of files:" >> $WORK_DIR/stats.pre && ls -R | grep -c ""








