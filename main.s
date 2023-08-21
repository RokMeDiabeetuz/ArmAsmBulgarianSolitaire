@ main.s
@ Starting program for bulgarian solitaire
@ Daryll Guiang, 007419370
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries:
    @ r4 - pointer to random array
    @ r5 - size of random array
    @ r6 - pointer to 1-9 array
    @ r7 - counter variable
    @ r8 - stores final item
    

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ data
.data
    initial: .asciz "\n\nInitial Random Array:  "
    current: .asciz "\n\t\tCurrent Array: "
    final:   .asciz "\n\n Final Array after %d loops: \t "

@ text
.text
.align 2
.global main
.type main, %function

main:
    @ save onto stack 
    push {fp, lr}
    add fp, sp, #4

    @ allocate array space, save in r4/r5
    sub sp, sp, #184    
    mov r4, sp          @ r4 - holds address for random array
    sub sp, sp, #36
    mov r6, sp          @ r5 - holds address for final array

    @ start counter:
    mov r7, #0

    @ fill random array
    mov r0, r4
    push {r4, r5, r6, r7}
    bl fillArray
    pop {r4, r5, r6, r7}
    mov r5, r0

    @ fill completed array
    mov r0, r6
    push {r4, r5, r6, r7}
    bl getFinalArray
    pop {r4, r5, r6, r7}

    @ print initial array
    ldr r0, =initial
    bl printf
    mov r0, r4
    mov r1, r5
    push {r4, r5, r6, r7}
    bl printArray
    pop {r4, r5, r6, r7}

    @ loop and shuffle, print current
    loop:
        @ increment count
        add r7, r7, #1

        @ call sub and fill
        mov r0, r4
        mov r1, r5
        push {r4, r5, r6, r7}   @ save values
        bl subAndFill
        pop {r4, r5, r6, r7}    @ restore values
        mov r5, r0
        
        @ call correct zeros to remove zeros and resize array
        mov r0, r4
        mov r1, r5
        push {r4, r5, r6, r7}
        bl correctZeros
        pop {r4, r5, r6, r7}
        mov r5, r0

        @ print current form of the array
        ldr r0, =current
        bl printf
        mov r0, r4
        mov r1, r5
        push {r4, r5, r6, r7}
        bl printArray
        pop {r4, r5, r6, r7}
 
        @ call compare, compares the random array with 
        mov r0, r4
        mov r1, r5
        mov r2, r6
        mov r3, #9
        push {r4, r5, r6, r7}
        bl compare              @ call compare method
        pop {r4, r5, r6, r7}
        mov r8, r0
        cmp r8, #9      @ end game if the arrays are the same
        beq end
        b loop

    end: @ print out final array
        ldr r0, =final      @ load and print final promp
        mov r1, r7
        bl printf           
        mov r0, r4          @ load and print final form of the array
        mov r1, r5
        bl printArray
        @ return control to os
        sub sp, fp, #4
        pop {fp, pc}




