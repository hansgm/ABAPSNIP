REPORT  Z_INTERFACE.

interface myIFOne.
  data: myInt type i.
  methods: setInt importing inInt type i.
endinterface.

interface myIFTwo.
  data: myInt type i.
  methods: setInt importing inInt type i.
endinterface.

class myClass definition.
  public section.
    interfaces: myIFOne, myIFTwo.
endclass.

class myClass implementation.
  method myIFOne~setInt.
    myIFOne~myInt = inInt.
  endmethod.

  method myIFTwo~setInt.
    myIFTwo~myInt = inInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass.

  create object myObj.
  myObj->myIFOne~setInt( 1000 ).
  myObj->myIFTwo~setInt( 2000 ).

  write : myObj->myIFOne~myInt, myObj->myIFTwo~myInt.