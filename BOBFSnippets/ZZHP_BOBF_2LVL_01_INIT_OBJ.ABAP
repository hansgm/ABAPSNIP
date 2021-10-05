*&---------------------------------------------------------------------*
*& Report ZZHP_BOBF_ASSOCIATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zzhp_bobf_association.
" Instantiate object

start-of-selection.
  data: r_txn_mngr type ref to /bobf/if_tra_transaction_mgr,
        r_svc_mngr type ref to /bobf/if_tra_service_manager,
        v_bokey    type /bobf/obm_bo_key.

  " Initialization
  try.
      v_bokey = zif_zhp_project_c=>sc_bo_key.

      r_txn_mngr = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).
      r_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( v_bokey ).

    catch cx_root into data(lx).
      " Any processing
  endtry.
  