COMPOSE= ./srcs/docker-compose.yml
DATA_DIR = /data/

up:
	docker-compose -f $(COMPOSE) up --build

down:
	docker-compose -f $(COMPOSE) down --remove-orphans --volumes

.PHONY: up down