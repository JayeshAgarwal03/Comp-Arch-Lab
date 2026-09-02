.data

# ============================================================
# MARS 4.5 - LAB 2 PRACTICE PROBLEMS
# 8 programs in one .asm file
# ============================================================


# ============================================================
# 1. GCD OF TWO NUMBERS
# ============================================================

.data
msg: .asciiz "GCD = "

.text
main:

    li $t0, 54        # a
    li $t1, 24        # b

	loop:
    	beq $t0, $t1, done

    	blt $t0, $t1, b_greater

    	# a > b
    	sub $t0, $t0, $t1
    	j loop

	b_greater:
    	# b > a
    	sub $t1, $t1, $t0
    	j loop

	done:
    	la $a0, msg
    	li $v0, 4
    	syscall

    	move $a0, $t0
    	li $v0, 1
    	syscall

    	li $v0, 10
    	syscall

# ============================================================






# ============================================================
# 2. PRIME FACTORIZATION
# ============================================================

# Find and print all prime factors of a positive integer.

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



# ============================================================
# 3. MEAN, VARIANCE AND STANDARD DEVIATION
# ============================================================

# mean = sum(x)/n
# variance = sum((x-mean)^2)/n
# SD = sqrt(variance)

# .data
# arr: .float 2.0, 4.0, 6.0, 8.0, 10.0
# n: .word 5
#
# msg1: .asciiz "Mean = "
# msg2: .asciiz "\nVariance = "
# msg3: .asciiz "\nStandard deviation = "
#
# .text
# main:
#     la $s0, arr
#     lw $t0, n
#
#     li $t1, 0
#
#     mtc1 $zero, $f0
#     cvt.s.w $f0, $f0
#
# sum_loop:
#     bge $t1, $t0, calculate_mean
#
#     sll $t2, $t1, 2
#     add $t3, $s0, $t2
#
#     l.s $f2, 0($t3)
#     add.s $f0, $f0, $f2
#
#     addi $t1, $t1, 1
#     j sum_loop
#
# calculate_mean:
#     mtc1 $t0, $f4
#     cvt.s.w $f4, $f4
#
#     div.s $f6, $f0, $f4
#
#     la $a0, msg1
#     li $v0, 4
#     syscall
#
#     mov.s $f12, $f6
#     li $v0, 2
#     syscall
#
#     li $t1, 0
#
#     mtc1 $zero, $f8
#     cvt.s.w $f8, $f8
#
# variance_loop:
#     bge $t1, $t0, calculate_variance
#
#     sll $t2, $t1, 2
#     add $t3, $s0, $t2
#
#     l.s $f10, 0($t3)
#
#     sub.s $f12, $f10, $f6
#     mul.s $f12, $f12, $f12
#
#     add.s $f8, $f8, $f12
#
#     addi $t1, $t1, 1
#     j variance_loop
#
# calculate_variance:
#     div.s $f14, $f8, $f4
#
#     la $a0, msg2
#     li $v0, 4
#     syscall
#
#     mov.s $f12, $f14
#     li $v0, 2
#     syscall
#
#     sqrt.s $f16, $f14
#
#     la $a0, msg3
#     li $v0, 4
#     syscall
#
#     mov.s $f12, $f16
#     li $v0, 2
#     syscall
#
#     li $v0, 10
#     syscall


# ============================================================
# 8. SOLVE A 2x2 SYSTEM OF LINEAR EQUATIONS
# ============================================================

# ax + by = e
# cx + dy = f
#
# D = ad - bc
# x = (ed - bf) / D
# y = (af - ec) / D

# .data
# a: .float 2.0
# b: .float 3.0
# c: .float 1.0
# d: .float -1.0
#
# e: .float 8.0
# f: .float 2.0
#
# zero: .float 0.0
#
# msg1: .asciiz "x = "
# msg2: .asciiz "\ny = "
# msg3: .asciiz "No unique solution."
#
# .text
# main:
#     l.s $f0, a
#     l.s $f2, b
#     l.s $f4, c
#     l.s $f6, d
#     l.s $f8, e
#     l.s $f10, f
#
#     # D = ad - bc
#     mul.s $f12, $f0, $f6
#     mul.s $f14, $f2, $f4
#     sub.s $f16, $f12, $f14
#
#     # check D == 0
#     l.s $f18, zero
#
#     c.eq.s $f16, $f18
#     bc1t no_solution
#
#     # x = (ed - bf) / D
#     mul.s $f20, $f8, $f6
#     mul.s $f22, $f2, $f10
#     sub.s $f24, $f20, $f22
#     div.s $f26, $f24, $f16
#
#     # y = (af - ec) / D
#     mul.s $f20, $f0, $f10
#     mul.s $f22, $f8, $f4
#     sub.s $f24, $f20, $f22
#     div.s $f28, $f24, $f16
#
#     la $a0, msg1
#     li $v0, 4
#     syscall
#
#     mov.s $f12, $f26
#     li $v0, 2
#     syscall
#
#     la $a0, msg2
#     li $v0, 4
#     syscall
#
#     mov.s $f12, $f28
#     li $v0, 2
#     syscall
#
#     j end
#
# no_solution:
#     la $a0, msg3
#     li $v0, 4
#     syscall
#
# end:
#     li $v0, 10
#     syscall
