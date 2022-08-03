#!/bin/bash

readonly ATTEMPTS=10


if [[ $# -ne 1 ]]
then
	echo "Error: A file must be provided as argument" >&2
	exit 1
fi


echo "Count,IP,Location"
cat $1 | 
