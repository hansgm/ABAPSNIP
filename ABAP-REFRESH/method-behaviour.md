# Method behavior

## 'create object' and 'call' are outdated
In general, use as little verbs as possible
``` abap
class naturalnumbers definition.
  public section.
    methods: is_naturalnumber importing i_number type i returning value(is_it) type boolean_flg.
endclass.

if new naturalnumbers( )->is_naturalnumber( 2 ).
  cl_demo_output=>display( |2 is a natural number| ).
endif.

class naturalnumbers implementation.
  method is_naturalnumber.
    if i_number >= 0.
      is_it = abap_true.
    endif.
  endmethod.
endclass.
```

## Returning Boolean handling
Does not require comparison with variable anymore

``` ABAP
class naturalnumbers definition.
  public section.
    class-methods: is_naturalNumber importing i_number type i returning value(is_it) type boolean_flg.
endclass.

data i_input type int4.
cl_demo_input=>request( exporting text = |Enter a number| changing field = i_input ).

if naturalnumbers=>is_naturalnumber( i_input ).
  cl_demo_output=>display( |Entered value = { i_input } is a natural number| ).
else.
  cl_demo_output=>display( |Entered value = { i_input } is not a natural number| ).
endif.

class naturalnumbers implementation.
  method is_naturalnumber.
    if i_number >= 0.
      is_it = abap_true.
    endif.
  endmethod.
endclass.
```

## Returning Boolean handling with conditional operator cond
Compare ? : 

``` ABAP
class naturalnumbers definition.
  public section.
    class-methods: is_naturalNumber importing i_number type i returning value(is_it) type boolean_flg.
endclass.

data i_input type int4.
cl_demo_input=>request( exporting text = |Enter a number| changing field = i_input ).

cl_demo_output=>display( |Entered value = { i_input } is { 
                                            cond string( when naturalnumbers=>is_naturalnumber( i_input ) then '' else 'not' )
                                            } a natural number| ).

class naturalnumbers implementation.
  method is_naturalnumber.
    if i_number >= 0.
      is_it = abap_true.
    endif.
  endmethod.
endclass.
```

## Methods may have both returning and exporting parameters
Can be useful in rare cases, for instance for method chaining
``` ABAP
class anyclass definition.
  public section.
    methods: method1 exporting e_number type i returning value(self) type ref to anyclass.
    methods: method2 exporting e_number type i returning value(self) type ref to anyclass.
  private section.
    data counter type i.
endclass.

new anyclass( )->method1( importing e_number = data(num1) )->method1( importing e_number = data(num2) ).

cl_demo_output=>display( |Number1 = { num1 } Number2 = { num2 }| ).

class anyclass implementation.
  method method1.
    counter += 1.
    e_number = counter.
    self     = me.
  endmethod.
  method method2.
    counter += 1.
    e_number = counter.
    self     = me.
  endmethod.
endclass.
```
# Subclasses of exception cx_no_check are propagated by default
Does not require explicit declaration (methods: ... raising ...)

Note raise exception type  message id number triggers where used for the message.

``` ABAP
class myexception definition inheriting from cx_no_check.
  public section.
    interfaces: if_t100_dyn_msg.
endclass.

class anyclass definition.
  public section.
    methods: method1 returning value(r_counter) type i.
  private section.
    data counter type i.
endclass.

try.
    data(lr) = new anyclass( ).
    cl_demo_output=>display( |Round 1 value is { lr->method1( ) }| ).
    cl_demo_output=>display( |Round 2 value is { lr->method1( ) }| ).
    cl_demo_output=>display( |Round 3 value is { lr->method1( ) }| ).

  catch cx_root into data(lx).
    cl_demo_output=>display( |Exception { lx->get_text( ) } | ).
endtry.

class anyclass implementation.
  method method1.
    counter += 1.
    r_counter = counter.
    if counter > 2.
      raise exception type myexception message id '38' number 000 
                      with |Something went over the limit of 2| 
                           |Other parameters|.
    endif.
  endmethod.
endclass.
```