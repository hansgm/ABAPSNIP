REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods IntToPower changing i type i.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method IntToPower.
     i = i ** 2.
  endmethod.

endclass.

start-of-selection.
  data: myObj type ref to myClass, loci type i value 3.
  create object myObj.

  myObj->IntToPower( changing i = loci ).

  write loci.