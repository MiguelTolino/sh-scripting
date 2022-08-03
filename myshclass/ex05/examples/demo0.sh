#!/bin/bash

log()
{
	local VERBOSE=$1
	shift
	if [[ $VERBOSE='true' ]]
	then
		echo $@
	fi
}

function log2 {
	local MESSAGE="$@"
	echo $MESSAGE
}

readonly VERBOSITY=false #Constant

log $VERBOSITY "Verbose  activated"
log2 "Calling log function 2 using parameters" "Many  of  them"
