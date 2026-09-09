.data
	array: .float -2.5, -0.5, 2.5, 9.5, 16.0
	zero_f: .float 0.0
	ten_f: .float 10.0
	two_f: .float 2.0
	one_f: .float 1.0
	newLine: .asciiz "\n"
	space: .asciiz " "
	
.text
	main:
		li $t0, 0
		li $t1, 5
		li $t2, 0
		
		loop:
			beq $t0, $t1, endLoop
			lwc1 $f0, array($t2)
			lwc1 $f1, zero_f
			c.lt.s $f0, $f1
			bc1t lessThan0
			lwc1 $f1, ten_f
			c.eq.s $f0, $f1
			bc1t greaterOrEq10
			c.lt.s $f1, $f0
			bc1t greaterOrEq10
			lwc1 $f2, two_f
			mul.s $f3, $f0, $f2
			lwc1 $f4, one_f
			add.s $f3, $f3, $f4
			
			li $v0, 2
			mov.s $f12, $f0
			syscall
			
			li $v0, 4
			la $a0, space
			syscall
			
			li $v0, 2
			mov.s $f12, $f3
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			addi $t2, $t2, 4
			addi $t0, $t0, 1
			j loop
			
			
			lessThan0:
				mul.s $f3, $f0, $f0
				
				li $v0, 2
				mov.s $f12, $f0
				syscall
			
				li $v0, 4
				la $a0, space
				syscall
			
				li $v0, 2
				mov.s $f12, $f3
				syscall
				
				li $v0, 4
				la $a0, newLine
				syscall
				
				addi $t2, $t2, 4
				addi $t0, $t0, 1
				j loop
				
			greaterOrEq10:
				sqrt.s $f3, $f0
				li $v0, 2
				mov.s $f12, $f0
				syscall
			
				li $v0, 4
				la $a0, space
				syscall
			
				li $v0, 2
				mov.s $f12, $f3
				syscall
				
				li $v0, 4
				la $a0, newLine
				syscall
				
				addi $t2, $t2, 4
				addi $t0, $t0, 1
				j loop
		
		endLoop:
			li $v0, 10
			syscall 
				
				
			 
			
			
