#!/bin/sh

#Here's where all dependencies are listed
depends='atool html2text'

#Defining the path for the files of the program
#and the list of files that are going to be copied.
confpath=/etc/mirringo
confFiles="buscar.sh construir.sh info.sh new.sh receta.sh info.txt"

bdpath=/var/mirringo
bdFiles='mybd.bd'

binpath=/usr/bin
binFile='mirringo.sh'


#This is going to be used as a partial solution
#it only works on debian-based linux distros

if [ $(whoami) != "root" ] ; then
	echo 'sorry, you must be root to run this script'
      exit 1
else
	
	echo 'Installing dependencies...'
	apt-get install depends
	
	#Making the paths for the program installation
	mkdir $confpath
	mkdir $confpath/config 	
	mkdir $binpath
		
	#Copying the configuration files to the corresponding directory
	echo 'Installing program...'
	for instFile in $confFiles
		do
			cp $instFile $confpath/config
		done
	#Copying the database files to the corresponding directory	
	for instFile in $bdFiles
		do
			cp $instFile $bdpath
		done
	
	#Copying the executable file to the corresponding directory
	cp $binFile $binpath
	
fi

echo "done :D"
