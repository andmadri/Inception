#!/bin/bash

WP_PATH = "/var/www/html"
WP_CONFIG_PATH="$WP_PATH/wp-config.php"

#check if MariaDB is working properly here or in the healthcheckup
echo "MariaDB is up."

if [ ! -f "$WP_CONFIG_PATH" ]; then
	echo "Creating wp-config.php..."
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USR" --dbpass="$DB_USR_PWD" --dbhost"$DB_HOST":"$DB_PORT" --allow-root
fi

#if this is false it means that wordpress files exist but the database tables are not created yet
if [ ! wp core is-installed --allow-root ]; then
	echo "Installing WordPres..."
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL"
fi

#if the user exists it will print to stdout, therefore it has to go to /dev/nul;
#if the user doesn't exist it will print in stderr and I am moving it to stdou which is already null
if [ ! wp user get "$WP_USR" --allow_root > /dev/null 2>&1 ]; then
	wp user create "$WP_USR" "$WP_USR_EMAIL" --user_pass="$WP_USR_PWD"
fi

exec "$@"
