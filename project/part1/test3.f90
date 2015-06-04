! $MYHPSC/homework/hw6/homework6/test2.f90

! I need to consider the case that num_procs==1

program test3

    use mpi

    use quadrature, only: trapezoid
    use functions, only: f, fevals_proc, k

    implicit none
    real(kind=8) :: a, b, int_true, int_approx, dx_sub, int_sub

    integer :: proc_num, num_procs, ierr, n, fevals_total, nsub, j, num_sent, next_sub, sender, sub_tag
    integer, dimension(MPI_STATUS_SIZE) :: status
    real(kind=8) :: ab_sub(2)
    logical :: debug = .false.

    call MPI_INIT(ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)
    if(num_procs < 2) then
      print *, "*** Error: need to use at least two processes"
      call MPI_FINALIZE(ierr)
      stop
    endif
    call MPI_COMM_RANK(MPI_COMM_WORLD, proc_num, ierr)

    ! All processes set these values so we don't have to broadcast:
    k = 1.d3   ! functions module variable 
    a = 0.d0
    b = 2.d0
    int_true = (b-a) + (b**4 - a**4) / 4.d0 - (1.d0/k) * (cos(k*b) - cos(k*a))
    n = 1000

    ! Each process keeps track of number of fevals:
    fevals_proc = 0

    ! Keep track of number of endpoints sent.
    ! When this is equal to the number of subintervals
    ! then, we can stop


    if (proc_num==0) then
      num_sent = 0
      print '("Using ",i3," processes")', num_procs
      print *, "How many subintervals?"
      read *, nsub
      print '("true integral: ", es22.14)', int_true
      print *, " "  ! blank line
    endif
   
    call MPI_BCAST(nsub, 1, MPI_INTEGER, 0 , MPI_COMM_WORLD, ierr)

    if(proc_num > nsub) go to 99

    ! ------------------------------
    ! Code for master processor (0)
    ! ------------------------------
    if(proc_num==0) then
      
      dx_sub = (b-a) / nsub

      ! The master sends out different endpoints to each processor
      ! Get the first batch out to get the processors working
      do j=1,min(num_procs-1, nsub)
        ab_sub(1) = a + (j-1)*dx_sub
        ab_sub(2) = a + j*dx_sub
        call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, j, j, &
                      MPI_COMM_WORLD, ierr)
        if (debug) then
          print '("+++ Process ", i4, ", sent message to  process", i6," with tag", i6)', proc_num, j, j
        endif
        
        num_sent = num_sent + 1
      enddo

        ! In this block of code, we want to get the answers back
        ! and if there are more to be sent out, then send the rest out
        ! if not, end the program
        do j=1,nsub
          call MPI_RECV(int_sub, 1, MPI_DOUBLE_PRECISION, MPI_ANY_TAG, &
                           MPI_ANY_SOURCE, MPI_COMM_WORLD, status, ierr) ! MPI_ANY_TAG means they can come in any order

          int_approx = int_approx + int_sub
          sender = status(MPI_SOURCE)
          sub_tag = status(MPI_TAG)

          if (debug) then
            print '("+++ Process ", i4, ", received message from process", i6," with tag", i6)', proc_num, sender, sub_tag
            print*, "Integral approx:", int_approx
          endif

          if (num_sent < nsub) then
            next_sub = num_sent + 1
            ab_sub(1) = a + (next_sub-1)*dx_sub
            ab_sub(2) = a + next_sub*dx_sub
            call MPI_SEND(ab_sub, 2, MPI_DOUBLE_PRECISION, sender, &
                          next_sub, MPI_COMM_WORLD, status, ierr)
            if (debug) then
              print '("+++ Process ", i4, ", sent message to process", i6," with tag", i6)', proc_num, sender, next_sub
            endif
            num_sent = num_sent + 1
          else
            call MPI_SEND(MPI_BOTTOM, 0, MPI_DOUBLE_PRECISION, &
                          sender, 0, MPI_COMM_WORLD, ierr)
            if (debug) then
              print '("+++ Process ", i4, ", sent message to process", i6," with tag", i6)', proc_num, sender, 0
            endif

          endif
        enddo
          
    endif

    !---------------------------------------
    ! Code for worker processors (1,2,3...)
    !---------------------------------------

    if (proc_num /= 0) then

      !if (proc_num > nsub) go to 99
      !print *, "Process number first, nsub: ", proc_num, nsub

      do while(.true.)
        call MPI_RECV(ab_sub, 2, MPI_DOUBLE_PRECISION, 0, MPI_ANY_TAG, &
                    MPI_COMM_WORLD, status, ierr)
        j = status(MPI_TAG)

        if (debug) then
          print '("+++ Process ", i4, ", received message with tag ", i6)', proc_num, j
        endif

        if(j==0) go to 99 ! received done message
        !if(j==0) then
        !  print *, "Process number: ", proc_num
        !  call MPI_FINALIZE(ierr)
        !endif

        int_sub = trapezoid(f,ab_sub(1),ab_sub(2),n)

        call MPI_SEND(int_sub, 1, MPI_DOUBLE_PRECISION, 0, j, &
                    MPI_COMM_WORLD, ierr)
        if (debug) then
          print '("+++ Process ", i4, ", sent message with tag ", i6)', proc_num, j
        endif

      enddo
    endif



! What is odd is that process 0 is printing from here.
! It should never get here
! And also, where is process 3? For num_procs=4 and nsub=2, it should come here
99 continue
   ! print the number of function evaluations by each thread:
    print '("fevals by Process ",i2,": ",i13)',  proc_num, fevals_proc

    call MPI_REDUCE(fevals_proc, fevals_total, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    if (proc_num==0) then
      print '("Total number of fevals:" , i10)', fevals_total
      print '("Trapezoid approximation with ", i10 ," total points: ",es22.14)',fevals_total, int_approx
    endif

    call MPI_FINALIZE(ierr)


end program test3
