report  zzhp0006.

data : lt type table of dats.

append sy-datum to lt.

read table
  lt  transporting no fields
  with key table_line = '00000000'.

write sy-subrc.

read table
  lt  transporting no fields
  with key table_line = sy-datum.

write sy-subrc.
