#!/bin/bash

CTR=1
while [[ ${CTR} -lt 9 ]]; do
  echo "Var CTR is: $CTR"
  ((CTR++)) 
done
echo "Finished"

if [[ $? == 0 ]]; then
  echo "script was successfull"
else
  echo "script failed"
fi 
