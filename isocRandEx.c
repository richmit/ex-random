/* -*- Mode:C; Coding:us-ascii-unix; fill-column:132 -*- */
/* ****************************************************************************************************************************** */
/**
   @file      isocRandEx.c
   @author    Mitch Richling <https://www.mitchr.me/>
   @Copyright Copyright 1998 by Mitch Richling.  All rights reserved.
   @brief     hello   @EOL
   @Keywords  iso c random rand srand
   @Std       C89

   The random number generators implemented to meet the ISO C standard are almost always very primitive.  ISO C doesn't specify the
   algorithm to use for the generation of the sequence, but most implementations are a simple linear congruence generator.  The
   standard specifies that the maximum random number possible must be at least 2**17.  Sequences generated by rand() are almost
   always very poor and are not suitable for serious simulation work.  Even the minimal standard random number generator is better
   --- and given the ease with which the minimal standard can be implemented one really has no reason not to use it.  Still, rand()
   is always around and ready for use.

   While non-standard, many UNIX implementations provide for a function sranddev() that uses the random device to set the seed for
   rand().  I think this function appeared sometime around BSD 4.2.
              
*/

/* ------------------------------------------------------------------------------------------------------------------------------ */
#include <stdio.h>              /* I/O lib         ISOC  */
#include <stdlib.h>             /* Standard Lib    ISOC  */

/* ------------------------------------------------------------------------------------------------------------------------------ */
int main(int argc, char *argv[]) {

  int i, aRand;

  printf("Biggest rand: %lu\n", (unsigned long)RAND_MAX);

  /* Set the seed for the random number -- use an unsigned integer */
  srand(1234);

  printf("Five random integers in U[0, RAND_MAX]\n");
  for(i=0; i<5; i++) {
    aRand = rand();
    printf("%3d %15d\n", i, aRand);
  }

  return 0;
}
