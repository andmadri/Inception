#!/bin/bash

wait_for_maridab() {
    while ! nc -z mariadb $DB_PORT; does
        echo "Waiting for MariaDB to be ready..."
        sleep 5
    done
    echo "MariaDB is ready!"
}

wait_for_maridab

if [ ! -f "/var/www/html/wp-load.php" ]; then
	echo "Downloading Wordpress..."
	wp core download --path="/var/www/html/" --allow-root
	echo "Wordpress is Downloaded..."
else
	echo "Wordpress is already downloaded..."
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Creating wp-config.php..."
	wp config create --path="/var/www/html/" --dbname="$DB_NAME" --dbuser="$DB_USR" --dbpass="$DB_USR_PWD" --dbhost="$DB_HOST":"$DB_PORT" --allow-root
	echo "Created wp-config.php..."
fi

if ! wp core is-installed --path="/var/www/html/" --allow-root; then
	echo "Installing Wordpress..."
	wp core install --path="/var/www/html/" --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
fi

if ! wp user get "$WP_USR" --path="/var/www/html/" --allow-root; then
	echo "Creating $WP_USR user ..."
	wp user create "$WP_USR" "$WP_USR_EMAIL" --path="/var/www/html/" --user_pass="$WP_USR_PWD" --allow-root
fi

exec "$@"
