! $MYHPSC/lectures/w7-l21/send_receive2.f90

program send_receive2

  use mpi
  implicit none

  integer :: i, j, numprocs, proc_num, ierr
  integer :: status(MPI_STATUS_SIZE)

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, numprocs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, proc_num, ierr)

  if (proc_num == 0) then
    i = 55
    call mpi_send(i, 1, MPI_INTEGER, 1, 21, MPI_COMM_WORLD, ierr)
  else if  (proc_num < numprocs - 1) then
    call mpi_recv(i, 1, MPI_INTEGER, proc_num-1, 21, MPI_COMM_WORLD, status, ierr)
    call mpi_send(i, 1, MPI_INTEGER, proc_num+1, 21, MPI_COMM_WORLD, status, ierr)
  else if (proc_num == numprocs - 1) then
    call mpi_recv(i, 1, MPI_INTEGER, proc_num-1, 21, MPI_COMM_WORLD, status, ierr)
    print *, "i = ", i, "from processor ", proc_num
  end if

  call mpi_finalize(ierr)

end program send_receive2
