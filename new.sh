pkgname=python-constraint
pkgver=1.1
pkgrel=5
pkgdesc='A Python module offering solvers for Constraint Solving Problems (CSPs) over finite domains in simple and pure Python'
arch='any'
url='http://labix.org/python-constraint'
license='GPL'
depends='python adasdads'
source="http://labix.org/download/python-constraint/python-constraint-1.1.tar.bz2"
sha512sums=2385b564cb833ee34e11ae6c410fb584f51570c7ed64f201e7619301364b93ab50d2e2b8c9c3a90c81f217aa4fee11137e70dcf6b6be725bd2a4792b9757f414

build() {
  cd $pkgname-$pkgver

  python setup.py build

  # cd $pkgname-$pkgger

  python setup.py install --root=$pkgdir --optimize=1
}
