#include <stdio.h>
#include <stdbool.h>
#include <limits.h>

#include "input.h"

unsigned long int upow(unsigned long int const base,
                       unsigned long int exponent) {
  unsigned long int result = 1;
  while (exponent--) {
    result *= base;
  };
  return result;
}

bool is_invalid(unsigned long int const id) {

  /* Count digits */
  unsigned long int digits = 1;
  unsigned long int n = id;
  while (n /= 10uL) {
    ++digits;
  }

  if (digits % 2uL) {
    /* IDs with odd digit count are all valid */
    return false;
  }

  unsigned long int const upper = id / upow(10uL, digits / 2uL);
  unsigned long int const lower = id % upow(10uL, digits / 2uL);

  return (upper == lower);
}

unsigned long int sum_invalid_ids_between(unsigned long int const lower,
                                          unsigned long int const upper) {
  unsigned long int sum = 0;

  for (unsigned long int n = lower; n <= upper; ++n) {
    sum += is_invalid(n) ? n : 0uL;
  }

  return sum;
}

unsigned long int solve(unsigned int const input_len,
                        unsigned char const *input) {

  unsigned long int total = 0;

  /* ID range parameters */
  unsigned long int upper = 0;
  unsigned long int lower = 0;

  /* Current parsed ID value */
  unsigned long int current = 0;

  unsigned char const *p = input;

  while (p < (input + input_len)) {
    switch (*p) {
    case '0' ... '9':
      current *= 10;
      current += (*p - '0');
      break;

    case '-':
      lower = current;
      current = 0;
      break;
      
    case '\n':
    case ',':
      upper = current;
      current = 0;
      total += sum_invalid_ids_between(lower, upper);
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
  printf("%lu\n", solve(input_len, input));

  return 0;
}
