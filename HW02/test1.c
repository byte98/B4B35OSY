#include <lib/stdio.h>
#include "lib/program1_u.h"
#include "lib/program1_u.c"

void print_hello()
{
	fprintf(stdout, "Hello ");
}

int main(int argc, char*argv[])
{
	int reti = 0;
	print_hello();
	print_world();
	print_something_different();
	internal__func();
	_func();
	_func_xy();
	sin_Cos();
	remove_allX();
//Doing print_hello() and print_something_different()
	return 0;
}


