! $MYHPSC/w4-l10/newton/functions.f90

module functions

contains

real(kind=8) function f_sqrt(x)
  implicit none
  real(kind=8), intent(in) :: x

  f_sqrt = x**2 - 4.d0 ! Hardcoding four means we want to find the square root of 4

end function f_sqrt


real(kind=8) function fprime_sqrt(x)
  implicit none
  real(kind=8), intent(in) :: x

  fprime_sqrt = 2.d0*x

end function fprime_sqrt

end module functions





