report zzhp_json_ser_deser.

data(fieldvalues) = value tihttpnvp(
  ( name = |CO| value = |Coffee| )
  ( name = |FI| value = |Finance| )
).

data(json) = /ui2/cl_json=>serialize( data = fieldvalues pretty_name = abap_true ).
write json.

data(lt_newvalues) = value tihttpnvp( ).

/ui2/cl_json=>deserialize(
  exporting json = json
  changing  data = lt_newvalues
).

loop at lt_newvalues assigning field-symbol(<nvp>).
  write : / <nvp>-name, <nvp>-value.
endloop.