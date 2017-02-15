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
      methods: setInt redefinition.
  endclass.

  class mySub implementation.
    method setInt.
      data x_factor type i value 199.
      x_factor = inint * x_factor.
      super->setInt( x_factor ).
    endmethod.
  endclass.

  class mySubSub definition inheriting from mySub.
    public section.
      methods: setInt redefinition.
  endclass.

  class mySubSub implementation.
    method setInt.
      data x_factor type i value 199.
      x_factor = inint * x_factor.
      super->setInt( x_factor ).
    endmethod.
  endclass.

  start-of-selection.
    data: myObj     type ref to mySubSub.

    create object: myObj.
    myObj->setInt( 5 ).
    write myObj->anyInt.