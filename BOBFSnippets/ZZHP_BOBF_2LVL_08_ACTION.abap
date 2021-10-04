report zzhp_bobf_association.

" Do Action

include zzhp_bobf_association_object.

start-of-selection.
  data: r_txn_mngr type ref to /bobf/if_tra_transaction_mgr,
        r_svc_mngr type ref to /bobf/if_tra_service_manager,
        v_bokey    type /bobf/obm_bo_key.

  " Initialization
  try.
*      break-point.
      v_bokey = zif_zhp_project_c=>sc_bo_key.

      r_txn_mngr = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).
      r_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( v_bokey ).

      data: t_ids type ztk_zhp_project_db_key.
      append initial line to t_ids assigning field-symbol(<dbkey>).
      <dbkey>-id = '000001005510'.

      data: t_node_key type    /bobf/t_frw_key.

      r_svc_mngr->convert_altern_key(
        exporting
          iv_node_key          = zif_zhp_project_c=>sc_node-zzhp_project
          iv_altkey_key        = zif_zhp_project_c=>sc_alternative_key-zzhp_project-db_key
          it_key               = t_ids
          iv_check_existence   = abap_true
        importing
          et_key               = t_node_key
          eo_message           = data(r_message) ).

      if r_message is bound.
        break-point.
        return.
      endif.

      data lr_logmessage type ref to zzhp_simple_string.              " Where the structure is a simple wrapper around a stringval
      create data lr_logmessage.
      lr_logmessage->value = |Test from DoAction at { sy-datum }/{ sy-uzeit }|.

      r_svc_mngr->do_action(
        exporting
          it_key               = t_node_key
          is_parameters        = lr_logmessage
          iv_act_key           = zif_zhp_project_c=>sc_action-zzhp_project-write_log
      ).

    catch cx_root into data(lx).
      break-point.
  endtry.

  break-point.
  
" Implementation action
"   method /BOBF/IF_FRW_ACTION~EXECUTE.
"     field-symbols <parameter> type zzhp_simple_string.
"     assign is_parameters->* to <parameter>.
"     zcl_logger=>create( )->struct_to_log( <parameter>  )->save( ).     " Where zcl_logger is some SLG1 logger or what ever
"   endmethod.