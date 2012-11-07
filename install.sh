#!/bin/sh
depends='atool html2text'

confpath=/etc/mirringo/config
confFiles='buscar.sh construir.sh info.sh new.sh receta.sh test.sh'

bdpath=/var/mirringo/
bdFiles='

binpath=/usr/bin/


#This is going to be used as a partial solution
#it only works on debian-based linux distros

if [ $(whoami) != "root" ] ; then
	echo 'sorry, you must be root to run this script' > &2
      exit 1
else
	echo 'Installing dependencies...'
	apt-get install depends
	echo 'Installing program...'
	for instFile in $confFiles
		do
			cp $instFile $confpath
fi
