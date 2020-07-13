#!/bin/bash

FILES=( "file1" "file2" "file3" )

function create_files() {
  local FILE_NAME="$1"
  local PERM="$2"
  touch "${FILE_NAME}" && chmod "${PERM}" "${FILE_NAME}" 
    for file in $(ls | grep ${FILE_NAME}); do
      echo "The following files were created: $file"
      done
}

for file in ${FILES[@]}; do
  create_files "$file" "777"
done


 
echo "created all files with a function"
exit 0
