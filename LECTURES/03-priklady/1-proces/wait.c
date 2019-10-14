#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
    int ret = 0;
    pid_t f;

    f=fork();
    if (f==0) {
       ret=10;
       printf("Ja jsem potomek vracim %i\n", ret);
       sleep(2);
       // stejne s exit(ret);
    } else {
       int potomek_ret;
       pid_t w = waitpid(-1, &potomek_ret, 0);
       printf("Potomek vratil %i PID potomka wait vratil %i fork vratil %i\n", WEXITSTATUS(potomek_ret), w, f);
    }
    return ret;
}
