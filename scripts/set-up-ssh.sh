#!/bin/bash

set -e

mkdir -p "${HOME}/.ssh"

if [[ ! -f "${HOME}/.ssh/known_hosts" ]]; then
  touch "${HOME}/.ssh/known_hosts"
fi
ssh-keyscan bitbucket.org >> "${HOME}/.ssh/known_hosts"
ssh-keyscan github.com >> "${HOME}/.ssh/known_hosts"

eval `ssh-agent`
ssh-add - <<<"$(echo "${BITBUCKET_READ_ONLY_SSH_KEY}")"
ssh-add - <<<"$(echo "${GITHUB_READ_ONLY_SSH_KEY}")"

ssh-add -l

echo "BITBUCKET_READ_ONLY_SSH_KEY=''" >> $GITHUB_ENV
echo "GITHUB_READ_ONLY_SSH_KEY=''" >> $GITHUB_ENV
echo "SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> $GITHUB_ENV
echo "SSH_AGENT_PID=${SSH_AGENT_PID}" >> $GITHUB_ENV
