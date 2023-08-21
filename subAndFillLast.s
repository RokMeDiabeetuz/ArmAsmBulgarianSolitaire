@ subAndFillLast.s
@ subtracts 1 from each index and adds the sum to the index after 
@ the current last index.
@ Daryll Guiang, 007419370
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r4 - array pointer
    @ r5 - size of array
    @ r6 - holds updated size of array
    @ r7 - calculates the offset
    @ r8 - index counter
    @ r9 - stores temp value from each index

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global subAndFill
.type subAndFill, %function

subAndFill:
    @ save previous method call
    push {fp, lr}
    add fp, sp, #4

    @ save current items
    mov r4, r0
    mov r5, r1
    add r6, r5, #1

    @ fill up spot after last index with the sum of all indices
    mov r7, r5, lsl #2
    str r5, [r4, r7]

    @ start loop to subtract
    mov r8, #0
    loop:
        cmp r8, r5
        beq end
        @ calculate offset, extract item from index
        mov r7, r8, lsl #2
        ldr r9, [r4, r7]
        sub r9, #1          @ subtract 1 from current value
        str r9, [r4, r7]    @ load updated value into the same index
        add r8, r8, #1      @ increment index
        b loop

    @ restore previous method call
    end:
    mov r0, r6
    sub sp, fp, #4
    pop {fp, pc}
