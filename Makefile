
DOCKER_COMPOSE = srcs/docker-compose.yml


all:
	@mkdir -p /home/ymazini/data/wordpress
	@mkdir -p /home/ymazini/data/mariadb	
	@mkdir -p /home/ymazini/data/portainer

	docker compose -f $(DOCKER_COMPOSE) up --build -d


down:
	docker compose -f $(DOCKER_COMPOSE) down



clean:
	docker compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans



fclean: clean
	docker system prune -a --volumes -f
	@sudo rm -rf /home/ymazini/data/*


re: fclean all
