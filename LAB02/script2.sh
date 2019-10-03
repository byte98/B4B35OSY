#!/bin/bash
B=$IFS
IFS='
'
FI=`ls -l *.txt`
for F in $FI
do
	echo "Soubor $F ma $(stat -c%s ) bytu"
done
IFS=B

