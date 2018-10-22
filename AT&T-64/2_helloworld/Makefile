helloworld.out: helloworld.o
	gcc helloworld.o -o helloworld.out

helloworld.o: helloworld.s
	as -gstabs helloworld.s -o helloworld.o

clean:
	-rm *.o *.out
