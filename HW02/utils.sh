function changeToUpperCase()
{
	src=$1
	letters_with_underscore=($(echo $src | grep -o [_].))
	reti=$src
	for letter_with_underscore in "${letters_with_underscore[@]}"; do
		letter_only=$letter_with_underscore
		upper_case=$letter_only
		uppercase_with_underscore=$letter_with_underscore
		if [[ $letter_only =~ [a-z]+ ]]; then
			letter_only=$(echo $letter_with_underscore | grep -o [a-z])
			uppercase=$(echo $letter_only | tr '[:lower:]' '[:upper:]')
			uppercase_with_underscore="_$uppercase"
		fi
		reti=$(echo $reti | sed s/$letter_with_underscore/$uppercase_with_underscore/)
	done
	echo $reti
}

function removeUnderscore()
{
	src=$1
	reti="${src//_}"
	echo $reti;
}