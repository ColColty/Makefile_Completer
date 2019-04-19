/*
** EPITECH PROJECT, 2018
** test.c
** File description:
** testfile
*/

#include <criterion/criterion.h>
#include <criterion/redirect.h>

void redirect_all_std(void)
{
    cr_redirect_stdout();
    cr_redirect_stderr();
}

TestSuite(
    my_tests,
    .init = redirect_all_std
);

Test(my_tests, test01)
{
    
}

Test(my_tests, test01_without_redirect, .init = NULL)
{
    
}
