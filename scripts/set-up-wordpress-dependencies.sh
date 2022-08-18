#!/bin/bash

. pipeline-functions

WEB_ROOT="${WP_CORE_DIR}"
WP_CONTENT_TARGET_DIR="${WP_CORE_DIR}/wp-content"

# Install client-mu-plugins.
if [[ ! -d "${WP_CONTENT_TARGET_DIR}/client-mu-plugins" ]]; then
  mkdir "${WP_CONTENT_TARGET_DIR}/client-mu-plugins"
fi
mv "${RUNNER_TEMP}/plugin-loader.php" "${WP_CONTENT_TARGET_DIR}/client-mu-plugins/plugin-loader.php"

# Install VIP Go's mu-plugins.
git_checkout "${WP_CONTENT_TARGET_DIR}/mu-plugins" https://github.com/Automattic/vip-go-mu-plugins-built.git 1

# Install pmc-vip-go-plugins.
if [[ -f "${WP_CONTENT_TARGET_DIR}/plugins/README.md" ]]; then
  rm -rf "${WP_CONTENT_TARGET_DIR}/plugins"
fi

git_checkout "${WP_CONTENT_TARGET_DIR}/plugins" git@bitbucket.org:penskemediacorp/pmc-vip-go-plugins.git 1

# Install pmc-plugins and parent theme.
if [[ -z "${PMC_IS_PMC_PLUGINS}" ]]; then
  WP_THEME_FOLDER="${WP_CONTENT_TARGET_DIR}/themes"
  checkout_dependencies .
else
  rm -rf "${PMC_PLUGINS_DIR}"
  ln -s "$GITHUB_WORKSPACE" "${PMC_PLUGINS_DIR}"
fi

maybe_switch_branch_for_testing_theme . "${BITBUCKET_BRANCH}"
