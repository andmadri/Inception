FROM debian:bullseye

ENV DEBIAN_FRONTED=noninteractive

RUN apt update -y && apt install -y \
		php8.1-fpm \
		php-mysql \
		php-zip \
		unzip \
		curl \
		&& apt clean \
		&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && curl -LO https://wordpress.org/latest.zip
RUN unzip latest.zip -d /var/www/ \
		&& mv /var/www/wordpress/* /var/www/html/ \
		&& rm -rf /var/www/wordpress latest.zip

COPY wp_script.sh /usr/local/bin/wp_script.sh
RUN chmod +x /usr/local/bin/wp_script.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT [ "wp_script.sh" ]

CMD [ "php8.1-fpm", "-F" ]
