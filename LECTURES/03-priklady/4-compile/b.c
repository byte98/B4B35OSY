#include "a.h"

int i_b;
int f_b(long int x) {
   i_b = f_a((short)x);
   i_a = (int)(x/2);
   return (int)(x>>16);
}