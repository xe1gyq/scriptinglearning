#!/bin/bash

#Script for getting, unpacking and reading kernel packages
#Disclaimers of usual bla,bla,bla; yaddi, yaddi, yadda.

#Reading command line terms

SOURCE_TYPE=$1
KERNEL_NUMBER=$2
FILE_TYPE="tar.$3"

#Testing line arguments
#Checking if arguments were provided

if [ $# -ne 3 ]
then
  echo "Usage: myscript.sh source kernel_number file_type"
  exit 1
else

#Read and returns 

echo $SOURCE_TYPE $KERNEL_NUMBER $FILE_TYPE
fi

#Test first argument for internet/local

case $1 in
  "internet" ) SOURCE_ARG="i";;
  "local" ) SOURCE_ARG="l";;
esac

#Logic for each get

if [ $SOURCE_ARG="i" ]
then
  SOURCE_ARG="https://www.kernel.org/pub/linux/kernel/v3.x/"
  FILENAME="linux-$KERNEL_NUMBER.$FILE_TYPE"
  GET_FILE=$SOURCE_ARG$FILENAME
  echo $GET_FILE
fi

#Set enviroment

TEMP_DIR="`pwd`/temp_dir"
FINAL_DIR="`pwd`/working_dir"
echo $TEMP_DIR
echo $FINAL_DIR

mkdir -v $TEMP_DIR $FINAL_DIR
touch $FINAL_DIR/stats.pre
touch $FINAL_DIR/stats.post
ls $FINAL_DIR
read -p "Pause..."

#Getting files and uncompressing

wget -P $TEMP_DIR $GET_FILE
tar xvzf $TEMP_DIR/$FILENAME 1>file.lst

#Main program logic
#Starting with sorting and counting

#first attempt - *.pl error
#cat file.lst | awk '{print substr($0,length,1)}' | grep c | wc -l 1>c_files.count
#cat file.lst | awk '{print substr($0,length,1)}' | grep h | wc -l 1>h_files.count
#cat file.lst | awk '{print substr($0,length,2)}' | grep pl | wc -l 1>pl_files.count

#second attempt - *.doc error
#echo ${i##*/} | awk -F. '{print $NF}' | grep c
#echo ${i##*/} | awk -F. '{print $NF}' | grep h
#echo ${i##*/} | awk -F. '{print $NF}' | grep pl

#Full path and character error free

find "linux-$KERNEL_NUMBER" -name *README | wc -l > README_files.count 
find "linux-$KERNEL_NUMBER" -name *Kconfig | wc -l > Kconfig_files.count
find "linux-$KERNEL_NUMBER" -name *Kbuild | wc -l > Kbuild_files.count
find "linux-$KERNEL_NUMBER" -name *Makefile | wc -l > Make_files.count
find "linux-$KERNEL_NUMBER" -name *.c | wc -l > c_files.count
find "linux-$KERNEL_NUMBER" -name *.h | wc -l > h_files.count
find "linux-$KERNEL_NUMBER" -name *.pl | wc -l > pl_files.count

#total files 
find "linux-$KERNEL_NUMBER" -depth -type f | wc -l > total.count
#counting to do differences

#counter=0
#counter=$counter+`cat README_files.count`
#echo $counter
#rm -vR $TEMP_DIR $FINAL_DIR

