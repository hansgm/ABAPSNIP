REPORT  ZZHPCLASS_ZZHP_INHERIT.

  class mySuper definition.
    public section.
      methods: setInt importing inint type i,
               getInt returning value(retint) type i.
      data: anyInt type i.

  endclass.

  class mySuper implementation.
    method setInt.
      anyInt = inint.
    endmethod.
    method getInt.
      retint = anyInt.
    endmethod.
  endclass.

  class mySub definition inheriting from mySuper.
    public section.
      methods: setNum importing inNum type n.
  endclass.

  class mySub implementation.
    method setNum.
      anyInt = inNum.
    endmethod.
  endclass.

  start-of-selection.
    data: myObj     type ref to mySub.

    create object: myObj.
    myObj->setNum( 5 ).
    write myObj->anyInt.