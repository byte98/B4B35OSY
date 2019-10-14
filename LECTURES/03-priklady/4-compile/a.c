#include "b.h"

int i_a;

int f_a(short int x) {
   return x+3;
}

int main(void) {
   i_a = i_b = 0;
   f_a(100);
   f_b(200);
   return i_a;
}