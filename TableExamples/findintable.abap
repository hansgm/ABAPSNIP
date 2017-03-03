report zzhptable2.

start-of-selection.
  data(lt) = value stringtab(
    ( |Hello planet World| )
    ( |This is| )
    ( |a message from planet Vegas| )
  ).

  find all occurrences of |planet| in table lt results data(tfound).
  loop at tfound assigning field-symbol(<found>).
    ...
  endloop.