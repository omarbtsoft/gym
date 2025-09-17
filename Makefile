ifneq (,$(wildcard ./backend/.env))
    include ./backend/.env
    export
endif

# =======================
# VARIABLES
# =======================
FRONT_REPO = git@github.com:omarbtsoft/gym-fe.git
BACK_REPO  = git@github.com:omarbtsoft/gym-be.git

FRONT_DIR = ./frontend
BACK_DIR  = ./backend
DOCKER_COMPOSE = docker compose -f docker-compose.yml

GYM_BE= docker exec -it gym-be1
GYM_FE_DEV = docker exec -it fe-dev
create-env:
	cp -n $(BACK_DIR)/.env.example $(BACK_DIR)/.env || true

# =======================
# GIT
# =======================
clone-frontend:
	rm -rf $(FRONT_DIR)
	mkdir -p $(FRONT_DIR)
	git clone --branch main $(FRONT_REPO) $(FRONT_DIR)

clone-backend:
	rm -rf $(BACK_DIR)
	mkdir -p $(BACK_DIR)
	git clone --branch main $(BACK_REPO) $(BACK_DIR)

clone-all: clone-frontend clone-backend

# =======================
# DOCKER
# =======================
build:
	rm -fR $(BACK_DIR)/vendor/*
	rm -fR $(FRONT_DIR)/node_modules/*
	$(DOCKER_COMPOSE) build

build-no-cache:
	$(DOCKER_COMPOSE) build --no-cache

up: create-env
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart: down up

logs:
	$(DOCKER_COMPOSE) logs -f

ps:
	$(DOCKER_COMPOSE) ps

# =======================
# BACKEND (Laravel)
# =======================
composer-install:
	docker exec gym-be1 git config --global --add safe.directory /var/www
	docker exec gym-be1 composer install

bash: 
	${GYM_BE} bash

migrate:
	${GYM_BE} php artisan migrate

seed:
	${GYM_BE} php artisan db:seed

artisan-%:
	${GYM_BE} php artisan $*

# =======================
# FRONTEND (React/Vite)
# =======================
npm-install:
	docker exec -it fe-dev npm install

npm-build:
	docker exec -it fe-dev rm -rf dist
	docker exec -it fe-dev npm run build
# =======================
# UTILITIES
# =======================
clean:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	docker system prune -f
