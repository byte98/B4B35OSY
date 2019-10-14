#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
    int ret = 0, i;
    pid_t f[10];

    for (i=0; i<10; i++) {
       if ((f[i]=fork())==0) {
          ret=i;
          printf("Ja jsem potomek vracim %i\n", ret);
          sleep(5*(10-i));
          return ret;
       }
    }
    for (i=0; i<10; i++) {
       int potomek_ret;
       pid_t w = waitpid(f[i], &potomek_ret, 0);
       printf("Potomek vratil %i PID potomka wait vratil %i fork vratil %i\n", WEXITSTATUS(potomek_ret), w, f[i]);
    }
    return ret;
}
