report zzhp_func_bytestring.

data: xstr type xstring value '0B0A09080706050403020100'.

write xstr.
write xstrlen( xstr ).

while sy-index < 16.  " 64.
  data(bitset2) =  bit-set( sy-index ).
  write : / sy-index, bitset2.
  bitset2 =  bit-set( 0 - sy-index ).
  write :  bitset2.
endwhile.

skip.

data : b type x length 1, c type x length 1, d type x length 1..

b = '01'.
c = '08'.
d = b bit-or c.   "bit-xor, bit-and likewise
write : / b, c, d.