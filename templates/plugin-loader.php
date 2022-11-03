<?php
/**
 * Allow themes to load code as part of `mu-plugins`, such as when access to the
 * `plugins_loaded` hook is required.
 *
 * Borrows VIP Go's logic for loading `client-mu-plugins` from
 * `mu-plugins/z-client-mu-plugins.php`, which is what loads this file in the
 * first place.
 */

add_action( 'muplugins_loaded', function() {
	var_export( 'LOADING PLUGINS!', false );
	var_export( PMC_IS_VIP_GO_SITE, false );
var_export( has_action( 'muplugins_loaded', [ PMC\Unit_Test\Bootstrap::get_instance(), 'muplugins_loaded_early_bind' ] ), false );
	$theme_plugins_path = getenv( 'GITHUB_WORKSPACE' ) . '/client-mu-plugins/';

	if ( wpcom_vip_should_load_plugins() && is_dir( $theme_plugins_path ) ) {
		foreach ( wpcom_vip_get_client_mu_plugins( $theme_plugins_path ) as $client_mu_plugin ) {
			include_once $client_mu_plugin;
		}

		unset( $client_mu_plugin );
	}

	unset( $theme_plugins_path );
}, 999999 );
