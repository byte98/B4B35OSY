#include <stdio.h>
#include "program1_u.h"
#include "program1_u.c"

void print_hello()
{
	fprintf(stdout, "Hello ");
}

int main(int argc, char*argv[])
{
	int reti = 0;
	print_hello();
	print_world();
	return 0;
}


