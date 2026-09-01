# Find type of roots and then calculate the roots if real.
.data
	array: .float 2.0, 4.0, 2.0, 5.0, 6.0, 5.0, 2.0, 8.0, 2.0
	zero: .float 0.0
	four: .float 4.0
	two: .float 2.0
	d: .float 0.0
	negative: .float -1.0
	newLine: .asciiz "\n"
	msgEqual: .asciiz "Equal roots: "
	msgImg: .asciiz "Imaginary roots"
	msgReal: .asciiz "Real roots: "
	
.text
	main:
		li $t0, 0
		li $t1, 3
		li $t2, 0
		loop:
			beq $t0, $t1, endLoop
			lwc1 $f1, array($t2)
			lwc1 $f5, array($t2)
			addi $t2, $t2, 4
			lwc1 $f2, array($t2)
			lwc1 $f6, array($t2)
			addi $t2, $t2, 4
			lwc1 $f3, array($t2)
			lwc1 $f7, array($t2)
			addi $t2, $t2, 4
			mul.s $f2, $f2, $f2
			mul.s $f1, $f1, $f3
			lwc1 $f4, four
			mul.s $f1, $f1, $f4
			sub.s $f2, $f2, $f1
			swc1 $f2, d
			lwc1 $f0, zero
			c.eq.s $f2, $f0
			bc1t equal
			c.lt.s $f2, $f0
			bc1t img
			c.lt.s $f0, $f2
			bc1t real
			
			equal:
				lwc1 $f8, negative
				mul.s $f8, $f8, $f6
				lwc1 $f9, two
				mul.s $f5, $f5, $f9
				div.s $f8, $f8, $f5
				
				la $a0, msgEqual
				li, $v0, 4
				syscall
				
				mov.s $f12, $f8
				li $v0, 2
				syscall 
				
				la $a0, newLine
				li, $v0, 4
				syscall
				
				j end
			
			img:
				la $a0, msgImg
				li, $v0, 4
				syscall
				
				la $a0, newLine
				li, $v0, 4
				syscall
				
				j end
			
			real:
				lwc1 $f8, negative			#f8=-1
				mul.s $f8, $f8, $f6		#f8=-b
				lwc1 $f13, d				#f3=d
				sqrt.s $f11, $f13		#f11=rt.d
				add.s $f10, $f8, $f11	#f10=-b+rt.d
				lwc1 $f9, two			#f9=2
				mul.s $f5, $f5, $f9		#f5=2a
				div.s $f10, $f10, $f5	#f10=(-b+rt.d)/2a
				
				la $a0, msgReal
				li, $v0, 4
				syscall
				
				mov.s $f12, $f10
				li $v0, 2
				syscall
				
				lwc1 $f8, negative
				mul.s $f11, $f11, $f8			#f11=-rt.d
				mul.s $f8, $f8, $f6				#f8=-b
				add.s $f10, $f8, $f11	#f10=-b-rt.d
				div.s $f10, $f10, $f5   #f10=(-b-rt.d)/2a
				
				
				mov.s $f12, $f10
				li $v0, 2
				syscall
				
				la $a0, newLine
				li, $v0, 4
				syscall
				
				j end	
				
				
			end:
				addi $t0, $t0, 1
				j loop
		
		
		endLoop:
			li $v0, 10
			syscall 
															
				
				
				
				
				
			
			