REPORT ZZHP0002.

class test definition create private.
  public section.
    class-methods factory returning value(theinstance) type ref to test.

  private section.
    class-data: singleton type ref to test.
    methods: constructor.


endclass.

class test implementation.
  method constructor.
    write : / 'In singleton ctor'.
  endmethod.


  method factory.
    if singleton is not bound.
      create object singleton.
    endif.

    theinstance = singleton.
  endmethod.

endclass.

start-of-selection.
  data: a type ref to test,
        b type ref to test.

* create object a. "Not permitted

  a = test=>factory( ).
  b = test=>factory( ).

  if a = b.
    write : 'Same'.
  endif.