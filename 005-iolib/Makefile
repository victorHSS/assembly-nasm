AS = nasm
LD = ld
ASFLAGS = -f elf64

OARGS = *.o

all: prog

prog: $(OARGS)
	$(LD) $^ -o $@
	
%.o: %.asm
	$(AS) $(ASFLAGS) $^ -o $@

autoremove:
	rm -rf *.o

clean:
	rm -rf *.o prog

.PHONY: clean autoremove
