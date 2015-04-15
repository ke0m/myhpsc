! $MYHPSC/homeworks/hw5/quad2d/functions.f90
! Code written by R.J. Leveque
! and modified by Joseph Jennings

module functions

    use omp_lib
    implicit none
    integer :: fevals(0:7)
    integer :: gevals(0:7)
    real(kind=8) :: k
    save

contains

    real(kind=8) function f_old(x)
        implicit none
        real(kind=8), intent(in) :: x 
        integer thread_num

        ! keep track of number of function evaluations by
        ! each thread:
        thread_num = 0   ! serial mode
        !$ thread_num = omp_get_thread_num()
        !fevals(thread_num) = fevals(thread_num) + 1
        
        f_old = 1.d0 + x**3 + sin(k*x)
        
    end function f_old

    real(kind=8) function g(x,y)
      implicit none
      real(kind=8), intent(in) :: x,y
      integer thread_num

      thread_num = 0 
      !$ thread_num = omp_get_thread_num()
      gevals(thread_num) = gevals(thread_num) + 1

      g = sin(x + y)

    end function g

    real(kind=8) function f(x)
      implicit none
      real(kind=8), intent(in) :: x
      real(kind=8) :: h, trap_sum, yj
      integer, parameter :: ny = 1000
      real(kind=8), parameter :: a  = 1.d0
      real(kind=8), parameter :: b  = 4.d0
      integer :: j, thread_num

      thread_num = 0
      !$ thread_num = omp_get_thread_num()
      fevals(thread_num) = fevals(thread_num) + 1

      h = (b-a)/(ny-1)
      trap_sum = 0.5d0*(g(x,a)+g(x,b))

      do j=2,ny-1
        yj = a + h*(j-1)
        trap_sum = trap_sum + g(x,yj)
      enddo

      f = h*trap_sum

    end function f

end module functions
