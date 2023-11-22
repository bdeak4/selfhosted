#!/bin/sh

ip=23.88.98.91
user=root

service=$1

if [ -z "$service" ]; then
  echo "Usage: $0 <service>"
  exit 1
fi

cd -P -- "$(dirname -- "$(realpath -- "$0")")" || exit
sops -d "../ssh-keys/selfhosted.enc" | ssh-add -
find "../services/$1" -name "*.enc.*" -exec sops -d -i {} \;

rsync -av --progress "../services/$1" $user@$ip:services/

ssh $user@$ip <<EOF
cd services/$1 \
&& docker compose pull \
&& docker compose up -d \
&& docker system prune -af \
&& if [ -e ./postup.sh ]; then
     echo "Running postup.sh"
     ./postup.sh
   fi
EOF


find "../services/$1" -name "*.enc.*" -exec sops -e -i {} \;
ssh-add -d "../ssh-keys/selfhosted.pub"