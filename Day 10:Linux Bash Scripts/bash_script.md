# Bash Script

The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on App Server 2 in Stratos Datacenter, and they need to create a bash script named blog_backup.sh which should accomplish the following tasks. (Also remember to place the script under /scripts directory on App Server 2).

a. Create a zip archive named xfusioncorp_blog.zip of /var/www/html/blog directory.

b. Save the archive in /backup/ on App Server 2. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.

c. Copy the created archive to Nautilus Backup Server server in /backup/ location.

d. Please make sure script won't ask for password while copying the archive file. Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.

e. Do not use sudo inside the script.

Note:
The zip package must be installed on given App Server before executing the script. This package is essential for creating the zip archive of the website files. Install it manually outside the script.

Bash script:

```bash
#!/bin/bash

# Variables
#!/bin/bash

SRC_DIR="/var/www/html/official"
LOCAL_BACKUP_DIR="/backup"
BACKUP_NAME="fusioncorp_official.zip"


zip -r "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}" "${SRC_DIR}"


REMOTE_USER=clint
REMOTE_HOST=stbkp01
REMOTE_BACKUP_DIR=/backup
scp "${LOCAL_BACKUP_DIR}/${BACKUP_NAME}"  "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BACKUP_DIR}/"

```

Giving the executable permission to the script file.

```bash
chmod +x blog_backup.sh
```

Enable passwordless ssh:

```bash
ssh-keygen -t rsa

ssh-copy-id clint@stbkp01

```






