#!/bin/bash
. ./$1

name=`grep "pkgname=" $1`
name=${name#*=}
ver=`grep "pkgver=" $1`
ver=${ver#*=}
rel=`grep "pkgrel=" $1`
rel=${rel#*=}
owner=`grep "pkgowner=" $1`
owner=${owner#*=}
url=`grep "url=" $1`
url=${url#*=}
sourc=`grep "source=" $1`
sourc=${sourc#*=}
shasum=`grep "sha512sums=" $1`
shasum=${shasum#*=}

path=$PWD
wget $source
ss=`sha512sum $name-$ver.tar.gz| cut -d " " -f 1`
echo $shasum
echo $ss
if [ $ss != $shasum ]
then
    rm $name-$ver.tar.gz
    echo "Suma criptografica mala."
exit 1
fi
tar xvfz $name-$ver.tar.gz
mkdir paquete
cp -r $name-$ver/* paquete
cd paquete
build
tar cvfz $name-$ver-$rel.tar.gz *
mv $name-$ver-$rel.tar.gz $path
cd $path 
rm -rf paquete
rm -rf $name-$ver
rm $name-$ver.tar.gz
