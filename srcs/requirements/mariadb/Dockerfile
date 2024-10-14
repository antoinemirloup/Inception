FROM debian:bullseye

RUN apt update
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/my.cnf /etc/mysql/my.cnf
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld && chmod 777 /var/run/mysqld
RUN chown mysql:mysql /var/lib/mysql && chmod -R 777 /var/lib/mysql
COPY conf/create_database.sh /etc/create_database.sh
RUN chmod +x /etc/create_database.sh

EXPOSE 3306

CMD ["sh", "/etc/create_database.sh"]