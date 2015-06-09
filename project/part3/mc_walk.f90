! $MYHPSC/project/part3/mc_walk.f90

module mc_walk

use problem_description, only: uboundary, ax, ay, dx, dy

implicit none ! This declaration affects all declared variables
              ! in the entire module
contains

subroutine random_walk(i0, j0, max_steps, ub, iabort)

	! Currently, my main question is how do we check if
	! we have hit the boundary. How does that work?

	! I also need to call the function uboundary within 
	! the file problem_description.f90. I am not sure how that
	! will work

	! Input arguments and what the subroutine returns
	integer, intent(in) :: i0, j0, max_steps
	integer, intent(inout) :: iabort
	real(kind=8), intent(inout) :: ub

	! Subroutine variables
	integer :: istep, i, j
	logical :: debug

	debug = .true.

	! Starting point
	i = i0
	j = j0

	! Generate as many random number generators as we could
	! possibly need for this walk, since this is much faster
	! than generating one at a time.

end subroutine random_walk


subroutine many_walks(i0, j0, max_steps, n_mc, u_mc, n_sucesses)

	integer, intent(in) :: i0, j0, max_steps, n_mc
	integer, intent(inout) :: n_sucesses
	real(kind=8), intent(inout) :: u_mc

end subroutine many_walks


end module mc_walk