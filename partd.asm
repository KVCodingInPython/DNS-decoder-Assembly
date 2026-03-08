
.text
lbu $t0 4($a0)
lbu $t1 5($a0)
bne $t0 $zero NOT_ZERO 

ZERO:
    li $t2 0x01
    beq $t1 $t2 VALID
NOT_ZERO:
    li $v0 -1

VALID:
    lbu $t0 12($a0)

PROCESS_CHARS:
    addi $sp $sp -4
    lbu $t0 12($a0)
    lbu $t1 0($t0)
    beq $t1 $zero PROCESS_CHARS
    addi $t0 $t0 1
    move $t2 $t0
    li $t3 0

COPY_LABEL_CHARS:
    beq $t3 $t1 COPY_LABEL_CHARS
    lbu $t4 0($t0)
    sb $t4 0($a1)
    addi $t0 $t0 1
    addi $a1 $a1 1
    addi $t3 $t3 1
    j COPY_LABEL_CHARS

CHECK_GAPS:
    lb $t5 0($t0)
    beq $t5 $zero SKIP_GAP
    sw $a1 0($sp)
    addi $sp $sp -4
    addi $a1 $a1 1

SKIP_GAP:
    j CHECK_GAPS

INSERT_DOTS:
    addi $sp $sp 4

INSERT_DOTS_LOOP:
    lw $t2 0($sp)
    beq $t2 $zero DONE
    li $t4 0x2E
    sb $t4 0($t2)
    addi $sp $sp 4
    j INSERT_DOTS_LOOP

DONE:
    move $t0 $v0
