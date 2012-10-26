pkgname=helloworld
pkgver=0.1
pkgrel=1
pkowner="Clase de linux"
pkgdesc="The Generic Constraint Development Environment"
url="http://www.gecode.org"
license='MIT'
depends='qt'
source="http://escher.puj.edu.co/~farhat/helloworld-0.1.tar.gz"
md5sums='7a5cb9945e0bb48f222992f2106130ac'

build() {
    path=$PWD
    wget $source
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

