#!/bin/bash

# TODO

# all volumes
# pgadmin servers
# pg databases


# This script allows you to backup a single volume from a container
# Data in given volume is saved in the current directory in a tar archive.

CONTAINER_NAME=$1
VOLUME_PATH=$2

usage() {
  echo "Usage: $0 [container name] [volume path]"
  exit 1
}

if [ -z "$CONTAINER_NAME" ]
then
  echo "Error: missing container name parameter."
  usage
fi

if [ -z "$VOLUME_PATH" ]
then
  echo "Error: missing volume path parameter."
  usage
fi

sudo docker run --rm --volumes-from "$CONTAINER_NAME" -v "$PWD":/backup busybox tar cvf /backup/backup.tar "$VOLUME_PATH"
