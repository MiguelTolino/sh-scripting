#!/bin/bash

IP=192.168.56.1
SERVERFILE="/vagrant/servers"
SSH="ssh -o ConnectTimeout=2"

usage() {

	echo -e "Usage: $0 [-f FILE] [-nsv] CMD\n" >&2
	echo -e "-f FILE\t\tThis allows the user to override the default file of /vagrant/servers.  This way they can create their own list of servers execute commands against that list." >&2
	echo -e "-n\t\tThis allows the user to perform a "dry run" where the commands will be displayed instead of executed.  Precede each command that would have been executed with DRY RUN: " >&2
	echo -e "-s\t\tRun the command with sudo (superuser) privileges on the remote servers." >&2
	echo -e "-v\t\tEnable verbose mode, which displays the name of the server for which the command is being executed on.\n" >&2
	exit 1
}

check_file() {

if [[ ! -e $SERVERFILE ]]
then
	echo "Error: File does not exists" >&2
	usage
fi
}

while getopts "f:nsv" opt;
do
	case ${opt} in
		f)	SERVERFILE=${OPTARG}
			shift;;
		n)	DRYRUN=true;;
		s)	SUPER="sudo";;
		v)	VERBOSE="true";;
		*)	usage;;
	esac
shift
done
		
check_file

if [[ $# -lt 1 ]]
then
	usage
fi

CMD=$@

for i in $(cat ${SERVERFILE});
do
	if [[ $VERBOSE ]]
	then
		echo "IP|SERVER NAME: $i"
	fi
		$SUPER $SSH $i $CMD 
	if [[ $? -ne 0 ]]
	then
		echo "Error: $ip command failed"
		exit 1
	fi
done

exit 0
