# $MYHPSC/hw4/Makefile

OBJECTS1 = quadrature.o test1.o
OBJECTS2 = quadrature.o test2.o
MODULES  = quadrature.mod

.PHONY: test1 clean

test1: test1.exe
	./test1.exe

test1.exe: $(MODULES) $(OBJECTS1)
	gfortran $(OBJECTS1) -o test1.exe

%.o: %.f90
	gfortran -c $<

%.mod: %.f90
	gfortran -c $<

clean: 
	rm -f $(MODULES) $(OBJECTS1) $(OBJECTS2) *.exe 

