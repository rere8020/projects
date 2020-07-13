#!/bin/bash

var=2

case $var in 
1)
  echo 1
  ;;
2)
  echo 2
  ;;
*)
  echo "What is $var ??"
  exit 1
esac
