#!/bin/bash

# script returns the donor name and amount donated
# if we omit the '' around EOF it would interpolate the $ within the amounts
# the - after << tells bash to ignore spacing

grep -i $1 <<-'EOF'
	Sandra $100
	Joe $500
	Sam $10	
	EOF
