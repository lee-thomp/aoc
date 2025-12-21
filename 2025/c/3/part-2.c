#include <stdio.h>

#if defined(TEST) && (TEST == 1)
#include "test.h"
#else
#include "input.h"
#endif

unsigned long int find_highest_joltage(size_t length, unsigned char const *input) {

  unsigned long int total = 0;

  unsigned char z = '0';
  unsigned char const *joltages[12] = {
    &z, &z, &z, &z, &z, &z,
    &z, &z, &z, &z, &z, &z,
  };

  /* Find the first highest joltage */
  for (unsigned char const *b = input - 12; b >= (input - length); --b) {
    if (*b >= *joltages[0]) {
      joltages[0] = b;
    }
  }

  /* and the rest —range from end plus index back to previous digit */
  for (size_t index = 1; 12 > index; ++index) {
    for (unsigned char const *b = input - (12 - index);
         b > joltages[index - 1]; --b) {
      if (*b >= *joltages[index]) {
        joltages[index] = b;
      }
    }
  }

  /* Sum up joltages */
  for (size_t index = 0; 12 > index; ++index) {
    total *= 10uL;
    total += (unsigned long int)(*joltages[index] - '0');
  }
  return total;
}

unsigned long int solve(unsigned int input_len, unsigned char input[static 1]) {

  unsigned long int total = 0;

  size_t line_length = 0;

  unsigned char const *p = input;

  while (p < (input + input_len)) {
    switch (*p) {
    case '0' ... '9':
      ++line_length;
      break;

    case '\n':
      /* Add highest joltage to total */
      total += find_highest_joltage(line_length, p);
      line_length = 0;
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
  printf("%lu\n", solve(test_len, test));
#else
  printf("%lu\n", solve(input_len, input));
#endif

  return 0;
}
