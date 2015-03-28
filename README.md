# rsync_backup
rsync incremental backup with hardlinks.

1. Place in `/opt/backup`
2. Mount target disk at `/mnt/diskbackup`
3. Set paths and such in backup.sh
4. Enable cronjob for root. Example cronjob:
```
# Root/disk backup, 6 minutes past 03:00 on mondays
5 3 * * 1 /opt/backup/backup.sh
```
