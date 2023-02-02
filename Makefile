all: main

main: main.c fonctions.c fonctions.h
	gcc -o main main.c fonctions.c -I.

clean:
	rm -f main
