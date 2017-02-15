REPORT  ZZHPCLASS_W_ATTR.

class myClass definition.
  public section.
    data myInt type i.

endclass.

class myClass implementation.

endclass.

start-of-selection.
  data: myObj type ref to myClass.
  create object myObj.

  myObj->myInt = 200.

  write myObj->myInt.