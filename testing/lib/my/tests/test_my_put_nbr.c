/*
** EPITECH PROJECT, 2018
** config_files (Workspace)
** File description:
** test_my_put_nbr.c
*/

#include "../../../include/lib.h"
#include <criterion/criterion.h>
#include <criterion/redirect.h>

void redirect_all_std(void)
{
    cr_redirect_stderr();
    cr_redirect_stdout();
}

Test(my_put_nbr, test_long_number, .init = redirect_all_std)
{
    long int nb = 2000000000;
    char *nb_str = "2000000000";

    my_put_nbr(nb);
    cr_assert_stdout_eq_str(nb_str);
}

Test(my_put_nbr, test_binary_number, .init = redirect_all_std)
{
    int nb = 1001010;
    char *nb_str = "1001010";

    my_put_nbr(nb);
    cr_assert_stdout_eq_str(nb_str);
}

Test(my_put_nbr, test_negative_number, .init = redirect_all_std)
{
    int nb = -34;
    char *nb_str = "-34";

    my_put_nbr(nb);
    cr_assert_stdout_eq_str(nb_str);
}

Test(my_put_nbr, test_zero_number, .init = redirect_all_std)
{
    int nb = 0;
    char *nb_str = "0";
    my_put_nbr(nb);
    cr_assert_stdout_eq_str(nb_str);
}