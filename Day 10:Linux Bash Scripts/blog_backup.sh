#!/bin/bash

# Variables
SRC_DIR="/var/www/html/blog"
BACKUP_NAME="xfusioncorp_blog.zip"
LOCAL_BACKUP_DIR="/backup"
REMOTE_USER="clint"                  # Replace with actual backup server username
REMOTE_HOST="stbkp01"                 # Replace with backup server hostname
REMOTE_DIR="/backup"

# Step a: Create a zip archive of the source directory
zip -r "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" "$SRC_DIR"

# Step b: Copy archive to Nautilus Backup Server
scp "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"

# End of script