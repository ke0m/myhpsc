# $MYHPSC/w4-l10/newton/Makefile

OBJECTS  = functions.o newton.o test1.o
OBJECTS2 = functions.o newton.o intersections.o
MODULES  = functions.mod newton.mod

FFLAGS = -g

.PHONY: intersections test1 clean

intersections: intersections.exe
	./intersections.exe

intersections.exe: $(MODULES) $(OBJECTS2)
	gfortran $(FFLAGS) $(OBJECTS2) -o intersections.exe

test1: test1.exe
	./test1.exe

# The first line checks to see if the files are up to date
# if they are not, then it will create the files that are not
# up to date by executing the commands on lines 18-20
test1.exe: $(MODULES) $(OBJECTS) 
	gfortran $(FFLAGS) $(OBJECTS) -o test1.exe

%.o: %.f90
	gfortran $(FFLAGS) -c $<

%.mod: %.f90
	gfortran $(FFLAGS) -c $<

clean:
	rm -f $(OBJECTS) $(OBJECTS2) $(MODULES) *.exe
