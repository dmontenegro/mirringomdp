#!/bin/bash


#Este Script representa el Main del Manejador de Paquetes


function Mirringo()
{
   if [ $1 == "--install" || $1 == "-i" ] then
	
	source instalar.sh $2
   fi

   if [ $1 == "--unistall" || $1 == "-u" ] then
	
	source eliminar.sh $2
   fi

   if [ $1 == "--build" || $1 == "-b" ] then
        
	source construir.sh $2
   fi

   if [ $1 == "--update" || $1 == "-up"] then

	source actualizar.sh $2
   fi

   if [ $1 == "--version" || $1 == "-v"] then
	
	source versionar.sh $2
   fi

   if [ $1 == "--search" || $1 == "-s" ] then

	source buscar.sh
   fi 
}
