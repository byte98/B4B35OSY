#include <lib/lib/lib/stdio.h>
#include "lib/lib/lib/program1_u.h"
#include "lib/lib/lib/program1_u.c"

#include <lib/lib/stdio.h>

void printHello()
{
	fprintf(stdout, "Hello ");
}

int main(int argc, char*argv[])
{
	int reti = 0;
	printHello();
	printWorld();
	printSomethingDifferent();
	internal__func();
	_func();
	_func_xy();
	sin_Cos();
	remove_allX();
//Doing printHello() and printSomethingDifferent()
	return 0;
}


