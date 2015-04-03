! $MYHPSC/w5-l14/private1.f90

program private1

  use omp_lib
  integer :: n = 7
  real(kind=8) :: y = 2.d0
  real(kind=8) :: x(7)

  !$ call omp_set_num_threads(2)

  !$omp parallel do firstprivate(y) lastprivate(y)
  do i = 1,n
    y = y + 10.d0
    x(i) = y
    !omp critical
    print *, "i = ",i,"   x(i) = ",x(i)
    !omp end critical
  enddo
  
  print *, "At end, y = ", y

end program private1
