#!/bin/bash

# #Démarrer le serveur MariaDB
# /etc/init.d/mariadb start

# #Attendre que le serveur soit prêt
# for i in {1..30}; do
#     if mysqladmin ping --silent; then
#         break
#     fi
#     echo "En attente que le serveur MariaDB soit prêt..."
#     sleep 1
# done

# #Vérifier si le serveur est opérationnel après 30 secondes
# if ! mysqladmin ping --silent; then
#     echo "Erreur : Le serveur MariaDB n'est pas opérationnel."
#     exit 1
# fi

# #Créer la base de données
# # mysql --socket=/run/mysqld/mysqld.sock -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
# mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"

# #Créer l'utilisateur root si il n'existe pas
# if ! mysql -e "SELECT User FROM mysql.user WHERE User='root';"; then
#     mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
#     mysql -e "GRANT ALL PRIVILEGES ON . TO 'root'@'%' WITH GRANT OPTION;"
#     mysql -e "FLUSH PRIVILEGES;"
# fi

# #Créer l'utilisateur
# mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"

# #Accorder les privilèges
# mysql -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"

# #Actualiser les privilèges
# mysql -e "FLUSH PRIVILEGES;"

# #Arrêter le serveur
# mysqladmin -u root shutdown

# #Lancer mysqld_safe pour garder le conteneur actif
# exec mysqld_safe


/etc/init.d/mariadb start

mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS ${DB_USER}@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO ${DB_USER}@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown
exec mysqld_safe