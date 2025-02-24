#!/bin/bash

wait_for_mariadb() {
    while ! nc -z mariadb $DB_PORT; do
        echo "Waiting for MariaDB to be ready..."
        sleep 5
    done
    echo "MariaDB is ready!"
}

wait_for_mariadb

if [ ! -f "/var/www/html/wp-load.php" ]; then
	echo "Downloading Wordpress..."
	wp-cli.phar core download --path="/var/www/html/" --allow-root
	echo "Wordpress is Downloaded..."
	echo "Creating wp-config.php..."
	wp-cli.phar config create --path="/var/www/html/" --dbname="$DB_NAME" --dbuser="$DB_USR" --dbpass="$DB_USR_PWD" --dbhost="$DB_HOST" --allow-root
else
	echo "Wordpress is already downloaded..."
fi

if ! wp-cli.phar core is-installed --path="/var/www/html/" --allow-root; then
	echo "Installing Wordpress..."
	wp-cli.phar core install --path="/var/www/html/" --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
fi

if ! wp-cli.phar user get "$WP_USR" --path="/var/www/html/" --allow-root > /dev/null 2>&1; then
	echo "Creating $WP_USR user ..."
	wp-cli.phar user create "$WP_USR" "$WP_USR_EMAIL" --path="/var/www/html/" --user_pass="$WP_USR_PWD" --allow-root
fi

echo "Executing WordPress..."
exec "$@"
