#!/bin/bash
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod -R 755 /var/run/mysqld

service mariadb start
sleep 4
mysql << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME ;
CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' ;
FLUSH PRIVILEGES;
EOF

service mariadb stop

exec "$@"
