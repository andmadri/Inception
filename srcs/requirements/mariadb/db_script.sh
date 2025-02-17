#!/bin/bash

if [! 'find /var/lib/mysql -name $DATABASE_NAME' ]; then
    service mariadb start
    echo "Databse $DB_NAME does not exist, creating it..."

    mysql << EOF
    CREATE DATABASE IF NOT EXISTS $DB_NAME ;
    CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' IDENTIFIED BY '$DB_USR_PWD' ;
EOF

    service mariadb stop
else
    echo "Database $DB_NAME already exists..."
fi

exec "$@"
