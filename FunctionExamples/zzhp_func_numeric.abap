report zzhp_func_numeric.

data: lv_p type p decimals 2 value '1.51-'.
types tt_int type i.

start-of-selection.
  write : / conv tt_int( lv_p ),
            abs( lv_p  ),
            conv tt_int( ceil( lv_p ) ),
            conv tt_int( floor( lv_p ) ),
            sign( lv_p ),
            trunc( lv_p ),
            frac( lv_p ).

  data angle type f value '90E01'.
  write : / sin( angle ).  "Strange outcome. Should be 1.00

  lv_p = round( val = lv_p prec = 1 ).
  write : / lv_p.

  lv_p = '1.51'.
  lv_p = rescale( val = lv_p prec = 2  ).   "1.51, prec 2 - 2 digigs > 1.50
  write : / lv_p.