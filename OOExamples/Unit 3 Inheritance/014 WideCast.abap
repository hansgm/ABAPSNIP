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
  public section. methods: showsub.
endclass.

class mySub implementation.
  method showsub.
    write : / 'Sub'.
  endmethod.
endclass.

class mySubSub definition inheriting from mySub.
  public section. methods: showsubsub.
endclass.

class mySubSub implementation.
  method showsubsub.
    write : / 'SubSub'.
  endmethod.endclass.

start-of-selection.
  data: myObj     type ref to mySubSub.
  data: wideCast  type ref to mySub.
  data: SuperCast type ref to mySuper.

  Create object myObj.

  myObj->ShowSubSub( ).
  WideCast = myObj.
  WideCast->ShowSub(  ).
  SuperCast = myObj.
  WideCast->ShowMe(  ).