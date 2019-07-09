#!/bin/bash

{

read
re='^[0-9]+$'
COUNTER=1
cd rep
if [ -e ../log_dataset/$1 ]
then
	rm ../log_dataset/$1
fi

while IFS=, read build project date commit push_commit number_commit
do
	
	
	if [ $COUNTER -eq 1 ]; then
		
		git clone https://github.com/$project
		rep=$(echo $project | cut -d'/' -f2)
		cd $rep
	fi
	str_commit=""
	export IFS="#"
	
	echo "*************$number_commit**************"
	for c in $push_commit; do 
		#~ echo $c
		str_commit="$str_commit$c:["
		
		#~ loop over lines and for each, mettre ':' et le nombre de ligne modifiee
		while read -r line ; do
			if [ ! -z "$line" ]
			then
				echo $line
				del=$(echo "$line" | cut -f1)
				#~ echo $del
				add=$(echo "$line" | cut -f2)
				#~ echo $add
				
				if [[ $add =~ $re ]] || [[ $del =~ $re ]] ; then
					mod=$((add+del))
					file=$(echo "$line" | cut -f3)
					str_commit="$str_commit$file:$mod;"
				fi
				echo $mod
				
				
				#~ echo $file
				
			fi
		done <<<$(git diff-tree --numstat $c | tail -n +2)
		
		str_commit="$str_commit]#"
	done
	#~ echo $str_commit


	echo "$build, $project, $date, $commit, $push_commit, $number_commit, $str_commit" >>../../log_dataset/$1
	let COUNTER-=1
	
done 
cd ../..
rm -rf rep/$rep
} < $1
