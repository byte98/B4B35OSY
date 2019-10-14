#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

int a;

void *fce(void *n) {
   a+=10;
   sleep(1);
   printf("a=%i\n", a);
   pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
   pthread_t tid;

   a=10;
   pthread_create(&tid, NULL, fce, NULL);
   fce(NULL);
   sleep(1);
   return 0;
}
