DOCKER_COMPOSE  = docker-compose

EXEC_PHP        = $(DOCKER_COMPOSE) exec php
EXEC_DB         = $(DOCKER_COMPOSE) exec db

SYMFONY         = $(EXEC_PHP) bin/console
COMPOSER        = $(EXEC_PHP) composer

##
## Project
## -------
##

.DEFAULT_GOAL := help
help: ## Show this help message
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help

install: ## [build start vendor db] - Install and start the project
install: build start vendor db
.PHONY: install

build: ## Build the Docker images
	$(DOCKER_COMPOSE) build --force-rm --compress
.PHONY: build

start: ## Start all containers
	$(DOCKER_COMPOSE) up -d --remove-orphans
.PHONY: start

stop: ## Stop running containers
	$(DOCKER_COMPOSE) stop
.PHONY: stop

cc: ## Clear and warmup PHP cache
	$(SYMFONY) cache:clear --no-warmup
	$(SYMFONY) cache:warmup
.PHONY: cc

vendor: ## Install PHP vendors
	$(COMPOSER) install
.PHONY: vendor

db: ## Reset the database
	@echo "Waiting for database..."
	@while ! $(EXEC_DB) mysql -uroot -proot -e "SELECT 1;" > /dev/null 2>&1; do sleep 0.5 ; done
	-$(SYMFONY) doctrine:database:drop --if-exists --force
	-$(SYMFONY) doctrine:database:create --if-not-exists
	-$(SYMFONY) doctrine:schema:create
.PHONY: db
