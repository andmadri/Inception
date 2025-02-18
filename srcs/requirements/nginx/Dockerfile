FROM debian:bullseye

ENV DEBIAN_FRONTED=noninteractive

RUN apt update -y \
    && apt install -y nginx \
    && apt install -y openssl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/andmadri.42.fr.key \
    -out /etc/nginx/ssl/andmadri.42.fr.crt \
    -subj "/C=FR/ST=Île-de-France/L=Paris/0=42/OU=Student/CN=andmadri.42.fr"

EXPOSE 443

ENTRYPOINT ["/usr/sbin/nginx"]

CMD ["-g", "daemon off;"]