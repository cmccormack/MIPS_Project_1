#-------------------------------------------------------------------------------------------
#  Assignment #: Project 1
#  Name: Christopher McCormack
#  ASU email: cjmccorm@asu.edu
#  Course: CSE/EEE230, MW 4:30pm
#  Description: This is my first assembly language program.
#               It calculates dot product.
#-------------------------------------------------------------------------------------------

# ======================================
# Description: perform dot product of 2 vectors
# Test:
# A = [6,5,2,3,4,1] = [0x6,0x5,0x2,0x3,0x4,0x1]
# B = [0,2,3,7,8,10] = [0x0,0x2,0x3,0x7,0x8,0x10]
# Expected result
# R = A.B = 0+10+6+21+32+10 = 79 = 0x4F
# ======================================
# $s0 stores the address of vectorA
# $s1 stores the address of vectorB
# $s2 stores the final result (initialized to $zero)
# $s3 counter i
# $t0 condition
# $t1 internal flag used to compare to 1
# $t2 stores the address of vectorA[i]
# $t3 stores the address of vectorB[i]
# $t4 stores the value of vectorA[i]
# $t5 stores the value of vectorB[i]
# $t6 stores the intermediate addition of t4 and t5

# ========== Data Segment
.data
vectorA: .word 6,5,2,3,4,1
vectorB: .word 0,2,3,7,8,10

# ========== Code Segment
.text
.globl main

main:

la $s0, vectorA    # [pseudo] puts the address of vectorA into $s0
la $s1, vectorB    # [pseudo] puts the address of vectorB into $s1
addi $s2, $zero, 0 # initialized the result to zero
addi $s3, $zero, 0 # i=0
addi $t1, $zero, 1 # $t1=1
addi $t2, $s0, 0   # $t2 stores the address of a[0]
addi $t3, $s1, 0   # $t3 stores the address of b[0]

LOOP:
slti $t0, $s3, 56   # $t0=1 if i < 6
bne $t0, $t1, EXIT # if i >= 6, exit from the loop
lw $t4, 0($t2)     # load a[i] to $t4
lw $t5, 0($t3)     # load b[i] to $t5
mult $t5, $t4      # $LO<=b[i]*a[i]
mflo $t6           # $t6<=$LO
add $s2,$s2,$t6    # add $t6 to final result
addi $s3, $s3, 1   # i=i+1
addi $t2, $t2, 4   # increment address of a[] by 4 bytes, 1 ptr.
addi $t3, $t3, 4   # increment address of b[] by 4 bytes, 1 ptr.
j LOOP

EXIT:
li $v0,10
syscall
# End of file