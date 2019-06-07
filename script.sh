#!/bin/bash
# Escriba su código aquí
# crea el archivo data.csv
touch data_temp.01
cp data.csv data_temp.01

# Tratando los campos \N
sed 's/n/\N/g' data_temp.01 > out.1 # n -> N
sed 's/;;/;\\N;/g' out.1 > out.2    # ;; -> ;\N;
sed 's/;N;/;\\N;/g' out.2 > out.3   # ;N;-> ;\N;
sed 's/;N/;\\N/g' out.3 > out.4      # ;N -> ;\N    
sed 's/;$/;\\N/g' out.4 > out.5     # ;$ -> ;\N

# Transformando punto de los numeros
sed 's/,/./g' out.5 > out.6         # , -> .

# Transformando 
sed 's/;/,/g' out.6 > out.7         # ; -> , 

# Transformando el formato de la fecha cuando tienen dos digitos en el anno
sed -E 's,([0-9]{2})/([0-9]{2})/([0-9]{2}),20\3-\2-\1,g' out.7 > out.8
# Fechas que tienen 4 digitos como anno
sed -E 's,([0-9]{1})/([0-9]{1})/([0-9]{4}),\3-0\2-0\1,g' out.8 > out.9

#Transformando letras a mayusculas
sed 's/a/A/g' out.9 > out.10
sed 's/c/C/g' out.10 > out.11

#############################
cp out.11 solucion.back
cat solucion.back
rm -rf out.*
#############################
