! $MYHPSC/project/[art3/laplace_mc.f90

program laplace_mc

  use problem_description, only: utrue, ax, ay, dx, dy
	use mc_walk, only: many_walks
	use random_util, only: init_random_seed

	implicit none
	real(kind=8) :: x0, y0, u_true, u_mc, error
	integer :: i0, j0, seed1, max_steps, n_mc, n_sucesses

	! Do not forget to include the write statement at the end
	open(unit=25, file='mc_laplace_error.txt', status='unknown')

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

	! I am not sure if this should be computed here.
	! I am thinking of including a print_table subroutine
	! similar to what I did earlier with an omp quadrature
	! program
	error = abs((u_mc-u_true)/u_true)

end program laplace_mc