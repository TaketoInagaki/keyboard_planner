.PHONY: help build build-local up down logs ps test
.DEFAULT_GOAL := help

DOCKER_TAG := latest
build: ## Build docker image to deploy
	docker build -t TaketoInagaki/keyboard_planner:${DOCKER_TAG} \
		--target deploy ./

build-local: ## Build docker image to local development
	docker compose build --no-cache

up: ## Do docker compose up with hot reload
	docker compose up planner-db -d
	docker compose up planner-redis -d
	docker compose up app -d

run: ## Do docker compose run --rm app /bin/bash
	docker compose run --rm app /bin/bash

down: ## Do docker compose down
	docker compose down

down-v: ## Do docker compose down
	docker compose down -v

logs: ## Tail docker compose logs
	docker compose logs -f

ps: ## Check container status
	docker compose ps

test: ## Execute tests
	go test -race -shuffle=on ./...

dry-migrate: ## Try migration
	mysqldef -u planner -p planner -h 127.0.0.1 -P 36306 planner --dry-run < ./_tools/mysql/schema.sql

migrate:  ## Execute migration
	mysqldef -u planner -p planner -h 127.0.0.1 -P 36306 planner < ./_tools/mysql/schema.sql

generate: ## Generate codes
	go generate ./...

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
