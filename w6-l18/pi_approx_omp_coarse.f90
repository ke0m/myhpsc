! $MYHPSC/w6-l18/pi_approx_omp_coarse.f90

program pi_approx_omp_coarse
  
  use omp_lib
  ! using the midpoint rule: a piecwise constant approx
  ! trapezpoidal rule is a piecewice linear approx
  implicit none
  real(kind=8) :: dx, pisum, x, pi, pisum_thread
  integer :: n = 1000
  integer :: nthreads = 4
  integer :: i, points_per_thread, istart, iend, thread_num

  !$ call omp_set_num_threads(nthreads)

  points_per_thread = (n + nthreads - 1)/nthreads
  pisum = 0.d0
  dx = 1.d0 / n

  !$omp parallel private(i, pisum_thread, istart, iend, x, thread_num)
  !$ thread_num = omp_get_thread_num()
  istart = thread_num * points_per_thread + 1 ! ensures that I am always above zero
  iend   = min((thread_num+1)*points_per_thread, n) ! ensures that I never go over the end

  pisum_thread = 0.d0
  do i=istart,iend
    x = (i-0.5d0) * dx
    pisum_thread = pisum_thread + 1.d0 / (1.d0 + x**2)
  enddo
  !$omp critical
    pisum = pisum + pisum_thread
  !$omp end critical
  !$omp end parallel

  pi = 4.d0 * dx * pisum

  print *, 'Pi = ', pi

end program pi_approx_omp_coarse
