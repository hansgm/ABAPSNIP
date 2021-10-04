report zzhp_bobf_association.

" Update single entry (with altkey)

start-of-selection.
  data: r_txn_mngr type ref to /bobf/if_tra_transaction_mgr,
        r_svc_mngr type ref to /bobf/if_tra_service_manager,
        v_bokey    type /bobf/obm_bo_key.

  " Initialization
  try.
      break-point.
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

      data: t_data type ztzhp_project.

      r_svc_mngr->retrieve(
        exporting
          iv_node_key             = zif_zhp_project_c=>sc_node-zzhp_project
          it_key                  = t_node_key
        importing
          et_data                 = t_data
      ).

      check lines( t_data ) = 1.

      data: lr_project   type ref to zszhp_project_d.
      create data lr_project.
      t_data[ 1 ]-leadtime = t_data[ 1 ]-leadtime + 10.    " Just sample data
      move-corresponding t_data[ 1 ] to lr_project->*.

      data(t_modify) = value /bobf/t_frw_modification( (  node           = zif_zhp_project_c=>sc_node-zzhp_project
                                                          change_mode    = /bobf/if_frw_c=>sc_modify_update
                                                          key            = t_data[ 1 ]-key
                                                          data           = lr_project
                                                          changed_fields = value #( ( |LEADTIME| ) )
                                                          ) ).
      r_svc_mngr->modify(
        exporting
          it_modification = t_modify
        importing
          eo_message      = r_message
      ).

      r_txn_mngr->save( ).

    catch cx_root into data(lx).
      break-point.
  endtry.

  break-point.