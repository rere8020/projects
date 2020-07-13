#!/bin/bash

param1=$1

# local params are only accessible within function
echo ${param1}
function rene() {
  local param1=$1
  local param2=$2
  local param3=$3
  local param4=$4
  echo "${param1} ${param2} ${param3} ${param4}"
}

rene "r" "e" "n" "t"
