#!/bin/bash

mkdir -p ~/.ssh
ls -lah ~/.ssh
if [[ ! -f ~/.ssh/known_hosts ]]; then
  touch ~/.ssh/known_hosts
fi
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

echo "${INPUT_SSH_KEY_ENCODED}" | base64 --decode --ignore-garbage > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
ssh-keygen -lf ~/.ssh/id_rsa
