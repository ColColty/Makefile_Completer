
DOCK_FILE	=	Dockerfile

DOCKER_NAME	=	d_makefile_completer

DOCK_IMG_NAME	=	m_completer

DOCKER_REPO	=	colcolt/makefile_completer:latest

GREEN	=	\033[0;32m
RED	=	\033[0;31m
DEFAULT	=	\033[0m

all:	build run

build:
	@docker build -t $(DOCK_IMG_NAME) . && \
	echo "$(GREEN)Image well created$(DEFAULT)" || \
	echo "$(RED)Image build has failed$(DEFAULT)"

run:
	@docker run --name $(DOCKER_NAME) --restart=always -v "$(PWD):/home" -d m_completer:latest && \
	echo "$(GREEN)Docker running in background, your Makefiles will be completed$(DEFAULT)" || \
	echo "$(RED)There is no related image in local or another docker is running.\nEnter:\n\tmake re\nTo run it again.$(DEFAULT)"

repo_run:
	@docker pull $(DOCKER_REPO) && \
	echo "$(GREEN)The image was well pulled from the repository on the Docker Hub$(DEFAULT)" || \
	echo "$(RED) There was an error pulling the image from the online repository$(DEFAULT)"
	@docker run --name $(DOCKER_NAME) --restart=always -v "$(PWD):/home" -d $(DOCKER_REPO) && \
	echo "$(GREEN)Docker running in background, your Makefiles will be completed$(DEFAULT)" || \
	echo "$(RED)There is a problem starting the docker on background$(DEFAULT)"

new_makefile:
	@python3 scripts/makefile_creator.py && \
	echo "$(GREEN)The new Makefile was well created$(DEFAULT)" || \
	echo "$(RED)The program can't create the Makefile$(DEFAULT)"

tests_run:
	@docker build -t $(DOCK_IMG_NAME) . && \
	(docker run --name $(DOCKER_NAME) -d -v "$(PWD):/home" $(DOCK_IMG_NAME) || \
	docker start $(DOCKER_NAME)) || \
	echo "$(RED)There was a problem building the image$(DEFAULT)"
	@echo "Executing adding tests\n"
	@./ci/test_add.sh && \
	echo "$(GREEN)The adding tests passed\n$(DEFAULT)"
	@echo "Executing removing tests\n"
	@./ci/test_remove.sh && \
	echo "$(GREEN)The removing tests passed\n$(DEFAULT)"
	@echo "Executing moving tests\n"
	@./ci/test_move.sh && \
	echo "$(GREEN)The moving tests passed\n$(DEFAULT)"
	sleep 2
	@docker rm -f $(DOCKER_NAME)

stop:
	@docker rm -f $(DOCKER_NAME) && \
	echo "$(GREEN)The docker was well removed$(DEFAULT)"

re:	stop build run

help:
	@cat README.md

.PHONY:	create run repo_run new_makefile tests_run stop re help