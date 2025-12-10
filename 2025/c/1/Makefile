CC=gcc
CFLAGS+=-Werror -Wextra -std=gnu23 # -Wpedantic forbids case ranges

input.h: input
	xxd -i $< > $@

part-1: part-1.c input.h
	$(CC) $(CFLAGS) $< -o $@

.phony: run-1
run-1: part-1
	./$<

part-2: part-2.c input.h
	$(CC) $(CFLAGS) $< -o $@

.phony: run-2
run-2: part-2
	./$<

.phony: clean
clean:
	rm part-1
	rm input.h
