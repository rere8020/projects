#!/bin/bash

#https://www.thegeekstuff.com/2010/07/bash-string-manipulation/

park="parks.are.amazing.parks"

echo ${#park}

# extract substring ${string:position:length}
echo ${park:3:3}

# match substring ${string#substring} and delete shortest match from front of string
echo "${park#*.}" 

# delete shortest match of substring from back of string ${string%substring}
echo ${park%.*}

# delete longest match of substring ${string##substring}
echo ${park##*.}

# delete the longest match of substring from back of $string ${string%%substring}
echo ${park%%*.}

# replace first occurance ${string/pattern/replacement}
echo ${park/parks/pools}

# replace all matches ${string//pattern/replacement}
echo ${park//parks/pools}

# replace beginning and end ${string/#pattern/replacement}
echo begin and end
echo ${park/#parks/pool}

# replaces with the replacement string, only when the pattern matches beginning of the $string ${string/%pattern/replacement}
echo ${park/%parks/is}

# remove the - and print absolute number
myvar=-1
echo ${myvar#-}

