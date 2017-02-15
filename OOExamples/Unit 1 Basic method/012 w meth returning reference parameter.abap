REPORT  ZZHPCLASS_W_ATTR.


class myRef definition.
  public section. data refi type i.
endclass.

class myClass definition.
  public section.
    methods IntToPower importing i type ref to myRef
                       returning value(r) type ref to myRef.

endclass.

class myClass implementation.
  method IntToPower.
    create object r.
    r->refi = i->refi ** 2.
  endmethod.

endclass.

start-of-selection.
  data: myObj     type ref to myClass,
        myref     type ref to myRef,
        loci      type i value 3,
        raisedref type ref to myRef.

  create object: myObj, myRef.

  myRef->refi = 5.

  raisedref = myObj->IntToPower( myRef ).

  write : / myRef->refi.
  write : / raisedRef->refi.