! $MYHPSC/w4-l10/multifile2/main.f90

program demo
  use sub1m, only: sub1
  print *, "In main program"
  call sub1()
end program demo
