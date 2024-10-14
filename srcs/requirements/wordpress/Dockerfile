FROM debian:bullseye

RUN apt update
RUN apt upgrade -y
RUN apt-get -y install wget
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.6-fr_FR.tar.gz && rm wordpress-6.6-fr_FR.tar.gz
RUN	chown -R www-data:www-data /var/www/wordpress
RUN mkdir -p /run/php
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/wp-config.php /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
WORKDIR /var/www/wordpress
EXPOSE 9000

CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh && php-fpm7.4 -F"]
# CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh", "php-fpm7.4", "-F"]