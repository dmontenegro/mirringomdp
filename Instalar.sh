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
	echo "Extension:   "$ext
	if [ -f "$2"/"$1" ]
	then
	
		if [ "$ext" = "mdp" ]
		then
			echo "Extension Incorrecta, debe ser mdp"
		else
			echo "Extension Correcta, Buscariamos si el archivo no este instalado\n\n"
			Buscar MyDB.db ALgo.sh
		fi
		
		
	else
		echo "El Paquete No Existe, porfavor escriba bien"
	fi
fi


#echo "Archivo:    $1\n"
#echo "Ruta:    $2\n"
