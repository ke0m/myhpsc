# $MYHPSC/w4-l10/circles/Makefile

OBJECTS = circle_mod.o main.o initialize.o

MODULES = circle_mod.mod

.PHONY: clean

output.txt: main.exe
	./main.exe > output.txt

# The first line checks to see if the files are up to date
# if they are not, then it will create the files that are not
# up to date by executing the commands on lines 18-20
main.exe: $(MODULES) $(OBJECTS) 
	gfortran $(OBJECTS) -o main.exe

%.o: %.f90
	gfortran -c $<

%.mod: %.f90
	gfortran -c $<

clean:
	rm -f $(OBJECTS) $(MODULES) main.exe
