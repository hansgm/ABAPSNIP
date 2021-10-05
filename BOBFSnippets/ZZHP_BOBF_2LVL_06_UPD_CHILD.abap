report zzhp_bobf_association.

" Update child

start-of-selection.
  data: r_txn_mngr type ref to /bobf/if_tra_transaction_mgr,
        r_svc_mngr type ref to /bobf/if_tra_service_manager,
        v_bokey    type /bobf/obm_bo_key.

  " Initialization
  try.
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
        " any error handling
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

      data: t_datarole type ztzhp_role.
      data: r_datarole type ref to zszhp_role_d.
      create data r_datarole.

      r_svc_mngr->retrieve_by_association(
        exporting
          iv_node_key    = zif_zhp_project_c=>sc_node-zzhp_project
          it_key         = t_node_key
          iv_association = zif_zhp_project_c=>sc_association-zzhp_project-_roles
          iv_fill_data   = abap_true
        importing
          et_data        = t_datarole
      ).
      break-point.

      " Just pick the first one to modify as example and assign some value
      move-corresponding t_datarole[ 1 ] to r_datarole->*.
      r_datarole->assignee = '1881'.

      data(t_modify) = value /bobf/t_frw_modification(
        (
          node           = zif_zhp_project_c=>sc_node-zzhp_role
          key            = t_datarole[ 1 ]-key                                  " Key of the modified child object
          change_mode    = /bobf/if_frw_c=>sc_modify_update                     " sc_modify_delete to delete node
          data           = r_datarole
          changed_fields = value #( ( |ASSIGNEE| ) )
      ) ).

      r_svc_mngr->modify(
        exporting
          it_modification = t_modify
        importing
          eo_change       = data(r_change)
          eo_message      = r_message
      ).

      if r_message is not bound.
        r_txn_mngr->save( ).
      else.
        " any error handling
      endif.


    catch cx_root into data(lx).
      " any error handling
  endtry.
