#include <limits.h>
#include <stdio.h>

#if defined(TEST) && (TEST == 1)
#include "test.h"
#else
#include "input.h"
#endif

unsigned int make_pair(unsigned char tens, unsigned char ones) {

  unsigned int total = (unsigned int)(tens & UCHAR_MAX);
  total <<= 8;
  total |= (unsigned int)(ones & UCHAR_MAX);

  return total;
}

void foo(unsigned char const **const tens,
         unsigned char const **const ones,
         unsigned char const *const n) {

  unsigned int ab = make_pair(**tens, **ones);
  unsigned int bc = make_pair(**ones, *n);
  unsigned int ac = make_pair(**tens, *n);

  /* if (ab > bc && ab > ac) { do_nothing(); }; */
  if (bc >= ab && bc >= ac) { *tens = *ones; *ones = n; };
  if (ac >= ab && ac >= bc) {                *ones = n; };

}

unsigned int solve(unsigned int input_len, unsigned char input[static 1]) {

  unsigned int total = 0;

  unsigned char const zero = '0';
  unsigned char const *tens = &zero;
  unsigned char const *ones = &zero;

  unsigned char const *p = input;

  while (p < (input + input_len)) {
    switch (*p) {
    case '0' ... '9':
      foo(&tens, &ones, p);
      break;
      
    case '\n':
      /* Add highest joltage to total */
      total += 10u * (unsigned int)(*tens - '0');
      total += (unsigned int)(*ones - '0');

      /* Reset for next line */
      tens = &zero;
      ones = &zero;
      break;

    default:
      fprintf(stderr, "unknown char in input: %c at offset %zu\n",
	      *p, p - input);
      return 0;
    }
    ++p;
  }
  
  return total;
}

int main(void) {

#if defined(TEST) && (TEST == 1)
  printf("%u\n", solve(test_len, test));
#else
  printf("%u\n", solve(input_len, input));
#endif

  return 0;
}
