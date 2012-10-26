#!/bin/bash

pkgname=helloworld
pkgver=0.1
pkgrel=1
pkowner="Clase de linux"
pkgdesc="The Generic Constraint Development Environment"
url="http://www.gecode.org"
license='MIT'
depends='qt'
source="http://escher.puj.edu.co/~farhat/helloworld-0.1.tar.gz"
sha512sums='ce60395855714433442cbef5344bf167cbac48100d0033fbfb641f858925159cd0176ced715cfbead4a36b62a79358f782aa0748ac7925dd062c87a6ec93a83c'

build() {
    path=$PWD
    wget $source
    ss=`sha512sum $pkgname-$pkgver.tar.gz| cut -d " " -f 1`
    echo $ss
	if [ $ss != $sha512sums ]
    then
	rm $pkgname-$pkgver.tar.gz 
	echo "Suma criptografica mala."
	exit 1
    fi    
    tar xvfz $pkgname-$pkgver.tar.gz
    cd $pkgname-$pkgver
    chmod +x helloworld
    mkdir paquete
    cp helloworld paquete/
    
  
    tar cvfz $pkgname-$pkgver-$pkgrel.mdp paquete
    mv $pkgname-$pkgver-$pkgrel.mdp $path
    cd $path
    rm $pkgname-$pkgver.tar.gz
    rm -rf $pkgname-$pkgver
}

build

