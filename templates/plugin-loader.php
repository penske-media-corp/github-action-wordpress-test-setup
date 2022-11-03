<?php
/**
 * Allow themes to load code as part of `mu-plugins`, such as when access to the
 * `plugins_loaded` hook is required.
 *
 * Borrows VIP Go's logic for loading `client-mu-plugins` from
 * `mu-plugins/z-client-mu-plugins.php`, which is what loads this file in the
 * first place.
 */

// Cannot use `STYLESHEETPATH` as it isn't set yet.
$theme_plugins_path = get_stylesheet_directory() . '/client-mu-plugins/';
var_export( 'LOADING PLUGINS!', false );
var_export( $theme_plugins_path, false );
var_export( is_dir( $theme_plugins_path ), false );
if ( wpcom_vip_should_load_plugins() && is_dir( $theme_plugins_path ) ) {
	foreach ( wpcom_vip_get_client_mu_plugins( $theme_plugins_path ) as $client_mu_plugin ) {
var_export( $client_mu_plugin, false );
		include_once $client_mu_plugin;
	}

	unset( $client_mu_plugin );
}

unset( $theme_plugins_path );
