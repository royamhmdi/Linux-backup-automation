#!/bin/bash

start_time=$(date +%s)

# Check if we have arqument or not 

echo "------ phase 1 ------"

if [ $# -eq 4 ]
then
    source_path="$1"
    extension="$2"
    backup_path="$3"
    retention_days="$4"

    echo "Running in Cron/Argument mode..."
else
    echo "Running in Interactive mode..."

    echo "Enter source path:"
    read source_path

    echo "Enter file extension:"
    read extension

    echo "Enter backup path:"
    read backup_path

    echo "Enter number of days to keep backups:"
    read retention_days
fi



echo " ------ Phase 2 ------"

extension=${extension#.}

echo "Searc for: *.$extension"

find "$source_path" -type f -name "*.$extension" > backup_manifest.txt

count=$(wc -l < backup_manifest.txt)


if [ "$count" -eq 0 ]; then
    echo "No files found."
    exit 1
fi

echo "Manifest file created successfully "
echo "Found files:"
cat backup_manifest.txt
echo "total files we found : $count"



echo "------ Phase 3 ------"

timestamp=$(date +"%Y_%m_%d_%H_%M_%S")

backup_dir="$backup_path/backup_$timestamp"

mkdir -p "$backup_dir"

echo "backup directory created:"
echo "$backup_dir"

echo ""
echo "------ Phase 4 -------"

archive_name="$backup_dir/files_backup.tar.gz"

tar -czf "$archive_name" -T backup_manifest.txt 2>/dev/null

echo "Backup archive created successfullyyy."
echo "Archive location:"
echo "$archive_name"

encrypt="y"   

if [ "$encrypt" = "y" ]; then
    echo "Encrypting backup..."

    password="1234"   

    openssl enc -aes-256-cbc -pbkdf2 -salt \
    -in "$archive_name" \
    -out "$archive_name.enc" \
    -pass pass:"$password"

    if [ $? -eq 0 ]; then
        rm "$archive_name"
        archive_name="$archive_name.enc"
        echo "Backup encrypted successfully."
    else
        echo "Encryption failed!"
    fi
fi

echo ""
echo "========== Phase 5,6,7 =========="

log_file="$backup_dir/backup.log"

echo "Backup Started" > "$log_file"
echo "Source Path: $source_path" >> "$log_file"
echo "Extension: $extension" >> "$log_file"
echo "Files Found: $count" >> "$log_file"
echo "Archive Created: $archive_name" >> "$log_file"

size=$(du -h "$archive_name" | cut -f1)

echo "Backup Size: $size" >> "$log_file"

end_time=$(date +%s)
execution_time=$((end_time - start_time))

echo "Execution Time: $execution_time seconds" >> "$log_file"

echo "removing backups older than $retention_days days..." >> "$log_file"

find "$backup_path" -type d -name "backup_*" ! -path "$backup_dir" -mtime +"$retention_days" -exec rm -rf {} \;

echo "Old backups deleted." >> "$log_file"
echo "Backup Completed Successfully" >> "$log_file"

echo ""
echo "Log file created:"
echo "$log_file"


if command -v notify-send >/dev/null 2>&1
then
    notify-send \
    "Backup Completed" \
    "Files: $count | Size: $size" 2>/dev/null || true
fi
