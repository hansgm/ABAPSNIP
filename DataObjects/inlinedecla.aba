report x.

class cla definition.
  public section.
    methods getme exporting obj type ref to cla.
endclass.

class cla implementation.
  method getme.
  endmethod.
endclass.

start-of-selection.
  select single * from t001 into @data(ls_t001).

  select * from t001 into table @data(lt_t001).

  loop at lt_t001 assigning field-symbol(<ls_t001>).
  endloop.

  data(lr_obj1) = new cla( ).
  lr_obj1->getme(
    importing obj = data(lr_obj2)
  ).