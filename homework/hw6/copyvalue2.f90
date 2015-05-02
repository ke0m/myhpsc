! $MYHPSC/homework/hw6/copyvalue2.f90

program copyvalue2

  use mpi
  integer :: ierr, numprocs, proc_num
  integer :: status(MPI_STATUS_SIZE)
  integer :: val

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, numprocs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, proc_num, ierr)

  if(numprocs==1) then
    print *, "Only one process, cannot do anything"
    call mpi_finalize(ierr)
    stop 
  endif

  if(proc_num == numprocs-1) then
    val = 55
    print '("Processor, " i3, " setting value = ", i3)', proc_num, val

    ! I believe this call sends the integer to processor 1 (before the 21)
    ! and send it out to each processor (MPI_COMM_WORLD)
    call mpi_send(val, 1, MPI_INTEGER, proc_num-1, 21, MPI_COMM_WORLD, ierr)

  else if (proc_num > 0) then !targeting processes 1-2
    ! for process 2, receive from 3. for process 1, receive from 2. 
    ! This is a blocking receive. It does not continue until it
    ! receives data
    call mpi_recv(val, 1, MPI_INTEGER, proc_num+1, 21, MPI_COMM_WORLD, status, ierr)

    print '("Processor, " i3, " receives value = ", i3)', proc_num, val
    print '("Processor, " i3, " sends    value = ", i3)', proc_num, val

    ! for process 2, send to 1. process 1, send to 0
    call mpi_send(val, 1, MPI_INTEGER, proc_num-1, 21, MPI_COMM_WORLD, ierr)

  else if(proc_num == 0) then
    call mpi_recv(val, 1, MPI_INTEGER, 1, 21, MPI_COMM_WORLD, status, ierr)
    print '("Processor, " i3, " ends up with value = ", i3)', proc_num, val
  endif

  call mpi_finalize(ierr)

end program copyvalue2
