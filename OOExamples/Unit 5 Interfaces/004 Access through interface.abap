REPORT  Z_INTERFACE.

interface myInterface.
  data: myInt type i.
  methods: setInt importing inInt type i,
           getInt returning value(exInt) type i.
endinterface.

class myClass definition.
  public section.
    interfaces: myInterface.
endclass.

class myClass implementation.
  method myInterface~setInt.
    myInterface~myInt = inInt.
  endmethod.

  method myInterface~getInt.
    exInt = myInterface~myInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass,
        myIF  type ref to myInterface.

  create object myObj.
  myIF = myObj.

  myIF->setInt( 200 ).
  write : / myIF->myInt.