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

class mySubclass definition inheriting from myClass.
endclass.

start-of-selection.
  data: myObj      type ref to mySubClass,
        myCompound type ref to IFCompound,
        mySuper    type ref to IFSuper,
        my2ndObj   type ref to myClass,
        x          type i.

  create object myObj.
  myObj->IFCompound~setInt( 200 ).

  mySuper = myObj.
  write : / mySuper->myInt.

  myCompound ?= mySuper.
  mySuper->myInt = 909090.

  my2ndObj ?= myCompound.
  x = my2ndObj->IFSuper~myInt. write : / x.