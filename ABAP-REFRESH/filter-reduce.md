# Filter, Reduce

## Simple filtering
Mind the requirement to make a key (which makes it much less useful)


``` ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type sorted table of instrument with unique key iname.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

cl_demo_output=>display( filter #( t_instrument where iname = |Moog Mother| ) ).
```
## Filtering on secondary key
Again, filter requires key
``` ABAP
types: begin of instrument,
         iname          type string,
         itype          type string,
         inventorycount type i,
       end of instrument,
       instrumentlist type sorted table of instrument with unique key iname
       with non-unique sorted key key_itype components itype.

data(t_instrument) = value instrumentlist(
( iname = 'Moog Mother'        itype = 'Mono Analog'  inventorycount = 2 )
( iname = 'Moog One'           itype = 'Poly Analog'  inventorycount = 1 )
( iname = 'Arturia Microfreak' itype = 'Hybr Digital' inventorycount = 0 )
( iname = 'Arturia PolyBrute'  itype = 'Poly Analog'  inventorycount = 3 )
).

cl_demo_output=>display( filter #( t_instrument using key key_itype where itype = |Poly Analog| ) ).
```