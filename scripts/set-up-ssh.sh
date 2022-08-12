#!/bin/bash

mkdir -p "${HOME}/.ssh"

if [[ ! -f "${HOME}/.ssh/known_hosts" ]]; then
  touch "${HOME}/.ssh/known_hosts"
fi
ssh-keyscan bitbucket.org >> "${HOME}/.ssh/known_hosts"
ssh-keyscan github.com >> "${HOME}/.ssh/known_hosts"

eval `ssh-agent`
ssh-add - <<<"$( echo "${INPUT_SSH_KEY_ENCODED}" | base64 --decode --ignore-garbage )"

ls -lah "${HOME}/.ssh"
