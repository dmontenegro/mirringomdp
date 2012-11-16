#!/bin/bash

#$1 representa la cantidad de cifras de la version
#$2 representa la version que se va a comparar
#$3 representa la columna o version que se quiere comparar

Var=$(grep $PKGNAME mybd.bd|cut -d "," -f$3)

if [ "$2" = "$Var" ]
then
	echo 3

else

	for i in $(seq 1 $1)
	do
		#Num Corresponde a la version del paquete que se desea instalar
		Num=$(echo $2|tr [="."=] ' '|cut -d " " -f$i)
		
		#Num2 Corresponde a la version del paquete instalado
		Num2=$(grep $PKGNAME mybd.bd|cut -d "," -f$3 |tr [="."=] ' ' | cut -d " " -f$i)
		
		if [ $Num -gt $Num2  ]
		then
			echo 2
			break
		elif [ $Num -lt $Num2  ]
		then
			echo 1
			break
		fi
	done
fi


