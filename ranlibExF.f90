! -*- Mode:F90; Coding:us-ascii-unix; fill-column:132 -*-
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!  @file      ranlibExF.f90
!  @Author    Mitch Richling<https://www.mitchr.me/>
!  @Copyright Copyright 1994 by Mitch Richling.  All rights reserved.
!  @breif     Example of RANLIB@EOL
!  @Keywords  example of ranlib
!  @Std       F90
!  We demonstrate the basic use of RANLIB with a simple example..
!
!  RANLIB has been around for a long time, and has a well understood track record.  The package has 32 random number generators that
!  may be independently seeded and reseeded.  An easy way is provided to simultaneously seed all generators to provide 32
!  independent, non-overlapping sequences of random numbers.  Each generator sequence can be advanced a power of two forward to
!  provide many parallel, smaller modulus, streams if 32 isn't enough.
!
!  The library also provides functions to generate random variates from common distributions:  
!
!      - GENBET  GeNerate BETa random deviate                             
!      - GENCHI  Generate random value of CHIsquare variable             
!      - GENEXP  GENerate EXPonential random deviate                 
!      - GENF    GENerate random deviate from the F distribution         
!      - GENGAM  GENerates random deviates from GAMma distribution            
!      - GENMN   GENerate Multivariate Normal random deviate              
!      - GENMUL  GENerate an observation from the MULtinomial distribution
!      - GENNCH  Generate random value of Noncentral CHIsquare variable       
!      - GENNF   GENerate random deviate from the Noncentral F distribution   
!      - GENNOR  GENerate random deviate from a NORmal distribution
!      - GENUNF  GeNerate Uniform Real between LOW and HIGH               
!      - IGNBIN  GENerate BINomial random deviate                    
!      - IGNNBN  GENerate Negative BiNomial random deviate
!      - IGNPOI  GENerate POIsson random deviate                     
!      - IGNUIN  GeNerate Uniform INteger                                
!  
!  Even a few kooky, buy handy functions are provided:
!
!      - PHRTSD  PHRase To SeeDs                                          
!      - GENPRM  GENerate random PeRMutation of iarray                    
!  
!  RANLIB is available from NetLib.  A C version exists too.  I have a partial F90 style interface avaiable with this code.
!             

!-----------------------------------------------------------------------------------------------------------------------------------
program ranlibEx
  USE ranlibM

  implicit none

  integer        :: j, genNum, seed1, seed2
  integer        :: ranInt1, ranInt2, ranInt3
  real           :: ranReal

  ! This is a handy way to call INITGN and INRGCM for all generators, set the current generator to the first one, set the first
  ! generator to the given seeds, and the rest of the generators to seeds that will "continue" the sequence.  In simple
  ! applications, this is generally used instead of SETSD.  First arg in [1, 2147483562], and second arg in [1, 214748339]
  call SETALL(11, 9)

  ! Set current generator to 2 (it is 1 by default) -- arg in [1,32]
  call SETCGN(2)

  ! Query to see what generator we are using
  call GETCGN(genNum)
  write(*,*) 'Using generator number ', genNum

  ! Query to see what the seed is for current generator
  call GETSD(seed1, seed2)
  write (*,*) 'Seed after SETALL: ', seed1, seed2

  ! Set the seed for the current generator
  ! First arg in [1, 2147483562], and second arg in [1, 214748339]
  call SETSD(11, 9)

  ! Query to see what the seed is for current generator
  call GETSD(seed1, seed2)
  write (*,*) 'Seed after SETSD: ', seed1, seed2

  ! Note gen 1 and 2 have the same seq -- we set the seeds the same.
  write (*,*) 'Five random integers in U[1, 2147483562] from first three generators:'
  do j=1,5
     call SETCGN(1)
     ranInt1 = IGNLGI()
     call SETCGN(2)
     ranInt2 = IGNLGI()
     call SETCGN(3)
     ranInt3 = IGNLGI()     
     write (*,*) j, ranInt1, ranInt2, ranInt3
  end do

  ! Now get some uniform random reals
  call SETCGN(1)
  write (*,*) 'Five random reals in U(0,1) from generator 1:'
  do j=1,5
     ranReal = RANF()
     write (*,*) j, ranReal
  end do

  ! Lastly, we get some ranom reals from a normal distribution
  call SETCGN(1)
  write (*,*) 'Five random reals in N(1,0.0001) from generator 1:'
  do j=1,5
     ranReal = GENNOR(1.0, 0.0001)
     write (*,*) j, ranReal
  end do

end program ranlibEx
