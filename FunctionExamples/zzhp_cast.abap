report zzhp_cast.

class anyvalue definition abstract .
endclass.

class datevalue definition inheriting from anyvalue.
  public section.
    data: myvalue type d.
    methods constructor importing setdate type d.
endclass.

class datevalue implementation.
  method constructor.
    super->constructor( ).
    myvalue = setdate.
  endmethod.
endclass.

class dateadder definition.
  public section.
    methods adddays importing dateobj type ref to datevalue
                              adddays type i.
endclass.

class dateadder implementation.
  method adddays.
    dateobj->myvalue = dateobj->myvalue + adddays.
  endmethod.
endclass.

start-of-selection.

  data: valobj type ref to anyvalue.
  valobj = new datevalue( |20161231|  ).

  new dateadder( )->adddays(
    dateobj = cast datevalue( valobj )
    adddays = 1
  ).

  write : cast datevalue( valobj )->myvalue dd/mm/yyyy.
