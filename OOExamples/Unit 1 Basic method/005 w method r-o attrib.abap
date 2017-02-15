REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods: setMyInt importing inint type i.

    data myInt type i read-only.

endclass.

class myClass implementation.
  method setMyInt.
    myInt = inInt.
  endmethod.

endclass.

start-of-selection.
  data: myObj type ref to myClass.
  create object myObj.

  data i type i.

  myObj->setMyInt( 250 ).

  write : myObj->myInt.