#!/bin/bash

mkdir -p ~/.ssh
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
echo "${INPUT_SSH_KEY_ENCODED}" | base64 --decode --ignore-garbage > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
ssh-keygen -lf ~/.ssh/id_rsa
