COMPOSE=./src/docker-compose.yml

up:
	docker-compose -f $(COMPOSE) up --build

down:
	docker-compose -f $(COMPOSE) down --remove-orphans

.PHONY up down