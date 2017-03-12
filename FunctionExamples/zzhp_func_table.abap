REPORT ZZHP_FUNC_TABLE.

data(lt_tab) = value stringtab(
  ( |my| )
  ( |lucky| )
  ( |plaza| )
).

write : /  lines( lt_tab ).
data(ix) = line_index( lt_tab[ table_line = |lucky| ] ).
write : / ix.