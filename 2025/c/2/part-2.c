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

unsigned int count_digits(unsigned long int n) {

  unsigned int digits = 1;
  while (n /= 10uL) {
    ++digits;
  }
  return digits;
}

bool is_invalid(unsigned long int const id) {

  unsigned int digits = count_digits(id);

  // clang-format off
  switch (digits) {
  case 2:  return !(id % 11);
  case 3:  return !(id % 111);
  case 4:  return !(id % 1111)
	      || (!(id % 101) && ((id / 101) > 9));
  case 5:  return !(id % 11111);
  case 6:  return !(id % 111111)
	      || (!(id %  10101) && ((id / 10101) >  9))
	      || (!(id %   1001) && ((id /  1001) > 99));
  case 7:  return !(id % 1111111);
  case 8:  return !(id % 11111111)
	      || (!(id %  1010101) && ((id / 1010101) >   9))
	      || (!(id %    10001) && ((id /   10001) > 999));
  case 9:  return !(id % 111111111)
	      || (!(id %   1001001) && ((id / 1001001) > 99));
  case 10: return !(id % 1111111111)
	      || (!(id %  101010101) && ((id / 101010101) >    9))
	      || (!(id %     100001) && ((id /    100001) > 9999));
  case 11: return !(id % 11111111111);
  case 12: return !(id % 111111111111)
	      || (!(id %  10101010101) && ((id / 10101010101) >     9))
	      || (!(id %   1001001001) && ((id /  1001001001) >    99))
	      || (!(id %    100010001) && ((id /   100010001) >   999))
	      || (!(id %      1000001) && ((id /     1000001) > 99999));
  case 13: return !(id % 1111111111111);
  case 14: return !(id % 11111111111111)
	      || (!(id %       10000001) && ((id / 10000001) > 999999));
  case 15: return !(id % 111111111111111)
	      || (!(id %   1001001001001)  && ((id / 1001001001001) >   99))
	      || (!(id %     10000100001)  && ((id /   10000100001) > 9999));
  case 16: return !(id % 1111111111111111)
	      || (!(id %  101010101010101) && ((id / 101010101010101) >       9))
	      || (!(id %    1000100010001) && ((id /   1000100010001) >     999))
	      || (!(id %        100000001) && ((id /       100000001) > 9999999));
  case 17: return !(id % 11111111111111111);
  case 18: return !(id % 111111111111111111)
	      || (!(id %  10101010101010101) && ((id / 10101010101010101) >        9))
	      || (!(id %   1001001001001001) && ((id /  1001001001001001) >       99))
	      || (!(id %      1000001000001) && ((id /     1000001000001) >    99999))
	      || (!(id %         1000000001) && ((id /        1000000001) > 99999999));
  case 19: return !(id % 1111111111111111111);
  case 20: return !(id % 11111111111111111111u)
	      || (!(id %     1000010000100001u) && ((id / 1000010000100001u) >      9999))
	      || (!(id %          10000000001u) && ((id /      10000000001u) > 999999999));
  default: return false;
  }
  // clang-format on
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
  printf("%lu\n", solve(test_len, test));

  return 0;
}
