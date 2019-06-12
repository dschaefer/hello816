AS = cl65
ASFLAGS = -c -t c64 -l $(basename $<).list --create-dep $(basename $<).d
LDFLAGS = -t c64 -C c64-asm.cfg -u __EXEHDR__ -m $(basename $<).map -Ln $(basename $<).vice

hello.prg:	hello.o
	cl65 $(LDFLAGS) -o $@ $^

-include hello.d

clean:
	del *.o *.d

run:	hello.prg
	xscpu64 -moncommands hello.vice -fs9 . -device9 1 -iecdevice9 hello.prg
