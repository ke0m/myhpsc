! $MYHPSC/w6-l16/demo2.f90

program demo2

  use omp_lib
  integer, parameter :: n = 100000
  real(kind=8), dimension(n) :: x,y,z
  !$ call omp_set_num_threads(2)

  !$omp parallel ! spawn two threads
  !$omp sections ! split up work between them

    !$omp section
    x = 1.d0

    !$omp section
    y = 1.d0

  !$omp end sections
  !$omp barrier ! not needed, implied at end of sections

  !$omp single ! only want to print once
  print *, "Done initializing x and y"
  !$omp end single nowait ! ok for other thread to continue

  !$omp do ! split work between threads
  do i=1,n
    z(i) = x(i) + y(i)
  enddo

  !$omp end parallel

end program demo2
