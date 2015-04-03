! $MYHPSC/w6-l18/pi_approx_omp.f90

program pi_approx_omp
  
  use omp_lib
  ! using the midpoint rule: a piecwise constant approx
  ! trapezpoidal rule is a piecewice linear approx
  implicit none
  real(kind=8) :: dx, pisum, x, pi
  integer :: n = 1000
  integer :: i

  dx = 1.d0 / n
  pisum = 0.d0
  !$omp parallel do reduction(+: pisum) private(x) ! I am not entirely sure why x needs to be private
  do i=1,n
    x = (i-0.5d0) * dx
    pisum = pisum + 1.d0 / (1.d0 + x**2)
  enddo
  pi = 4.d0 * dx * pisum

  print *, 'Pi = ', pi

end program pi_approx_omp
