.data


packet:
    # --- DNS HEADER (12 bytes) ---
    .byte 0x12, 0x34      # ID
    .byte 0x01, 0x00      # FLAGS (standard query)
    .byte 0x00, 0x01      # QDCOUNT = 1 ✅
    .byte 0x00, 0x00      # ANCOUNT
    .byte 0x00, 0x00      # NSCOUNT
    .byte 0x00, 0x00      # ARCOUNT

    # Example DNS name: 3www5google3com0

    .byte 3,'w','w','w',6,'g','o','o','g','l','e',3,'c','o','m',0

output:
    .space 100

.text
.globl main

main:
    la $a0, packet
    la $a1, output
    # --- Check QDCOUNT == 1 ---
    lbu $t0, 4($a0)
    lbu $t1, 5($a0)

    sll $t0, $t0, 8
    or  $t0, $t0, $t1

    li $t2, 1
    bne $t0, $t2, INVALID



    move $t0, $a0
    j VALID

    INVALID: 
        li $v0, -1
        j DONE

    VALID: 
        addi $t0, $a0, 12

    PROCESS_CHARS:
        lbu $t1, 0($t0)
        li $v0, 1
        move $a0, $t1
        syscall

        beq $t1, $zero, DONE

        addi $t0, $t0, 1
        li $t3, 0

    COPY_LABEL_CHARS:
            lbu $t4, 0($t0)
            sb $t4, 0($a1)

            addi $t0, $t0, 1
            addi $a1, $a1, 1
            addi $t3, $t3, 1

            blt $t3, $t1, COPY_LABEL_CHARS   # ✅ loop while t3 < t1

            j NEXT_LABEL
   

    NEXT_LABEL:
        lbu $t5, 0($t0)            # look at next length

        beq $t5, $zero, PROCESS_CHARS  # last label → no dot

        li $t4, 46                 # '.'
        sb $t4, 0($a1)
        addi $a1, $a1, 1

        j PROCESS_CHARS

    DONE:
    
        li $v0, 4      # print string
        syscall

        li $v0, 10
        syscall
