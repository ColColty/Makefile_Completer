##
## EPITECH PROJECT, 2018
## Makefile
## File description:
## Makefile
##

SRC_DIR	=	$(realpath ./src)

LIB_FILE	=	$(realpath ./lib/my/)

TEST_SRC	=	$(realpath ./tests)

SRC	=	$(SRC_DIR)/test.c	\

TESTS	=	$(TEST_SRC)/test1.c	\

NAME	=	test

MAIN_SRC	=	main.c

LIB	=	-L$(LIB_FILE) -lmy

INCLUDE	=	-I./include

OBJ	=	$(SRC:.c=.o)

DEFAULT	=	\033[0m
GREEN	=	\033[0;32m
RED	=	\033[1;31m

all:	$(NAME)

$(NAME):	$(OBJ)
	@make -C $(LIB_FILE)
	@gcc -o $(NAME) $(MAIN_SRC) $(OBJ) $(INCLUDE) $(LIB) && \
	echo "[ $(GREEN)$(NAME) created !$(DEFAULT) ]" || \
	echo "[ $(RED)Error compiling $(NAME)$(DEFAULT) ]"

clean:
	@make clean -C $(LIB_FILE)
	@rm -f *.gc*
	@find . -name "*.o" -type f -delete

fclean:	clean
	rm -f $(NAME)
	rm -f unit_tests
	make fclean -C $(LIB_FILE)

re:	fclean all

bonus:	$(OBJ)
	make -C $(LIB_FILE)
	gcc -o $(NAME) $(MAIN_SRC) $(SRC) $(INCLUDE) $(LIB) -DBONUS

debug:	$(OBJ)
	make -C $(LIB_FILE)
	gcc -o $(NAME) $(MAIN_SRC) $(SRC) $(INCLUDE) $(LIB) -DTESTS

docker:
	docker run -v "$$PWD:/app" epitechcontent/epitest-docker bash -c "cd /app && make re"

tests_run:	re
	gcc -c $(SRC) $(INCLUDE) -DUNIT_TESTS --coverage
	gcc -c $(TESTS) $(INCLUDE)
	gcc -o unit_tests *.o -lcriterion -lgcov $(LIB)
	./unit_tests --always-succeed
	gcovr

%.o:	%.c
	@$(CC) -o $@ -c $< -W $(INCLUDE) && \
	echo "[ $(GREEN)$< Compiled !$(DEFAULT) ]" || \
	echo "[ $(RED)Fail compilation $<$(DEFAULT) ]"

.PHONY:	all clean fclean re tests_run bonus debug docker