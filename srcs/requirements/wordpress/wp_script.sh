#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Downloading Wordpress..."
	wp core download --path="/var/www/html/" --allow-root
	echo "Wordpress is Downloaded..."
	echo "Creating wp-config.php..."
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USR" --dbpass="$DB_USR_PWD" --dbhost="$DB_HOST":"$DB_PORT" --allow-root
fi

#when I use wget wordpress.com... I am only installing the files
#therefore I use core install to create a database
#configure the site title and so on
#if this is false it means that wordpress files exist but the database tables are not created yet
#WP-CLI discourages running commands as root therefore cause the container is root
#We use --allow-root to run it
if ! wp core is-installed --allow-root; then
	echo "Installing WordPress..."
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL"
fi

if ! php -v; then
	echo "php is not installed properly..."
fi

#if the user exists it will print to stdout, therefore it has to go to /dev/nul;
#if the user doesn't exist it will print in stderr and I am moving it to stdou which is already null
if ! wp user get "$WP_USR" --allow_root > /dev/null 2>&1; then
	wp user create "$WP_USR" "$WP_USR_EMAIL" --user_pass="$WP_USR_PWD"
fi

exec "$@"
