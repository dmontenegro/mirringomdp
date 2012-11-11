#!/bin/sh

#Lista de las dependencias del programa
depends="atool html2text git"

#Definiendo las direcciones que se crearán
#y los archivos que se copiarán a los directorios
confpath=/etc/mirringo
confFiles='buscar.sh construir.sh info.sh new.sh receta.sh info.txt'

bdpath=/var/mirringo
bdFiles='mybd.bd'

binpath=/usr/bin
binFile='mirringo.sh'

notInstalled=""

#Verificar si se está ejecutando como root.
if [ $(whoami) != "root" ] ; then
	echo 'Debe ser root para ejecutar este archivo'
    exit 1
else

	#Verifica si todas las dependencias estan instaladas
	for pckg in $depends
	do
		if ! which $pckg > /dev/null; then
			notInstalled=$notInstalled"$pckg "
		fi
	done

	if 	[ "$notInstalled" != "" ]; then
		echo $notInstalled'no estan instalados y son necesarios para el programa'
		exit 1
	
	else
	
		#Crea los directorios de instalación
		mkdir $confpath
		mkdir $confpath/config 	
		mkdir $bdpath
		
		echo 'Instalando...'
		
		#Copiando los archivos de configuración a su directorio
		for file in $confFiles
		do
			cp $file $confpath/config
		done
			
		#Copiando los archivos de base de datos a su directorio
		for file in $bdFiles
		do	
			cp $file $bdpath
		done
		
		#Copiando el archivo ejecutable al directorio de ejecutables
		cp $binFile $binpath
	fi
	
	echo 'Mirringo ha sido instalado'
	
fi
