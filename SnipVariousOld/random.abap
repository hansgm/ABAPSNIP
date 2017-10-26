report zzhp_random.

class rnd definition.
  public section.
    class-methods: create importing value(min) type i optional
                                    value(max) type i optional
                                    preferred parameter max
                          returning value(val) type i.
  private section.
    class-data: i_counter type i.

endclass.

class rnd implementation.
  method create.
    if min is not supplied.
      min = 0.
    endif.

    if max is not supplied.
      max = 10.
    endif.

    get time stamp field data(now).

    val = cl_abap_random_int=>create(  seed = ( frac( now ) * 10000 + i_counter )  min = min max = max )->get_next( ).
    add 1 to i_counter.
  endmethod.
endclass.


start-of-selection.
  do 10 times.
    write : / rnd=>create( 1000 ).
  enddo.