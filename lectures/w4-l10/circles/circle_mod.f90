! $MYHPSC/w4-l10/circles/circle_mod2.f90

module circle_mod

  ! declaring the constant pi. Why do we need the d0 on the end? Don't we know
  ! that it is a double precision number from the type?
  implicit none
  real(kind=8) :: pi
  save ! makes pi a global variable, can be used across subroutines/functions

  contains

    real(kind=8) function area(r)
      real(kind=8), intent(in) :: r
      area = pi * r**2
    end function area

    real(kind=8) function circumference(r)
      real(kind=8), intent(in) :: r
      circumference = 2.d0 * pi * r
    end function circumference

end module circle_mod


