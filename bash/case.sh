#!/bin/bash

while [[ $ANSWER -ne 10 ]]; do
  read -p "Please enter your answer: 5 + 5= " ANSWER
  case $ANSWER in 
  10) 
    echo "$ANSWER is correct."
  ;;
  *) 
    echo "$ANSWER is wrong."
  ;;
  esac
done
