REPORT  Z_ACCESS.

class myFriend definition deferred.

class mySuper definition friends myFriend.
  protected section.
    methods: setInt importing inInt type i,
             getInt returning value(exInt) type i.

  private section.
    data: privInt type i.
endclass.

class mySuper implementation.
  method setInt.
    privInt = inInt.
  endmethod.

  method getInt.
    exInt = privInt.
  endmethod.
endclass.

class myFriend definition.
  public section.
    methods: setVisInt importing inInt type i,
             getVisInt returning value(exInt) type i,
             constructor.
  private section.
    data: myFriend type ref to mySuper.
endclass.

class myFriend implementation.
  method constructor.
    create object myFriend.
  endmethod.

  method setVisInt.
    myFriend->privInt = inInt.
  endmethod.

  method getVisInt.
    exInt = myFriend->privInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myFriend,
        x     type i.
  create object myObj.

  myObj->setVisInt( 200 ).
  x = myObj->getVisInt( ). write : / x.