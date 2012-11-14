#!/bin/bash


#Este Script representa el Main del Manejador de Paquetes
confpath=/etc/mirringo/config

function Mirringo
{

   if  [[ $1 = "--install" || $1 = "-i" ]]  ; then
	echo "installing"
	source $confpath/instalar.sh $2
   fi

   if [[ $1 = "--unistall" || $1 = "-u" ]]; then
	echo "unistalling"
	source $confpath/eliminar.sh $2
   fi

   if [[ $1 = "--build" || $1 = "-b" ]] ; then
        echo "building"
	source $confpath/construir.sh $2
   fi

   if [[ $1 = "--update" || $1 = "-up" ]] ; then
	echo "Update"
	source $confpath/actualizar.sh $2
   fi

   if [[ $1 = "--version" || $1 = "-v" ]] ; then
	echo "version"
	source $confpath/versionar.sh $2
   fi

   if [[ $1 = "--search" || $1 = "-s" ]] ; then
	echo "search"
	source $confpath/buscar.sh $2 $3
   fi 
}

Mirringo $1 $2 $3
