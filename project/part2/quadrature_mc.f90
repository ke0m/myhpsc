
module quadrature_mc

contains

real(kind=8) function quad_mc(g, a, b, ndim, npoints)

	! Returns the monte Carlo estimation of
	! the integral of an ndimensional function
	! g(x) from from a(i) to b(i) where i is a specific
	! spatial dimension.
	! It performs this estimation with npoints number of 
	! Monte Carlos samples.

	! Input:
	!    g: the ndimensional function to integrate
	!    a: an array of length ndim that contains the lower
	!       limits of integration
	!    b: an array of length ndim that contains the upper
	!       limits of integration
	!    ndim: the number of dimensions over which we integrate
	!    npoints: the number of Monte Carlo samples to use 

	! How does it work?
	! I beleive Monte Carlo integration works by approximating
	! the integral instead of using preselected points to approximate
	! the function (piece-wise for midpoint, linear for trapezoid, etc.)
	! it uses a random number generator to randomly create points over
	! which the integral will be approximated

	! Handling the input arguments
	implicit none
	real(kind=8), dimension(ndim), intent(in) :: a,b
	real(kind=8), external :: g
	integer, intent(in) :: ndim, npoints

	! Function variables/arrays
	! Boundaries are required for the random numbers
	! as we are integrating over specified limits (a,b)
	real(kind=8), allocatable :: x_total(:)
	real(kind=8) :: x(ndim)
	integer :: i, j
	real(kind=8) :: g_total, v

	j = 0
	g_total = 0.d0
	v = 1
	allocate(x_total(ndim*npoints))
	call random_number(x_total) ! Only to be called once

	! Slices the x_total array in order for each point
	! to get the ndim values in order to evaluate
	! g. Remember that the goal is find the sum of the 
	! evaluations of g npoints times. 
	do i=1,npoints
		x = a + x_total(j:j+(ndim-1))*(b-a)
		g_total = g_total + g(x,ndim)
		j = j + ndim
		enddo

	v = product(b-a)

	quad_mc = (v/npoints)*g_total

end function quad_mc

end module
