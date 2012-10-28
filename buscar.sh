#!/bin/bash
#Primer parametro es la palabra clave a buscar en la BD. Imprime toda la linea

#Imprimir la tabla
#awk -F '","' '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $8 "\t" $9 "\t" $10}' mybd.txt
#imprimir las dependencias
#awk -F '","' '{print $7}' mybd.txt|awk '{print $0}' 
#buscar en la bd
grep -n $1 mybd.txt|awk -F '","' '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $8 "\t" $9 "\t" $10}'
