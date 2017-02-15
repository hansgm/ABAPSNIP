REPORT  Z_STATIC.

class myStatic definition.
  public section.
    class-data: instanceCount type i.
    data: myName type string.
    methods: constructor importing inName type string.
endclass.

class myStatic implementation.
  method constructor.
    myName = inName.
    add 1 to instanceCount.
  endmethod.
endclass.

start-of-selection.
  data: myObj1 type ref to myStatic,
        myObj2 type ref to myStatic.

  create object myObj1 exporting inName = 'ONE'.
  create object myObj2 exporting inName = 'TWO'.

  write : / myObj1->instanceCount, myObj1->myName.
  write : / myObj2->instanceCount, myObj2->myName.