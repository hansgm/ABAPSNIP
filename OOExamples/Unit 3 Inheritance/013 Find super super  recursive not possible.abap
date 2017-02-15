REPORT  Z_INHERIT_CONSTRUCTOR.

class mySuper definition.
  public section. methods: find_super.
endclass.

class mySuper implementation.
  method find_super. 
    write : / 'In Find Super'.
*   super->find_super(  ).   Does not exist
  endmethod.
endclass.

class mySub definition inheriting from mySuper.
  public section. methods: find_super redefinition..
endclass.

class mySub implementation.
  method find_super.
    write : / 'In Sub Find Super'.    super->find_super(  ).
  endmethod.
endclass.

class mySubSub definition inheriting from mySub.
  public section. methods: find_super redefinition..
endclass.

class mySubSub implementation.
  method find_super.
    write : / 'In SubSub Find Super'. super->find_super(  ).
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to mySubSub.
  Create object myObj.

  myObj->find_super(  ).