COMPOSE=docker-compose
PROJECT_NAME=inception

build:
	$(COMPOSE) build

up: build
	$(COMPOSE) up -d

down:
	$(COMPOSE) down --remove-orphans

.PHONY up build down