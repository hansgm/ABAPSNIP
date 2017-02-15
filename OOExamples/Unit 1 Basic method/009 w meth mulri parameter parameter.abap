REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    methods IntToPower importing i type i
                                 p type i
                       returning value(e) type i.

  private section.
    data myInt type i.

endclass.

class myClass implementation.
  method IntToPower.
     e = i ** p.
  endmethod.

endclass.

start-of-selection.
  data: myObj type ref to myClass, loci type i value 3, locp type i value 4.
  create object myObj.

  loci = myObj->IntToPower( i = loci p = locp ).

  write loci.