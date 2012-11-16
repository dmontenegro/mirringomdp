#!/bin/bash
#!/usr/bin/





tem="/tmp/mirringo/Desintalar/"
tem1="/tmp/mirringo/Instalados/"

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
	if [ $USER = "root" ]
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
				echo "Pruba:  "$(source VerificarPaqueteBD.sh $(echo $archivo | sed -e 's/-/ /g' -e 's/.tar.gz/ /g' ))
				
				et=3
				### Condicional que mira si esta instalado
				
				case $et in
					
					0 )
						
						## lo hago por si las moscas
						cd $tem
						et=$tem${archivo%%.*}".txt"
						
						## lo copio en la carpeta desintalacion
						tar tzf "$2"/"$1" | sed '/\/$/d' > ${archivo%%.*}".txt"
						
						if [ $(Verificar $et) = 1 ]
						then
							echo "Conflictos en archivos del paquete"
							rm ${archivo%%.*}".txt"
							exit
						fi
						
						echo "Instalando.... ${archivo%%.*}"
						echo
						tar xf "$2"/"$1" -C /
						cat /info.txt >> $tem1"/Instalados.db"
						echo "Termino Instalacion"
						echo
						
						### entra a la carpeta /etc para ver si se modificaron archovos y guardar el estado actual
						
						cd /etc
						
						## Condicion para q hacer el push
						if [ -n "$(git status -s)" ]
						then
							git add .
							git commit -m {archivo%%.*}
							git push origin master
							exit
						fi
						
						
						;;
					
					2 )
						echo "El Paquete a instalar es una version Anterior, no se instalara"
						exit 1
						;;
					1 )
						$op
						echo "Desea Actilzar el Paquete (si o no):  "
						read op
						case $op in
							"si" )
									echo "Llama lo de nelson"
									;;
							"no" )
									exit 1
									;;
						esac
						;;
					3) 
						echo "El Paquete $archivo ya se encuentra"
				esac
			fi
		else
			echo "El Paquete No Existe, porfavor escriba bien"
			exit 1
		fi
	fi
}

Instalar $1 $2
