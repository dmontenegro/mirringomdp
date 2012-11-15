#!/bin/bash
. $1	#deberia ser absoluta
#Aqui llamamos el archivo que pasamos por argumento al ejecutar construir .sh
#que va a ser la receta que vamos a construir probablemente
#despues vamos a modificar esto, hay que hablarlo.
#Esto genera el archivo .tar.gz y extraemos todos los datos de la receta
#que pasamos como argumento.

#Construir.sh depende de: atool. libreria la cual tiene apack, aunpack y als.
#para instalar atool es apt-get install atool

<<<<<<< HEAD
#function construir{


=======
#Paquetes necesarios para la funcion build y para manejar los respectivos
#directorios de lo que se va a instalar.
>>>>>>> construir
pkgdir=paquete
srcdir=$pkgname-$pkgver
path=$PWD
pkgdir=$path/$pkgdir
mkdir $srcdir
mkdir $pkgdir
wget $source

#ss=`sha512sum $pkgname-$pkgver.tar.bz2| cut -d " " -f 1`

#Se comprueba la suma criptografica usando sha512sums.
ss=`sha512sum $pkgname-$pkgver.* | cut -d " " -f 1`

if [ $ss != $sha512sums ]
then
    rm $pkgname-$pkgver.*
    echo "Suma criptografica mala."
	exit 1
fi

#Se descomprime el paquete con aunpack utilizando la dependencia atool y
#se copia lo descomprimido en pkgdir.
aunpack $pkgname-$pkgver.* 
cd Unpack-* #Entra al paquete descomprimido
cp -r $pkgname-$pkgver* $path/
cd /$path
rm -rf Unpack-* #copia afuera la carpeta pkgname-pkver 

#Se ejecutia la funcion build de la receta
build

#Nos movemos a pkgdir. La comprimimos y esta es la que va a ser usada para la
#instalacion.
cd $pkgdir
tar cvfz $pkgname-$pkgver-$pkgrel.tar.gz *  
mv $pkgname-$pkgver-$pkgrel.tar.gz $path
cd $path 

#Agregamos el paquete a la base de datos mybd.bd , previamente creada
#en la instalacion de mirringmdp.
asd="\""$pkgname"\"","\""v$pkgver"\"","\""v$pkgrel"\"","\""$pkgdesc"\"","\""$url"\"","\""$license"\"","\""$depends"\"","\""$source"\"","\""$sha512sums"\""

echo $asd >>mybd.bd

#Borramos todo lo innecesario. Dejamos solo el .tar.gz de la construccion del paquete
rm -rf $pkgdir
rm -rf $srcdir
rm -rf $pkgname-$pkgver
rm $pkgname-$pkgver.*

exit 0


