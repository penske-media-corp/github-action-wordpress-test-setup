#!/bin/bash

set -e

CHECKOUT_DIR="/usr/local/bin/pmc"

git clone -b add/support-default-branch-not-master git@bitbucket.org:penskemediacorp/pmc-docker-common-use-shell-scripts.git "${CHECKOUT_DIR}"
echo "${CHECKOUT_DIR}/bin" >> $GITHUB_PATH
