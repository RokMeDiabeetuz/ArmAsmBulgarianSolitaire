@ correctZeros.s
@ Iterates through the array and finds the indices with zeros. Swaps that index with the last item and 
@ updates the size of the array.
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r4 - store first array
    @ r5 - store size of first array
    @ r6 - index counter
    @ r7 - calculate offset
    @ r8 - temp storage for item in index
    @ r9 - temporary value


@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global correctZeros
.type correctZeros, %function

@ correct zeros
correctZeros:
    @ save previous method call
    push {fp, lr}
    add fp, sp, #4

    @ save items
    mov r4, r0
    mov r5, r1
    mov r6, #0
    loop:
        @ compare current index with the size of the array, end if they are the same
        cmp r6, r5
        beq end
        @ extract value at the current index, compare to 0
        mov r7, r6, lsl #2
        ldr r8, [r4, r7]
        cmp r8, #0
        @ if item is zero, swap items or modify array
        beq zeroFound
        add r6, r6, #1
        b loop

    @ if a zero is found in the random array
    zeroFound:
        @ extract item in last index
        mov r0, r5
        sub r0, r0, #1
        mov r0, r0, lsl #2
        ldr r1, [r4, r0]
        cmp r1, #0          
        @ if last item is also zero, decrement, count
        beq findNewEnding                
        @ otherwise, decrement count and swap
        sub r5, r5, #1
        mov r0, r4
        mov r1, r6
        mov r2, r5
        @ save local values
        push {r4, r5, r6, r7, r8, r9}
        bl swap @ swap the two indices
        @ restore local values
        pop {r4, r5, r6, r7, r8, r9}
        add r6, r6, #1 @ increment index by 1
        b loop

    @ restore previous method call
    end:
    mov r0, r5  @ return current size of the array
    sub sp, fp, #4
    pop {fp, pc}


    @ if no zeros other than the last item, decrement size of array and return
    findNewEnding:
        sub r5, r5, #1
        b loop
