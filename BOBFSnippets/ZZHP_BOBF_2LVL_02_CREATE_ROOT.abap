report zzhp_bobf_association.

" Write single entry

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

      " Create root record
      data lr_project type ref to zszhp_project.
      create data lr_project.

      lr_project->* = value #(
        status      = 'INIT'
        description = 'Test project BOBX 1'
        externalid  = 'HP300921-01'
      ).

      data(t_modify) = value /bobf/t_frw_modification(
      ( node        = zif_zhp_project_c=>sc_node-zzhp_project
        change_mode = /bobf/if_frw_c=>sc_modify_create
        data        = lr_project
      ) ).

      r_svc_mngr->modify(
        exporting
          it_modification = t_modify
        importing
          eo_message      = data(r_message)
          eo_change       = data(r_changes)
      ).

      if r_message is bound.
        break-point.
      else.
        r_txn_mngr->save( ).
      endif.

    catch cx_root into data(lx).
      break-point.
  endtry.

  break-point.