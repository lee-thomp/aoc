#include <stdio.h>
#include <stdint.h>

#include "input.h"

int solve(unsigned int input_len, unsigned char const *input) {

    int total = 50;
    int zero_count = 0;

    int current = 0;
    int sign = 1;

    int full_turns = 0;

    unsigned char const *p = input;

    while (p < (input + input_len)) {
      switch (*p) {
      case '0' ... '9':
        current *= 10;
	current += (*p - '0');
        break;

      case 'L':
        sign = -1;
      case 'R':
        break;

      case '\n':

	/* Self explanatory */
	full_turns += current / 100;
        current %= 100;
	
	/* Ugly logic */
	if (total > 0 && sign ==  1) { full_turns += (total + current) >  100; }
	if (total < 0 && sign ==  1) { full_turns += (total + current) >    0; }
	if (total > 0 && sign == -1) { full_turns += (total - current) <    0; }
	if (total < 0 && sign == -1) { full_turns += (total - current) < -100; }

        total += (current * sign);
        total %= 100;

	zero_count += (total == 0);


        current = 0;
	sign = 1;
	break;

      default:
        fprintf(stderr, "unknown char in input: %c at offset %zu\n",
                *p, p - input);
	return 0;
      }
      ++p;
    }
    return zero_count + full_turns;
}

int main(void) {

    printf("%d\n", solve(input_len, input));

    return 0;
}
