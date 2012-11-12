#!/bin/bash

#Lista de las dependencias del programa
depends="atool html2text git"

#Definiendo las direcciones que se crearán
#y los archivos que se copiarán a los directorios
confpath=/etc/mirringo
confFiles='buscar.sh construir.sh info.sh new.sh receta.sh info.txt eliminar.sh instalar.sh actualizar.sh versionar.sh'

bdpath=/var/mirringo
bdFiles='mybd.bd'

binpath=/bin
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
		
		chown -R root:root $confpath
		chmod 755 -R $confpath
			
		#Copiando los archivos de base de datos a su directorio
		for file in $bdFiles
		do	
			cp $file $bdpath
		done
		
		chown -R root:root $bdpath
		chmod 755 -R $bdpath
		
		#Copiando el archivo ejecutable al directorio de ejecutables
		cp $binFile $binpath
		
		chown root:root $binpath/$binFile
		chmod 755 $binpath/$binFile
		
		echo 'Mirringo ha sido instalado'
	
		exit 0
	fi
	
fi
