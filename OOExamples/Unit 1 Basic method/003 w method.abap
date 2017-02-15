REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods: setMyInt importing inint type i,
             getMyInt returning value(reint) type i.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method setMyInt.

  endmethod.

  method getMyInt.

  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass.
  create object myObj.

  data i type i.

  myObj->setMyInt( 250 ).
  i = myObj->getMyInt(  ).