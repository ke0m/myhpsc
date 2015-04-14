OBJECTS = functions.o quadrature.o test.o
FFLAGS = -fopenmp

.PHONY: test clean 

test: test.exe
	./test.exe

test.exe: $(OBJECTS)
	gfortran $(FFLAGS) $(OBJECTS) -o test.exe
#gfortran $(OBJECTS) -o text.exe

%.o : %.f90
	gfortran $(FFLAGS) -c  $< 
#gfortran -c  $< 

clean:
	rm -f *.o *.exe *.mod

