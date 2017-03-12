REPORT ZZHPTABLE_REPLACE.

  data(lt) = value stringtab(
    ( |Hello planet World| )
    ( |This is| )
    ( |a message from planet Vegas| )
  ).

  replace all occurrences of |planet| in table lt with |pannekoek|.

  loop at lt assigning field-symbol(<line>).
    write : / <line>.
  endloop.