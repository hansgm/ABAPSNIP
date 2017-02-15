report z_events.

class myClass definition.
  public section.
    methods: constructor importing name type i.

  protected section.
    events:  setEvent exporting value(evInt) type i.
    methods: setMyInt for event SetEvent of myClass
                      importing evInt.

  private section.
    data : myInt type i,
           myName type i.
endclass.

class myClass implementation.
  method setMyInt.
    myInt = evInt.
    write : / 'In event handler', myName, 'Value set to myInt is:', myInt.
  endmethod.

  method constructor.
    myName = name.
    set handler setMyInt for all instances.
  endmethod.
endclass.

class mySub definition inheriting from myClass.
  public section.
    methods: raiseEvt importing inInt type i.
endclass.

class mySub implementation.
  method raiseEvt.
    raise event setEvent exporting evInt = inInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to mySub.

  do 100 times.
    create object myObj exporting name = sy-index.
  enddo.

  myObj->raiseEvt( 200 ).