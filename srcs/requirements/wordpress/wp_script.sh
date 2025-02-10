#!/bin/bash

WP_CONFIG_PATH="/var/www/html/wp-config.php"

#We need to make sure that MariaDB is fully initialized
#Before we start Wordpress
#Although at docker-compose.yml level it says it depends on:, it might not be fully initialized


if [ ! -f "$WP_CONFIG_PATH" ]; then
	echo "Creating wp-config.php..."
	cp /var/www/html/wp-config-sample.php "$WP_CONFIG_PATH"



exec "$@"