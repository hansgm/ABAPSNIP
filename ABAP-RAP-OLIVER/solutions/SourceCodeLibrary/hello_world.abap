CLASS zcl_zzhp_helloworld DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zzhp_helloworld IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    TRY.
        out->write( |Hello World | ).
        out->write( |User:        { cl_abap_context_info=>get_user_alias( ) } | ).
        out->write( |System date: { cl_abap_context_info=>get_system_date( ) } | ).
        out->write( |System time: { cl_abap_context_info=>get_system_time( ) } | ).
        out->write( |System url:  { cl_abap_context_info=>get_system_url( ) } | ).
      CATCH cx_abap_context_info_error.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.