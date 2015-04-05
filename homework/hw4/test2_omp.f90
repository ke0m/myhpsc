! $MYHPSC/hw4/test2_omp.f90

program test2_omp
    use omp_lib
    use quadrature_omp, only: trapezoid_omp, error_table_omp

    implicit none
    real(kind=8) :: a,b,int_true
    integer, parameter :: length = 25
    integer :: nvals(length), i
    real(kind=8) :: k
    integer :: num_threads = 4
    !$ call omp_set_num_threads(num_threads)
    a = 0.d0
    b = 2.d0
    k = 1000
    int_true = (b-a) + (b**4 - a**4)/4.d0 - (1.d0/k) * (cos(k*b) - cos(k*a))

    print 10, int_true
 10 format("true integral: ", es22.14)
    !$ print *, "Using ", num_threads, " threads"
    print *, " "  ! blank line

    ! values of n to test:
    do i=1,length
        nvals(i) = 5 * 2**(i-1)
    enddo

    call error_table_omp(f, a, b, nvals, int_true)

contains

    real(kind=8) function f(x)
        implicit none
        real(kind=8), intent(in) :: x 
        
        f = 1.d0 + x**3 + sin(k*x)
    end function f

end program test2_omp
