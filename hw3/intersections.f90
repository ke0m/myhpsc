! $MYHPSC/hw3/intersections.f90

program intersections

  use newton, only: solve
  use functions, only: g1, g2, g1_g2, g1_g2_prime

  implicit none
  real(kind=8) :: x0, fx
  real(kind=8) :: x(4), x0vals(4)
  integer :: iters, i
  logical :: debug = .false.

  ! the four guesses for each intersection
  x0vals = (/-3.d0, -2.d0, -1.d0, 1.9d0/)

  do i = 1, 4
    x0 = x0vals(i)
    print *, ' '
    call solve(g1_g2, g1_g2_prime, x0, x(i), iters, debug)
    print *, 'With initial guess x0 = ', x0, ' solve returns x = ', x(i), 'after ', iters, ' iterations.'
    !print 11, x0, x(i), iters
    !11 format('With initial guess x0 = ', e40.15, ' solve returns x = ', e20.15, ' after ' i3 ' iterations.')
  enddo

end program intersections


