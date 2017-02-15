REPORT  Z_SINGLETON.

class mySingleton definition.
  public section.
    class-methods: factory  importing name type string
                            returning value(exObj) type ref to mySingleton.
    data: mySingleValue type string.

  private section.
    class-data: myOnlyInstance type ref to mySingleton.
endclass.

class mySingleton implementation.
  method factory.
    if myOnlyInstance is not bound.
      create object myOnlyInstance.
    endif.

    exObj = myOnlyInstance.
    exObj->mySingleValue = name.
  endmethod.
endclass.

start-of-selection.
  data : myObj1 type ref to mySingleTon,
         myObj2 type ref to mySingleTon,
         myObj3 type ref to mySingleTon.

  myObj1 = mySingleTon=>factory( 'The only instance ever created' ).
  myObj2 = mySingleTon=>factory( 'And again' ).
  myObj3 = mySingleTon=>factory( 'And again and again' ).

  write : / myObj1->mySingleValue,
          / myObj2->mySingleValue,
          / myObj3->mySingleValue.