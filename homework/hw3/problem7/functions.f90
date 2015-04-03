! $MYHPSC/w4-l10/newton/functions.f90

module functions

  !real(kind=8):: pi 
  real(kind=8), parameter :: pi = 3.14159265358979323
  real(kind=8) :: eps
  save

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


real(kind=8) function g1(x)
  implicit none
  real(kind=8), intent(in) :: x

  g1 = x*cos(pi*x)

end function g1

real(kind=8) function g1_prime(x)
  implicit none
  real(kind=8), intent(in) :: x

  g1_prime = cos(pi*x) - x*pi*sin(pi*x)

end function g1_prime

real(kind=8) function g2(x)
  implicit none
  real(kind=8), intent(in) :: x

  g2 = 1 - 0.6*x**2

end function g2

real(kind=8) function g2_prime(x)
  implicit none
  real(kind=8), intent(in) :: x

  g2_prime = -1.2*x**2

end function g2_prime

real(kind=8) function g1_g2(x)
  implicit none
  real(kind=8), intent(in) :: x

  g1_g2 = x*cos(pi*x) + 0.6*x**2 - 1

end function g1_g2

real(kind=8) function g1_g2_prime(x)
  implicit none
  real(kind=8), intent(in) :: x

  g1_g2_prime = cos(pi*x) - x*pi*sin(pi*x) + 1.2*x

end function

real(kind=8) function f_quartic(x)
  implicit none
  real(kind=8), intent(in) :: x

  f_quartic = (x-1)**4 - eps
end function

real(kind=8) function fprime_quartic(x)
  implicit none
  real(kind=8), intent(in) :: x

  fprime_quartic = 4*(x-1)**3
end function


end module functions

