REPORT  ZZHPCLASS_W_ATTR.

types: strTab type table of string.

class myClass definition.
  public section.
    methods Add1Line changing t type strTab.
endclass.

class myClass implementation.
  method Add1Line.
    append 'from outer space' to t.

  endmethod.

endclass.

start-of-selection.
  data: myObj     type ref to myClass,
        tab1      type strTab,
        v         type string.

  create object: myObj.

  append : 'Hello World.' to tab1,
           'This is ABAP calling' to tab1.

  myObj->Add1Line( changing t = tab1 ).

  loop at tab1 into v. write v. endloop.