#!/bin/bash
. ./$1
#Aqui llamamos el archivo que pasamos por argumento al ejecutar construir .sh
#que va a ser la receta que vamos a construir probablemente
#despues vamos a modificar esto, hay que hablarlo.
#Esto genera el archivo .tar.gz y extraemos todos los datos de la receta
#que pasamos como argumento.

#Construir.sh depende de: atool. libreria la cual tiene apack, aunpack y als.
#para instalar atool es apt-get install atool
pkgdir=paquete
srcdir=$pkgname-$pkgver
path=$PWD
pkgdir=$path/$pkgdir
mkdir $srcdir
mkdir $pkgdir
#echo $source
wget $source
#ss=`sha512sum $pkgname-$pkgver.tar.bz2| cut -d " " -f 1`

ss=`sha512sum $pkgname-$pkgver.* | cut -d " " -f 1`

#echo $sha512sums
#echo $ss
if [ $ss != $sha512sums ]
then
    rm $pkgname-$pkgver.tar.bz2
    echo "Suma criptografica mala."
exit 1
fi
#tar xvfj $pkgname-$pkgver.tar.bz2 $srcdir

aunpack $pkgname-$pkgver.* 
cd Unpack-* #Entra al paquete descomprimido
cp -r $pkgname-$pkgver* $path/
cd /$path
rm -rf Unpack-*

build
cd $pkgdir
tar cvfz $pkgname-$pkgver-$pkgrel.tar.gz *  
mv $pkgname-$pkgver-$pkgrel.tar.gz $path
cd $path 
rm -rf $pkgdir
rm -rf $srcdir
rm -rf $pkgname-$pkgver
#rm $pkgname-$pkgver.tar.bz2
rm $pkgname-$pkgver.*
