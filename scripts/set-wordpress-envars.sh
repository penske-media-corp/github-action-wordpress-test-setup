#!/bin/bash

. pmc-functions

echo "TMPDIR=${RUNNER_TEMP}" >> $GITHUB_ENV
echo "WP_CORE_DIR=${RUNNER_TEMP}/wp/core" >> $GITHUB_ENV
echo "WP_TESTS_DIR=${RUNNER_TEMP}/wp/tests-lib" >> $GITHUB_ENV
echo "PMC_PLUGINS_DIR=${RUNNER_TEMP}/wp/core/wp-content/plugins/pmc-plugins" >> $GITHUB_ENV
echo "PMC_PHPUNIT_BOOTSTRAP=${RUNNER_TEMP}/wp/core/wp-content/plugins/pmc-plugins/pmc-unit-test/bootstrap.php" >> $GITHUB_ENV

if [[ "branch" == "${GITHUB_REF_TYPE}" && "$(pmc_get_git_default_branch)" == "${BITBUCKET_BRANCH}" ]]; then
  echo "PMC_PHPUNIT_MATCH_BRANCH=${BITBUCKET_BRANCH}" >> $GITHUB_ENV
else
  echo "PMC_PHPUNIT_MATCH_BRANCH=true" >> $GITHUB_ENV
fi
