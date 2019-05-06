/*
** EPITECH PROJECT, 2018
** config_files (Workspace)
** File description:
** test_my_putstr.c
*/

#include "../../../include/lib.h"
#include <criterion/criterion.h>

Test(my_putstr, test_null_str)
{
    char *str = NULL;
    int ret = 0;

    ret = my_putstr(str);
    cr_assert_eq(ret, -1);
}

Test(my_putstr, test_little_str)
{
    char *str = "Hello this is a test\n";
    int ret = 0;

    ret = my_putstr(str);
    cr_assert_eq(ret, my_strlen(str));
}

Test(my_putstr, test_send_one_character)
{
    char *c = "o";
    int ret = 0;

    ret = my_putstr(c);
    cr_assert_eq(ret, my_strlen(c));
}