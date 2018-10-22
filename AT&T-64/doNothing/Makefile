doNothing: doNothing.o
	gcc doNothing.o -o doNothing.out

doNothing.o: doNothing.s
	as -gstabs doNothing.s -o doNothing.o

clean:
	-rm *.o *.out
