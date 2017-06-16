# Reverse digits of an integer.

# Example1: x = 123, return 321
# Example2: x = -123, return -321

# click to show spoilers.

# Note:
# The input is assumed to be a 32-bit signed integer. Your function should return 0 when the reversed integer overflows.

def reverse(x)
  bignum = 2 ** 31 - 1
  reversed = x.abs.to_s.reverse.to_i
  return 0 if reversed >= bignum
  x > 0 ? reversed : reversed * -1
end