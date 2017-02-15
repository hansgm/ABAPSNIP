REPORT  Z_INHERIT_CONSTRUCTOR.

class mySuper definition.
  public section.
    methods: constructor importing s type string.
endclass.

class mySuper implementation.
  method constructor.
    write : / 'In super constructor', s.
  endmethod.
endclass.

class mySub definition inheriting from mySuper.
  public section.
    methods: constructor importing s type string.
endclass.

class mySub implementation.
  method constructor.
    super->constructor( s ).
    write : / 'In sub constructor', s.
    " super->constructor( s ).
  endmethod.
endclass.


start-of-selection.
  data: myObj type ref to mySub.
  Create object myObj exporting s = 'THECALL'.