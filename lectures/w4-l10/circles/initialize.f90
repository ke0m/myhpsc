! $MYHPSC/w4-l10/circles/initialize.f90

subroutine initialize()
  
  use circle_mod, only: pi

  pi = acos(-1.d0)

end subroutine initialize
