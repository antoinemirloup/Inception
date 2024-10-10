NAME	= Inception

DEF_COLOR = \033[0;39m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m
CURRENT_DATE	:= $(shell date +"%Y-%m-%d %H:%M:%S")

.PHONY: network build-nginx build-maria build-wordpress build run clean git

all:
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

network:
	@docker network create inception
	@echo "$(MAGENTA)Network successfully created!$(DEF_COLOR)"

build-nginx:
	@docker build srcs/requirements/nginx -t nginx

build-maria:
	@docker build srcs/requirements/mariadb -t mariadb

build-wordpress:
	@docker build srcs/requirements/wordpress -t wordpress

build: network build-maria build-wordpress build-nginx 

run:
	@docker run -d --name wordpress --network inception -p 9000:9000 wordpress
	@docker run -d --name mariadb --network inception mariadb
	@docker run -d --name nginx --network inception -p 8443:8443 nginx
	docker logs nginx
	docker logs mariadb
	docker logs wordpress

clean:
	@echo "$(RED)Hop, ça dégage !$(DEF_COLOR)"
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker image prune -f

git	:
	@git add . > /dev/null 2>&1
	@@msg=$${MSG:-"$(CURRENT_DATE)"}; git commit -m "$(USER) $$msg" > /dev/null 2>&1 
	@git push > /dev/null 2>&1
	@echo "$(GREEN)(•̀ᴗ•́)و ̑̑GIT UPDATE!(•̀ᴗ•́)و ̑̑$(DEF_COLOR)"