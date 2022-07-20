#!/bin/bash

USERNAME=$(whoami)

#Check if we are root user

if [[ "$USERNAME" != "root" ]]
then
	echo "You need to execute this script with root privileges"
	exit 1
fi

#Read data
echo "$USERNAME is using user-add-script"
read -p "Username: " NEWUSER
read -p "Full name : " COMMENT
read -p "Password: " PASSWORD

#Create a new user and set a password
useradd -c ${COMMENT} ${NEWUSER}
echo "${PASSWORD}" | passwd --stdin $NEWUSER

#Configure password expires
passwd -e $NEWUSER

#In case any error, exit 1
if [[ $? -eq 1 ]]
then
	echo "Error..."
	exit 1
fi

#Display user data
echo -e "\nData information:\n"
echo "USERNAME: $NEWUSER"
echo "FULL NAME: $COMMENT"
echo "HOST: $(hostname)"
