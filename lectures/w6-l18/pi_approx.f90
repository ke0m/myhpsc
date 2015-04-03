! $MYHPSC/w6-l18/pi_approx.f90

program pi_approx

  ! using the midpoint rule: a piecwise constant approx
  ! trapezpoidal rule is a piecewice linear approx
  implicit none
  real(kind=8) :: dx, pisum, x, pi
  integer :: n = 100.d0
  integer :: i

  dx = 1.d0 / n
  pisum = 0.d0
  do i=1,n
    x = (i-0.5d0) * dx
    pisum = pisum + 1.d0 / (1.d0 + x**2)
  enddo
  pi = 4.d0 * dx * pisum

  print *, 'Pi = ', pi

end program pi_approx
