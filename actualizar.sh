#!/bin/bash

(source eliminar.sh $1) && (read -p "Por favor ingrese ruta: " di;read -p "Por favor ingrese el paquete: " paq;source instalar.sh "$paq" "$dir")
