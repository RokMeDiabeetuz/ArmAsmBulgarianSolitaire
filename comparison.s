@ comparison.s
@ takes in two arrays and their lengths, compares the items in common and returns the 
@ total number of items they have in common. Returns 0 if arrays are not the same size
@ array 1 address in arg1, array 1 size in arg2, array 2 address in ar3, array 2 size in arg4
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r4 - store first array
    @ r5 - store size of first array
    @ r6 - store second array
    @ r7 - store size of second array
    @ r8 - outer index
    @ r9 - inner index
    @ r10 - similarities counter

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global compare
.type compare, %function

@ compare function
compare:
    @ save previous method call
    push {fp, lr}
    add fp, sp, #4
    
    @ save values
    mov r4, r0
    mov r5, r1
    mov r6, r2
    mov r7, r3
        
    @ compare size of arrays
    cmp r7, r5
    bne notSameLenght

    @ declare similarities counter
    mov r10, #0
    @ declare outer index
    mov r8, #0
    @ start loop
    outerLoop:
        @ compare outer loop counter
        cmp r8, #10
        beq endOuter
        mov r9, #0
        @ start inner loop
        innerLoop:
            @ compare inner loop
            cmp r9, r5
            beq endInner
            @ extract from outer array (the final array)
            mov r0, r8, lsl #2
            ldr r2, [r6, r0]
            @ extract from inner array (the random array)
            mov r1, r9, lsl #2
            ldr r3, [r4, r1]
            @ compare values; if a match, increment count.
            cmp r3, r2
            beq addCount
            add r9, r9, #1
            b innerLoop
            addCount: @ increment count, end inner loop
                add r10, r10, #1
                add r9, r9, #1
                b endInner

        @ end inner loop
        endInner:
        add r8, r8, #1
        b outerLoop

    @ exit once outer array traversed.
    endOuter:
        mov r0, r10
        b end
    
    @ if arrays not the same length, it is not a match. 0 returned.
    notSameLenght:
        mov r0, #0
        b end

    end:
        @ restore previous method call
        sub sp, fp, #4
        pop {fp, pc}

