! testing some fortran code for quiz

program test
      implicit none
      integer :: x(0:4), z(5)
      x = (/ 10, 20, 30, 40, 50 /)
      z = x
      print *, z(2)
end program test
