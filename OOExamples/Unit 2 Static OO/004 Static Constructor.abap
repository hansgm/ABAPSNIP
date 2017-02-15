REPORT  Z_STATIC.

class myStatic definition.
  public section.
    class-methods: class_constructor.
    methods: constructor importing inKey type i,
             getName     returning value(outKey) type i.

  private section.
    class-data: key type i.
    class-methods: convertKey importing inKey type i returning value(outKey) type i.
    class-methods: convertYek importing inKey type i returning value(outKey) type i.
    data: myName type i.
endclass.

class myStatic implementation.
  method class_constructor.
    key = sy-uzeit.
  endmethod.

  method convertKey.
    outKey = inKey * key.
  endmethod.

  method convertYek.
    outKey = inKey / key.
  endmethod.

  method constructor.
    myName = convertKey( inKey ).
  endmethod.

  method getName.
    outKey = convertYek( myName ).
  endmethod.
endclass.

start-of-selection.
  data: myObj1 type ref to myStatic,
        myObj2 type ref to myStatic,
        x      type i.

  create object myObj1 exporting inKey = 200.
  create object myObj2 exporting inKey = 300.

  x = myObj1->getName( ). write : / x.
  x = myObj2->getName( ). write : / x.