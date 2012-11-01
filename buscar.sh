#!/bin/bash

#Primer parametro es la palabra clave a buscar en la BD. Imprime toda la linea
#Segundo parametro es el repositorio remoto
#DEPENDENCIAS -> html2text
#Imprimir la tabla
#awk -F '","' '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $8 "\t" $9 "\t" $10}' mybd.txt
#imprimir las dependencias
#awk -F '","' '{print $7}' mybd.txt|awk '{print $0}' 


#command test
#para repositorios externos
#./buscar.sh zynadd mirror.pointysoftware.net/archlinux/community/os/x86_64

#para repositorios locales, simplemente no se pone el segundo parametro


#buscar en un repositorio externo
if [ -z "$2" ]
then
#echo 'en la base de datos local se ha encontrado'
grep -n $1 mybd.txt|awk -F '","' '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $8 "\t" $9 "\t" $10}'
exit 0
else
#buscar en la bd local
echo 'En el repositorio indicado se ha encontrado'
wget -qO- $2|html2text|grep $1
exit
fi
