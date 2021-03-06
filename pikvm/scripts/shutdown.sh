#!/bin/sh

ANSIBLE_DOCKER="docker run -it --rm -u "$(id -u):$(id -u)" -v /etc/passwd:/etc/passwd:ro -v "${PWD}":/ansible:ro -v "${HOME}":"${HOME}" --workdir=/ansible vwnio/ansible:latest ansible"
ANSIBLE=$(command -v ansible || echo "${ANSIBLE_DOCKER}")

if ! command -v ansible &> /dev/null
then
    echo "ansible is not installed, using docker instead"
fi

echo 'ansible pikvm --become --module-name shell --args "/usr/bin/shutdown --poweroff now" --background 60 --poll 0 --one-line'

$ANSIBLE pikvm --become --module-name shell --args "/usr/bin/shutdown --poweroff now" --background 60 --poll 0 --one-line