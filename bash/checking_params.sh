#!/bin/bash

# Script will check that parameters are passed and error if not
USAGE="USAGE: $0 scratchdir sourcefile conversion"

# checks that 3 params are passed 
if [ -z "$3" ]
then
    echo "Error. $USAGE"
fi
exit 0 
