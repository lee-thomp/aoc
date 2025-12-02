part-1.o: part-1.nasm input
	nasm -f elf64 -o $@ $<

part-1: part-1.o
	ld -o $@ $<

.PHONY: run-1
run-1: part-1
	./$<

.PHONY: clean
clean:
	rm -rf *.o
