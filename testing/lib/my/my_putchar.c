/*
** EPITECH PROJECT, 2018
** MY_PUTCHAR
** File description:
** Display a character
*/
#include <unistd.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}
