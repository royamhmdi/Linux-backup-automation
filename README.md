# Linux Backup Automation Script

A Bash automation script that performs recursive file backup based on user-defined file extensions.

## Features

- Recursive file search
- Backup manifest generation
- Automatic archive creation
- Timestamped backup directories
- Backup logging
- Automatic cleanup of old backups
- AES-256 encryption
- Desktop notification
- Cron compatible

## Requirements

- Bash
- tar
- openssl
- find
- notify-send (optional)

## Usage

Interactive mode

```bash
bash BackUp.sh
```

Cron mode

```bash
bash BackUp.sh /home/user/Documents txt /home/user/backups 7
```

## Backup Structure

```
backups/
└── backup_2026_04_06_12_33/
    ├── files_backup.tar.gz.enc
    ├── backup.log
    └── backup_manifest.txt
```

## Example

```
Enter source path:
/home/user/Documents

Enter extension:
txt

Backup completed successfully.
```

## Cron Example

```
0 2 * * * /home/user/BackUp.sh /home/user/Documents txt /home/user/backups 7
```

## Author

Your Name
