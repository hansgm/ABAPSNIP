report z_iterator.

class myClass definition.
  public section.
    methods: constructor importing name type i.

    class-methods:
             setMyInt importing inName type i inInt type i,
             getMyInt importing inName type i returning value(exInt) type i.

  private section.
    data : myInt type i,
           myName type i.
    class-data: collection type table of ref to myClass. "Table of instances
endclass.

class myClass implementation.
  method constructor.
    myName = name.
    append me to collection.
  endmethod.

  method setMyInt.
    data: locObj type ref to myClass.
    loop at collection into locObj.
      check locObj->myName = inName.
      locObj->myInt = inInt.
      return.
    endloop.
  endmethod.

  method getMyInt.
    data: locObj type ref to myClass.
    loop at collection into locObj.
      check locObj->myName = inName.
      exInt = locObj->myInt.
      return.
    endloop.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass,
        x     type i.

  do 100 times.
    create object myObj exporting name = sy-index.
  enddo.

  myClass=>setMyInt( exporting inName = 5 inInt = 200 ).

  x = myClass=>getMyInt( 5 ). write x.