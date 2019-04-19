/*
** EPITECH PROJECT, 2018
** MAIN
** File description:
** main
*/

#include "my.h"

int error_handle(int argc, char **argv)
{
    if (argc != 1)
        return (1);
    return (0);
}

int main(int argc, char **argv)
{
    if (error_handle(argc, argv))
        return (84);
    test();
    return (0);
}