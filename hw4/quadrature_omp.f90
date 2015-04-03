! $MYHPSC/hw4/quadrature_omp.f90

module quadrature_omp

  use omp_lib

  contains

    real(kind=8) function trapezoid_omp(f,a,b,n)

      implicit none
      real(kind=8), external :: f
      real(kind=8), intent(in) :: a,b
      integer, intent(in) :: n
      integer :: i
      real(kind=8) :: h,x,fsum
      real(kind=8) :: fj(n)

      h = (b-a)/(n-1)
      fsum = 0.d0
      !$omp parallel do reduction(+: fsum) private(x)
      do i=1,n
        x = (i-1)*h
        fj(i) = f(x)
        fsum = fsum + fj(i)
      enddo
      trapezoid_omp = h*fsum - 0.5*h*(fj(1) + fj(n))
      !print *, 'trapezoid=', trapezoid_omp, ' h=', h, ' fsum=', fsum, ' fj(1)=', fj(1), ' fj(n)=', fj(n)


    end function trapezoid_omp


    subroutine error_table_omp(f,a,b,nvals,int_true)

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
        int_trap = trapezoid_omp(f,a,b,n)
        error = abs(int_trap - int_true)
        ratio = last_error/error
        last_error = error
        print 11, n, int_trap, error, ratio
        11 format(i8, es22.14, es13.3, es13.3)
      enddo

    end subroutine error_table_omp

end module quadrature_omp
