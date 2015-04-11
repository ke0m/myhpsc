! $MYHPSC/lectures/w8-l22/gsend_receive_1norm.f90

program gsend_receive_1norm

  use mpi

  implicit none

  integer :: i,j,jj,nrows,ncols,proc_num,num_procs,ierr,nerr
  integer :: numsent, sender, nextcol
  integer :: status(MPI_STATUS_SIZE) 
  real(kind=8) :: colnorm
  real(kind=8), allocatable, dimension(:,:) :: a
  real(kind=8), allocatable, dimension(:) :: anorm, colvect
  logical :: debug = .true.


  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, num_procs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, proc_num, ierr)

  nerr = 0
  if(proc_num == 0) then
    print *, "Input nrows, ncols"
    read *, nrows, ncols
    allocate(a(nrows,ncols)) ! only master process 0 needs the matrix
    a = 1.d0 ! Initialize to all 1's for this test
    allocate(anorm(ncols))
  endif

  call mpi_bcast(nrows, 1, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)
  call mpi_bcast(ncols, 1, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)

  if(proc_num > 0) then
    allocate(colvect(nrows))
  endif

  ! -------------------------------------
  ! Code for Master (Processor 0)
  ! ------------------------------------

  if(proc_num == 0) then

    numsent = 0

    do j=1,min(num_procs-1, ncols)
      call mpi_send(a(1,j), nrows, MPI_DOUBLE_PRECISION, j, j, MPI_COMM_WORLD, ierr)
      numsent = numsent + 1
    enddo

    ! as results come back, send out more work...
    ! the variable sender tells who sent back a result and ready for more work
    do j=1,ncols
      call mpi_recv(colnorm, 1, MPI_DOUBLE_PRECISION, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
      sender = status(MPI_SOURCE)
      jj = status(MPI_TAG)
      anorm(jj) = colnorm
      if(numsent < ncols) then
        nextcol = numsent + 1
        call mpi_send(a(1,j), nrows, MPI_DOUBLE_PRECISION, sender, nextcol, MPI_COMM_WORLD, ierr)
        numsent = numsent + 1
      else
        ! send an empty message with tag=0 to indicate this work is done, sent from process 0 to worker
        call mpi_send(MPI_BOTTOM, 0, MPI_DOUBLE_PRECISION, sender, 0, MPI_COMM_WORLD, ierr)
      endif
    enddo

    print *, "Finished filling anorm with values..."
    print *, anorm
    print *, "1-norm of matrix a = ", maxval(anorm)
  endif

  ! ---------------------------------------------
  ! Code for wokers (Processors 1, 2, 3, ....)
  ! ---------------------------------------------

  if(proc_num /= 0) then
    if (proc_num > ncols) go to 99 ! no work expected
    do while(.true.)
      ! repeat until message with tag=0 received
      call mpi_recv(colvect, nrows, MPI_DOUBLE_PRECISION, 0, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
      j = status(MPI_TAG)

      if(debug) then
        print *,"+++ Process, ",proc_num," received message with tag ", j
      endif

      if (j==0) go to 99 ! received done message

      colnorm = sum(abs(colvect))

      call mpi_send(colnorm, 1, MPI_DOUBLE_PRECISION, 0, j, MPI_COMM_WORLD, ierr)
    
    enddo

  endif

99 continue ! might jump here if finished early
  call mpi_finalize(ierr)

end program gsend_receive_1norm
