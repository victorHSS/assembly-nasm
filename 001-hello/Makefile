AS = nasm
LD = ld
ASFLAGS = -f elf64

all: prog

prog: main.o
	$(LD) $^ -o $@
	
%.o: %.asm
	$(AS) $(ASFLAGS) $^ -o $@

clean:
	rm -rf *.o prog

.PHONY: clean
