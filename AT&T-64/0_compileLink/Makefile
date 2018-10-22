# linker
main.out: main.o foo.o
	gcc main.o foo.o -o main.out

# assembler
main.o: main.s
	as -gstabs main.s -o main.o

# assembler
foo.o: foo.s
	as -gstabs foo.s -o foo.o

# compiler
main.s: main.c foo.h
	gcc -S main.c -o main.s

# compiler
foo.s: foo.c foo.h
	gcc -S foo.c -o foo.s

clean:
	-rm *.s
	-rm *.o
	-rm *.out
