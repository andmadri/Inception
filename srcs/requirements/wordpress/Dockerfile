FROM debian:bullseye

ENV DEBIAN_FRONTED=noninteractive

RUN apt update -y && apt install -y \
		php-fpm \
		php-mysql \
		php-zip \
		unzip \
		curl \
		&& apt clean \
		&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

RUN curl -LO https://wordpress.org/latest.zip

RUN unzip latest.zip -d /var/www/ \
		&& mv /var/www/wordpress/* /var/www/html \
		&& rm -rf /var/www/wordpress latest.zip

CMD [ "executable" ]