    .p816
    .smart
    .include "macros.s"

    ; start
    cpunat
    ai16
    swapStacks basic_stack, python_stack

    ldx #hello
    jsr print

    swapStacks python_stack, basic_stack
    ai8
    cpuemu
    rts
    .a16
    .i16

    .proc print
    ; B, X = pointer to string
    pha
    phy
    ; save and set dp to 0
    phd
    lda #0
    tad
    ; need to use basic stack for kernel call
    swapStacks python_stack, basic_stack
    a8
loop:
    lda a:0, x
    beq done
    ; prepare for kernel call
    phx
    phb
    i8
    ; set bank to zero
    ldy #0
    phy
    plb
    ; call the kernel
    cpuemu
    jsr $FFD2 ; chrout
    cpunat
    ; put the bank back
    i16
    plb
    plx
    ; next character
    inx
    bra loop
done:
    a16
    swapStacks basic_stack, python_stack
    pld
    ply
    pla
    rts
    .endproc

hello:
    .asciiz "hello world!"

basic_stack:
    .word 0

python_stack:
    .word $7fff
