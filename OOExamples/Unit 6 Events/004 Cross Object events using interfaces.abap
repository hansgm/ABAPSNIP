report z_events.

interface myEvent.
  events:  setEvent exporting value(evInt) type i.
endinterface.

class myClass definition.
  public section.
    interfaces : myEvent.
    methods: constructor importing name type i,
             setMyInt for event SetEvent of myEvent
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

class myEventCaller definition.
  public section.
    interfaces : myEvent.
    methods: raiseEvt importing inInt type i.
endclass.

class myEventCaller implementation.
  method raiseEvt.
    raise event myEvent~setEvent exporting evInt = inInt.
  endmethod.
endclass.

start-of-selection.
  data: myObj type ref to myClass,
        myEvtCaller type ref to myEventCaller.

  do 100 times.
    create object myObj exporting name = sy-index.
  enddo.

  create object myEvtCaller.
  myEvtCaller->raiseEvt( 200 ).