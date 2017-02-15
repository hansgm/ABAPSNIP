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
                        raising   exc.
endclass.

class myCaller implementation.
  method CallMethod.
    data: locObj type ref to myClass.
    create object locObj.
    locObj->doThis( s ).
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myCaller,
        myErr type ref to exc.
  create object myObj.

  try.
    myObj->CallMethod( 'Anything' ).

  catch exc into myErr.
     write : / myErr->errorText.
  endtry.
