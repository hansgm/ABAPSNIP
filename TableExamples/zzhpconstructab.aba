report t.

types: begin of st_abc,
         name  type string,
         value type string,
       end of st_abc,

       tt_abc type standard table of st_abc with default key.

data: ls_abc type st_abc,
      ls_ab2 type st_abc,
      lt_abc type tt_abc.

ls_abc-name = '33'.
ls_abc-value = 'Drie en dertig'.
append ls_abc to lt_abc.

data(ls_xyz) = value st_abc( name = '34' value = 'Vier en dertig' ).
append ls_xyz to lt_abc.

try.
    ls_ab2 = lt_abc[ name = '32'  ] .
    write ls_ab2-value.
  catch cx_sy_itab_line_not_found.
* Error handling
    write 'We have got an error'.
endtry.

loop at lt_abc assigning field-symbol(<fs_abc>).
  write : / <fs_abc>-name, <fs_abc>-value.
endloop.

lt_abc = value tt_abc(
  ( name = '35' value = 'Vijf en dertig' )
  ( name = '36' value = 'Zes en dertig')
).

loop at lt_abc assigning <fs_abc>.
  write : / <fs_abc>-name, <fs_abc>-value.
endloop.
