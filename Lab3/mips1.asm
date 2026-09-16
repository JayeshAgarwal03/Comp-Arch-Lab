.data
	arr: .word 3, 7, 12, 18, 25, 31, 42, 56, 71, 89
	x: .word 42
	l: .word 0
	h: .word 10
	str: .asciiz "Element found at: "
	
.text
main:
	lw $a0, l
	lw $a1, h
	
	jal fun
	
	la $a0, str
	li $v0, 4
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
	
	
fun:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	blt $a1, $a0, retMinus1
	
	add $t0, $a0, $a1
	li $t1, 2
	div $t0, $t1
	mflo $t3		#t3=mid
	move $t0, $t3
	sll $t0, $t0, 2
	
	lw $t1, arr($t0)   #t1=arr[mid]
	lw $t2, x			#t2=x
	
	blt $t2, $t1, lo
	
	blt $t1, $t2, hi
	
	addi $sp, $sp, 12
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	move $v0, $t3
	jr $ra
	
	
	
	
	
	lo:
		addi $t3, $t3, -1
		move $a1, $t3
		jal fun
		
	hi:
		addi $t3, $t3, 1
		move $a0, $t3
		jal fun
	
	
	
	retMinus1:
		addi $sp, $sp, 12
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)	
		li $v0, -1
		jr $ra
	
	
	
	