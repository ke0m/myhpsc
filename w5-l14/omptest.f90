! $MYHPSC/w5-l13/opmptest.f90

program omptest
  use omp_lib
  integer :: thread_num
  integer :: thread_num1

  ! Specify the number of threads to use
  !$ call omp_set_num_threads(2) ! forking two threads

  print *, "Testing openmp..."

  !$omp parallel !spawns two threads
  !$omp critical !Says that this code must be done one thread at a time. This can prevent
  !$ thread_num = omp_get_thread_num() ! race conditions
  !$ print *, "This thread, = ", thread_num
  !$omp end critical
  !$omp end parallel

  print *, ' '

  !$omp parallel private(thread_num1)

  !$ thread_num1 = omp_get_thread_num()

  !$omp critical 
  !$ print *, "This thread = ", thread_num1 ! in a critical block to avoid simulataneous
  !$omp end critical                       ! printing  
  !$omp end parallel

end program omptest
