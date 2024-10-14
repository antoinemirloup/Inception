#!/bin/bash

chown -R www-data:www-data /var/www/wordpress

#Attendre que MariaDB soit prêt
until mysqladmin ping -h mariadb --silent; do
    echo "En attente de MariaDB..."
    sleep 5
done

sleep 2

#Vérifier si WordPress est déjà installé
if ! $(wp core is-installed --allow-root); then
    # Télécharger WordPress si nécessaire
    if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    fi

    # Créer le fichier wp-config.php
    if [ ! -f wp-config.php ]; then
        wp config create --dbname=${DB_DATABASE} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=mariadb --allow-root
    fi
    # Installer WordPress
    wp core install --url="https://localhost:8443/" \
                    --title="" \
                    --admin_user="antoine" \
                    --admin_password="password" \
                    --admin_email="email@example.com" \
                    --skip-email \
                    --allow-root

    # Configurer des options supplémentaires si besoin
    wp user create basile basile@basile.fr --role=author --user_pass=basile --allow-root
else
    echo "WordPress est déjà installé."
fi