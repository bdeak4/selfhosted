#!/bin/sh

ip=213.239.221.8
user=root

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -

ssh $user@$ip

ssh-add -d "../ssh-keys/selfhosted.pub"
