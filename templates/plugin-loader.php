<?php
/**
 * Allow themes to load code as part of `mu-plugins`, such as when access to the
 * `plugins_loaded` hook is required.
 *
 * Borrows VIP Go's logic for loading `client-mu-plugins` from
 * `mu-plugins/z-client-mu-plugins.php`, which is what loads this file in the
 * first place.
 */

add_action(
	'muplugins_loaded',
	static function(): void {
		// Bail during the PHPUnit install step as it happens before the bootstrap sets necessary constants.
		if ( ! class_exists( PMC\Unit_Test\Bootstrap::class, false ) ) {
			return;
		}

		if ( ! wpcom_vip_should_load_plugins() ) {
			return;
		}

		$theme_plugins_paths = [];

		if ( ! getenv( 'PMC_IS_PMC_PLUGINS' ) ) {
			$test = sprintf(
				'%1$s/wp-content/themes/%2$spmc-core-v2/client-mu-plugins/',
				getenv( 'WP_CORE_DIR' ),
				'true' === getenv( 'VIP_THEME' ) ? 'vip/' : '',
			);
var_export( $test );
		}
var_export( get_stylesheet_directory() );

		$theme_plugins_paths[] = getenv( 'GITHUB_WORKSPACE' ) . '/client-mu-plugins/';

		$theme_plugins_paths = array_unique( $theme_plugins_paths );
var_export( $theme_plugins_paths );
		foreach ( $theme_plugins_paths as $theme_plugins_path ) {
			if ( is_dir( $theme_plugins_path ) ) {
				foreach ( wpcom_vip_get_client_mu_plugins( $theme_plugins_path ) as $client_mu_plugin ) {
					include_once $client_mu_plugin;
				}

				unset( $client_mu_plugin );
			}
		}
	}
);
