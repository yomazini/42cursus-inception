#!/bin/bash
set -e

if [ ! -f /etc/.flag_true ]; then

  export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
  export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld

  mariadbd -u mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

  touch /etc/.flag_true
fi

exec mariadbd -u mysql
