#!/bin/bash

echo "My script is running"

echo "0:" $0 # file
echo "1:" $1 # location
echo "2:" $2 # version
echo "3:" $3 # File type
#echo Path:
#directory=pwd 
#echo $directory

KernelName="linux-$2.tar.$3"
echo "the name of the kernel is:" 
echo $KernelName
#creando directorios
mkdir -p TemporalDirectory
mkdir -p OfficialWorkingDirectory

#Obteniendo kernel
if [ $1 = "local" ];
then
	echo "procedemos con el local"
	pwd
	cp $KernelName TemporalDirectory
elif [ $1 = "internet" ];
then
	echo "procedemos con la descarga de internet"
	wget https://www.kernel.org/pub/linux/kernel/v3.x/$kernelName -P TemporalDirectory
else
	echo "procedemos a lanzar la ayuda"
fi
#Descomprimiedo archivo
	tar -xzf TemporalDirectory/$KernelName -C OfficialWorkingDirectory

#Contando archivos
nCfiles=`find OfficialWorkingDirectory -type f -name \*.c | wc -l`
nHfiles=`find OfficialWorkingDirectory -type f -name \*.h | wc -l`
nPlfiles=`find OfficialWorkingDirectory -type f -name \*.pl | wc -l`
nKcfiles=`find OfficialWorkingDirectory -type f -name Kconfig | wc -l`
nKbfiles=`find OfficialWorkingDirectory -type f -name Kbuild | wc -l`
nMkfiles=`find OfficialWorkingDirectory -type f -name Makefile | wc -l`
nRefiles=`find OfficialWorkingDirectory -type f -name README.txt | wc -l`
nOtfiles=`find OfficialWorkingDirectory -type f ! -name \*.c -a ! -name \*.h -a ! -name \*.pl -a ! -name Kconfig -a ! -name Kbuild -a ! -name Makefiles -a ! -name README.txt | wc -l`
nAlfiles=`find OfficialWorkingDirectory -type f | wc -l`

echo $nCfiles of .c files > stats.pre
echo $nHfiles of .h files >> stats.pre
echo $nPlfiles of .pl files >> stats.pre
echo $nKcfiles of Kconfig files >> stats.pre
echo $nKbfiles of Kbuild files >> stats.pre
echo $nMkfiles of Makefile files >> stats.pre
echo $nRefiles of READMEs files >> stats.pre
echo $nOtfiles of other files >> stats.pre
echo $nAlfiles of files >> stats.pre


#Contando Ocurrencias de Linux
LinuxOc=`grep -roh Linux OfficialWorkingDirectory | wc -w`
nArchs=`find OfficialWorkingDirectory/"linux-$2"/arch -maxdepth 1 -type d | wc -l`
kernelOc=`grep -roh kernel_start OfficialWorkingDirectory | wc -w`
initOc=`grep -roh __init OfficialWorkingDirectory | wc -w`
gpioOc=`find OfficialWorkingDirectory -type f -name *gpio* | wc -l`
pattern="#include\s<linux/(\w*)\.h>"
modulesOc=`grep -crEoh $pattern OfficialWorkingDirectory | paste -s -d+ | bc`
grep -rEo $pattern OfficialWorkingDirectory/linux-"$2"/drivers/i2c | sed -r 's/(.*)\/(.*)\.(.*)/\2/g' | sort -d > .modules.txt

#modulesOc=`cat .modules.txt | wc -l`
#modulesOc=`grep -crEoh $pattern OfficialWorkingDirectory/linux-"$2"/drivers/i2c | paste -s -d+ | bc`
#echo "$string" | grep -Eo $pattern | sed -r 's/(.*)\/(.*)\.(.*)/\2/g'

echo $LinuxOc of ocurrences for Linux >> stats.pre
echo $nArchs of Architectures >> stats.pre
echo $kernelOc of ocurrences for kernel >> stats.pre
echo $initOc of ocurrences for init >> stats.pre
echo $gpioOc of files with gpio in its filename >> stats.pre
echo $modulesOc of ocurrences for \#include \<linux\/module\.h\> >> stats.pre

grep -rE $patternMail OfficialWorkingDirectory | sed -r 's/(.*):\s*\*\s*([^<]*)<(.*)@(.*)/\1 | \2 | \3/g' > intel.contributors

mkdir -p OfficialWorkingDirectory/cFiles
mkdir -p OfficialWorkingDirectory/hFiles
mkdir -p OfficialWorkingDirectory/othersFiles

find -type f -name "*.c" -exec mv --backup=numbered {} OfficialWorkingDirectory/cFiles \;
find -type f -name "*.h" -exec mv {} OfficialWorkingDirectory/hFiles \;
find -type f ! -name "*.h" -a ! -name "*.c" -exec mv {} OfficialWorkingDirectory/othersFiles \;

