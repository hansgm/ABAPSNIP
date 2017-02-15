REPORT  Z_INTERFACE.

interface: IFSuper.
  data: myInt type i.
endinterface.

interface IFCompound.
  interfaces: IFSuper.
  methods: setInt importing inInt type i,
           getInt returning value(exInt) type i.
endinterface.

class myClass definition.
  public section.
    interfaces: IFCompound.
endclass.

class myClass implementation.
  method IFCompound~setInt.
    IFSuper~myInt = inInt.
  endmethod.

  method IFCompound~getInt.
    exInt = IFSuper~myInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass.
  create object myObj.

  myObj->IFCompound~setInt( 200 ).