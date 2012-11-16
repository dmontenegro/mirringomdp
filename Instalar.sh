#!/bin/bash
#!/usr/bin/





tem="/var/mirringo/"

##Funcion q mira si los archivos a capiar ya estan en el sistema
Verificar()
{
	while read linea
	do
		### Condicion q verifica si el archivo existe
	   if [ -e /$linea ]
	   then
		echo 1
		return
	   fi
	done < $1
	echo 0
	
}

### Para permisos de administrador
Instalar(){
	if [ $USER != "root" ]
	then
		echo
		echo "Necesitas Permiso de Administrador para ejecutar esta funcion"
		echo
		exit 1

	else
		#echo "ARchivo:   " $2"/"$
		archivo=$1
		ext=${archivo#*.}
		Col=$(echo $archivo |tr [="-"=] ' '|cut -d " " -f3 | tr [="."=] ' '|awk '{print NF}'| sort -nu | tail -n 1)
		ext=$(echo $archivo |tr [="-"=] ' '|cut -d " " -f3 | tr [="."=] ' '|cut -d " " -f3,4|tr [:blank:] '.')
		if [ -f "$2"/"$1" ]
		then
		
			if [ "$ext" != "tar.gz" ]
			then
				echo "Extension Incorrecta, debe ser tar.gz"
				exit 1
			else
				##echo "Extension Correcta, Buscariamos si el archivo no este instalado\n\n"
				#Buscar MyDB.db ALgo.sh
				## Seria:  et=Funcion
				#et=0 ## $(funcion Juan Pablo)Iria funcion de juan pablo ${archivo%%.*}
				
				
				### echo "geany_2.0_2" | sed 's/-/ /g'
				et=$(source VerificarPaqueteBD.sh $(echoBD.sh $(echo $archivo | sed -e 's/-/ /g' -e 's/.tar.gz/ /g' ))
				
				
				### Condicional que mira si esta instalado
				
				case $et in
					
					0 )
						
						
						
						cd $tem
						et=$tem$(echo $archivo | sed -e 's/.tar.gz/.txt/g')
						
						## lo copio en la carpeta desintalacion
						tar tzf "$2"/"$1" | sed '/\/$/d' > $et
						
						
						
						
						if [ $(Verificar $et) = 1 ]
						then
							echo "Conflictos en archivos del paquete"
							rm $(echo $archivo | sed -e 's/.tar.gz/.txt/g')
							exit 1
						fi
						
						## No se puede isntalar
						tar -zxvf "$2"/"$1" -C /
						
						cat /infobd.txt >> mybd.bd
						### entra a la carpeta /etc para ver si se modificaron archovos y guardar el estado actual
						
						rm infobd.txt
						cd /etc
						
						## Condicion para q hacer el push
						if [ -n "$(git status -s)" ]
						then
							git add .
							git commit -m $(echo $archivo | sed -e 's/.tar.gz/.txt/g')
							git push origin master
							exit 1
						fi
						
						;;
					
					1 )
						echo "El Paquete a instalar es una version Anterior, no se instalara"
						exit 1
						;;
					2 )
						echo
						echo "Si desea instalar este paquete por favor utilice la funcion mirringo -up NombrePaquete.tar.gz"
						echo
						;;
					3) 
						echo "El Paquete $archivo ya se encuentra"
						exit 1
				esac
			fi
		else
			echo "El Paquete No Existe, porfavor escriba bien"
			exit 1
		fi
	fi
}

Instalar $1 $2
