#!/bin/bash

# Homework #1 for operating systems
# Author: Jiri Skoda <skodaji4@fel.cvut.cz>

PREFIX="PATH "

HELP_FLAG=false
HELP_SWITCH="-h"
ZIP_FLAG=false
ZIP_SWITCH="-z"

ZIP_COMMAND="tar czf output.tgz "

ERROR_FLAG=false
CRITICAL_FLAG=false


for arg in $@; do # check arguments of script
	if [[ $arg = $HELP_SWITCH ]]; then
		HELP_FLAG=true
	elif [[ $arg = $ZIP_SWITCH ]]; then
		ZIP_FLAG=true
	elif [ "$HELP_FLAG" = false ]; then
		CRITICAL_FLAG=true
		exit 2
	fi
done

if [ "$HELP_FLAG" = true ]; then # when -h switch is active, show help and exit
	echo -e $(cat man.txt)
	exit 0
fi


while read -r line; do
	if [[ $line = $PREFIX* ]]; then  # check if input starts with PATH
		input=${line#"$PREFIX"}
		if [[ -e $input ]]; then
			if [[ -f $input ]]; then # input is file
				lines=$(< "$input" wc -l)
				first_line=$(head -n 1 "$input")
				echo "FILE '$input' $lines '$first_line'"
				if [ "$ZIP_FLAG" = true ]; then
					ZIP_COMMAND="${ZIP_COMMAND}$input "
				fi
			elif [[ -L $input ]] || [[ -h $input ]]; then # input is symlink
				target=$(readlink "$input")
				echo "LINK '$input' '$target'"
			elif [[ -d $input ]]; then # input is directory
				echo "DIR '$input'"			
			else # input is nothing from above
				>&2 echo "ERROR '$input'"
				ERROR_FLAG=true
			fi
		else # input doesn't exists
			>&2 echo "ERROR '$input'"
			ERROR_FLAG=true
		fi
	fi
done

if [ "$ZIP_FLAG" = true ]; then
	eval $ZIP_COMMAND
fi

EXIT_CODE=0
if [ "$ERROR_FLAG" = true ]; then
	EXIT_CODE=1
fi

if [ "$CRITICAL_FLAG" = true ]; then
	EXIT_CODE=2

fi

exit $EXIT_CODE