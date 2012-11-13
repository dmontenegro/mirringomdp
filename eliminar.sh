#!/bin/bash

filpath=/var/mirringo	#dirección donde se encuentran los archivos que dicen que borrar
bdpath=/var/mirringo	#dirección donde se encuentran la db

if [ $UID -ne 0 ] ; then
	echo 'Debe tener permisos de root para ejecutar este archivo'
    exit 1
else
	l=`grep $1 $bdpath/mybd.bd -c`	#número de líneas donde encontro el parámetro
	if [ $l -eq 0 ] ; then
		echo 'No se ha instalado con Mirringo'
	    exit 1
	fi
	if [ $l -eq 1 ] ; then
		oldifs=$IFS
		IFS=$'\n'
		
		rline=`grep $1 $bdpath/mybd.bd -n | awk -F ':' '{print $1}'`	#saca el número de la línea en la db
		
		fil=`sed -n ${rline}p $bdpath/mybd.bd | awk -F '","' '{print $1"-"$2".txt"}'`	#saca el nombre del archivo que debe tener los archivos a borrar
		
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
	if [ $l -ne 1 ] ; then
		echo 'Múltiples entradas en la base de datos, por favor escoja'
		oldifs=$IFS
		IFS=$'\n'
		
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
			exit 1
		fi
		if [ $line -ge 18 -o $line -le 0 ] ; then
			echo "Fuera de rango"
			exit 1
		fi
		
		#borrar
		rline=`grep $1 $bdpath/mybd.bd -n | sed -n ${line}p | awk -F ':' '{print $1}'`	#saca el número de la línea en la db
		
		fil=`sed -n ${rline}p $bdpath/mybd.bd | awk -F '","' '{print $1"-"$2".txt"}'`	#saca el nombre del archivo que debe tener los archivos a borrar
		
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
	
fi
