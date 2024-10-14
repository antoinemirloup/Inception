#!/bin/bash

WP_PATH='/var/www/wordpress'

# if ! $(wp core is-installed --allow-root --path=$WP_PATH); then
#     # wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root --path=$WP_PATH

#     wp core install --url="https://amirloup.42.fr:8443" --title="Inception Project" --admin_user="admin" --admin_password="adminpassword" --admin_email="admin@42.fr" --allow-root --path=$WP_PATH

#     wp user create editor editor@example.com --role=editor --user_pass=editorpassword --allow-root --path=$WP_PATH
# fi

# php-fpm7.4 -F

cd /usr/local/bin
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
./wp-cli.phar core download --allow-root --path=$WP_PATH
./wp-cli.phar config create --dbname=DB_DATABASE --dbuser=DB_USER --dbpass=DB_PASSWORD --dbhost=DB_HOST --allow-root
./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root --path=$WP_PATH

php-fpm7.4 -F