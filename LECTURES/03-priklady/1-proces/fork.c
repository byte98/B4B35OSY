#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    int f = fork(),ff=-1;
    if (f==0) {
      ff = fork();
    }
    printf("Hello %i, %i \n", f, ff);
    return 0;
}
