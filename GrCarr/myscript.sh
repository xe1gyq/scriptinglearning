#!/bin/bash
#set -x
## ================================================================
## Type: Shell_Proyect
## File: myscript
## ================================================================
## Description: A script that processes a kernel decompressing it,
## gathering some statistics and modifiyng some includes             
##              
## ================================================================
## Author:      Gustavo Carreón
## ================================================================


##HelpOption
if [[ $1 =~ ^\-Help$ ]];then
	printf "Kernel analizer. Intput arguments are file's location, Kernel version and file type \n $ myscript.sh <internet/local> <x.x.xx> <xz|gz> \n";
	exit 0;
##validate arguments 
elif [[ ! "$3" ]];then
    printf "$0 -E-:Not enough input parameters \n Three parameters needed $ myscript.sh <internet/local> <x.x.xx> <xz|gz> \n";
exit 1;
fi

directory="$2.tar.$3";

if [[ $1 = "internet" ]];then
#mkdir Temp;
cd Temp;
#wget "https://www.kernel.org/pub/linux/kernel/v3.x/$directory";
directory="Temp/$directory";
cd ..;
fi
if [[ -e $directory ]];then
	if [[ $3 =~ 'gz' ]];then
		tar -xvzf $directory >> list;
	else	tar -Jxvf $directory >> list; fi
else
	printf "File not found in local Directory \n";
	exit 1;
fi

touch stats.pre;
touch stats.post;

echo "FILE NAMES \n" >> stats.pre;
echo "# of READMEs" >> stats.pre | grep "^.*README.*$" list | wc -l >> stats.pre | sed -i 's/^.*README.*$/ /' list;
echo "# of Kconfigs" >> stats.pre | grep "^.*Kconfig.*$" list | wc -l >> stats.pre | sed -i 's/^.*Kconfig.*$/ /' list;
echo "# of Kbuilds" >> stats.pre | grep "^.*Kbuild.*$" list | wc -l >> stats.pre | sed -i 's/^.*Kbuild.*$/ /' list;
echo "# of Makefiles" >> stats.pre | grep "^.*Makefile.*$" list | wc -l >> stats.pre | sed -i 's/^.*Makefile.*$/ /' list;
echo "# of c files" >> stats.pre | grep "^.*\.c$" list | wc -l >> stats.pre | sed -i 's/^.*\.c$/ /' list;
echo "# of h files" >> stats.pre | grep "^.*\.h$" list | wc -l >> stats.pre | sed -i 's/^.*\.h$/ /' list;
echo "# of pl files" >> stats.pre | grep "^.*\.pl$" list | wc -l >> stats.pre | sed -i 's/^.*\.pl$/ /' list;
echo "# of other files" >> stats.pre | wc -w list >> stats.pre;
echo "Total # of files" >> stats.pre | wc -l list >> stats.pre;
cd $2;
echo "FILE CONTENTS \n" >> ../stats.pre;
echo "# of ocurrences for linus" >> ../stats.pre | grep "Linus"  /bin/* | wc -l >> ../stats.pre;
echo "# of architechtures/directories found under arch/ " | ls -l arch/ > ../list | grep "d[r\-][w\r][x\-]" ../list | wc -l >> stats.pre
echo "# of ocurrences for kernel_start " >> ../stats.pre | grep -i "kernel_start" */*/*/* | wc -l >> ../stats.pre;
echo "# of ocurrences for __init " >> ../stats.pre | grep -i "__init" */*/*/* | wc -l >> ../stats.pre;
echo "# of ocurrences for #include <linux/module.h> " >> ../stats.pre | grep -i "#include <linux/module.h>" */*/*/* | wc -l >> ../stats.pre;

