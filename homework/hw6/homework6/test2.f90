! $MYHPSC/homework/hw6/homework6/test.f90
! I believe the goal for this second part, 
! will be to divy up the function so that each
! process will compute a different portion
! of the integral of the function.
! This will involve passing different
! values of a and b (and I believe n)
! to the function trapezoid (I think)
! Look at W7-L21.4 (matrix one-norm)

! I need to look at special cases of the number or processors...
! For example, only one is specified.

program test2

    use mpi

    use quadrature, only: trapezoid
    use functions, only: f, fevals_proc, k

    implicit none
    real(kind=8) :: a, b, int_true, int_approx, dx_sub, int_sub

    integer :: proc_num, num_procs, ierr, n, fevals_total, nsub, j
    integer, dimension(MPI_STATUS_SIZE) :: status
    real(kind=8) :: ab_sub(2)

    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

    nsub = num_procs-1 

    ! All processes set these values so we don't have to broadcast:
    k = 1.d3   ! functions module variable 
    a = 0.d0
    b = 2.d0
    int_true = (b-a) + (b**4 - a**4) / 4.d0 - (1.d0/k) * (cos(k*b) - cos(k*a))
    n = 1000

    ! Each process keeps track of number of fevals:
    fevals_proc = 0

    ! ------------------------------
    ! Code for master processor (0)
    ! ------------------------------

    if (proc_num==0) then
        print '("Using ",i3," processes")', num_procs
        print '("true integral: ", es22.14)', int_true
        print *, " "  ! blank line

        ! The master sends out different endpoints to each processor
        dx_sub = (b-a) / nsub

        do j=1,nsub
          ab_sub(1) = a + (j-1)*dx_sub
          ab_sub(2) = a + j*dx_sub
          call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, j, j, &
                        MPI_COMM_WORLD, ierr)
        enddo

        do j=1,nsub
          call MPI_RECV(int_sub, 1, MPI_DOUBLE_PRECISION, MPI_ANY_TAG, &
                           MPI_ANY_SOURCE, MPI_COMM_WORLD, status, ierr)
          int_approx = int_approx + int_sub
        enddo
          
    endif

    !---------------------------------------
    ! Code for worker processors (1,2,3...)
    !---------------------------------------

    if (proc_num /= 0) then
      call MPI_RECV(ab_sub, 2, MPI_DOUBLE_PRECISION, 0, MPI_ANY_TAG, &
                  MPI_COMM_WORLD, status, ierr)
      j = status(MPI_TAG)
      int_sub = trapezoid(f,ab_sub(1),ab_sub(2),n)
      call MPI_SEND(int_sub, 1, MPI_DOUBLE_PRECISION, 0, j, &
                  MPI_COMM_WORLD, ierr)

      ! print the number of function evaluations by each thread:
      print '("fevals by Process ",i2,": ",i13)',  proc_num, fevals_proc

    endif

    call MPI_REDUCE(fevals_proc, fevals_total, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    if (proc_num==0) then
      print '("Total number of fevals:" , i10)', fevals_total
      print '("Trapezoid approximation with ", i10 ," total points: ",es22.14)',fevals_total, int_approx
    endif

    call MPI_FINALIZE(ierr)

end program test2
