#!/bin/bash


#Este Script representa el Main del Manejador de Paquetes


function Mirringo
{

   if  [[ $1 = "--install" || $1 = "-i" ]]  ; then
	echo "installing"
	source instalar.sh $2
   fi

   if [[ $1 = "--unistall" || $1 = "-u" ]]; then
	echo "unistalling"
	source eliminar.sh $2
   fi

   if [[ $1 = "--build" || $1 = "-b" ]] ; then
        echo "building"
	source construir.sh $2
   fi

   if [[ $1 = "--update" || $1 = "-up" ]] ; then
	echo "Update"
	source actualizar.sh $2
   fi

   if [[ $1 = "--version" || $1 = "-v" ]] ; then
	echo "version"
	source versionar.sh $2
   fi

   if [[ $1 = "--search" || $1 = "-s" ]] ; then
	echo "search"
	source buscar.sh
   fi 
}
Mirringo $1 $2
