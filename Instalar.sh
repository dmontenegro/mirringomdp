#/bin/bash

## $1 el paquete
## $2 la ruta
tem="/tmp/mirringo/Desintalar/"


echo "Carpeta tempora:   $tem"
#### Funcion que busca si el archivo ya esta instalado
Buscar() {
	echo "Prueba:  $1\n"
	echo "Prueba:  $2\n"
}

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
if [ $USER = "root" ]
then
	echo "Necesitas Permiso de Administrador para ejecutar esta funcion\n"
	exit 1

else
	#echo "ARchivo:   " $2"/"$
	archivo=$1
	ext=${archivo#*.}
	echo "Extension del Archivo $1 :   "$ext
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
			et=0 ## $(funcion Juan Pablo)Iria funcion de juan pablo
			
			### Condicional que mira si esta instalado
			
			case $et in
				
				0 )
					echo "Se puede instalar, Hago de descomprimir en una direccion"
					
					## Creo la Carpeta temporal
					mkdir "/tmp/mirringo/"
					mkdir $tem
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
					
					echo "Hace lo de Descomprimir en /"
					tar xf "$2"/"$1" -C /
					
					### entra a la carpeta /etc para ver si se modificaron archovos y guardar el estado actual
					
					cd /etc
					
					if [ $(
					
					
					;;
				
				1 )
					echo "El Paquete a instalar es una version Anterior, no se instalara"
					exit 1
					;;
				2 )
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
			esac
		fi
	else
		echo "El Paquete No Existe, porfavor escriba bien"
		exit 1
	fi
fi
## tar tzf Prueba.tar.gz | sed '/\/$/d' Para eliminar las lineas que terminas en / osea /home/
### Solo dejas las q tienes una extension o un archivo despues osea /home/algo.txt


#echo "Archivo:    $1\n"
#echo "Ruta:    $2\n"