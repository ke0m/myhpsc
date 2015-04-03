! $MYPSC/hw4/quadrature.f90

module quadrature


  contains

    real(kind=8) function trapezoid(f,a,b,n)
      implicit none
      real(kind=8), external :: f
      real(kind=8), intent(in) :: a, b
      integer, intent(in) :: n
      integer :: i
      real(kind=8) :: h,x,fsum
      real(kind=8) :: fj(n)

      h = (b-a)/(n-1)

      do i=1,n
        x = (i-1)*h
        fj(i) = f(x)
        fsum = fsum + fj(i)
      enddo
      trapezoid = h*fsum - 0.5*h*(fj(1) + fj(n)) 

    end function trapezoid


    subroutine error_table(f,a,b,nvals,int_true)

      implicit none
      real(kind=8), external :: f
      real(kind=8), intent(in) :: a,b,int_true
      integer, dimension(:), intent(in) :: nvals
      real(kind=8) :: int_trap,error,ratio, last_error
      integer :: i, iend, n
      last_error = 0
      iend = size(nvals)

      print *, "      n       trapezoid            error        ratio"

      do i=1,iend
        n = nvals(i)
        int_trap = trapezoid(f,a,b,n)
        error = abs(int_trap - int_true)
        ratio = last_error/error
        last_error = error
        print 11, n, int_trap, error, ratio
        11 format(i8, es22.14, es13.3, es13.3)
      enddo

    end subroutine error_table

end module quadrature
