REPORT  Z_EXC.

class exc definition inheriting from cx_dynamic_check.
  public section.
    data: errortext type string.
    methods: constructor importing excText type string.
endclass.

class exc implementation.
  method constructor.
    super->constructor( ).
    errorText = excText.
  endmethod.
endclass.

class highlevelexc definition inheriting from cx_dynamic_check.
endclass.

class myClass definition.
  public section.
    methods : doThis importing s type string
                     raising exc.
endclass.

class myClass implementation.
  method doThis.
    write : / s.
    raise exception type exc exporting excText = 'Something went wrong'.
  endmethod.
endclass.

class myCaller definition.
  public section.
    methods: CallMethod importing s type string
                        raising   highlevelexc.
endclass.

class myCaller implementation.
  method CallMethod.
    data: locObj type ref to myClass,
          locExc type ref to exc.
    create object locObj.
    try.
      locObj->doThis( s ).
    catch exc into locExc.
      raise exception type highlevelexc
        exporting previous = locExc.
    endtry.
  endmethod.
endclass.

start-of-selection.
  data: myObj     type ref to myCaller,
        myHiErr type ref to highlevelexc,
        myLoErr type ref to exc.

  create object myObj.

  try.
    myObj->CallMethod( 'Anything' ).

  catch highlevelexc into myHiErr.
     myLoErr ?= myHiErr->previous.
     write : / 'Handling via previous:', myLoErr->errorText.

  endtry.