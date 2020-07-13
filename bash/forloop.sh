#!/bin/bash

# create an array
FILES=( "file1" "file2" "file3" )

# you can select which index to print or @ for all
for FILE in ${FILES[@]}  
do
  echo "Files in this directory are: ${FILE}"
done
echo "All the files were echo\'d."
