@ getFinalArray.s
@ Create a 9 element array with 1-9 in it
@ Daryll Guiang, 007419370
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r4 - stores array
    @ r9 - used to increment elements and counter
    @ r10 - used as to calculate shift

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global getFinalArray
.type getFinalArray, %function

@ create array
getFinalArray:
    @ save fp and lr
    push {fp, lr}
    add fp, sp, #4

    @ save array in r4
    mov r4, r0

    @ start loop
    mov r10, #0
    mov r9, #1

    @ loop to insert 1-9 in indices 0-8
    loop:
        cmp r9, #9
        beq end
        mov r1, r10, lsl #2
        str r9, [r4, r1]    @ store in current index current digit
        add r10, r10, #1    @ increment index and digit
        add r9, r9, #1      
        b loop
    
    end:
        @ return size of the array
        mov r0, r10 
        sub sp, fp, #4
        pop {fp, pc}
