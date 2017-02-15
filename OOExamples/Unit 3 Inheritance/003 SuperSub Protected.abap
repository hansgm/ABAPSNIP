  REPORT  ZZHPCLASS_ZZHP_INHERIT.

  class mySuper definition.
    protected section.
      data: mySuperInt type i.
  endclass.

  class mySub definition inheriting from mySuper.
    public section.
      methods: setSuperInt importing inint type i,
               getSuperInt returning value(retint) type i.
  endclass.

  class mySub implementation.
    method setSuperInt.
      mySuperInt = inint.
    endmethod.
    method getSuperInt.
      retint = mySuperInt.
    endmethod.
  endclass.

  start-of-selection.
    data: myObj     type ref to mySub.

    create object: myObj.
    myObj->setSuperInt( 5 ).