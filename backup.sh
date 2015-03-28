#!/bin/sh
# Script using rsync to backup entire system excluding /mnt, /proc and stuff.
# Script should be put in /opt/backup

# Set config here or, even better, in backup.cfg.
SOURCE="/*"
PATHTOBACKUP="/mnt/diskbackup"
EXCLUDEFILE="/opt/backup/exclude.txt"
date=`date "+%Y-%m-%dT%H:%M:%S"`

# Mount disk for writing
mount -o rw,remount $PATHTOBACKUP

# Do rsync, excluding directories in exclude.txt
rsync -aAXvz --exclude-from $EXCLUDEFILE --link-dest=$PATHTOBACKUP/current $SOURCE $PATHTOBACKUP/back-$date

# Make new symlink for current
if [ -e $PATHTOBACKUP/current ]; then
    rm $PATHTOBACKUP/current && ln -s back-$date $PATHTOBACKUP/current
else
    ln -s back-$date $PATHTOBACKUP/current
fi

# Write protect disk
mount -o ro,remount $PATHTOBACKUP
