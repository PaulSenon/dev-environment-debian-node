COMPOSE = docker-compose -f docker-compose.yml
EXEC?= $(COMPOSE) exec devenv

install: create-dir docker-pull docker-build
dev: docker-start bash
stop: docker-stop
stop-all: docker-stop-all
clean: docker-clean
######################
# Docker management  #
######################

docker-pull: ## pull docker images
	$(COMPOSE) pull --ignore-pull-failures

docker-build: ## build images from Dockerfiles
	$(COMPOSE) build --force-rm

docker-start: ## start docker containers
	$(COMPOSE) up -d --remove-orphans

docker-start-attached: ## start docker containers
	$(COMPOSE) up --remove-orphans

docker-stop: ## stop docker containers
	$(COMPOSE) stop --timeout=0

docker-stop-all: 
	docker stop $$(docker ps -a -q --filter "name=^.*_devenv.*$$")

docker-clean: ## Clean docker container with "exited" status
	docker rm $$(docker ps -qa --no-trunc --filter "status=exited" --filter "name=^.*_devenv.*$$")

clean-all: ## Remove all unused Docker objetcs
	docker stop $$(docker ps -a -q --filter "name=^.*_devenv.*$$")
	docker system prune
	docker volume prune

bash: # open shell for ad-hock commands
	$(EXEC) /bin/zsh

create-dir: # needed to have current user rights
	mkdir -p dev