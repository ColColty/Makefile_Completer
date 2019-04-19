/*
** EPITECH PROJECT, 2018
** config_files (Workspace)
** File description:
** test_my_swap.c
*/

#include "../../../include/lib.h"
#include <criterion/criterion.h>

Test(my_swap, test_swap_two_integers)
{
    int a = 1;
    int b = 2;

    my_swap(&a, &b);
    cr_assert_eq(a, 2);
    cr_assert_eq(b, 1);
}
