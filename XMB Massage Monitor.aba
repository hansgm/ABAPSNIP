REPORT  zbpm_xi_daily_msg_mon.
PARAMETERS: pa_day    TYPE sydatum,
            pa_dayb   TYPE boole_d DEFAULT 'X',  "Take full day before pa_day
            pa_weekb  TYPE boole_d,              "Take full week before pa_day,
            pa_wrlog  TYPE boole_d DEFAULT 'X'.  "Report to spool
*----------------------------------------------------------------------*
*       CLASS myrep DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS myrep DEFINITION.
  PUBLIC SECTION.
    METHODS: determin_time_interval
               IMPORTING iv_date TYPE sydatum
                         iv_daybefore TYPE boole_d
                         iv_weekbefore TYPE boole_d,
             init_state_texts,
             init_bpm_proces_step,
             main.
    DATA: gt_nr_of_processed_steps    TYPE i,
          gt_nr_of_created_emails     TYPE i,
          gv_timestampdate            TYPE d.
  PRIVATE SECTION.
    DATA: lt_messmast      TYPE TABLE OF sxmspmast,
          ls_messmast      TYPE sxmspmast,
          lt_messenhd      TYPE TABLE OF sxmspemas,
          ls_messenhd      TYPE sxmspemas,
          lt_zprxi_process TYPE TABLE OF zprxi_process,
          ls_zprxi_process TYPE zprxi_process,
          lt_zprxi_step    TYPE TABLE OF zprxi_step,
          ls_zprxi_step    TYPE zprxi_step,
          lt_zbpm_proces_step TYPE TABLE OF zbpm_proces_step,
          ls_zbpm_proces_step TYPE zbpm_proces_step,
          lv_exetimest     TYPE dats,
          lv_exetimestfrom TYPE dats,
          lv_exetimestto   TYPE dats.
*          lt_zprxd_status  TYPE TABLE OF zprxd_status.
    METHODS:
          process_messages,
          error_log
            IMPORTING is_messmast TYPE sxmspmast
                      is_messenhd TYPE sxmspemas
                      iv_message  TYPE string.
ENDCLASS.                    "myrep DEFINITION
*----------------------------------------------------------------------*
*       CLASS myrep IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS myrep IMPLEMENTATION.
  METHOD determin_time_interval.
    DATA: lv_workdate TYPE d.
    IF iv_date IS INITIAL.
      lv_workdate = sy-datum.
    ELSE.
      lv_workdate = iv_date.
    ENDIF.
    IF iv_daybefore = 'X'.
      lv_exetimest = lv_workdate - 1.
      lv_exetimestfrom = lv_exetimest.
      lv_exetimestto = lv_exetimest.
    ELSEIF iv_weekbefore = 'X'.
      lv_exetimest = lv_workdate - 8.
      lv_exetimestfrom = lv_exetimest.
      lv_exetimest = lv_exetimest + 7.
      lv_exetimestto = lv_exetimest.
    ELSE.
      lv_exetimest = lv_workdate.
      lv_exetimestfrom = lv_exetimest.
      lv_exetimestto = lv_exetimest.
    ENDIF.
    WRITE : / 'Time stamp from: ', lv_exetimestfrom.
    WRITE : / 'Time stamp to:   ', lv_exetimestto.
  ENDMETHOD.                    "determin_time_interval
  METHOD init_state_texts.
*    SELECT * FROM zprxd_status
*      INTO TABLE lt_zprxd_status
*      ORDER BY status.
  ENDMETHOD.                    "init_state_texts
  METHOD init_bpm_proces_step.
    SELECT * FROM zbpm_proces_step
      INTO TABLE lt_zbpm_proces_step
      ORDER BY process_name step_name.
  ENDMETHOD.                    "init_state_texts
  METHOD main.
    DATA: lv_timefrom TYPE tims,
          lv_timeto   TYPE tims,
          lt_status   TYPE RANGE OF zstatus,
          ls_status   LIKE LINE OF lt_status.
    lv_timefrom = '000000'. "lv_exetimestfrom+8(6).
    lv_timeto   = '235959'. "lv_exetimestto+8(6).
    ls_status-sign = 'I'.
    ls_status-option = 'BT'.
    ls_status-low = 2.
    ls_status-high = 4.
    APPEND ls_status TO lt_status.
*    SELECT process~pl3id process~piid process~description process~version
*           step~stepid step~index step~pdstepid step~status
*      INTO TABLE lt_process_step
*      FROM zprxi_process AS process
*      INNER JOIN zprxi_step AS step ON
*        step~piid = process~piid
*     WHERE process~status    IN lt_status
*       AND process~alertdate GE lv_exetimestfrom
*       AND process~alertdate LT lv_exetimestto
*       AND process~alerttime GE lv_timefrom
*       AND process~alerttime LT lv_timeto.
    SELECT *
      INTO TABLE lt_zprxi_step
      FROM zprxi_step
     WHERE status    IN lt_status
       AND
       ( (   alertdate GE lv_exetimestfrom
         AND alertdate LE lv_exetimestto
         AND alerttime GE lv_timefrom
         AND alerttime LE lv_timeto )
       OR
         (   deadlinedate GE lv_exetimestfrom
         AND deadlinedate LE lv_exetimestto
         AND deadlinetime GE lv_timefrom
         AND deadlinetime LE lv_timeto ) ).
    SELECT *
      INTO TABLE lt_zprxi_process
      FROM zprxi_process
      FOR ALL ENTRIES IN lt_zprxi_step
      WHERE piid = lt_zprxi_step-piid.
    process_messages( ).
  ENDMETHOD.                    "main
  METHOD process_messages.
    DATA: lv_message_found TYPE c,
          ls_zprxi_step   TYPE zprxi_step,
          ls_process_step TYPE zprocess_step1,
          ls_create_task  TYPE ztask_request1,
          ls_element      TYPE zcontainer_element,
          ls_zprxd_step   type zprxd_step,
          lv_stepid       type ZPDSTEPID,
          lr_get_process_binding TYPE REF TO zcl_is_get_process_binding,
          lr_create_task TYPE REF TO zcl_ia_create_task,
          lr_error_message TYPE REF TO zcx_error_message,
          ls_standard TYPE zexchange_fault_data,
          lv_status   TYPE string.
    LOOP AT lt_zprxi_step INTO ls_zprxi_step.
      CLEAR lv_message_found.
      lv_message_found = 'X'.
      add 1 to gt_nr_of_processed_steps.
      IF  ls_zprxi_step-alertdate GE lv_exetimestfrom
      AND ls_zprxi_step-alertdate LE lv_exetimestto.
        ls_zprxi_step-status = '3'.
      ELSE.
        ls_zprxi_step-status = '4'.
      ENDIF.
      TRY.
*     SET status: Process step in process
          UPDATE zprxi_step
            SET   changedate   = sy-datum
                  changetime   = sy-uzeit
                  status       = ls_zprxi_step-status
            WHERE stepid    = ls_zprxi_step-stepid
              AND stepindex = ls_zprxi_step-stepindex.
*     IF error
          IF sy-subrc <> 0.
            ROLLBACK WORK.
            lv_status = ls_zprxi_step-status.
            CONCATENATE
              'Process step instance (zprxi_step), status could not be updated. Key:'
              'Process step definition id'      ls_zprxi_step-stepid
              'Process instance id:'            ls_zprxi_step-stepindex
              '. The target status:'            lv_status
              INTO ls_standard-fault_text SEPARATED BY space.
            RAISE EXCEPTION TYPE zcx_error_message
               EXPORTING
                  standard = ls_standard.
          ENDIF.
          COMMIT WORK AND WAIT.
        CATCH zcx_error_message INTO lr_error_message.
          WRITE:/ ls_standard-fault_text.
          CONTINUE.
      ENDTRY.
* Get binding
      ls_process_step-process_step-step_id = ls_zprxi_step-stepid.
      TRY.
          CREATE OBJECT lr_get_process_binding.
          lr_get_process_binding->zii_is_get_process_binding~execute_synchronous( exporting input =  ls_process_step
                                                                                  importing output = ls_process_step
                                           ).
        CATCH zcx_error_message.
          WRITE :/  'Cannot get binding', ls_zprxi_step-stepid, ls_zprxi_step-stepindex.
          CONTINUE.
      ENDTRY.
* Mail alert
      TRY.
*     Get Process
          READ TABLE lt_zprxi_process INTO ls_zprxi_process WITH KEY piid = ls_zprxi_step-piid.
*     Vul Taak
          MOVE-CORRESPONDING ls_process_step-process_step to ls_create_task-task_request.
          ls_create_task-task_request-process-process_name      = ls_zprxi_process-pl3id.
          ls_create_task-task_request-process-process_id        = ls_zprxi_process-piid.
          ls_create_task-task_request-process-process_step_name = ls_process_step-process_step-name.
          ls_create_task-task_request-process-process_step_id   = ls_process_step-process_step-step_id.
*    Vul Task
          LOOP AT ls_process_step-process_step-container-element INTO ls_element
            WHERE name = 'TaskType'.
            ls_create_task-task_request-task_type = ls_element-value.
          ENDLOOP.
          ls_create_task-task_request-response_service = ls_zprxi_process-description.
          lv_stepid = ls_create_task-task_request-process-process_step_name.
          select single * into ls_zprxd_step
           from zprxd_step
          where pl3id    eq ls_zprxi_process-pl3id
            and version  eq ls_zprxi_process-version
            and pdstepid eq lv_stepid.
          ls_create_task-task_request-description_en = ls_zprxd_step-description.
          if ls_process_step-process_step-step_index is initial.
            ls_process_step-process_step-step_index = '0000000001'.
          endif.
          CONCATENATE ls_process_step-process_step-step_id '#' ls_process_step-process_step-step_index
                 INTO ls_create_task-task_request-response_id.
*     Voer de taak uit
          CREATE OBJECT lr_create_task.
          lr_create_task->zii_ia_create_task~execute_asynchronous(
                       input = ls_create_task
                       ).
        CATCH zcx_error_message.
          WRITE :/  'Cannot create message', ls_zprxi_step-stepid, ls_zprxi_step-stepindex.
          CONTINUE.
      ENDTRY.
      add 1 to gt_nr_of_created_emails.
    ENDLOOP.
  ENDMETHOD.                    "process_messages
  METHOD error_log.
    WRITE : / iv_message.
  ENDMETHOD.                    "error_log
ENDCLASS.                    "myrep IMPLEMENTATION
START-OF-SELECTION.
  DATA: lr_myrep TYPE REF TO myrep.
  write 'Program not ready yet'.
  stop.
  CREATE OBJECT lr_myrep.
  lr_myrep->determin_time_interval(
               EXPORTING iv_date = pa_day
                         iv_daybefore = pa_dayb
                         iv_weekbefore = pa_weekb ).
  lr_myrep->init_state_texts( ).
  lr_myrep->main( ).
  WRITE : / 'Daily monitoring of XI messages'.
  WRITE : / 'Time/Date of running       :', sy-datum DD/MM/YYYY, sy-uzeit.
  WRITE : / 'Nr of processed steps      :', lr_myrep->gt_nr_of_processed_steps.
  WRITE : / 'Nr of sent emails          :', lr_myrep->gt_nr_of_created_emails.
