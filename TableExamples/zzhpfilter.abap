report zzhp_filter.
start-of-selection.
  data lt001_filtered type table of t001.
  data: lt_t001 type sorted table of t001 with non-unique key ktopl.
  select * from t001 into table lt_t001.
  lt001_filtered = filter #( lt_t001 where ktopl = 'EN01' ).
  write : / lines( lt001_filtered ).
  "or wo declaration
  data(lt001_filtered2) = filter #( lt_t001 where ktopl = 'EN01' ).  
  write : / lines( lt001_filtered ).
