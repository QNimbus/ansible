#!/bin/sh

if [ -z ${1} ]
then
  echo "Usage:"
  echo "${0} <hostname>"
  exit 1
fi

echo ${1} | printf "%s\n%s" "$(cat -)" "$(getent hosts ${1} | awk '{ print $1 }')" | xargs -n1 -r ssh-keyscan -H -t rsa,ed25519 2> /dev/null