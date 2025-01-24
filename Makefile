NAME		= Inception
SRCS		= ./srcs
DC_FILE		= $(SRCS)/docker-compose.yml
HOST	= claferna.42.fr

all: up

up:
	@sudo sh -c 'echo "127.0.0.1	claferna.42.fr"' >> /etc/hosts
	@mkdir -p /home/claferna/data
	@mkdir -p /home/claferna/data/database
	@mkdir -p /home/claferna/data/wordpress
	@docker-compose -p $(NAME) -f $(DC_FILE) up --build
	@echo " $(TICK) $(NAME)	$(GREEN)Executed$(RESET)"

down:
	@docker-compose -p $(NAME) -f $(DC_FILE) down
	@echo " $(TICK) $(NAME)	$(RED)Stopped$(RESET)"	

backup:
	@if [ -d ~/data ]; then sudo tar -czvf ~/data.tar.gz -C ~/ data/ > $(HIDE) && echo " $(BKP)" ; fi

clean:
	@docker-compose -p $(NAME) -f $(DC_FILE) down

fclean: clean 
	@docker-compose -p $(NAME) -f $(DC_FILE) down
	@sudo rm -rf /home/claferna/data
	@sudo sed -i '/claferna.42.fr/d' /etc/hosts
	@sudo docker volume ls -q | xargs -r sudo docker volume rm
	@sudo docker image ls -q  | xargs -r sudo docker image rmi -f

status:
	@clear
	@echo "\nCONTAINERS\n"
	@docker ps -a
	@echo "\nIMAGES\n"
	@docker image ls
	@echo "\nVOLUMES\n"
	@docker volume ls
	@echo "\nNETWORKS\n"
	@docker network ls --filter "name=inception_all"
	@echo ""

re: fclean all

HIDE		= /dev/null 2>&1
RED			= \033[0;31m
GREEN		= \033[0;32m
RESET		= \033[0m
TICK		= $(GREEN)✔$(RESET)
REMOVED		= $(GREEN)Removed$(RESET)
BKP			= $(TICK) Backup at $(HOME)	$(GREEN)Created$(RESET)

.PHONY: all up down clean fclean status backup prepare re