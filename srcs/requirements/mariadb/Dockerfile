FROM debian:bullseye

RUN apt update -y \
	&& apt install -y mariadb-server mariadb-client\
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/*

COPY ./db_script.sh /usr/local/bin/db_script.sh

RUN chmod +x /usr/local/bin/db_script.sh

EXPOSE 3306

ENTRYPOINT [ "db_script.sh" ]

CMD [ "mysqld" "--bind-address=0.0.0.0" ]