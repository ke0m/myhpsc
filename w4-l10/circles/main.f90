! $MYHPSC/w4-l10/circles/main.f90

program main

  use circle_mod, only: pi, area
  !use circle_mod2, only:pi, area
  implicit none
  real(kind=8) :: a

  call initialize() ! sets pi for circle_mod2

  ! print parameter pi defined in module:
  print *, 'pi = ', pi

  ! test the area function from module
  a = area(2.d0)
  print *, 'area for a circle of radius 2: ', a

end program main

