#-------------------------------------------------------------------------------------------
#  Assignment #: Project 1 Task 2
#  Name: Christopher McCormack
#  ASU email: cjmccorm@asu.edu
#  Course: CSE/EEE230, MW 4:30pm
#  Description: This is my second assembly language program.
#               It calculates dot product using left shift instead of mult.
#-------------------------------------------------------------------------------------------

# ======================================
# Description: perform dot product of 2 vectors using left shift
# Test:
# A = [6,5,2,3,4,1] = [0x6,0x5,0x2,0x3,0x4,0x1]
# B = [2,4,8,16,32,64] = [0x2,0x4,0x8,0x10,0x20,0x40]
# Expected result
# R = A.B = 12+20+16+48+128+64 = 288 = 0x120
# ======================================
# $s0 stores the address of vectorA
# $s1 stores the address of vectorB
# $s2 stores the final result (initialized to $zero)
# $s3 counter i
# $s4 counter j 
# $t0 condition
# $t1 internal flag used to compare to 1
# $t2 stores the address of vectorA[i]
# $t3 stores the address of vectorB[i]
# $t4 stores the value of vectorA[i]
# $t5 stores the value of vectorB[i]
# $t6 stores the intermediate shift left of t4

# ========== Data Segment
.data
vectorA: .word 6,5,2,3,4,1
vectorB: .word 2,4,8,16,32,64

# ========== Code Segment
.text
.globl main

main:

la $s0, vectorA    # [pseudo] puts the address of vectorA into $s0
la $s1, vectorB    # [pseudo] puts the address of vectorB into $s1
addi $s2, $zero, 0 # initialized the result to zero
addi $s3, $zero, 0 # i=0
addi $s4, $s3, 1   # j=i+1
addi $t1, $zero, 1 # $t1=1
addi $t2, $s0, 0   # $t2 stores the address of a[0]
addi $t3, $s1, 0   # $t3 stores the address of b[0]

LOOP:
slti $t0, $s3, 6   # $t0=1 if i < 6
bne $t0, $t1, EXIT # if i >= 6, exit from the loop
lw $t4, 0($t2)     # load a[i] to $t4
lw $t5, 0($t3)     # load b[i] to $t5
sllv $t6, $t4, $s4 # shift the value of a[i] left by the value of b[i]
add $s2,$s2,$t6    # add $t6 to final result
addi $s3, $s3, 1   # i=i+1
addi $s4, $s4, 1   # j=j+1
addi $t2, $t2, 4   # increment address of a[] by 4 bytes, 1 ptr.
addi $t3, $t3, 4   # increment address of b[] by 4 bytes, 1 ptr.
j LOOP

EXIT:
li $v0,10
syscall
# End of file