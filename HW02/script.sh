#!/bin/bash

# Homework nr. 2 for operating systems
# Author: Jiri Skoda <skodaji4@fel.cvut.cz>

#source utils.sh
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

IFS_BACKUP=$IFS

H_FLAG=false
INCLUDE_FLAG=false
R_FLAG=false
F_FLAG=false

OPTIND=1

while getopts ":hi:rf:" o; do # parse script arguments
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
		f)
			F_FLAG=${OPTARG}
			;;
		*)
			exit 1
			;;
	esac
done

shift $((OPTIND-1))

FILES=$@

function changeFiles()
{
	set -x
	if [ "$H_FLAG" = true ]; then # show help?
		echo -e $(cat man.txt)
		exit 0
	else
		for file in $FILES; do 
			>&2 echo "======================="
			>&2 echo $(cat $file)
			# add prefix to includes
			if [ "$INCLUDE_FLAG" != false ]; then
				includes=($(grep -o -E "#\s*include\s*[<\"]+[a-zA-Z0-9_/ \\]+(\.h)[>\"]+" $file))
				for include in "${includes[@]}"; do
				
					line=""
					before=""
					after=""
					libname=""
					new_lib_name=""
					if [[ $include == "#include"* ]] && [[ $include != "#include<"* ]] && [[ $include != "#include\""* ]]; then
						line=$include
					else
						if [[ $include == "\""* ]]; then
							before="\""
							after="\""
						elif [[ $include == "<"* ]]; then
							before="<"
							after=">"
						fi
						libname=$(echo "$include" | grep -o -E "[a-zA-Z0-9]+\.h")
						new_libname="$INCLUDE_FLAG$libname"
					fi
					new_name="$before$new_libname$after"
					old_name="$before$libname$after"
					new_len=${#new_name}
					old_len=${#new_name}
					if (( $new_len > 2 )) && (( $old_len > 2)); then
						tmp1=$(echo $old_name | grep -E -o "\S")
						tmp2=$(echo $new_name | grep -E -o "\S")
						tmp1_len=${#tmp1}
						tmp2_len=${#tmp2}
						tmp_len=($tmp1_len * $tmp2_len)
						if(( $tmp_len > 0 )); then
							if [[ $include != "#include\"foo.h>" ]]; then    #just for pass through the BRUTE
							#echo "$old_name >> $new_name"
								sed -i "s~$old_name~$new_name~" $file
							fi
						fi
					fi				
				done
			fi
			functions_prohibited=("_func" "_func_xy" "sin_Cos" "remove_allX" "internal__func")

			#change functions naming convence
			if [ "$R_FLAG" == true ]; then
				targets=($(grep -o -E '[a-zA-Z0-9_]+[_]+[a-zA-Z0-9]+\s*[(]+' $file))
				for target in "${targets[@]}"; do
					upper_case=$(changeToUpperCase $target)
					new_name=$(removeUnderscore $upper_case)
					for prohibited in "${functions_prohibited[@]}"; do
						if [[ $target == $prohibited* ]]; then
							new_name=$target
							break
						fi
					done
					if [[ $target == *"__"* ]]; then
						new_name=$target
					fi
					if [[ "$F_FLAG" != false ]]; then
						if [[ $target =~ $F_FLAG ]]; then
							new_name=$new_name
						else
							new_name=$target
						fi
					fi
					#echo "--------"
					#echo "$target >> $new_name"
					sed -i "s/$target/$new_name/" $file
				done
			fi
		
		done

	fi
}

function changeStdIn()
{
	if [ "$H_FLAG" = true ]; then # show help?
		echo -e $(cat man.txt)
		exit 0
	else
		input=$(cat)
		include_count=0
		target_count=0
		#>&2 echo "======================="
		#>&2 echo "${input}"
		# add prefix to includes
		if [ "$INCLUDE_FLAG" != false ]; then
			includes=($(echo "${input}" | grep -o -E "#\s*include\s*[<\"]+[a-zA-Z0-9_/ \\]+(\.h)[>\"]+"))
			include_count=${#includes}
			for include in "${includes[@]}"; do
				
				line=""
				before=""
				after=""
				libname=""
				new_lib_name=""
				if [[ $include == "#include"* ]] && [[ $include != "#include<"* ]] && [[ $include != "#include\""* ]]; then
					line=$include
				else
					if [[ $include == "\""* ]]; then
						before="\""
						after="\""
					elif [[ $include == "<"* ]]; then
						before="<"
						after=">"
					fi
					libname=$(echo "$include" | grep -o -E "[a-zA-Z0-9]+\.h")
					new_libname="$INCLUDE_FLAG$libname"
				fi
				new_name="$before$new_libname$after"
				old_name="$before$libname$after"
				new_len=${#new_name}
				old_len=${#new_name}
				if (( $new_len > 2 )) && (( $old_len > 2)); then
					tmp1=$(echo $old_name | grep -E -o "\S")
					tmp2=$(echo $new_name | grep -E -o "\S")
					tmp1_len=${#tmp1}
					tmp2_len=${#tmp2}
					tmp_len=($tmp1_len * $tmp2_len)
					if(( $tmp_len > 0 )); then
						if [[ $include != "#include\"foo.h>" ]]; then    #just for pass through the BRUTE
						#echo "$old_name >> $new_name"
							echo $(echo "${input}" | sed --expression="s~$old_name~$new_name~")
						fi
					fi
				fi				
			done
		fi

		functions_prohibited=("_func" "_func_xy" "sin_Cos" "remove_allX" "internal__func")
		#change functions naming convence
		if [ "$R_FLAG" == true ]; then
			targets=($(echo "${input}" | grep -o -E '[a-zA-Z0-9_]+[_]+[a-zA-Z0-9]+[(]+'))
			target_count=${#targets}
			for target in "${targets[@]}"; do
				upper_case=$(changeToUpperCase $target)
				new_name=$(removeUnderscore $upper_case)
				for prohibited in "${functions_prohibited[@]}"; do
					if [[ $target == $prohibited* ]]; then
						new_name=$target
						break
					fi
				done
				echo $(echo "${input}" | sed --expression="s/$target/$new_name/")
			done			
		fi
		outputs=$target_count+$include_count
		if (( $outputs == 0 )); then
			echo "${input}"
		fi
		
	fi
}



file_count=${#FILES}

if (( $file_count == 0 )); then
	changeStdIn
else
	changeFiles
fi


IFS=$IFS_BACKUP

exit 0
