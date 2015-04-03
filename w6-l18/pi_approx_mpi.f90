! $MYHPSC/w6-l18/pi_approx_mpi.f90

program pi_approx_mpi
  use mpi
  implicit none
  real(kind=8) :: dx, pisum_proc, x, pisum, pi
  integer :: n, i, istart, iend, proc_num, ierr, points_per_proc, num_procs

  call MPI_INIT(ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

  if(proc_num == 0) n = 1000

  ! Broadcast to all processes:
  call MPI_BCAST(n, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)
  ! n is the memory address that we want to send
  ! 1 is the number of elements we want to send
  ! MPI_INTEGER is the datatype we want to send
  ! 0 is the process that we want to do the sending
  ! MPI_COMM_WORLD the communicator to whom we want to send the data
  ! ierr is the error message that will be returned after execution

  dx = 1.d0/n

  points_per_proc = (n + num_procs - 1)/num_procs
  istart = proc_num * points_per_proc + 1
  iend   = min((proc_num+1)*points_per_proc, n)

  pisum_proc = 0.d0
  do i=istart,iend
    x = (i-0.5d0) * dx
    pisum_proc = pisum_proc + 1.d0 / (1 + x**2)
  enddo

  call MPI_REDUCE(pisum_proc, pisum, 1, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
  ! the buffer that is being sent
  ! The buffer to which we will write the reduced result
  ! the number of elements to send
  ! the datatype
  ! the reduction operation
  ! the root process to do the sending and receiving
  ! the communicator

  if (proc_num == 0) then
    pi = 4.d0 * dx * pisum
    print *, "PI = ", pi
  endif

  call MPI_FINALIZE(ierr)

end program pi_approx_mpi
