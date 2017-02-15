REPORT  Z_STATIC.

class myStatic definition.
  public section.
    class-data: staticInt type i.
    class-methods: setInt importing inInt type i.
endclass.

class myStatic implementation.
  method setInt.
    StaticInt = inInt.
  endmethod.
endclass.

start-of-selection.
  myStatic=>setint( 200 ).
  write : / myStatic=>staticInt.

  data: myObj type ref to myStatic.
  create object myObj.

  myObj->setInt( 500 ).
  write : / myObj->staticInt.
  write : / myStatic=>staticInt.