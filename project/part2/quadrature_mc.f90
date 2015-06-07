
module quadrature_mc

real(kind=8) contains function quad_mc(g, a, b, ndim, npoints)

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
	implicit none
	real(kind=8), intent(in) :: a,b
	real(kind=8), external :: g
	integer, intent(in) :: ndim, npoints

end function quad_mc

end module
