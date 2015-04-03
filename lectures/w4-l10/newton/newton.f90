! $MYHPSC/w4-l10/newton/newton.f90

module newton

  !module parameters
  implicit none
  integer, parameter :: maxiter = 20
  real(kind=8), parameter :: tol = 1.d-14

contains

  subroutine solve(f, fp, x0, x, iters, debug)

    ! Estimate the zero of f(x) using Newton's method
    ! Input:
    !   f: the function of which we will find the root
    !   fp: function returnin the derivative f'
    !   x0: the intial guess
    !   debug: a logical, prints the number of iterations if debug is true
    ! Returns:
    !   x: the estimate of x satisfying f(x) = 0 (assumes Newton convergence)
    !   iters: the number of iterations required to converge 

    implicit none
    real(kind=8), intent(in) :: x0 ! cannot change, therefore we x = x0
    real(kind=8), external :: f, fp ! we are passing f and fp as functions defined elsewhere
    ! they return real(kind=8)
    logical, intent(in) :: debug
    real(kind=8), intent(out) :: x
    integer, intent(out) :: iters

    !Declare any local variables
    real(kind=8) :: deltax, fx, fxprime
    integer :: k

    ! initial guess
    x = x0

    if(debug) then
      print 11, x
11    format('Initial guess: x = ', e20.15) ! scientific notation, 20 total digits, 15
    endif                             ! 15 to the right of the decimal

  ! Newton iteration to find a zero of f(x)

  do k=1, maxiter

    ! evaluate function and its derivative
    fx = f(x)
    fxprime = fp(x)

    ! convergence test
    if (abs(fx) < tol) then ! should be approaching 0 if we are finding the root of the fxn
      exit ! jump out of do loop
    endif

    ! compute Newton increment x:
    deltax = fx/fxprime

    ! update x
    x = x - deltax

    if(debug) then
      print 12, k,x
      12 format('After' i3, ' iterations, x = ' e20.15)
    endif

   enddo


   if(k > maxiter) then
     ! might not have converged

     fx = f(x)
     if(abs(fx) > tol) then
       print *, "*** Warning: has not yet converged"
     endif
   endif

   ! number of iterations taken:
   iters = k-1

end subroutine solve

end module newton
