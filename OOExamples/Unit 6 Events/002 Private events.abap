report z_events.

class myClass definition.
  public section.
    methods: raiseEvt importing inInt type i,
             constructor importing name type i.

  private section.
    events:  setEvent exporting value(evInt) type i.

    methods: setMyInt for event SetEvent of myClass
                      importing evInt.

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

  method raiseEvt.
    raise event setEvent exporting evInt = inInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass.

  do 100 times.
    create object myObj exporting name = sy-index.
  enddo.

  myObj->raiseEvt( 200 ).