# Euclidean Distance 
.data
	vector1: .float 1.0, 2.0, 3.0
	vector2: .float 4.0, 5.0, 6.0
	sum: .float 0.0
	two: .float 2.0
	
.text
	main:
		li $t0, 0
		li $t3, 3
		lwc1 $f7, sum
		loop1:
			sll $t1, $t0, 2
			lwc1 $f0, vector1($t1)
			lwc1 $f1, vector2($t1)
			sub.s $f3, $f1, $f0
			mul.s $f3, $f3, $f3
			add.s $f7, $f7, $f3
			addi $t0, $t0, 1
			beq $t0, $t3, endLoop1
			j loop1
		
		endLoop1:
			swc1 $f7, sum
			lwc1 $f8, sum
			li $t0, 0
			li $t1, 10
			loop2:
				beq $t0, $t1, endLoop2
				div.s $f9, $f7, $f8		#a=n/x
				add.s $f9, $f9, $f8		#a=x+n/x
				lwc1 $f2, two			
				div.s $f9, $f9, $f2		#a=(x+n/x)/2.0
				mov.s $f8, $f9			#x=a
				addi $t0, $t0, 1 
				j loop2
		
		endLoop2:
			mov.s $f12, $f8
			li $v0, 2
			syscall 
			
			
			li $v0, 10
			syscall
		
		
			
			
	
