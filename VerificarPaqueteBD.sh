#!/bin/bash

#Retorna 0 cuando el paquete no se encuentra en la BD
#Retorna 1 cuando hay una version mas vieja del paquete en la BD
#Retorna 2 cuando hay una version mas nueva del paquete en la BD
#Retorna 3 cuando el paquete a instlar es exactamente igual a un paquete ya instalado en el sistema 
#$1 representa el nombre del paquete a instalar
#$2 representa la version de la receta
#$3 representa la version del paquete


SearchNAME=$(grep $1 mybd.bd|wc -l)
PKGNAME=$1
if [ $SearchNAME -eq 0 ]
then
	echo 0
else
	#obtener la cantidad de puntos
	n1=$(echo $2|tr [="."=] ' '|awk '{print NF}'| sort -nu | tail -n 1)
	n2=$(echo $3|tr [="."=] ' '|awk '{print NF}'| sort -nu | tail -n 1)
	ValorRetornoRec=$(source CompararVersiones.sh $n1 $2 2) #comparacion Versiones de receta
	ValorRetornoVer=$(source CompararVersiones.sh $n2 $3 3) #comparacion Versiones de Paquete
	if [ $ValorRetornoRec -lt $ValorRetornoVer ]
	then
		echo $ValorRetornoRec
	elif [ $ValorRetornoVer -lt $ValorRetornoRec ]
	then
		echo $ValorRetornoVer
	elif [ $ValorRetornoVer -eq $ValorRetornoRec ]
	then
		echo $ValorRetornoVer
	fi
	
fi


