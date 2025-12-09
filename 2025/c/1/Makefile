CC=gcc
CFLAGS+=-Werror -Wextra -std=gnu23 # -Wpedantic forbids case ranges

input.h: input
	xxd -i $< > $@

part-1: part-1.c input.h
	$(CC) $(CFLAGS) $< -o $@

.phony: run-1
run-1: part-1
	./$<

.phony: clean
clean:
	rm part-1
	rm input.h
