# String functions

## Various functions
```ABAP
data(mystr) = |The quick brown fox    |.
              "12345678901234567890123

write: strlen( mystr ),
     /  numofchar( mystr ).
"        23
"        19

mystr = |{ mystr }{ repeat( val = 'fox' occ = 5 ) }|.
"The quick brown fox    foxfoxfoxfoxfox

data(count) = count( val = mystr sub = |fox| ).
write / count.
"         6

write : / mystr,
        / condense( mystr ).
"The quick brown fox    foxfoxfoxfoxfox
"The quick brown fox foxfoxfoxfoxfox


write : / replace( val = mystr regex = |fox| with = |lupa| occ = 0 ).
"The quick brown lupa    lupalupalupalupalupa

write : / replace( val = mystr regex = |fox| with = |lupa| occ = -1 ).
"The quick brown fox    foxfoxfoxfoxlupa

write : / substring( val = mystr off = 4 len = 5 ).
"quick
write : / to_upper( substring( val = mystr off = 4 len = 5 ) ).
"QUICK

mystr = |123|.
write : / translate( val = mystr from = '13' to = 'AC' ) .
"A2C

mystr = |AAAABBBB|.
write : / shift_left( val = mystr places = 4 ).
write : / reverse( mystr ).
"BBBB
"BBBBAAAA
```