main.out: main.o foo.o
	gcc main.o foo.o -o main.out

main.o: main.s
	as -gstabs main.s -o main.o

foo.o: foo.s
	as -gstabs foo.s -o foo.o

main.s: main.c foo.h
	gcc -S main.c -o main.s

foo.s: foo.c foo.h
	gcc -S foo.c -o foo.s

clean:
	-rm *.s
	-rm *.o
	-rm *.out
