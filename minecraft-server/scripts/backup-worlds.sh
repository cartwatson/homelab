#!/usr/bin/env bash
# script to backup minecraft server worlds

# get iso date for backup
timestamp=$(date +"%Y-%m-%dT%H:%M")

# create file name, replace : with -
filename="${timestamp//:/-}.tar.gz"

# define dirs
root_dir="/home/cwatson/minecraft"
backup_dir="/home/cwatson/minecraft/backups"

# compress world backup and all good
worlds=("nexus")
for world in "${worlds[@]}"; do
  # make backup dir if it doesn't exist
  mkdir -p "$backup_dir/$world"

  filepath="$backup_dir/$world/$filename"
  worldpath="$root_dir/$world/"

  # tar file
  tar -czf "$filepath" "$worldpath"
done
