#!/bin/sh

ip=23.88.98.91
user=root

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -

ssh $user@$ip

ssh-add -d "../ssh-keys/selfhosted.pub"