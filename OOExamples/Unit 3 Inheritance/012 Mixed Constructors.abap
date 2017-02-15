REPORT  Z_INHERIT_CONSTRUCTOR.

class mySuper definition.
  public section.
    class-methods: class_constructor.
    methods:       constructor importing s type string.
endclass.

class mySuper implementation.
  method class_constructor.
    write : / 'In super class_constructor'.
  endmethod.

  method constructor.
    write : / 'In super constructor', s.
  endmethod.
endclass.

class mySub definition inheriting from mySuper.
  public section.
    class-methods: class_constructor.
    methods: constructor importing s type string.
endclass.

class mySub implementation.
  method class_constructor.
    write : / 'In sub class_constructor'.
  endmethod.

  method constructor.
    super->constructor( s ).
    write : / 'In sub constructor', 'CALL FROM SUB CONSTRUCTOR'.
  endmethod.
endclass.


start-of-selection.
  data: myObj type ref to mySub.
  Create object myObj exporting s = 'THECALL FROM PROG'.