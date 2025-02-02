FROM debian:bullseye

RUN apt update -y \
    && apt install -y nginx \
    && apt install -y openssl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout:/etc/nginx/ssl/nginx-private.key \
    -out /etc/nginx/ssl/nginx-certificate.crt
#apt clean removes the installer files wich are downloaded to install the packages
#rm -rf /var/lib/apt/lists/* removes the catalogue of packages available

WORKDIR /srcs/requirements/nginx

COPY conf /etc/nginx/conf

#Generate a self-signed SSL Certificate

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]