#!/usr/bin/env bash
# script to sync mc docker file and tools
# NOTE: should be run from git repo root

scp container-vm:/home/cwatson/minecraft/docker-compose.yml ./minecraft-server/docker-compose.yml
scp -r container-vm:/home/cwatson/minecraft/scripts ./minecraft-server/scripts
