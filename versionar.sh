#!/bin/bash

confpath=/etc

if [ "$1" = "" ] ; then
	echo 'Por favor escoja'
	i=1
	for pckg in "Ir a la configuración anterior" "Mostrar historial"; do
		echo "$i) $pckg"
		let i++
	done
	echo -n "Escoja (1-$(($i - 1))):"
	read line

	case $line in
		1)
			oldpwd=`pwd`
			cd "$confpath"
			git revert HEAD
			cd "$oldpwd"
			exit 0;;
		2)
			oldpwd=`pwd`
			cd "$confpath"
			git log
			cd "$oldpwd"
			exit 0;;
		*)
			echo "Opción inválida"
			exit 1;;
	esac
else
	oldpwd=`pwd`
	cd "$confpath"
	git revert $1
	cd "$oldpwd"
	exit 0
fi
