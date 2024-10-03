#!/usr/bin/env bash
# script to create tmux env for log checking

SESH="proxmox"

tmux has-session -t "$SESH" 2>/dev/null

if [ "$?" != 0 ]; then
  # session doesn't exist
  ./minecraft-server/check-logs.sh
  # add more logs scripts here for other services
else
  # session exists
  # attempt to switch clients, if fails attach
  tmux switch-client -t "$SESH" || tmux attach-session -t "$SESH"
fi
