.data
	vector1: .float 1.0, 2.0, 3.0
	vector2: .float 4.0, 5.0, 6.0
	sum: .float 0.0
	two: .float 2.0
	
.text
	main:
		li $t0, 0
		li $t3, 2
		lwc1 $f7, sum
		loop1:
			sll $t1, $t0, 2t1
			lwc1 $f0, vector1($t1)
			lwc1 $f1, vector2($t1)
			sub.s $f3, $f1, $f0
			mul.s $f3, $f3, $f3
			add.s $f7, $f7, $f3
			addi $t0, $t0, 1
			beq $t0, $t3, endLoop1
			j loop1
		
			endLoop1:	
		li $t0, 0
		li $t3, 9
		lwc1 $f8, sum
		loop2:
			add.s $f9, $f7
			addi $t0, $t0, 1
			beq $t0, $t3, endLoop2
			j loop2
		
		
			
			
	