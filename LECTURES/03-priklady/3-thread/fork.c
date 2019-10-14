#include <stdio.h>
#include <unistd.h>

int a;

int main(int argc, char *argv[])
{
    a=10;
    fork();
    a+=10;
    printf("a=%i\n", a);
    return 0;
}
