REPORT  ZZHPCLASS_BASIC.

class myClass definition.

endclass.

class myClass implementation.

endclass.

start-of-selection.
  data: myObj type ref to myClass.

  if myObj is not bound.
    write / 'myObj is not yet instantiated'.
  endif.

  create object myObj.

  if myObj is bound.
    write / 'myObj is instantiated'.
  endif.