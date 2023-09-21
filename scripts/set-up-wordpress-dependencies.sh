#!/bin/bash

. pmc-test-functions

WEB_ROOT="${WP_CORE_DIR}"
WP_CONTENT_TARGET_DIR="${WP_CORE_DIR}/wp-content"

# Modify `wp-tests-config.php`.
WP_CONFIG_PATH="${WP_TESTS_DIR}/wp-tests-config.php"

if [[ ! -n "$(grep '000-pre-vip-config/requires.php' "${WP_CONFIG_PATH}")" ]]; then
  VIP_GO_REQUIRES_ADDITION="// Load VIP's additional requirements.
if ( file_exists( ABSPATH . '/wp-content/mu-plugins/000-pre-vip-config/requires.php' ) ) {
  require_once ABSPATH . '/wp-content/mu-plugins/000-pre-vip-config/requires.php';
}
"
  echo "${VIP_GO_REQUIRES_ADDITION}" >> "${WP_CONFIG_PATH}"
fi

# Install client-mu-plugins.
if [[ ! -d "${WP_CONTENT_TARGET_DIR}/client-mu-plugins" ]]; then
  mkdir "${WP_CONTENT_TARGET_DIR}/client-mu-plugins"
fi
mv "${RUNNER_TEMP}/plugin-loader.php" "${WP_CONTENT_TARGET_DIR}/client-mu-plugins/plugin-loader.php"

# Install VIP Go's mu-plugins.
git_checkout "${WP_CONTENT_TARGET_DIR}/mu-plugins" https://github.com/Automattic/vip-go-mu-plugins-built.git 1

# Install memcached drop-in.

  ln -s "${WP_CONTENT_TARGET_DIR}/mu-plugins/drop-ins/object-cache.php" "${WP_CONTENT_TARGET_DIR}/object-cache.php"
echo "We are loading the new object-cache"


# Install pmc-vip-go-plugins.
if [[ -f "${WP_CONTENT_TARGET_DIR}/plugins/README.md" ]]; then
  rm -rf "${WP_CONTENT_TARGET_DIR}/plugins"
fi

git_checkout "${WP_CONTENT_TARGET_DIR}/plugins" git@github.com:penske-media-corp/pmc-vip-go-plugins.git 1

# Install pmc-plugins and parent theme.
if [[ -z "${PMC_IS_PMC_PLUGINS}" ]]; then
  WP_THEME_FOLDER="${WP_CONTENT_TARGET_DIR}/themes"

  if [[ "${VIP_THEME}" == true ]]; then
    mkdir "${WP_THEME_FOLDER}/vip"
  fi

  checkout_dependencies .

  if [[ "${VIP_THEME}" == true ]]; then
    echo "vip theme is set to true"
    ln -s "${GITHUB_WORKSPACE}" "${WP_THEME_FOLDER}/vip/${REPO_SLUG}"
  else
    echo "vip theme is set to false"
    ln -s "${GITHUB_WORKSPACE}" "${WP_THEME_FOLDER}/${REPO_SLUG}"
  fi
else
  rm -rf "${PMC_PLUGINS_DIR}"
  ln -s "${GITHUB_WORKSPACE}" "${PMC_PLUGINS_DIR}"
fi

maybe_switch_branch_for_testing_theme . "${BITBUCKET_BRANCH}"
