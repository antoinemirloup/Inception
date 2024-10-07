FROM debian:bullseye

RUN apt update
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
COPY conf/create_database.sh /docker-entrypoint-initdb.d/create_database.sh
RUN chmod +x /docker-entrypoint-initdb.d/create_database.sh
# RUN ./docker-entrypoint-initdb.d/create_database.sh

CMD ["mysqld"]