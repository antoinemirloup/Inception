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

.PHONY: build-nginx build run clean oui

build-nginx:
	@docker build srcs/requirements/nginx -t nginx

build: build-nginx

run:
	@docker stop nginx || true
	@docker rm nginx || true
	@docker run -d --name nginx -p 8443:8443 nginx

clean:
	@echo "$(RED)Hop, ça dégage !$(DEF_COLOR)"
	@docker stop $$(docker ps -q) || true
	@docker rm $$(docker ps -a -q) || true
	@docker image prune -f

oui: clean build run

git	:
	@git add . > /dev/null 2>&1
	@@msg=$${MSG:-"$(CURRENT_DATE)"}; git commit -m "$(USER) $$msg" > /dev/null 2>&1 
	@git push > /dev/null 2>&1
	@echo "$(GREEN)(•̀ᴗ•́)و ̑̑GIT UPDATE!(•̀ᴗ•́)و ̑̑$(DEF_COLOR)"