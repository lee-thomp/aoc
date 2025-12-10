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
        full_turns += current / 100;
        current %= 100;
	
	if (total > 0 && sign ==  1) { full_turns += (total + current) >  100; }
	if (total < 0 && sign ==  1) { full_turns += (total + current) >    0; }
	if (total > 0 && sign == -1) { full_turns += (total - current) <    0; }
	if (total < 0 && sign == -1) { full_turns += (total - current) < -100; }

        1 || printf("full_turns: %2d, count: %2d, \
current × sign: %4d, total: %4d\n", full_turns, zero_count, current * sign, total);

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
