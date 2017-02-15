REPORT  ZZHPCLASS_ZZHP_INHERIT.

  class mySuper definition abstract.
    public section.
      methods: setInt importing inint type i ,
               getInt abstract returning value(retint) type i.
      data: anyInt type i.

  endclass.

  class mySuper implementation.
    method setInt.
      anyInt = inint.
    endmethod.

  endclass.

  class mySub definition inheriting from mySuper.
    public section.
      methods: getInt redefinition.
  endclass.

  class mySub implementation.
    method getInt.
      retint = anyInt * 199.
    endmethod.
  endclass.

  start-of-selection.
    data: myObj     type ref to mySub,
          x         type i.

    create object: myObj.
    myObj->setInt( 5 ).
    x = myObj->getInt( ).
    write x.