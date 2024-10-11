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

.PHONY: clean clean-v git

all:
	@if ! grep -q "127.0.0.1 amirloup.42.fr" /etc/hosts; then \
		echo >> /etc/hosts "127.0.0.1 amirloup.42.fr"; \
	fi
	
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

clean:
	@echo "$(RED)Hop, ça dégage !$(DEF_COLOR)"
	@docker-compose -f ./srcs/docker-compose.yml down
	@docker image prune -f

clean-v:
	@echo "$(RED)Hop, ça dégage !$(DEF_COLOR)"
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker image prune -f

git	:
	@git add . > /dev/null 2>&1
	@@msg=$${MSG:-"$(CURRENT_DATE)"}; git commit -m "$(USER) $$msg" > /dev/null 2>&1 
	@git push > /dev/null 2>&1
	@echo "$(GREEN)(•̀ᴗ•́)و ̑̑GIT UPDATE!(•̀ᴗ•́)و ̑̑$(DEF_COLOR)"