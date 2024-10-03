#!/usr/bin/env bash
# script to quicly pull up the logs of the minecraft servers

SESH="proxmox"
containervm="container-vm"

function open_logs() {
  tmux move-window -s "$SESH":mc-logs -t "$SESH":99
  tmux split-window -h -t "$SESH":mc-logs
  tmux send-keys -t "$SESH":mc-logs.0 "ssh ${containervm}" C-m
  tmux send-keys -t "$SESH":mc-logs.0 "docker container logs minecraft-tekkit-1 -f" C-m
  tmux send-keys -t "$SESH":mc-logs.1 "ssh ${containervm}" C-m
  tmux send-keys -t "$SESH":mc-logs.1 "docker container logs minecraft-nexus-1 -f" C-m
}

tmux has-session -t "$SESH" 2>/dev/null

if [ "$?" != 0 ]; then
  # session doesn't exist
  tmux new-session -d -s "$SESH" -n "mc-logs"
  open_logs
else
  # session exists
  tmux list-windows -t "$SESH" | grep -q mc-logs
  if [ $? != 0 ]; then
    # session exists, but doesn't have mc-logs window
    tmux new-window -n "mc-logs"
    open_logs
  else
    # session exists and has mc-logs window
    tmux select-window -t "$SESH":mc-logs
  fi
fi

# switch session if in session, else attach
if [ -n "$TMUX" ]; then
  tmux switch-client -t "$SESH"
else
  tmux attach-session -t "$SESH"
fi
