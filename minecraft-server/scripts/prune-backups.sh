#!/bin/usr/env bash
# script to prune backups of minecraft servers

backup_dir="/home/cwatson/minecraft/backups"

worlds=("nexus")
for world in "${worlds[@]}"; do
  # prune backups older than 30 days
  find "$backup_dir" -type f -mtime +30 -exec rm {} \;
done
