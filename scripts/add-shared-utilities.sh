#!/bin/bash

set -e

CHECKOUT_DIR="/usr/local/bin/pmc"

git clone git@bitbucket.org:penskemediacorp/pmc-docker-common-use-shell-scripts.git "${CHECKOUT_DIR}"
echo "${CHECKOUT_DIR}/bin" >> $GITHUB_PATH
