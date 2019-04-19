/*
** EPITECH PROJECT, 2018
** MY_PUTSTR
** File description:
** Displays one-by-one characters of a string
*/

#include <stddef.h>

void my_putchar(char c);

int my_putstr(char const *str)
{
    int i = 0;

    if (str == NULL)
        return (-1);
    for (i; str[i] != '\0'; i++)
        my_putchar(str[i]);
    return (i);
}