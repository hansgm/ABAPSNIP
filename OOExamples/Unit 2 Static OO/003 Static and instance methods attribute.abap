REPORT  Z_STATIC.

class myStatic definition.
  public section.
    methods: constructor importing inKey type i,
             getName     returning value(outKey) type i.

  private section.
    class-data: key type i value 233 .
    class-methods: convertKey importing inKey type i returning value(outKey) type i.
    class-methods: convertYek importing inKey type i returning value(outKey) type i.
    data: myName type i.
endclass.

class myStatic implementation.
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