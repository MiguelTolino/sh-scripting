#!/bin/bash

#This script generates a random password
#This user canset thepassword length with -land add a sspecial character with  -s
#Verbose mode can be enabled with -v

usage()
{
	echo "Usage: $0 [-vs] [-l LENGTH]" >&2
	echo 'Generate  a random password'
	echo '-l LENGTH Specify the password length'
	echo '-v Verbose mode on'
}

#Set a  default password length
LENGTH=64

while getopts vl:s OPTION
do
	case $OPTION in
	v)
		VERBOSE=true
		echo  'Verbose mode on'
		;;
	l)
		LENGTH=$OPTARG
		;;
	s)
		SPECIAL_CHAR=true
		;;
	?)
		echo  'Invalid option.'  >&2
		exit 1
		;;
	esac
done
