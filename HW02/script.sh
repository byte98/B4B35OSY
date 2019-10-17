#!/bin/bash

# Homework nr. 2 for operating systems
# Author: Jiri Skoda <skodaji4@fel.cvut.cz>

H_FLAG=false
INCLUDE_FLAG=false
R_FLAG=false

OPTIND=1

while getopts ":hi:r" o; do # parse script arguments
	case "${o}" in
		h)
			H_FLAG=true
			;;
		i)
			INCLUDE_FLAG=${OPTARG}
			;;
		r)
			R_FLAG=true
			;;
	esac
done

shift $((OPTIND-1))


FILES=$@


if [ "$H_FLAG" = true ]; then # show help?
	echo -e $(cat man.txt)
	exit 0
else
	for file in $FILES; do
		sed -i "s~#include <~#include <$INCLUDE_FLAG~" $file
		sed -i "s~#include \"~#include \"$INCLUDE_FLAG~" $file
	done

fi






