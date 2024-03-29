#!/bin/sh

ip=213.239.221.8
user=root

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -

ssh $user@$ip <<EOF
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo docker network create traefiknet
EOF

ssh-add -d "../ssh-keys/selfhosted.pub"
