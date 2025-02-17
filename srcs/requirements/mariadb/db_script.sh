#!/bin/bash

if ! mariadb -u root -p"$DB_USR_PWD" -e "USE $DB_NAME;" > /dev/null 2 >&1; then
    echo "Databse $DB_NAME does not exist, creating it..."

    echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;"
    echo "CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;"
    echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;"
fi

#why do I need to change 127.0.0.1 to 0.0.0.0?

exec "$@"
