
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
	results=$(grep $1 /var/mirringo/mybd.bd|awk -F '","' '{print "Nombre del programa: \n " $1 "\n \nVersion:\n" $2 "\n \n Version del Builder:\n" $3 "\n \n Descripcion:\n" $4 "\n \n pagina web: \n" $5 "\n \nLicencia: \n" $6 "\n \n Link de descarga directa:\n" $8 "\n \n Suma criptografica:\n" $9}')
	
		if [ -n "$results" ]; then
   	 	#echo "VAR is empty"
		echo $results
		echo -e "\n Dependencias"
		grep $1 /var/mirringo/mybd.bd|awk -F '","' '{print $7 "\n"}'|awk '{print $0 "\n"}' 
		exit 0
		else
			echo "No hay resultados"
			exit 0
		fi
else
	#buscar en la bd local
	echo 'En el repositorio indicado se ha encontrado'
	wget -qO- $2|html2text|grep $1
	exit 0
fi

