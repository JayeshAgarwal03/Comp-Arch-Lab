.data
prompt:    .asciz "Enter a real number: "
result_msg: .asciz "Sigmoid value: "
newline:   .asciz "\n"
const_one: .float 1.0
const_zero: .float 0.0
const_half: .float 0.5
neg_four:  .float -4.0
pos_four:  .float 4.0

.text
.globl main
main:

    # Print prompt
    li a7, 4
    la a0, prompt
    ecall

    # Read float input
    li a7, 6
    ecall

    # Calculate simplified sigmoid
    jal ra, simple_sigmoid

    # Print result message
    li a7, 4
    la a0, result_msg
    ecall

    # Print the result
    li a7, 2
    ecall

    # Print newline
    li a7, 4
    la a0, newline
    ecall

    # Exit
    li a7, 10
    ecall


# Simplified sigmoid function
# Rule: x <= -4 -> 0, x >= 4 -> 1, else compute 1/(1+e^(-x))
# Input: fa0 = x
# Output: fa0 = sigmoid(x)
simple_sigmoid:

    # Load constants
    flw ft0, neg_four, t0    # ft0 = -4.0
    flw ft1, pos_four, t0    # ft1 = 4.0
    flw ft2, const_zero, t0  # ft2 = 0.0
    flw ft3, const_one, t0   # ft3 = 1.0

    # Check if x <= -4.0
    fle.s t1, fa0, ft0       # if x <= -4.0
    bnez t1, return_zero

    # Check if x >= 4.0
    fle.s t1, ft1, fa0       # if 4.0 <= x
    bnez t1, return_one

    # For -4 < x < 4, compute using approximation
    # We use: sigmoid(x) ≈ 0.5 + 0.5 * (x / (1 + |x|))
    # This avoids complex exponential calculation


    # Calculate |x|
    fabs.s ft4, fa0          # ft4 = |x|

    # Calculate x / (1 + |x|)
    flw ft5, const_one, t0
    fadd.s ft5, ft5, ft4     # ft5 = 1 + |x|
    fdiv.s ft6, fa0, ft5     # ft6 = x / (1 + |x|)

    # Calculate 0.5 + 0.5 * (x / (1 + |x|))
    flw ft7, const_half, t0
    fmul.s ft6, ft7, ft6      # ft6 = 0.5 * (x / (1 + |x|))
    fadd.s fa0, ft7, ft6      # 0.5 + ...
    ret


return_zero:
    flw fa0, const_zero, t0
    ret

return_one:
    flw fa0, const_one, t0
    ret
