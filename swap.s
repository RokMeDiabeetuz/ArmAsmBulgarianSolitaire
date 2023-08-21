@ swap.s
@ Swaps the values between two indices of a given array.
@ first 0.
@ Daryll Guiang, 007419370
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r0 - array pointer
    @ r1 - index of zero element
    @ r2 - index of last element
    @ r3 - calculates index
    @ r4 - temprorary storage

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global swap
.type swap, %function

@ swap method
swap:
    @ save previous method call
    push {fp, lr}
    add fp, sp, #4
    
    @ swap
    mov r3, r2, lsl #2      @ extract the first value
    ldr r4, [r0, r3]
    mov r3, r1, lsl #2      
    str r4, [r0, r3]        @ place the second index's value into the first index
    mov r4, #0
    mov r3, r2, lsl #2
    str r4, [r0, r3]        @ place the first index's value into the second index

    @ restore previous method call
    sub sp, fp, #4
    pop {fp, pc}




