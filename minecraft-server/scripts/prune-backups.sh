#!/usr/bin/env bash
# script to prune backups of minecraft servers

backup_dir="/home/cwatson/minecraft/backups"

worlds=("nexus")
for world in "${worlds[@]}"; do
  # "archive" backup from seven days ago
  find "$backup_dir/$world" -maxdepth 1 -type f -mtime 7 -exec mv {} "$backup_dir/$world/archive/" \;

  # prune backups older than 7 days
  find "$backup_dir/$world" -maxdepth 1 -type f -mtime +7 -exec rm {} \;
done
