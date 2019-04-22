##
## EPITECH PROJECT, 2018
## Makefile
## File description:
## Do a file who compile for us
##

TEST_SRC	=	$(realpath tests/)

SRC	=	my_putchar.c	\
	my_putstr.c	\

TESTS	=	$(TEST_SRC)/test_my_putstr.c	\

OBJ	=	$(SRC:.c=.o)

NAME	=	libmy.a

DEFAULT	=	\033[0m
GREEN	=	\033[0;32m
RED	=	\033[1;31m

all:	$(NAME)

$(NAME):	$(OBJ)
	@ar rc $(NAME) $(OBJ) && \
	echo "\n" "[ $(GREEN)$(NAME) created !$(DEFAULT) ]" || \
	echo "\n" "[ $(RED)$(NAME) failed...$(DEFAULT) ]"

clean:
	@rm -f *.gc*
	rm -f $(OBJ)

fclean:	clean
	rm -f $(NAME)

%.o:	%.c
	@$(CC) -o $@ -c $< -W && \
	echo "[ $(GREEN)$<\tCompiled !$(DEFAULT) ]" || \
	echo "[ $(RED)Fail compilation $<$(DEFAULT) ]"

re:	fclean all

tests_run:	re
	gcc -c $(SRC) --coverage
	gcc -c $(TESTS)
	gcc -o unit_tests *.o -lcriterion -lgcov -L. -lmy
	./unit_tests --always-succeed
	gcovr

.PHONY:	all clean fclean re