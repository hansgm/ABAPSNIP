REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods changeInt changing i type i default 6.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method changeInt.
    if i is supplied.
      myInt = i.
    else.
      myInt = i .   "i does exist
    endif.
  endmethod.

endclass.

start-of-selection.
  data: myObj type ref to myClass, loci type i.
  create object myObj.

  myObj->changeInt( ).