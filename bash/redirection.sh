#!/bin/bash

# this sends all commands to /dev/null
echo "No output?"
ls ~/noexist.txt > /dev/null 2>&1

# retrieve output from a pipe
echo "section 1"
HISTORY_TEXT=$(cat ~/.bashrc | grep HIST)
echo "${HISTORY_TEXT}"

# output result to a file history.config
echo "section 2"
echo ${HISTORY_TEXT} > history.config

# redirect history.config as input to the cat command
echo "sending history to cat"
cat < history.config

# append a string to history.config
echo "MY_VAR=1" >> history.config

echo "section 3, using tee"
# neato.txt will contain the same info as the console
ls -la ~/fakefile.txt ~/ 2>&1 | tee neato.txt
