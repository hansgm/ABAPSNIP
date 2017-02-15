REPORT  Z_ACCESS.

class mySuper definition.
  protected section.
    methods: setInt importing inInt type i,
             getInt returning value(exInt) type i.

  private section.
    data: privInt type i.
endclass.

class mySuper implementation.
  method setInt.
    data: scope_limited_to_method type i.
    privInt = inInt + scope_limited_to_method.
  endmethod.

  method getInt.
    exInt = privInt.
  endmethod.
endclass.

class mySub definition inheriting from mySuper.
  public section.
    methods: setVisInt importing inInt type i,
             getVisInt returning value(exInt) type i.
endclass.

class mySub implementation.
  method setVisInt.
    setInt( inInt ).
  endmethod.

  method getVisInt.
    exInt = getInt( ).
  endmethod.
endclass.


start-of-selection.
  data: myObj type ref to mySub,
        x     type i.
  create object myObj.

  myObj->setVisInt( 200 ).
  x = myObj->getVisInt( ). write : / x.