#!/bin/bash

set -e

CHECKOUT_DIR="/usr/local/bin/pmc"

git clone git@github.com:penske-media-corp/github-action-wordpress-test-setup.git "${CHECKOUT_DIR}"
echo "${CHECKOUT_DIR}/bin" >> $GITHUB_PATH
