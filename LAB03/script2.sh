#!/bin/bash

sed -e 's/[^a-zA-Z]\+//g' | hile read LINE
do
	A="$A LINE"
done
