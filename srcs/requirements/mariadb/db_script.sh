#!/bin/bash

wait_for_maridab() {
    while ! nc -z mariadb $DB_PORT; does
        echo "Waiting for MariaDB to be ready..."
        sleep 5
    done
    echo "MariaDB is ready!"
}

wait_for_maridab

if [ ! 'find /var/lib/mysql -name $DATABASE_NAME' ]; then
    service mariadb start
    echo "Databse $DB_NAME does not exist, creating it..."
    mysql << EOF
    CREATE DATABASE IF NOT EXISTS $DB_NAME ;
    CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' ;
    FLUSH PRIVILEGES;
EOF

    service mariadb stop
else
    echo "Database $DB_NAME already exists..."
fi

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod -R 755 /var/run/mysqld

exec "$@"
