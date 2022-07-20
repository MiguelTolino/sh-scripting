#!/bin/bash

PASSWORD="$RANDOM@$RANDOM@$RANDOM"

echo "$PASSWORD"



# This script generates a random password for each user specified on the command line

# Display whay te user typed on the command line

if [[ $# -ge 1 ]]
then

	echo "You executed this command: $0"
	echo "You used this variable: $1"
	echo "I used $(dirname $1) as the path to the $(basename $1) command"
fi


for i in Frank Belinda Joel
do
	echo "Hi $i"
done



for USER_NAME in $@
do
	PASSWORD=$(date +%s%N | sha256sum | head -c48)
	echo "$USER_NAME : $PASSWORD"
done
