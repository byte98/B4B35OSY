all: prog

prog: a.o b.o 
	gcc -o prog a.o b.o 

a.o: a.c a.h b.h
	gcc -c a.c

b.o: b.c a.h b.h
	gcc -c b.c

clean:
	rm -rf *.o prog

