#!/bin/bash

# Attendre que MariaDB soit bien lancé
echo "Waiting for MariaDB to initialize..."
sleep 10

# Si wp-config.php n'existe pas, créer le fichier de configuration
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Creating wp-config.php file..."

    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    echo "wp-config.php created successfully!"
fi

# Vérifier si WordPress est déjà installé
if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    echo "Installing WordPress..."

    # Installer WordPress avec les informations de base
    wp core install --allow-root \
        --url="http://localhost" \
        --title="Mon Site" \
        --admin_user="admin" \
        --admin_password="password" \
        --admin_email="admin@example.com" \
        --path='/var/www/wordpress'

    echo "WordPress installed successfully!"

    # Créer un deuxième utilisateur WordPress
    echo "Creating second WordPress user..."
    wp user create user2 user2@example.com --role=author --user_pass=password --allow-root --path='/var/www/wordpress'
    echo "Second WordPress user created!"
else
    echo "WordPress is already installed!"
fi

# Créer le dossier /run/php s'il n'existe pas
if [ ! -d /run/php ]; then
    echo "Creating /run/php directory..."
    mkdir /run/php
fi

# Démarrer PHP-FPM
echo "Starting PHP-FPM..."
/usr/sbin/php-fpm7.3 -F
