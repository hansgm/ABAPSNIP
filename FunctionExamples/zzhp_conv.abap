report zzhp_conv.

class financevalue definition.
  public section.
    data: myvalue type wrbtr.
    methods: setvalue importing newval type wrbtr,
      getvalue returning value(val) type wrbtr.
endclass.

class financevalue implementation.
  method setvalue.
    myvalue = newval.
  endmethod.

  method getvalue.
    val = myvalue.
  endmethod.
endclass.

start-of-selection.
  data(testvalue) = |444.71| .    "implicitly type string
  data(finvalueobj) = new financevalue( ).
  finvalueobj->setvalue( newval = conv #( testvalue ) ).

  write : / finvalueobj->getvalue( ).
