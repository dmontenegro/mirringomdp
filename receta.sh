#!/bin/bash

pkgname=helloworld
pkgver=0.1
pkgrel=1
pkowner="Clase de linux"
pkgdesc="The Generic Constraint Development Environment"
url="http://www.gecode.org"
license='MIT'
depends=''
source="http://escher.puj.edu.co/~farhat/helloworld-0.1.tar.gz"
sha512sums=ce60395855714433442cbef5344bf167cbac48100d0033fbfb641f858925159cd0176ced715cfbead4a36b62a79358f782aa0748ac7925dd062c87a6ec93a83c

build() {
    chmod +x $pkgname
    touch hola.txt
}


