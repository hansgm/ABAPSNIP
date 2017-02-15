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

class ABC definition.
  public section.
    methods doIt importing IF type ref to myInterface.
endclass.

class ABC implementation.
  method doIt.
    write : / 'Old value of myInt was: ', IF->myInt.
    IF->setInt( 999 ).
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass,
        myABC type ref to ABC.

  create object : myObj, myABC.
  myObj->myInterface~setInt( 200 ).

  myABC->doit( myObj ).

  write : / 'Value after call is:    ', myObj->myInterface~myInt.