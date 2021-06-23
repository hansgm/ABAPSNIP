CLASS lcl_team DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
      METHODS validateTeam FOR VALIDATE ON SAVE
        IMPORTING keys FOR Team~validateTeam.
  
      METHODS do_lupa FOR MODIFY
        IMPORTING keys FOR ACTION Team~action_lupa.
  *   [REQUEST requested_fields]
  *   [RESULT result].
  
  ENDCLASS.
  
  
  CLASS lcl_team IMPLEMENTATION.
    METHOD validateTeam.
      READ ENTITIES OF zi_zzhp_team IN LOCAL MODE
      ENTITY Team
        FIELDS ( IdUf )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_team).
  
  
      LOOP AT lt_team ASSIGNING FIELD-SYMBOL(<team>).
        IF <team>-IdUf(2) <> 'TM'.
          APPEND VALUE #( %key = <team>-%key
                          id   = <team>-Id ) TO failed-team.
          APPEND VALUE #( id   = <team>-Id
                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error  text = |Teams moeten met TM beginnen| )
                        ) TO reported-team.
  
        ENDIF.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD do_lupa.
      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information  text = |Wel even die lupa implementeren natuurlijk| )
                    ) TO reported-team.
  
    ENDMETHOD.
  
  ENDCLASS.