report zzhp_mesh.

types:
  dd_tables type hashed table of dd02v with unique key tabname ddlanguage,
  dd_fields type hashed table of dd03l with unique key tabname fieldname
                                       with non-unique sorted key keydomain components domname,
  dd_values type hashed table of dd07v with unique key domname valpos ddlanguage,

  begin of mesh domains,
    t_tables type dd_tables
      association tables2fields to t_fields on tabname = tabname,
    t_fields type dd_fields
      association fields2tables to t_tables on tabname = tabname
      association fields2values to t_values on domname = domname,
    t_values type dd_values
      association values2fields to t_fields on domname = domname using key keydomain,
  end of mesh domains.

data: ddic type domains.

select * from dd02v into table ddic-t_tables
  where ddlanguage eq sy-langu
  and   tabname in ('ZPAM_TAKEN','ZPAM_TEMPL_TAKEN','T001','T003').                  " 'ZPAM_TAKEN' or tabname eq 'ZPAM_TEMPL_TAKEN' or tabname eq 'T001'.

check lines( ddic-t_tables ) gt 0.

select * from  dd03l
  into table ddic-t_fields
  for all entries in ddic-t_tables
  where tabname    = ddic-t_tables-tabname.

check lines( ddic-t_fields ) gt 0.

select * from  dd07v
  into table ddic-t_values
  for all entries in ddic-t_fields
  where domname    = ddic-t_fields-domname
  and   ddlanguage eq sy-langu.

loop at ddic-t_values assigning field-symbol(<value>) where domvalue_l = 'X'.
  loop at ddic-t_values\values2fields[ <value> ]
    assigning field-symbol(<field>).
    write: /  <field>-tabname,
              <field>-fieldname.
    data(ls_table) = ddic-t_fields\fields2tables[ <field> ].
    write ls_table-ddtext.

*   data(ls_table_inverse) = ddic-t_tables\^fields2tables~t_fields[ <field> ].
    if 1 = 0.
      loop at ddic-t_tables\^fields2tables~t_fields[ ls_table ] assigning field-symbol(<reversefields>).
        write : / '-',
                  <reversefields>-fieldname,
                  <reversefields>-position.
      endloop.
    endif.

  endloop.
endloop.

data(tabledirect) = ddic-t_tables[ tabname = 'T001' ].
write : / 'Direct tab t001 inverse: get table fields'.
loop at ddic-t_tables\^fields2tables~t_fields[ tabledirect ] assigning field-symbol(<reversefields2>).
  write : / '-',
            <reversefields2>-fieldname,
            <reversefields2>-position.
endloop.

write : / 'Direct tab t001 forward: get table fields'.
loop at ddic-t_tables\tables2fields[ tabledirect ] assigning field-symbol(<reversefields3>).
  write : / '-',
            <reversefields3>-fieldname,
            <reversefields3>-position.
endloop.

write : / 'Direct tab t001 wo existing node: get table fields'.
loop at ddic-t_tables\tables2fields[ ddic-t_tables[ tabname = 'T001' ] ] assigning field-symbol(<reversefields4>).
  write : / '-',
            <reversefields4>-fieldname,
            <reversefields4>-position.
endloop.

write : / 'Field possible values tab t001 wo existing node: get table fields'.
loop at ddic-t_tables\tables2fields[ ddic-t_tables[ tabname = 'T001' ] ]\fields2values[  ]
     assigning field-symbol(<directposiblevalues>).

  write : / '-',
            <directposiblevalues>-domname,
            <directposiblevalues>-domvalue_l,
            <directposiblevalues>-ddtext.
endloop.


write : / 'Field possible values tab t001 wo existing node via VALUES FOR constructor: get table fields'.
data(valuesViaConstructor) = value dd_values(
  for <SingleValue> in ddic-t_tables\tables2fields[ ddic-t_tables[ tabname = 'T001' ] ]\fields2values[ ]
  ( <SingleValue> )
).

loop at valuesViaConstructor assigning field-symbol(<valueViaConstructor>).
  write : / '-',
            <valueViaConstructor>-domname,
            <valueViaConstructor>-domvalue_l,
            <valueViaConstructor>-ddtext.
endloop.

write : / 'Field possible values tab t001 wo existing node via VALUES FOR constructor wo buffervar: get table fields'.
loop at value dd_values(
    for <SingleValue> in ddic-t_tables\tables2fields[ ddic-t_tables[ tabname = 'T001' ] ]\fields2values[ ]
      ( <SingleValue> )
  )
  assigning field-symbol(<valueViaConstructor2>).

  write : / '-',
            <valueViaConstructor2>-domname,
            <valueViaConstructor2>-domvalue_l,
            <valueViaConstructor2>-ddtext.
endloop.
