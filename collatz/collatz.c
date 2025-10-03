#include <cs50.h>
#include <stdio.h>

int collatz(int i);

int main(void)
{
    int n = get_int("Number: ");
    int i = collatz("%i \n", n);
}

int collatz(int i)
{
    if (i == 1)
        return 1;
    else if (i == even)
        return collatz / 2;
    else
        return 3 * collatz + 1;
}
