REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods IntToPower importing i type i
                                 p type i default 2
                                 preferred parameter i
                       returning value(r) type i.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method IntToPower.
     r = i ** p.
  endmethod.

endclass.

start-of-selection.
  data: myObj type ref to myClass, loci type i value 3.
  create object myObj.

  loci = myObj->IntToPower( i = 2 p = 5 ).

  write loci.