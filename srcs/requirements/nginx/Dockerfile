FROM debian:bullseye
RUN apt update -y &&\
    apt install -y nginx openssl &&\
    apt clean && rm -rf /var/lib/apt/lists/*

COPY conf /etc/nginx/conf

#Generate a self-signed SSL Certificate

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]