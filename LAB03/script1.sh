#!/bin/bash

while read LINE
	do A="$A $(echo "$LINE"|sed -e 's/[^a-zA-Z]\+//g')"
done
