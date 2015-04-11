! $MYHPSC/lectures/w8-l22/ssend_receive_1norm.f90


program ssend_receive_1norm

  use mpi

  implicit none

  integer :: i,j,jj,nrows,ncols,proc_num,num_procs,ierr,nerr
  integer :: status(MPI_STATUS_SIZE) 
  real(kind=8) :: colnorm
  real(kind=8), allocatable, dimension(:,:) :: a
  real(kind=8), allocatable, dimension(:) :: anorm, colvect

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, num_procs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, proc_num, ierr)

  nerr = 0
  if(proc_num == 0) then
    print *, "Input nrows, ncols"
    read *, nrows, ncols
    if(ncols > num_procs-1) then
      print *, "*** Error, this version requires ncols < num_procs =", num_procs
      nerr = 1
    endif
    allocate(a(nrows,ncols)) ! only master process 0 needs the matrix
    a = 1.d0 ! Initialize to all 1's for this test
    allocate(anorm(ncols))
  endif

  ! if nerr == 1, then all processes must stop:
  call mpi_bcast(nerr, 1, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)

  if(nerr == 1) then
    call mpi_finalize(ierr)
    stop
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
    do j=1,ncols
      call mpi_send(a(1,j), nrows, MPI_DOUBLE_PRECISION, j, j, MPI_COMM_WORLD, ierr)
    enddo

    do j=1,ncols
      call mpi_recv(colnorm, 1, MPI_DOUBLE_PRECISION, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
      jj = status(MPI_TAG)
      anorm(jj) = colnorm
    enddo

    print *, "Finished filling anorm with values..."
    print *, anorm
    print *, "1-norm of matrix a = ", maxval(anorm)
  endif

  ! ---------------------------------------------
  ! Code for wokers (Processors 1, 2, 3, ....)
  ! ---------------------------------------------

  if(proc_num /= 0) then
    if (proc_num > ncols) go to 99 ! no work expected for this processor
    call mpi_recv(colvect, nrows, MPI_DOUBLE_PRECISION, 0, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
    j = status(MPI_TAG)

    colnorm = sum(abs(colvect))

    call mpi_send(colnorm, 1, MPI_DOUBLE_PRECISION, 0, j, MPI_COMM_WORLD, ierr)

  endif

99 continue ! might jump here if finished early
  call mpi_finalize(ierr)

end program ssend_receive_1norm
