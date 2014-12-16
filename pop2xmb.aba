function z_bin_to_pipeline.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(SENDER) TYPE  SXI_FROMORTO
*"     VALUE(RECEIVER) TYPE  SXI_FROMORTO
*"     VALUE(XPAYLOAD) TYPE  XSTRING
*"     VALUE(CONTENT_TYPE) TYPE  STRING OPTIONAL
*"     VALUE(COMMIT_WORK) TYPE  BOOLE_D OPTIONAL
*"  EXPORTING
*"     VALUE(RESPONSE) TYPE  STRING
*"----------------------------------------------------------------------

  data ixmb              type ref to if_xms_message_xmb.
  data l_imo             type ref to if_xms_message.
  data msgguid           type sxmsmguid.
  data l_interface       type sxi_interface.
  data l_engine          type ref to if_xms_engine.
  data l_pfo_enabled     type sxmsflag.
  data l_timestamp       type timestamp.
  data l_adapter_context type string.
  data system_error      type ref to cx_xms_system_error.
  data l_content_type    type string.
  data l_commit_work     type string.

  if content_type is supplied.
    l_content_type = content_type.
  endif.
  if l_content_type is initial.
    l_content_type = if_xms_resource=>mimetype_application_octet.
  endif.

  if commit_work is supplied.
    l_commit_work = commit_work.
  else.
    l_commit_work = 'X'.
  endif.

  try.

      ixmb  = cl_xms_message_xmb=>createxmbmessage( ).

      get time stamp field l_timestamp.
      ixmb->set_time_sent( l_timestamp ).

      l_imo ?= ixmb.

      ixmb->set_quality_of_service( if_xms_message_xmb=>co_qos_exactly_once ).
      ixmb->set_processing_mode(    if_xms_msghdr30_main=>co_procmode_async ).

      call function 'GUID_CREATE'
        importing
          ev_guid_16 = msgguid.
      ixmb->set_message_id( msgguid ).

      ixmb->set_sender( im_sender = sender ).
      ixmb->set_receiver( im_receiver = receiver ).

      l_interface-name      = sender-name.
      l_interface-namespace = sender-namespace.
      ixmb->set_interface( im_interface = l_interface ).

      ixmb->set_message_class( if_xms_msghdr30_main=>co_msgclass_appreq ).

      l_imo->rm->set_sys_ack_req(     cl_xms_main=>co_false ).
      l_imo->rm->set_sys_err_ack_req( cl_xms_main=>co_false ).
      l_imo->rm->set_app_ack_req(     cl_xms_main=>co_false ).
      l_imo->rm->set_app_err_ack_req( cl_xms_main=>co_false ).

      try.
          ixmb->add_payload_with_bin_content( exporting
            data         = xpayload
            type         = l_content_type
            payloadtype  = if_xms_msghdr30_manifest=>co_payloadtype_main
            documentname = if_xms_msghdr30_manifest=>co_payloadname_main ).
        catch cx_xms_exception.
          response = 'cx_xms_exception '.

          return.

        catch cx_xms_system_error into system_error..   "#EC NO_HANDLER
          response = system_error->id.
          return.
      endtry.


* Create XMS Instance
      try.
          l_engine = cl_xms_main=>create_engine( ).

          call method l_engine->enter_engine
            exporting
              im_adapter_id      = l_engine->co_adapter_plain_http
              im_adapter_context = l_adapter_context
            changing
              ch_message         = ixmb.

        catch cx_xms_system_error into system_error.
          response = system_error->id.
          return.
      endtry.

    catch cx_root.
      response = 'Exception in processing: call aborted'.
      return.
  endtry.

  if l_commit_work is not initial.
    commit work.
  endif.

  response = 'OK'.

endfunction.
