report zzhp_funclogical.

write : / boolc( 1 = 1 ), xsdbool( 1 = 1 ).
data(boolxresult) = boolx( bool = 1 = 1 bit = 7 ).
write : / boolxresult.
skip.

if contains( val = 'Willow' sub = 'LL' case = abap_false ) .
  write : / |Does contain|.
endif.

if contains( val = 'Willow' end = 'loW' case = abap_false ) .
  write : / |endswith|.
endif.

if contains_any_of( val = 'Willow' sub = 'alo' ) .
  write : / |contains any of|.
endif.

if contains_any_not_of( val = 'Willow' sub = 'wil' ) .
  write : / |contains any not of|.  "Cannot make any usefull of this
endif.

if matches( val = 'Willow' regex = |[uW]illo[ABCDw]| ).
   write : / |matches|.
endif.

data(lt_str) = value stringtab(
  ( |Alpha| )
  ( |Beta| )
).

if line_exists( lt_str[ table_line = |Alpha| ] ).  "Only indexable tables or (!) indexes
  write : / 'Line exists'.
endif.