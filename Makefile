
DOCK_FILE	=	Dockerfile

DOCKER_NAME	=	d_makefile_completer

DOCK_IMG_NAME	=	m_completer

DOCKER_REPO	=	colcolt/makefile_completer:latest

GREEN	=	\033[0;32m
RED	=	\033[0;31m
DEFAULT	=	\033[0m

all:	create run

create:
	@docker build -t $(DOCK_IMG_NAME) . && \
	echo -e "$(GREEN)Image well created$(DEFAULT)" || \
	echo -e "$(RED)Image build has failed$(DEFAULT)"

run:
	@docker run --name $(DOCKER_NAME) --restart=always -v "$(PWD):/home" -d m_completer:latest && \
	echo -e "$(GREEN)Docker running in background, your Makefiles will be completed$(DEFAULT)" || \
	echo -e "$(RED)There is no related image in local.\nEnter:\nmake repo_run\n to run it with the image in the Docker Hub$(DEFAULT)"

repo_run:
	@docker pull $(DOCKER_REPO) && \
	echo -e "$(GREEN)The image was well pulled from the repository on the Docker Hub$(DEFAULT)" || \
	echo -e "$(RED) There was an error pulling the image from the online repository$(DEFAULT)"
	@docker run --name $(DOCKER_NAME) --restart=always -v "$(PWD):/home" -d $(DOCKER_REPO) && \
	echo -e "$(GREEN)Docker running in background, your Makefiles will be completed$(DEFAULT)" || \
	echo -e "$(RED)There is a problem starting the docker on background$(DEFAULT)"

new_makefile:
	@python3 scripts/makefile_creator.py && \
	echo -e "$(GREEN)The new Makefile was well created$(DEFAULT)" || \
	echo -e "$(RED)The program can't create the Makefile$(DEFAULT)"

tests_run:
	@docker build -t $(DOCK_IMG_NAME) . && \
	(docker run --name $(DOCKER_NAME) -d -v "$(PWD):/home" $(DOCK_IMG_NAME) || \
	docker start $(DOCKER_NAME)) || \
	echo -e "$(RED)There was a problem building the image$(DEFAULT)"
	./ci/test_add.sh
	./ci/test_remove.sh
	./ci/test_move.sh

help:
	@cat README.md