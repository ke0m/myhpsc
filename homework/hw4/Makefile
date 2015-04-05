# $MYHPSC/hw4/Makefile

OBJECTS1   = quadrature.o test1.o
OBJECTS2   = quadrature.o test2.o
OBJECTSO   = quadrature_omp.o test2_omp.o
MODULES    = quadrature.mod
MODULESO   = quadrature_omp.mod


FFLAGS = -O3 -fopenmp

.PHONY: test1 test2 test2_omp clean

test2_omp: test2_omp.exe
	./test2_omp.exe

test2_omp.exe: $(MODULESO) $(OBJECTSO)
	gfortran $(FFLAGS) $(OBJECTSO) -o test2_omp.exe

test2: test2.exe
	./test2.exe

test2.exe: $(MODULES) $(OBJECTS2)
	gfortran $(OBJECTS2) -o test2.exe

test1: test1.exe
	./test1.exe

test1.exe: $(MODULES) $(OBJECTS1)
	gfortran $(OBJECTS1) -o test1.exe

%.o: %.f90
	gfortran $(FFLAGS) -c $<

%.mod: %.f90
	gfortran $(FFLAGS) -c $<

clean: 
	rm -f $(MODULES) $(MODULESO) $(OBJECTS1) $(OBJECTS2) $(OBJECTSO) *.exe 

