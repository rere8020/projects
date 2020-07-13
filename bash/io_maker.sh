#!/bin/bash

source io_library.sh # relative path
FNAME="my_test_file.txt" # this var will be plugged into the library functions
create_file "${FNAME}"
delete_file "${FNAME}"

exit 0
