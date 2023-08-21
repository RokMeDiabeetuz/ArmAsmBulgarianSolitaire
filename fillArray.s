@ fillArray.s
@ Create a 46 element array and add random numbers into it. Max sum is 45; once 45 is reached,
@ the rest of the array will be filled with zeros.
@ Daryll Guiang, 007419370
@ CSCI 212, Summer 2023
@ July 24 2023
@ registries used:
    @ r4 - stores array pointer
    @ r8 - used to store count and for shift calculation
    @ r9 - temporary holds over value, fills indices with 0's in final part
    @ r10 - used as counter to a max of 45

@ define architecture
.cpu cortex-a72
.fpu neon-fp-armv8

@ text
.text
.align 2
.global fillArray
.type fillArray, %function

@ create array
fillArray:
    push {fp, lr}
    add fp, sp, #4

    @ save into r4 the array pointer
    mov r4, r0
    
    @ set random seed
    mov r0, #0
    bl time
    bl srand

    @ start loop
    mov r10, #0
    mov r8, #0
    loop:
        @ compare current sum to max of 45
        cmp r10, #45
        bge end
        @ get random number
        bl rand
        mov r1, #25         
        bl mod
        @ store random in r0
        add r0, r0, #1
        @ calculate offset
        mov r1, r8, lsl #2
        add r10, r10, r0
        @ check if over the 45 limit
        cmp r10, #45
        bgt fix
        continue:
        @ store random into arry index
        str r0, [r4, r1]
        add r8, r8, #1
        b loop
    fix:
        @ if the count is over 45, subtract that from 45
        sub r9, r10, #45
        sub r0, r9  @ store the the excess -45 into r0
        b continue


    zeroFill:  @ fills the rest of the array with 0's
        mov r5, #46 @ set the final index
        mov r9, #0  @ load the 0 into r9 to fill the rest of the indices
        zeroLoop:
            cmp r8, r5          @ end if the final index is reached.
            beq continueEnd     
            mov r1, r8, lsl #2
            str r9, [r4, r1]    @ fill index with 0
            add r8, r8, #1      @ increment index
            b zeroLoop

    end:
        mov r0, r8      @ store array size in r0 to return
        b zeroFill
        continueEnd:
        sub sp, fp, #4
        pop {fp, pc}
    


    


