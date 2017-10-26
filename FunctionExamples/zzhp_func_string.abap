report zzhp_func_string.

data(mystr) = |The quick brown fox    |.

write: strlen( mystr ),
       numofchar( mystr ).

data(charof) =  char_off( val = mystr add  = 10 ).
write : charof. 

mystr = |{ mystr }{ repeat( val = 'fox' occ = 5 ) }|.

data(count) = count( val = mystr sub = |fox| ).
write count.

write : / mystr,
        / condense( mystr ).

write : / replace( val = mystr regex = |fox| with = |lupa| occ = 0 ).
write : / replace( val = mystr regex = |fox| with = |lupa| occ = -1 ).

write : / substring( val = mystr off = 4 len = 5 ).
write : / to_upper( substring( val = mystr off = 4 len = 5 ) ).
write : / mystr.

mystr = |123|.
write : / translate( val = mystr from = '13' to = 'AC' ) . 
mystr = |AAAABBBB|.
write : / shift_left( val = mystr places = 4 ).
write : / reverse( mystr ).