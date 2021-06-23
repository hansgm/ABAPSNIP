CLASS zcl_zzhp_teamfill DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: _guid RETURNING VALUE(rv_guid) TYPE sysuuid_x16 RAISING cx_uuid_error.
ENDCLASS.



CLASS zcl_zzhp_teamfill IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Locaties
    " 0271DBE49BF41EDBA2DE6ECA76F48F31 Amerongen
    " 0271DBE49BF41EDBA2DE7364B9E98F3F Duurstede
    " 0271DBE49BF41EDBA2DE7A1B0B40CF46 Rhijnauwen
    " 0271DBE49BF41EDBA2DE7A1BC3360F46 Sterkenburg

    out->write( |Populate teams| ).

    TRY.
        TYPES: tty_team TYPE STANDARD TABLE OF zzhp_team WITH EMPTY KEY.

        DATA(lt_team) = VALUE tty_team(
           ( id = _guid( ) id_uf = 'TM00231' exposure = 'PUBLIC'   name = 'Intra/infra'      location = '0271DBE49BF41EDBA2DE6ECA76F48F31' bonus = 5000  currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00233' exposure = 'INTERNAL' name = 'Security'         location = '0271DBE49BF41EDBA2DE6ECA76F48F31' bonus = 76000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00235' exposure = 'PUBLIC'   name = 'Sales PD'         location = '0271DBE49BF41EDBA2DE6ECA76F48F31' bonus = 76000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00236' exposure = 'PUBLIC'   name = 'Performance PD'   location = '0271DBE49BF41EDBA2DE6ECA76F48F31' bonus = 76000 currency_code = 'USD' )

           ( id = _guid( ) id_uf = 'TM00238' exposure = 'PUBLIC'   name = 'Research'         location = '0271DBE49BF41EDBA2DE7364B9E98F3F' bonus = 33445 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00240' exposure = 'PUBLIC'   name = 'Quality control'  location = '0271DBE49BF41EDBA2DE7364B9E98F3F' bonus = 4455  currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00241' exposure = 'PUBLIC'   name = 'Sales PFDB'       location = '0271DBE49BF41EDBA2DE7364B9E98F3F' bonus = 76000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00244' exposure = 'PUBLIC'   name = 'Performance PFDB' location = '0271DBE49BF41EDBA2DE7364B9E98F3F' bonus = 76000 currency_code = 'USD' )

           ( id = _guid( ) id_uf = 'TM00244' exposure = 'PUBLIC'   name = 'Development'      location = '0271DBE49BF41EDBA2DE7A1B0B40CF46' bonus = 5000  currency_code = 'USD' )
           ( id = _guid( ) id_uf = 'TM00247' exposure = 'INTERNAL' name = 'HR'               location = '0271DBE49BF41EDBA2DE7A1B0B40CF46' bonus = 46000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00248' exposure = 'INTERNAL' name = 'Finance'          location = '0271DBE49BF41EDBA2DE7A1B0B40CF46' bonus = 16000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00249' exposure = 'PUBLIC'   name = 'Production PD-2'  location = '0271DBE49BF41EDBA2DE7A1B0B40CF46' bonus = 54440 currency_code = 'USD' )

           ( id = _guid( ) id_uf = 'TM00251' exposure = 'PUBLIC'   name = 'Facilities'       location = '0271DBE49BF41EDBA2DE7A1BC3360F46' bonus = 46000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00252' exposure = 'PUBLIC'   name = 'production LFDB'  location = '0271DBE49BF41EDBA2DE7A1BC3360F46' bonus = 16000 currency_code = 'EUR' )
           ( id = _guid( ) id_uf = 'TM00253' exposure = 'PUBLIC'   name = 'Production PD-1'  location = '0271DBE49BF41EDBA2DE7A1BC3360F46' bonus = 54440 currency_code = 'USD' )

        ).

        select client, id from zzhp_team into table @data(lt_currentteams).
        if sy-subrc <> 0.
          delete zzhp_team from table @lt_currentteams.
          if sy-subrc <> 0.
            out->write( |Error: cannot delete from table| ).
          endif.
        endif.

        insert zzhp_team from table @lt_team.
          if sy-subrc <> 0.
            out->write( |Error: cannot insert into table| ).
          endif.

        out->write( lt_team ).

      CATCH cx_root INTO DATA(lx).
        out->write( lx ).
    ENDTRY.
  ENDMETHOD.


  METHOD _guid.
    rv_guid = cl_system_uuid=>create_uuid_x16_static( ).
  ENDMETHOD.
ENDCLASS.