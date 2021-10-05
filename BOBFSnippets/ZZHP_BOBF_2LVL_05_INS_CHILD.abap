*&---------------------------------------------------------------------*
*& Report ZZHP_BOBF_ASSOCIATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zzhp_bobf_association.

" Create child node

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
        " Any processing
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

      " Create role record (child node)
      data lr_role type ref to zszhp_role.
      create data lr_role.

      lr_role->* = value #(
        root_key     = t_data[ 1 ]-key
        projectid    = t_data[ 1 ]-id
        role         = 'ZY'
        assigneetype = 'LF'
        assignee     = '11993XZXVY'
      ).

      data(t_modify) = value /bobf/t_frw_modification(
      (
        node        = zif_zhp_project_c=>sc_node-zzhp_role
        source_node = zif_zhp_project_c=>sc_node-zzhp_project              " Parent node
        source_key  = t_data[ 1 ]-key
        change_mode = /bobf/if_frw_c=>sc_modify_create
        association = zif_zhp_project_c=>sc_association-zzhp_project-_roles
        data        = lr_role

      ) ).

      r_svc_mngr->modify(
        exporting
          it_modification = t_modify
        importing
          eo_change       = data(r_change)
          eo_message      = r_message
      ).


      data(lt_change) = r_change->get_changes( ).
      lt_change[ 1 ]-change_object->get(
           importing
             et_change = data(lt_nodechanges) ).

      data lt_key type /bobf/t_frw_key.
      data ls_key like line of lt_key.
      ls_key-key = lt_nodechanges[ change_mode = 'C' ]-key .
      append ls_key to lt_key .

      data lt_project_created type ZTZHP_ROLE.

      r_svc_mngr->retrieve(
         exporting
           iv_node_key = zif_zhp_project_c=>sc_node-zzhp_role
           it_key      = lt_key
         importing
           et_data    = lt_project_created
           eo_message = r_message ).

      if r_message is not bound.
        r_txn_mngr->save( ).
      else.
        " Any processing
      endif.

    catch cx_root into data(lx).
      " Any processing
  endtry.
