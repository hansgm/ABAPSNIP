REPORT  Z_EXC.

class exc definition inheriting from cx_static_check.
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
                     raising resumable(exc).
endclass.

class myClass implementation.
  method doThis.
    write : / s.
    RAISE RESUMABLE exception type exc
      EXPORTING
        excText = 'Something went wrong'.
    write : / 'Continue after raise/resume'.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass,
        myErr type ref to exc.

  CREATE OBJECT myObj.

  try.
      myObj->doThis( 'Anything' ).

    catch before unwind exc into myErr.
      write : / myErr->errorText.
      resume.
  endtry.