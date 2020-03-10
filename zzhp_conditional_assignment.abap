report zzhp_conditional_assignment.

" Examples java ? : notation in ABAP

start-of-selection.
  data(istrue) = 'X'.
  write : / cond   char10( when istrue = abap_true then 'True' else 'False' ).
  write : / switch char10( istrue when abap_true   then 'True' else 'False' ).
