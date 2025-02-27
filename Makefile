NAME = inception

all: up

# Create and start the containers
up: build
	docker-compose -f ./srcs/docker-compose.yml up -d

# Stop and remove the containers + named volumes
down:
	docker-compose -f ./srcs/docker-compose.yml down

# Stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# Start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# Build the images
build:
	docker-compose -f ./srcs/docker-compose.yml build

# Stop and remove the containers + ALL volumes
clean:
	docker-compose -f ./srcs/docker-compose.yml down -v

# Stop and remove the containers + ALL volumes + images + networks
fclean: clean
	docker system prune -f

re: fclean all

.PHONY: all up down stop start build clean fclean re
