report zzhp_subroutine.

class exc definition inheriting from cx_static_check.
  public section.
    data: errortext type string.
    methods: constructor importing exctext type string.
endclass.

class exc implementation.
  method constructor.
    super->constructor( ).
    errortext = exctext.
  endmethod.
endclass.

start-of-selection.
  data: tvar type string value 'ABC',
        ttab type table of t000.

  try.
      perform dosome tables ttab
                     using  tvar.
      write : / tvar, lines( ttab ).
    catch exc into data(lx).
      write : / lx->errortext.
  endtry.

form dosome tables ftab structure t000
            using  value(invalue)
            raising exc.

  select * from t000 into table ftab.
  if sy-subrc <> 0.
    raise exception type exc exporting exctext = 'No T000 record found'.
  endif.

  write invalue.
  replace all occurrences of 'A' in invalue with ''.
  write invalue.
endform.