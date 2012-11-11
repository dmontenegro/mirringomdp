#!/bin/sh

#Lista de las dependencias del programa
depends='atool html2text'

#Definiendo las direcciones que se crearán
#y los archivos que se copiarán a los directorios
confpath=/etc/mirringo
confFiles="buscar.sh construir.sh info.sh new.sh receta.sh info.txt"

bdpath=/var/mirringo
bdFiles='mybd.bd'

binpath=/usr/bin
binFile='mirringo.sh'

notInstalled=''
#Verificar si se está ejecutando como root.
if [ $(whoami) != "root" ] ; then
	echo 'Debe ser root para ejecutar este archivo'
    exit 1
else
	#Verifica si todas las dependencias estan instaladas
	for package in $depends
	do
		if ! which $package > /dev/null; then
			notInstalled=$notInstalled$package' '
		fi
	done
	
	if [$notInstalled != '']; then
		echo '$notInstalled no estan instalados y son necesarios para el programa'
		exit 1
	
	else
		#Crea los directorios de instalación
		mkdir $confpath
		mkdir $confpath/config 	
		mkdir $binpath
			
		#Copiando los archivos de configuración a su directorio
		echo 'Instalando...'
		
		for instFile in $confFiles
			do
				cp $instFile $confpath/config
			done
			
		#Copiando los archivos de base de datos a su directorio	
		for instFile in $bdFiles
			do
				cp $instFile $bdpath
			done
		
		#Copiando el archivo ejecutable al directorio de ejecutables
		cp $binFile $binpath
	fi
	
fi
