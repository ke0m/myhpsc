! $MYHPSC/lectures/w7-l20/factorial_example.f90

module factorial_example
  contains 

  recursive subroutine myfactorial(m, mfact)

    implicit none
    integer, intent(in) :: m
    integer, intent(out) :: mfact
    integer :: m1fact

    if (m <= 1) then
      mfact = 1
    else
      call myfactorial(m-1, m1fact)
      mfact = m * m1fact
    endif

    end subroutine myfactorial

end module factorial_example
