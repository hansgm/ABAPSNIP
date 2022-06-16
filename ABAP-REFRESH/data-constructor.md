# Data constructors

## Simple table constructor
No generic definition, also not for table key

``` ABAP
types: begin of instrument,
         iname type string,
         itype type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

cl_demo_output=>display( t_instrument ).
```

## Corresponding
```ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type standard table of instrument with empty key,

       begin of instrument2,
         instrumentname type c length 40,
         instrumenttype type c length 40,
         inventorycount type p decimals 3,
       end of instrument2.

data t_instrument2 type table of instrument2.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

t_instrument2 = corresponding #( t_instrument mapping instrumentname = iname instrumenttype = itype ).

cl_demo_output=>display( t_instrument2 ).

types: instrument2list type standard table of instrument2 with empty key.
cl_demo_output=>display( corresponding instrument2list( t_instrument mapping instrumentname = iname instrumenttype = itype ) ).
```

## Create with create data

```ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data: r_instrumentlist type ref to data.

r_instrumentlist = new instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

field-symbols <t_instrument> type any table.
assign r_instrumentlist->* to <t_instrument>.
cl_demo_output=>display( <t_instrument> ).
```

## Create with create per line

```ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data: r_instrumentlist type table of ref to data.

append new instrument( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2  )  to r_instrumentlist.
append new instrument( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1  )  to r_instrumentlist.
append new instrument( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0  )  to r_instrumentlist.
append new instrument( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3  )  to r_instrumentlist.

field-symbols <instrument> type instrument.

loop at r_instrumentlist assigning field-symbol(<data>).
  assign <data>->* to <instrument>.
  cl_demo_output=>display( <instrument> ).
endloop.
```

## Create more complex data
``` ABAP
types: begin of feature,
         nam type string,
         val type string,
       end of feature,

       begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
         features       type standard table of feature with empty key,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'SEM') ) )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Steiner/Ladder') ) )
).

cl_demo_output=>display_json( /ui2/cl_json=>serialize( data = t_instrument pretty_name = abap_true ) ).
```


## Corresponding deep
``` ABAP
types: begin of feature,
         nam type string,
         val type string,
       end of feature,

       begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
         features       type standard table of feature with empty key,
       end of instrument,
       instrumentlist type standard table of instrument with empty key,

       begin of options,
         optionname type string,
         optionvalue   type string,
       end of options,

       begin of instrument2,
         instrumentname    type c length 40,
         instrumentoptions type standard table of options with empty key,
       end of instrument2.

data t_instrument2 type table of instrument2.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'SEM') ) )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Steiner/Ladder') ) )
).

t_instrument2 = corresponding #( t_instrument mapping instrumentname = iname                                      " Mapping, do deep is implicit
                               ( instrumentoptions = features mapping optionname = nam  optionvalue = val  ) ).

cl_demo_output=>display_json( /ui2/cl_json=>serialize( data = t_instrument2 pretty_name = abap_true ) ).

```

## Some table updates
``` ABAP
types: begin of feature,
         nam type string,
         val type string,
       end of feature,

       begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
         features       type standard table of feature with empty key,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Ladder') ) )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 features = value #( ( nam = 'keys' val = '0'  ) ( nam = 'filter' val = 'SEM') ) )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 features = value #( ( nam = 'keys' val = '61' ) ( nam = 'filter' val = 'Steiner/Ladder') ) )
).

t_instrument[ 2 ]-iname = 'Moog One used'.

assign t_instrument[ 2 ] to field-symbol(<line_instrument>).
append value #( nam = 'state' val = 'minor scratches on the left side panel' ) to <line_instrument>-features.

data line_instrument type ref to instrument.
line_instrument = ref #( t_instrument[ 4 ] ).
append value #( nam = 'state' val = 'Broken volume knob' ) to line_instrument->features.

if line_exists( t_instrument[ itype = 'Hybr Digital' ] ).
  t_instrument[ itype =  'Hybr Digital' ]-itype = 'Hybr Analog'.
endif.

data(line_to_delete) = line_index( t_instrument[ inventorycount = 3 ] ).
delete t_instrument index line_to_delete.

cl_demo_output=>display_json( /ui2/cl_json=>serialize( data = t_instrument pretty_name = abap_true ) ).
```
## Some table updates within an iteration
``` ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type standard table of instrument with empty key.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

loop at t_instrument into data(s_instrument).
  s_instrument-itype &&= ' Synth'.       " Does nothing
endloop.

loop at t_instrument assigning field-symbol(<s_instrument>).
  <s_instrument>-iname &&= ' B-Stock'.   " Does the job
endloop.

loop at t_instrument reference into data(r_instrument).
  r_instrument->inventorycount *= 100.   " Does the job
endloop.

cl_demo_output=>display_json( /ui2/cl_json=>serialize( data = t_instrument pretty_name = abap_true ) ).
```

## Some table updates with objects
``` ABAP
class instrument definition.
  public section.
    data: iname type string,
          itype type string,
          inventorycount type i.
    methods constructor importing i_iname type string i_itype type string i_inventorycount type i.
endclass.

data: t_instrument type standard table of ref to instrument with empty key.

t_instrument = value #(
( new instrument( i_iname = 'Moog Mother'        i_itype = 'Mono Analog'  i_inventorycount = 2  ) )
( new instrument( i_iname = 'Moog One'           i_itype = 'Poly Analog'  i_inventorycount = 1 ) )
( new instrument( i_iname = 'Arturia Microfreak' i_itype = 'Hybr Digital' i_inventorycount = 0 ) )
( new instrument( i_iname = 'Arturia PolyBrute'  i_itype = 'Poly Analog'  i_inventorycount = 3 ) )
).

t_instrument[ 3 ]->itype = 'Hybr Analog'.

loop at t_instrument into data(r_instrument).
  r_instrument->iname &&= ' B Stock'.            "Does the job
endloop.

cl_demo_output=>display_json( /ui2/cl_json=>serialize( data = t_instrument pretty_name = abap_true ) ).

class instrument implementation.
  method constructor.
    iname = i_iname.
    itype = i_itype.
    inventorycount = i_inventorycount.
  endmethod.
endclass.

```