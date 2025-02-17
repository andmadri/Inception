COMPOSE= ./srcs/docker-compose.yml
DATA_DIR = /data/

up:
	mkdir -p ./srcs/data/wp ./srcs/data/db
	docker-compose -f $(COMPOSE) up --build

down:
	docker-compose -f $(COMPOSE) down --remove-orphans --volumes

clean:
	rm -rf ./srcs/data/wp ./srcs/data/db

.PHONY: up down