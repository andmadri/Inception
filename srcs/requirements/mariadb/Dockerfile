FROM debian:bullseye

RUN apt update -y \
	&& apt install -y mariadb-server mariadb-client\
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./db_script.sh /usr/local/bin/db_script.sh

RUN chmod +x /usr/local/bin/db_script.sh

EXPOSE 3306

ENTRYPOINT [ "db_script.sh" ]

CMD [ "mysqld" ]