#!/bin/sh

ip=63.176.177.19
user=admin

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -

ssh $user@$ip <<EOF
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo docker network create traefiknet
sudo apt-get install -y rsync
EOF

ssh-add -d "../ssh-keys/selfhosted.pub"
