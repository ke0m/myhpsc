! $MYHPSC/project/[art3/laplace_mc.f90

program laplace_mc

  use problem_description, only: utrue, ax, ay, dx, dy
	use mc_walk, only: many_walks
	use random_util, only: init_random_seed

	implicit none
	real(kind=8) :: x0, y0, u_true, u_mc, error, u_mc_total, u_sum_old, u_sum_new
	integer :: i0, j0, seed1, max_steps, n_mc, n_sucesses, n_total, i

	! Do not forget to include the write statement at the end
	open(unit=25, file='mc_laplace_error.txt', status='unknown')

	! Initialization
	u_mc_total = 0.d0

	! Try it out from a specific (x0,y0): 
	x0 = 0.9
	y0 = 0.6
	i0 = nint((x0-ax)/dx)
	j0 = nint((y0-ay)/dy)

	! shift (x0,y0) to a grid point if it wasn't already:
	x0 = ax + i0*dx
	y0 = ay + j0*dy

	u_true = utrue(x0,y0)

	! Seedint the random number generator
	print *, "seed1 for random number generator: "
	read *, seed1
	call init_random_seed(seed1)

	! Maximum number of steps before giving up
	max_steps = 10 ! 100*max(nx,ny)

	! Initial number of Monte-Carlo walks to take:
	n_mc = 10

	call many_walks(i0,j0,max_steps,n_mc,u_mc,n_sucesses)

	error = abs((u_mc-u_true)/u_true)

	! Printing results
	print 11, n_mc, u_mc, error
	11 format(i8, es22.14,es22.7)

	! Start accumulating totals
	u_mc_total = u_mc
	n_total = n_sucesses

	do i=1,12
		u_sum_old = u_mc_total*n_total
		call many_walks(i0,j0,max_steps,n_mc,u_mc,n_sucesses)
		u_sum_new = u_mc * n_sucesses
		n_total = n_total + n_sucesses
		u_mc_total = (u_sum_old + u_sum_new) / n_total
		error = abs((u_mc-u_true)/u_true)

		print 11, n_mc, u_mc, error
		11 format(i8, es22.14,es22.7)

		n_mc = 2*n_mc ! double number of trials for next iteration
		enddo

end program laplace_mc
