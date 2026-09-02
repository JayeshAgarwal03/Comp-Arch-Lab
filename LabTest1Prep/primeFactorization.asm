# Print all the prime factors of integer num.
.data
	num: .word 101
	space: .asciiz " "
	
.text
	main:
		lw $t0, num
		li $t1, 1
		li $t2, 2
		
		loop:
			beq $t0, $t1, endLoop
			div $t0, $t2
			mfhi $t3
			beq $t3, $zero, divisible
			
			addi $t2, $t2, 1
			j loop 
			
			divisible:
				li $v0, 1
				move $a0, $t2
				syscall
				
				li $v0, 4
				la $a0, space
				syscall
				
				mflo $t0
				j loop
				
		endLoop:
			li $v0, 10
			syscall 