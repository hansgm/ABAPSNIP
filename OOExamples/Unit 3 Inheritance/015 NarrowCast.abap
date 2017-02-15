REPORT  Z_INHERIT_CONSTRUCTOR.

class mySuper definition.
  public section. methods: showme..
endclass.

class mySuper implementation.
  method showme.
    write : / 'Generic'.
  endmethod.
endclass.

class mySub definition inheriting from mySuper.
  public section. methods: showsub.
endclass.

class mySub implementation.
  method showsub.
    write : / 'MiddleGeneric subclass'.
  endmethod.
endclass.

class mySubSub definition inheriting from mySub.
  public section. methods: showsubsub.
endclass.

class mySubSub implementation.
  method showsubsub.
    write : / 'Least Generic subclass'.
  endmethod.endclass.

start-of-selection.
  data: LeastGenericObj  type ref to mySubSub.
  data: MiddleGenericObj type ref to mySub.
  data: MostGenericObj   type ref to mySuper.

  Create object MostGenericObj type mySubSub.
  MostGenericObj->ShowMe( ).

  MiddleGenericObj ?= MostGenericObj.
  MiddleGenericObj->showSub( ).

  LeastGenericObj ?= MostGenericObj.
  LeastGenericObj->ShowSubSub( ).