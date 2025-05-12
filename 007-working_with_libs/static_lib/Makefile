AS = nasm
LD = ld
ASFLAGS = -f elf64

all: prog

prog: main.o lib.o file.o
	$(LD) $^ -o $@

%.o: %.asm
	$(AS) $(ASFLAGS) $^ -o $@

autoremove:
	rm -rf *.o

clean:
	rm -rf *.o prog

.PHONY: clean autoremove
