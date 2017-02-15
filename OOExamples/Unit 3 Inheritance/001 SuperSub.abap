REPORT  ZZHPCLASS_ZZHP_INHERIT.

class mySuper definition.
  public section.
    data: mySuperInt type i. 
endclass.

class mySub definition inheriting from mySuper.
  public section.
    data: mySubInt type i. 
endclass.

class mySub implementation.

endclass.

start-of-selection.
  data: myObj     type ref to mySub.

  create object: myObj.
  
  myObj->mySuperInt = 5.
  myObj->mySubInt = 10.