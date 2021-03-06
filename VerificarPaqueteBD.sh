#!/bin/bash

#Retorna 0 cuando el paquete no se encuentra en la BD
#Retorna 1 cuando hay una version mas vieja del paquete en la BD
#Retorna 2 cuando hay una version mas nueva del paquete en la BD
#Retorna 3 cuando el paquete a instlar es exactamente igual a un paquete ya instalado en el sistema 
#$1 representa el nombre del archivo a instalar

NameSinExt=$(echo $1|sed 's/\(.*\)\..*/\1/' | sed 's/\(.*\)\..*/\1/') #para eliminar del nombre la extension del paquete
PKGNAME=$(echo $NameSinExt|tr [:digit:] ' '|tr [="."=] ' '|cut -d " " -f1|sed 's/.$//g') #saca el nombre del paquete
Versiones=$(echo $NameSinExt|tr [:alpha:] ' '|tr [='-'=] ' '|tr [='_'] ' ') # Elimina el nombre del paquete para obtener las versiones

VerRec=$(echo $Versiones|cut -d ' ' -f1)
VerPaq=$(echo $Versiones|cut -d ' ' -f2)

SearchNAME=$(grep $PKGNAME /var/mirringo/mybd.bd |wc -l)

if [ "$SearchNAME" -eq "0" ]
then
	#El paquete no se encuentra instalado en la base de datos
	echo 0
else
	#obtener la cantidad de puntos
	n1=$(echo $VerRec|tr [="."=] ' '|awk '{print NF}'| sort -nu | tail -n 1)
	n2=$(echo $VerPaq|tr [="."=] ' '|awk '{print NF}'| sort -nu | tail -n 1)
	ValorRetornoRec=$(source CompararVersiones.sh $n1 $VerRec 2) #comparacion Versiones de receta
	ValorRetornoVer=$(source CompararVersiones.sh $n2 $VerPaq 3) #comparacion Versiones de Paquete
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


