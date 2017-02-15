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
  data: myObj      type ref to myClass,
        myCompound type ref to IFCompound,
        mySuper    type ref to IFSuper,
        x          type i.
  create object myObj.

  myObj->IFCompound~setInt( 200 ).
  myCompound = myObj.
  write : / myCompound->IFSuper~myInt.

  mySuper = myCompound.
  mySuper->myInt = 999.

  x = myObj->IFSuper~myInt. write : / x.