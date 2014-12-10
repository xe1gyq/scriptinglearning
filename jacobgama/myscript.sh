#! /bin/bash
set -x


##################### KERNEL PROCESSOR ####################
#                                                         #
#           Author: Jacob Gamaliel de la Cruz Becerra     #
#                                                         #
###########################################################

#****************** Variables Declaration *****************
version=$2;
FileType=$3;
url="http://www.kernel.org/pub/linux/kernel/v3.x/"
kernel="linux-${version}";
filetountar="linux-$version.tar.gz";

#***************** Creating Directories *******************
if [[ ! -d temp_$kernel ]]; then 
mkdir temp_$kernel;
fi
if [[ ! -d Oficial_$kernel ]]; then 
mkdir Oficial_$kernel;
fi


#****************** Location analisis *********************
echo "Welcome to Kernel procesor";
if [[ $1 = "local" ]]; then
	printf "\nLocal Option Selected\n";
        filetocopy=`find $filetountar*`;
        cp $filetocopy temp_$kernel;
elif [[ $1 = "internet" ]]; then 
	printf "\nInternet Option Selected\n";
        fullname="${url}linux-${version}.tar.${FileType}";
        echo $fullname;
        #wget $fullname;

else 
	printf "\nNo valid option for this argument\n";
fi

#****************** Files Uncompression ******************
echo "Uncompresing files"


if [[ $FileType = "gz" ]]; then

tar -xvf temp_$kernel/$filetountar* -C Oficial_$kernel >> Oficial_$kernel/files_$filetountar.txt;

elif [[ $FileType = "xz" ]]; then 
tar -xvf temp_$kernel/linux-3.0.93.tar.gz.1 -C Oficial_$kernel;
fi


#****************** Processing ***************************

echo "Starting to process Kernel: $filetountar";
touch Oficial_$kernel/stats.pre
touch Oficial_$kernel/stats.post

true > Oficial_$kernel/stats.pre;

true > Oficial_$kernel/stats.post;

printf "File Names\n" >> Oficial_$kernel/stats.pre;
acc=0;
count=$((FIRSTV-SECONDV))
tem_var=`grep -c '.*README.*' Oficial_$kernel/files_$filetountar.txt`; printf "Number of READMEs = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*Kconfig.*' Oficial_$kernel/files_$filetountar.txt`; printf "Number of Kconfig = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*Kbuild.*' Oficial_$kernel/files_$filetountar.txt`; printf "Number of Kbuild = $tem_var\n" >> Ofiawcial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*Makefile.*' Oficial_$kernel/files_$filetountar.txt`; printf "Number of Makefiles = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*\.c$' Oficial_$kernel/files_$filetountar.txt`; printf "Number of .c files = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*\.h$' Oficial_$kernel/files_$filetountar.txt`; printf "Number of .h files = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`grep -c '.*\.pl$' Oficial_$kernel/files_$filetountar.txt`; printf "Number of .pl files = $tem_var\n" >> Oficial_$kernel/stats.pre;acc=$((acc+tem_var));
tem_var=`cat Oficial_$kernel/files_$filetountar.txt | wc -l`;acc=$((tem_var-acc));printf "Number of other files = $acc\n" >> Oficial_$kernel/stats.pre; 
printf "Total Number of files = $tem_var\n" >> Oficial_$kernel/stats.pre;


cat Oficial_$kernel/stats.pre;
#*************** Deleting temp_$kernelorary directory ****************
rm -R temp_$kernel;









