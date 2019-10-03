#!/usr/bin/bash
if [ -L "$1" -a ! -e "$s1" ]
then
	echo "YES"
fi