doNothing: doNothing.o
	gcc doNothing.o -o doNothing

doNothing.o: doNothing.s
	as doNothing.s -o doNothing.o

clean:
	rm *.o *~
