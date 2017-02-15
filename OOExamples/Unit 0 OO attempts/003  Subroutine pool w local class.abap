program  z_subroutine_pool_w_class.

class local_class definition.
  public section.
    data: myint type i.

    methods: setint importing inint type i,
             getint returning value(outint) type i.
endclass.

class local_class implementation.
  method setint.
    myint = inint.
  endmethod.                    "setint

  method getint.
    outint = myint.
  endmethod.                    "getInt
endclass.

data: myObj type ref to local_class.


form create_obj using inInt.
  create object myObj.
  myObj->setInt( inInt ).
endform.

form read_obj using outInt.
  outInt = myObj->getInt( ).
endform.