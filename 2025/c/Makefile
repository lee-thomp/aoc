CC=gcc
CFLAGS+=-Werror -Wextra -Wconversion -std=gnu23 # -Wpedantic forbids case ranges

# Inputs
input.h: input
	xxd -i $< > $@

test.h: test
	xxd -i $< > $@

# Part 1
part-1-full: part-1.c input.h
	$(CC) $(CFLAGS) -DTEST=0 $< -o $@

part-1-test: part-1.c test.h
	$(CC) $(CFLAGS) -DTEST=1 -g $< -o $@

.phony: test-1
test-1: part-1-test
	./$<

.phony: run-1
run-1: part-1-full
	./$<

# Part 2
part-2-full: part-2.c input.h
	$(CC) $(CFLAGS) -DTEST=0 $< -o $@

part-2-test: part-2.c test.h
	$(CC) $(CFLAGS) -DTEST=1 -g $< -o $@

.phony: test-2
test-2: part-2-test
	./$<

.phony: run-2
run-2: part-2-full
	./$<
