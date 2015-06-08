
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
	! the function (piece-wise for mdipoint, linear for trapezoid, etc.)
	! it uses a random number generator to randomly create points over
	! which the integral will be approximated

	! Handling the input arguments
	implicit none
	real(kind=8), dimension(ndim), intent(in) :: a,b
	real(kind=8), external :: g
	integer, intent(in) :: ndim, npoints

	! Function variables/arrays
	! Do I need to set boundaries on the values of these
	! random numbers?
	real(kind=4), allocatable :: x_total(:)
	real(kind=4) :: x(ndim)
	integer :: i, j
	real(kind=8) :: g_total, v

	j = 0
	g_total = 0.d0
	v = 1
	allocate(x_total(ndim*npoints))
	call random_number(x_total)

	!print *, "x_total: ", x_total

	! 1-20, 21-40, 41-60, because ndim=20 for this case
	do i=1,npoints
		x = a + x_total(j:j+(ndim-1))*(b-a)
		g_total = g_total + g(x,ndim)
		j = j + ndim
		!print *, "i= ", i
		enddo

	do i=1,ndim 
		v = v*(b(i)-a(i))
		enddo

	quad_mc = (v/npoints)*g_total

	print *, "V, quad_mc", v, quad_mc

end function quad_mc

end module
