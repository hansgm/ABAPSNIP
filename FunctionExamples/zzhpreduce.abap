report t.

parameters: fibo_in type i.



data(myint)  = reduce i( init sum = 0
                         for  n = 1 until n > fibo_in
                         next sum = sum + n ).

write myint.

types: tt_bseg type standard table of bseg with default key.

data(lt_bseg) = value tt_bseg(
  ( bukrs = '0001'
    belnr = '1234000000'
    gjahr = '2016'
    buzei = '001'
    bschl = '40'
    wrbtr = '666.22'
  )
  ( bukrs = '0001'
    belnr = '1234000000'
    gjahr = '2016'
    buzei = '002'
    bschl = '50'
    wrbtr = '222.11'
  )
).

data(diff) = value wrbtr( ) .
diff = lt_bseg[ 1 ]-wrbtr - lt_bseg[ 2 ]-wrbtr.
write diff.

*switch

data(sumpositions)  = reduce wrbtr(
  init sumpos type wrbtr
  for  wa in lt_bseg
  next  " sumPos = sumPos + wa-wrbtr
  sumpos =
    cond wrbtr(
      when wa-bschl = '50'
        then sumpos - wa-wrbtr
      when wa-bschl = '40'
        then sumpos + wa-wrbtr
  )
).

write : / sumpositions decimals 2.

data(sumpositions2)  = reduce wrbtr(
  init sumpos2 type wrbtr
  for  wa in lt_bseg
  next  " sumPos = sumPos + wa-wrbtr
  sumpos2 =
    switch wrbtr( wa-bschl
      when '50'
        then sumpos2 - wa-wrbtr
      when '40'
        then sumpos2 + wa-wrbtr
  )
).

write : / sumpositions2 decimals 2.


uline.

class mycls definition.
  public section.
    data: fiboout type i.
    methods : add_fibo importing fiboin      type i
                       returning value(this) type ref to mycls.
endclass.

class mycls implementation.
  method add_fibo.
    fiboout = fiboout + fiboin.
    write fiboout.
  endmethod.
endclass.

*
*data myfibo type ref to mycls.
*myfibo = reduce mycls(
*  init innerfibo = new mycls( )
*  for  n = 1 until n > fibo_in
*  next innerfibo = innerfibo->add_fibo( n )
*).

*loop at lt_abc assigning <fs_abc>.
*  write : / <fs_abc>-name, <fs_abc>-value.
*endloop.