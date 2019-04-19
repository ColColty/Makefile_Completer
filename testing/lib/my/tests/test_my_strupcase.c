/*
** EPITECH PROJECT, 2018
** config_files (Workspace)
** File description:
** test_my_strupcase.c
*/

#include "../../../include/lib.h"
#include <criterion/criterion.h>

Test(my_strupcase, test_all_str_lowcase)
{
    char *low_case = "abcdef";
    char *up_case = NULL;

    up_case = my_strupcase(low_case);
    cr_assert_str_eq(up_case, "ABCDEF");
    free(up_case);
}

Test(my_strupcase, test_str_low_up_case)
{
    char *low_case = "abCdEf";
    char *up_case = NULL;

    up_case = my_strupcase(low_case);
    cr_assert_str_eq(up_case, "ABCDEF");
    free(up_case);
}

Test(my_strupcase, test_null_str)
{
    char *low_case = NULL;
    char *up_case = NULL;

    up_case = my_strupcase(low_case);
    cr_assert_null(up_case);
    free(up_case);
}

Test(my_strupcase, test_with_numbers)
{
    char *low_case = "a1b2c3d4";
    char *up_case = NULL;

    up_case = my_strupcase(low_case);
    cr_assert_str_eq(up_case, "A1B2C3D4");
    free(up_case);
}