REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods DOIT importing t type ref to T000.
endclass.

class myClass implementation.
  method DOIT.
    field-symbols <T000> type T000.
    Assign t->* to <T000>.
    <T000>-MTEXT = 'Destroy the old value'.
  endmethod.

endclass.

start-of-selection.
  data: myObj     type ref to myClass,
        T000TAB   type table of T000,
        T000Ref   type ref to T000,
        T000TUP   type T000.

  create object: myObj.

  select * from T000 into table T000TAB.
  loop at T000TAB reference into T000REF.
    myObj->doit( T000REF ).
  endloop.

  loop at t000tab into t000tup.
    write : / t000tup-mandt, t000tup-mtext.
  endloop.