#!/bin/bash

cd log_dataset

for i in `ls`; do
	sed -i ':a;N;$!ba;s/#\n/\n/g' $i
	sed -i -e 's/;]/]/g' $i 
	sed -i -e 's/, /,/g' $i 
	
	sed -i -e '1ibuild,project,date,commit,push_commit,number_commit,data_log\'  $i
done

cd ..
