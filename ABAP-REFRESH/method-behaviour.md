# Method behaviour

## 'create object' and 'Call' are outdated
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

cl_demo_output=>display( |Entered value = { i_input } is { cond string( when naturalnumbers=>is_naturalnumber( i_input ) then '' else 'not' ) } a natural number| ).

class naturalnumbers implementation.
  method is_naturalnumber.
    if i_number >= 0.
      is_it = abap_true.
    endif.
  endmethod.
endclass.
```