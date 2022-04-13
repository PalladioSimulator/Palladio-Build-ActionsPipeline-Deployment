#!/bin/sh -l
set -eu

# Create a tmp sftp commands batch file
TEMP_SFTP_FILE='../sftp'
printf "%s" "put -r $5 $6" >$TEMP_SFTP_FILE

# Create tmp ssh key file
TEMP_SSH_PRIVATE_KEY_FILE='../ssh_key'
printf "%s" "$4" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

echo 'Start Deployment'

# Create deployment folder if it does not exist
ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 mkdir -p $6

# Remove potential existig files in deployment folder
ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 rm -rf $6/*

# Copy new files to folder
sftp -b $TEMP_SFTP_FILE -P $3 -o ConnectTimeout=5 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

echo 'Deployment success'
exit 0

