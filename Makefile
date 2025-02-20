CONTAINER_IDS := $(shell docker ps -qa)
COMPOSE= ./srcs/docker-compose.yml
DOCKER_VOLUMES := $(shell docker volume ls -q)
DATA_DIR = /data/

up:
	docker-compose -f $(COMPOSE) up --build

down:
	docker-compose -f $(COMPOSE) down --remove-orphans --volumes

clean:down
	docker stop $(CONTAINER_IDS)
	docker builder prune -f && docker system prune -af
	docker volume rm $(DOCKER_VOLUMES)

.PHONY: up down