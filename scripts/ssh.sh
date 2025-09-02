#!/bin/sh

ip=63.176.177.19
user=admin

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -

ssh $user@$ip

ssh-add -d "../ssh-keys/selfhosted.pub"
