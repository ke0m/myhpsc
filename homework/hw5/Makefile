
OBJECTS = functions.o quadrature.o test.o
OBJECTS2 = functions.o quadrature2.o test2.o
FFLAGS = -fopenmp

.PHONY: test clean 

test2: test2.exe
	./test2.exe

test2.exe: $(OBJECTS2)
	gfortran $(FFLAGS) $(OBJECTS2) -o test2.exe
	#gfortran $(OBJECTS2) -o test2.exe

test: test.exe
	./test.exe

test.exe: $(OBJECTS)
	gfortran $(FFLAGS) $(OBJECTS) -o test.exe

%.o : %.f90
	gfortran $(FFLAGS) -c  $< 
	#gfortran -c  $< 

clean:
	rm -f *.o *.exe *.mod

