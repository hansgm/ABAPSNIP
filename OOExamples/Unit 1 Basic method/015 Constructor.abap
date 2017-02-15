REPORT  ZZHP_CONSTRUCTOR.

class myClass definition.
  public section.
    methods: setMyInt importing inint type i,
             getMyInt returning value(reint) type i,
             constructor importing inint type i optional.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method setMyInt.
    myInt = inint.
  endmethod.

  method constructor.
    if inint is supplied.
      myInt = inint.
    endif.
  endmethod.

  method getMyInt.
    reint = Myint.
  endmethod.
endclass.

Start-of-selection.
  data: myObj type ref to myClass.
  create object myObj exporting inint = 5.

  data: x type i.
  x = myObj->getMyInt( ).
  write x.