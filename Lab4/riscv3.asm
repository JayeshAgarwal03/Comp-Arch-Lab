.data
	array: .word 12, 45, 23, 56, 78, 34, 67, 89, 21, 43
	array_len: .word 10
	normalized: .space 40          # 10 floats * 4 bytes
	minm: .float 100000.0
	maxm: .float -100000.0
	min_msg: .asciz "Minimum value: "
	max_msg: .asciz "Maximum value: "
	orig_msg: .asciz "Original array: "
	norm_msg: .asciz "Normalized array: "
	space: .asciz " "
	newline: .asciz "\n"

.text
.globl main
main:
# Your code here # Steps:
# 1. Find min and max of array
	li t0, 0
	lw t1, array_len
	la t3, array
	flw f1, minm, t6
	flw f2, maxm, t6

	Loop:
		bge t0, t1, endLoop
		add t2, t0, zero
		slli t2, t2, 2
		add t2, t3, t2
		lw t4, 0(t2)

		fcvt.s.w f3, t4         # f3 = (float) array[i]

		flt.s t5, f3, f1        # t5 = 1 if value < min
		beqz t5, checkMax
		fmv.s f1, f3            # min = value
	checkMax:
		flt.s t5, f2, f3        # t5 = 1 if max < value
		beqz t5, nextIter
		fmv.s f2, f3            # max = value
	nextIter:
		addi t0, t0, 1
		j Loop
	endLoop:

# print min and max (converted back to int, to match sample output)
	fcvt.w.s a0, f1
	la t6, min_msg
	mv a1, a0
	mv a0, t6
	li a7, 4
	ecall
	mv a0, a1
	li a7, 1
	ecall
	la a0, newline
	li a7, 4
	ecall

	fcvt.w.s a0, f2
	la t6, max_msg
	mv a1, a0
	mv a0, t6
	li a7, 4
	ecall
	mv a0, a1
	li a7, 1
	ecall
	la a0, newline
	li a7, 4
	ecall

# print original array
	la a0, orig_msg
	li a7, 4
	ecall
	li t0, 0
	PrintOrig:
		bge t0, t1, PrintOrigDone
		add t2, t0, zero
		slli t2, t2, 2
		add t2, t3, t2
		lw a0, 0(t2)
		li a7, 1
		ecall
		la a0, space
		li a7, 4
		ecall
		addi t0, t0, 1
		j PrintOrig
	PrintOrigDone:
	la a0, newline
	li a7, 4
	ecall

# 2. Normalize each element
# normalized_value = 2 * (value - min) / (max - min) - 1
	fsub.s f4, f2, f1              # f4 = range = max - min
	li t0, 0
	fcvt.s.w f5, t0                # f5 = 0.0
	li t0, 2
	fcvt.s.w f6, t0                # f6 = 2.0
	li t0, 1
	fcvt.s.w f7, t0                # f7 = 1.0

	feq.s t5, f4, f5               # range == 0 ?
	la t6, normalized

	li t0, 0
	NormLoop:
		bge t0, t1, NormDone
		add t2, t0, zero
		slli t2, t2, 2
		add t2, t3, t2
		lw t4, 0(t2)
		fcvt.s.w f3, t4          # f3 = (float) array[i]

		bnez t5, StoreZero
		fsub.s f8, f3, f1        # value - min
		fmul.s f8, f8, f6        # * 2
		fdiv.s f8, f8, f4        # / range
		fsub.s f8, f8, f7        # - 1
		j StoreVal
	StoreZero:
		fmv.s f8, f5             # all elements equal -> 0.0
	StoreVal:
		add t2, t0, zero
		slli t2, t2, 2
		add t2, t6, t2
		fsw f8, 0(t2)
		addi t0, t0, 1
		j NormLoop
	NormDone:

# 3. Print results
	la a0, norm_msg
	li a7, 4
	ecall
	li t0, 0
	PrintNorm:
		bge t0, t1, PrintNormDone
		add t2, t0, zero
		slli t2, t2, 2
		add t2, t6, t2
		flw fa0, 0(t2)
		li a7, 2
		ecall
		la a0, space
		li a7, 4
		ecall
		addi t0, t0, 1
		j PrintNorm
	PrintNormDone:
	la a0, newline
	li a7, 4
	ecall

	li a7, 10
	ecall