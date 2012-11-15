#!/bin/bash

#Dependencias: Bash version >= 3

filpath=/var/mirringo	#dirección donde se encuentran los archivos que dicen que borrar
bdpath=/var/mirringo	#dirección donde se encuentran la db
confpath=/etc

if [ $UID -ne 0 ] ; then
	echo 'Debe tener permisos de root para ejecutar este archivo'
    exit 1
else
	l=`grep $1 $bdpath/mybd.bd -c`	#número de líneas donde encontro el parámetro
	if [ $l -eq 0 ] ; then
		echo 'No se ha instalado con Mirringo'
	    exit 1
	fi
	
	oldifs=$IFS
	IFS=$'\n'
	
	if [ $l -eq 1 ] ; then		
		rline=`grep $1 $bdpath/mybd.bd -n | awk -F ':' '{print $1}'`	#saca el número de la línea en la db
		
		fil=`sed -n ${rline}p $bdpath/mybd.bd | awk -F '","' '{print $1"-"$2".txt"}'`	#saca el nombre del archivo que debe tener los archivos a borrar
	fi
	
	if [ $l -ne 1 ] ; then
		echo 'Múltiples entradas en la base de datos, por favor escoja'
		
		#Mostrar las opciones
		i=1
		for pckg in `grep $1 $bdpath/mybd.bd | awk -F '","' '{print $1" V"$2" VB"$3}'`; do
			echo "$i) $pckg"
			let i++
		done
		echo -n "Escoja (1-$l):"
		read line
		
		#comprobaciones
		if ! [[ "$line" =~ ^[0-9]+$ ]] ; then
			echo "No es un entero"
			IFS=$oldifs
			exit 1
		fi
		if [ $line -ge $l -o $line -le 0 ] ; then
			echo "Fuera de rango"
			IFS=$oldifs
			exit 1
		fi
		
		rline=`grep $1 $bdpath/mybd.bd -n | sed -n ${line}p | awk -F ':' '{print $1}'`	#saca el número de la línea en la db
		
		fil=`sed -n ${rline}p $bdpath/mybd.bd | awk -F '","' '{print $1"-"$2".txt"}'`	#saca el nombre del archivo que debe tener los archivos a borrar

	fi
	
	#guardar configuración
	nom=`sed -n ${rline}p $bdpath/mybd.bd | awk -F '","' '{print $1" V"$2" VB"$3}'`
	
	read -p "¿Desea guardar la configuración?" sn
	case $sn in
	    [Ss] | [Ss][Ii] )
	    	echo "Se guardará la configuración anterior"
	    	oldpwd=`pwd`
	    	cd "$confpath"
	    	git add .
	    	git commit -a -m "Antes de eliminar $nom."
	    	cd "$oldpwd";;
	    [Nn] | [Nn][Oo])
	    	echo "No se guardará la configuración anterior";;
	    * ) 
	    	echo "Opción inválida"
	    	IFS=$oldifs
	    	exit 1;;
	esac
	
	#borrar
	echo 'Eliminando...'
	
	sed -i ${rline}p $bdpath/mybd.bd	#borra la entrada de la db
	
	while read aborrar	#borra los archivos
	do
		rm $aborrar;
	done < $filpath/$fil
	
	rm $filpath/$fil	#borra el archivo que tiene los archivos a borrar
	
	IFS=$oldifs
	
	exit 0
	
fi
