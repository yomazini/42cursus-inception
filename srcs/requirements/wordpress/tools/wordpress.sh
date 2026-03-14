#!/bin/bash
set -e

if [ ! -f /etc/.flag_true ]; then
  sed -i 's|listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
  touch /etc/.flag_true
fi

if [ ! -f /var/www/html/wp-config.php ]; then

  export WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
  export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
  export WORDPRESS_PASSWORD=$(cat /run/secrets/wp_password)

  wp core download --allow-root

  echo "Waiting for MariaDb ; "
  sleep 10

  wp config create --allow-root \
    --dbhost=mariadb \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbname="$MYSQL_DATABASE"

  wp core install --allow-root \
    --skip-email \
    --url="$DOMAIN_NAME" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL"

  wp config set WP_REDIS_HOST redis --allow-root
  wp config set WP_REDIS_PORT 6379 --raw --allow-root
  wp config set WP_CACHE true --raw --allow-root

  sed -i "40i define( 'WP_REDIS_HOST', 'redis' );\ndefine( 'WP_REDIS_PORT', 6379 );\ndefine( 'WP_CACHE', true );" /var/www/html/wp-config.php

  wp plugin install redis-cache --activate --allow-root
  chown -R www-data:www-data /var/www/html/wp-content
  wp redis enable --allow-root

  wp user create --allow-root \
    "$WORDPRESS_USER" "$WORDPRESS_EMAIL" \
    --user_pass="$WORDPRESS_PASSWORD" \
    --role=author

  chown -R www-data:www-data /var/www/html
  chmod -R 755 /var/www/html

fi

mkdir -p /run/php

exec php-fpm8.2 -F
