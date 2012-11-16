#/bin/bash

## $1 el paquete
## $2 la ruta

echo "SASDASD:   "$USER

#### Funcion que busca si el archivo ya esta instalado
Buscar() {
	echo "Prueba:  $1\n"
	echo "Prueba:  $2\n"
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
		else
			##echo "Extension Correcta, Buscariamos si el archivo no este instalado\n\n"
			#Buscar MyDB.db ALgo.sh
			## Seria:  et=Funcion
			et=1 ## Iria funcion de juan pablo
			
			### Condicional que mira si esta instalado
			if [ $et = 0 ]
			then
				echo "No esta, lo puede instalar, Hago de descomprimir en una direccion"
			else
				if [ $et = 1 ]
				then
					echo "el Paquete a instalar es una version Anterior"
					exit 1
				else 
					if [ $et = 2 ]
					then
						$op
						echo "Desea Actilzar el Paquete:  "
						read op
						
						case op
						
						#echo "Valor:  $op"
					fi
				fi
			fi
		fi
	else
		echo "El Paquete No Existe, porfavor escriba bien"
	fi
fi
## tar tzf Prueba.tar.gz | sed '/\/$/d' Para eliminar las lineas que terminas en / osea /home/
### Solo dejas las q tienes una extension o un archivo despues osea /home/algo.txt


#echo "Archivo:    $1\n"
#echo "Ruta:    $2\n"
