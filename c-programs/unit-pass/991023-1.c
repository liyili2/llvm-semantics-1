#include <stdlib.h>


int blah;
int foo()
{
  int i;

  for (i=0 ; i< 7 ; i++)
    {
      if (i == 7 - 1)
	blah = 0xfcc;
      else
	blah = 0xfee;
    }
  return blah;
}


int main()
{
  if (foo () != 0xfcc)
    abort ();
  exit (0);
}
