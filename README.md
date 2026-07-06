# 🗂️ Linux Backup Automation Script

A Bash automation script that automatically creates backups of files with a specific extension. The script searches directories recursively, compresses and encrypts the backup, generates logs, removes old backups, and supports scheduled execution using Cron.

---

## ✨ Features

- 📂 Recursive search for files by extension
- 📝 Generates `backup_manifest.txt`
- 📦 Compresses files into a `.tar.gz` archive
- 🔐 AES-256-CBC backup encryption using OpenSSL
- 🕒 Creates timestamped backup directories
- 📋 Generates detailed backup logs
- 🧹 Automatically removes old backups
- ⏰ Supports scheduled execution with Cron
- 🔔 Desktop notification using `notify-send` (GUI environments)

---

## 📁 Project Structure

```
BackUp.sh
README.md
```

After running the script:

```
backups/
└── backup_2026_06_26_18_18_12/
    ├── files_backup.tar.gz.enc
    └── backup.log
```

---

## ⚙️ Requirements

The following tools should be installed:

- Bash
- tar
- find
- openssl
- gzip
- notify-send *(optional, GUI only)*
- cron *(optional, for scheduled backups)*

---

## 🚀 Usage

### Interactive Mode

Run the script and enter values manually.

```bash
bash BackUp.sh
```

The script will ask for:

- Source directory
- File extension
- Backup directory
- Retention days

---

### Argument / Cron Mode

```bash
bash BackUp.sh /home/user/Documents txt /home/user/backups 7
```

Arguments:

| Argument | Description |
|----------|-------------|
| `$1` | Source directory |
| `$2` | File extension |
| `$3` | Backup directory |
| `$4` | Retention days |

---

## 📦 Example

Input

```text
Source Path:
/home/user/Documents

Extension:
txt

Backup Path:
/home/user/backups

Retention Days:
7
```

Output

```text
Running in Argument Mode...

Searching for *.txt

Files Found: 4

Backup archive created successfully.

Backup encrypted successfully.

Log file created.
```

---

## 📋 Log File Example

Each backup creates a log file containing:

```text
Backup Started
Source Path: /home/user/Documents
Extension: txt
Files Found: 4
Archive Created: files_backup.tar.gz.enc
Backup Size: 4.0K
Execution Time: 0 seconds
Old backups deleted.
Backup Completed Successfully
```

---

## ⏰ Cron Example

Run every day at 2:00 AM

```cron
0 2 * * * /home/user/BackUp.sh /home/user/Documents txt /home/user/backups 7
```

Or every 2 minutes (testing)

```cron
*/2 * * * * /home/user/BackUp.sh /home/user/Documents txt /home/user/backups 7
```

---

## 🔒 Encryption

The backup archive is encrypted using:

- AES-256-CBC
- PBKDF2 key derivation
- OpenSSL

The resulting backup file:

```
files_backup.tar.gz.enc
```

---

## 📌 Technologies Used

- Bash Shell Scripting
- tar
- find
- OpenSSL
- Cron
- notify-send

---

## 👨‍💻 Author

**Roya**

Linux Backup Automation Script — Operating Systems Course Project
