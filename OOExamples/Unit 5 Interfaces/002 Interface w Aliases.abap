REPORT  Z_INTERFACE.

interface myInterface.
  data: myInt type i.
  methods: setInt importing inInt type i,
           getInt returning value(exInt) type i.
endinterface.

class myClass definition.
  public section.
    interfaces: myInterface.
    aliases   : IFSET for myInterface~setInt,
                IFGET for myInterface~getInt,
                IFVAL for myInterface~myInt.
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
  data: myObj type ref to myClass.

  create object myObj.
  myObj->IFSET( 200 ).

  write : / myObj->IFVAL.