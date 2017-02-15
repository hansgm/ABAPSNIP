REPORT  Z_INHERIT_CONSTRUCTOR.

class mySuper definition.
  public section. methods: showme..
endclass.

class mySuper implementation.
  method showme.
    write : / 'Super'.
  endmethod.
endclass.


class mySub definition inheriting from mySuper.
  public section. methods: showme redefinition.
endclass.

class mySub implementation.
  method showme.
    write : / 'Sub'.
  endmethod.
endclass.

class mySubSub definition inheriting from mySub.
  public section. methods: showme redefinition.
endclass.

class mySubSub implementation.
  method showme.
    write : / 'SubSub'.
  endmethod.endclass.

start-of-selection.
  data: myObj     type ref to mySubSub.
  data: wideCast  type ref to mySub.
  data: SuperCast type ref to mySuper.

  Create object myObj.

  myObj->ShowMe( ).
  WideCast = myObj.
  WideCast->ShowMe(  ).
  SuperCast = myObj.
  WideCast->ShowMe(  ).