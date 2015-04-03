! $MYHPSC/hw3/problem7/test_quartic.f90

program test_quartic

  use newton, only: solve, tol
  use functions, only: f_quartic, fprime_quartic, eps

  implicit none
  real(kind=8) :: x, x0, fx, xstar
  real(kind=8) :: xvals(9), tolvals(3), epsvals(3)
  integer :: iters, i, j
  logical :: debug = .false.
  
  tolvals = (/1.0d-5, 1.0d-10, 1.0d-14/)
  epsvals = (/1.0d-4, 1.0d-8,  1.0d-12/) 
  x0 = 4.0d0
  print *, 'Starting with initial guess ', x0
  print *, ' '
  print *, '    epsilon       tol    iters        x                     f(x)       x-xstar'

  do i=1,3
    do j=1,3
      eps = epsvals(i)
      tol = tolvals(j)
      xstar = 1 + (eps)**(0.25)
      call solve(f_quartic, fprime_quartic, x0, xvals(i), iters, debug)
      fx = f_quartic(xvals(i))
      print 11, eps, tol, iters, xvals(i), fx, xvals(i)-xstar
      11 format(2es13.3, i4, es24.15, 2es13.3)
    enddo
    print *, ' '
  enddo 

end program test_quartic
