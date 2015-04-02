! $MYHPSC/w5-l15/timings.f90

program timings
  use omp_lib

  implicit none
  integer, parameter :: ntests = 20
  integer :: n
  real(kind=8), allocatable, dimension(:,:) :: a,b,c
  real(kind=8) :: t1, t2, elapsed_time
  integer(kind=8) :: tclock1, tclock2, clock_rate
  integer :: i,j,k,itest,num_threads

  print *, "Using OpenMP, how many threads?"
  read*, num_threads

  !$ call omp_set_num_threads(num_threads)

  print *, "Will multiply n by n matrices, input n: "
  read *, n

  allocate(a(n,n), b(n,n), c(n,n))

  ! fill a and b with 1's just for demo purposes
  a = 1.d0
  b = 1.d0

  call system_clock(tclock1) ! start wall timer

  call cpu_time(t1) ! start cpu timer
  do itest=1,ntests
    !$omp parallel do private(i,k)
    do j = 1,n
      do i = 1,n
      c(i,j) = 0.d0
        do k=1,n
          c(i,j) = c(i,j) + a(i,k)*b(k,j)
        enddo
      enddo
    enddo
  enddo

  call cpu_time(t2) ! end cpu timer
  print 10, ntests, t2-t1
  10 format("Performed ", i4," matrix multiplies: CPU time ", f12.8)

  call system_clock(tclock2, clock_rate)
  elapsed_time = float(tclock2 - tclock1)/float(clock_rate)
  print 11, elapsed_time
  11 format("Elapsed time = ",f12.8, " seconds")

end program timings
