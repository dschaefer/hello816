CC = cl65
ASFLAGS = -t c64 -l $(basename $<).list --create-dep $(basename $<).d

hello.prg:	hello.o
	cl65 -t c64 -C c64-asm.cfg -u __EXEHDR__ -o $@ $^

-include hello.d

clean:
	del *.o *.d

run:	hello.prg
	xscpu64 -fs9 . -device9 1 -iecdevice9 hello.prg
