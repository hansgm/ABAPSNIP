report zzhp_exc.

class exc definition inheriting from cx_static_check.
  public section.
    data: errortext type string.
    methods: constructor importing exctext type string.
endclass.

class exc implementation.
  method constructor.
    super->constructor( ).
    errortext = exctext.
  endmethod.
endclass.


class myclass definition.
  public section.
    methods : dothis importing s type string
                     raising   exc.
endclass.

class myclass implementation.
  method dothis.
    write : / s.
    raise exception type exc exporting exctext = 'Something went wrong'.
  endmethod.
endclass.

start-of-selection.
  try.
      new myclass( )->dothis( 'Anything' ).
    catch exc into data(lx).
      write : / lx->errortext.               "Check with breakpoint
  endtry.