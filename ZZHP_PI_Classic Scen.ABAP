*&---------------------------------------------------------------------*
*& Report  ZZHP_PXJ_SCENARIOS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* Not programmed in a clean or efficient way. Not fully functional either (some shortcurs). 
* Just kept as example for only few times use

report zzhp_pxj_scenarios.

include ZZHP_PI_CLASS_INCL.

data: lv_str type c length 255.

parameters : pa_usern type string lower case default ''.
parameters : pa_passw type string lower case default ''.
parameters : pa_host  type string lower case default '' .
select-options: so_sndco for lv_str lower case.
select-options: so_rcvco for lv_str lower case.

types: begin of ty_report,
         ownded      type string,
         selected    type abap_bool,
         complexity  type string,
         sndpar      type string,
         sndcomp     type string,
         sndchannel  type string,
         sndchantype type string,
         sndintfname type string,
         sndintfns   type string,
         swcv        type string,
         rule        type string,
         mapname     type string,
         mapns       type string,
         mapswcv     type string,
         fill1       type string,
         rcvpar      type string,
         rcvcomp     type string,
         rcvintfname type string,
         rcvintfns   type string,
         rcvintswcv  type string,
         rcvchannel  type string,
         rcvchantyp  type string,
         rcvurl      type string,
         qos         type string,
       end of ty_report.

data: lt_report type standard table of ty_report.

start-of-selection.
  data(lr_irdet) = new post_http(
    username  = pa_usern
    password  = pa_passw
    url       = pa_host && '/InterfaceDeterminationInService/InterfaceDeterminationInImplBean'
  ).

  data(lv_payloadresp) = lr_irdet->post_xml( pi_requests=>get_intfdet_query_req( ) ).
  perform xml_iddet using lv_payloadresp.
  perform show_grid.

form xml_iddet using iv_payload type xstring.

  try.
      data(lr_xmldoc) = new xml2doc( )->prep( iv_payload ).
      clear iv_payload.

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'InterfaceDeterminationQueryResponse'
        uri  = 'http://sap.com/xi/BASIS'
      ).
      data(lr_idlist) = lr_element->get_children( )->create_iterator( ).

      do.
        data(lr_id) = lr_idlist->get_next( ).
        if lr_id is not bound.
          exit.
        endif.

        append initial line to lt_report assigning field-symbol(<line>).
        <line>-sndpar = lr_id->get_children( )->get_item( 0 )->get_value( ).
        <line>-sndcomp = lr_id->get_children( )->get_item( 1 )->get_value( ).
        <line>-sndintfname = lr_id->get_children( )->get_item( 2 )->get_value( ).
        <line>-sndintfns = lr_id->get_children( )->get_item( 3 )->get_value( ).
        <line>-rcvpar = lr_id->get_children( )->get_item( 4 )->get_value( ).
        <line>-rcvcomp = lr_id->get_children( )->get_item( 5 )->get_value( ).

        check so_sndco[] is not initial or so_rcvco[] is not initial.
        check <line>-sndcomp in so_sndco.
        check <line>-rcvcomp in so_rcvco.
        <line>-selected = abap_true.
        clear: lr_xmldoc.
        perform read_sa_details changing <line>.
        perform read_id_details changing <line>.
      enddo.

    catch cx_root into data(lx).
      " break-point.
  endtry.
endform.

form read_sa_details changing ls_line type ty_report.
  data next_lines type abap_bool.

  try.
      data(lr_irdet) = new post_http(
        username  = pa_usern
        password  = pa_passw
        url       = pa_host && '/SenderAgreementInService/SenderAgreementInImplBean'
      ).

      data(lv_payloadresp)  = lr_irdet->post_xml( pi_requests=>get_sa_details_req(
        senderpartyid       = ls_line-sndpar
        sendercomponentid   = ls_line-sndcomp
        interfacename       = ls_line-sndintfname
        interfacenamespace  = ls_line-sndintfns

      ) ).

      data(lr_xmldoc) = new xml2doc( )->prep( lv_payloadresp ).
      clear lv_payloadresp.

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'CommunicationChannel'
        uri  = ''
      ).

      if lr_element is bound.
        ls_line-sndchannel  = lr_element->get_children( )->get_item( 2 )->get_value( ).
        perform read_snd_channel_details changing ls_line.
      endif.

    catch cx_root.
      ls_line-rcvchannel = 'XMB'.
  endtry.
endform.


form read_id_details changing ls_line type ty_report.
  data next_lines type abap_bool.

  try.
      data(lr_irdet) = new post_http(
        username  = pa_usern
        password  = pa_passw
        url       = pa_host && '/InterfaceDeterminationInService/InterfaceDeterminationInImplBean'
      ).

      data(lv_payloadresp)  = lr_irdet->post_xml( pi_requests=>get_intfdet_details_req(
        senderpartyid       = ls_line-sndpar
        sendercomponentid   = ls_line-sndcomp
        interfacename       = ls_line-sndintfname
        interfacenamespace  = ls_line-sndintfns
        receiverpartyid     = ls_line-rcvpar
        receivercomponentid = ls_line-rcvcomp
      ) ).

      data(lr_xmldoc) = new xml2doc( )->prep( lv_payloadresp ).
      clear lv_payloadresp.

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'InterfaceDetermination'
        uri  = ''
      ).

      data(lr_idlist) = lr_element->get_children( )->create_iterator( ).
      do.
        data(lr_id) = lr_idlist->get_next( ).
        if lr_id is not bound.
          exit.
        endif.
        check lr_id->get_name( ) = 'Rule'.

        if next_lines = abap_true.
          append initial line to lt_report assigning field-symbol(<line>).
          move-corresponding ls_line to <line>.
        else.
          assign ls_line to <line>.
        endif.

        data(lr_rulemembers) = lr_id->get_children(  )->create_iterator( ).
        do.
          data(lr_rulemember) = lr_rulemembers->get_next( ).
          if lr_rulemember is not bound.
            exit.
          endif.

          if lr_rulemember->get_name( ) = 'Operation'.
            <line>-rule = lr_rulemember->get_value( ).
          elseif lr_rulemember->get_name( ) = 'Mapping'.
            <line>-mapname  = lr_rulemember->get_children( )->get_item( 0 )->get_value( ).
            <line>-mapns    = lr_rulemember->get_children( )->get_item( 1 )->get_value( ).
          elseif lr_rulemember->get_name( ) = 'Interface'.
            <line>-rcvintfname = lr_rulemember->get_children( )->get_item( 0 )->get_value( ).
            <line>-rcvintfns   = lr_rulemember->get_children( )->get_item( 1 )->get_value( ).
          endif.

          clear lr_xmldoc.
          perform read_ra_details changing <line>.

        enddo.

        next_lines = abap_true.
      enddo.

    catch cx_root.
      "     Nothing to do

  endtry.

endform.


form read_ra_details changing ls_line type ty_report.
  try.
      data(lr_irdet) = new post_http(
        username  = pa_usern
        password  = pa_passw
        url       = pa_host && '/ReceiverAgreementInService/ReceiverAgreementInImplBean'
      ).

      data(lv_payloadresp)  = lr_irdet->post_xml( pi_requests=>get_ra_details_req(
        senderpartyid       = ls_line-sndpar
        sendercomponentid   = ls_line-sndcomp
        interfacename       = ls_line-rcvintfname
        interfacenamespace  = ls_line-rcvintfns
        receiverpartyid     = ls_line-rcvpar
        receivercomponentid = ls_line-rcvcomp
      ) ).

      data(lr_xmldoc) = new xml2doc( )->prep( lv_payloadresp ).
*      clear lv_payloadresp.

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'ChannelID'
        uri  = ''
      ).

      if lr_element is bound.
        ls_line-rcvchannel = lr_element->get_value( ).

        if ls_line-rcvchannel is not initial.
          perform read_rcv_channel_details changing ls_line.
        endif.
      endif.

*      clear lr_xmldoc.

    catch cx_root.

  endtry.

endform.


form read_snd_channel_details changing ls_line type ty_report.
  try.
      data(lr_irdet) = new post_http(
        username  = pa_usern
        password  = pa_passw
        url       = pa_host && '/CommunicationChannelInService/CommunicationChannelInImplBean'
      ).

      data(lv_payloadresp)  = lr_irdet->post_xml( pi_requests=>get_channel_req(
        partyid     = ls_line-sndpar
        componentid = ls_line-sndcomp
        channelid   = ls_line-sndchannel
      ) ).

      data(lr_xmldoc) = new xml2doc( )->prep( lv_payloadresp ).

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'AdapterMetadata'
        uri  = ''
      ).

      if lr_element is bound.
        ls_line-sndchantype = lr_element->get_children( )->get_item( 0 )->get_value( ).
      endif.

*      data(lr_communicationchannel) = lr_xmldoc->find_from_name_ns(
*        name = 'CommunicationChannel'
*        uri  = ''
*      ).
*
*      data(lr_attributes) = lr_communicationchannel->get_children(  )->create_iterator( ).
*      do.
*        data(lr_attribute) = lr_attributes->get_next( ).
*        if lr_attribute is not bound.
*          exit.
*        endif.
*
*        if lr_attribute->get_name( ) = 'AdapterSpecificAttribute'.
*          if lr_attribute->get_children( )->get_item( 0 )->get_value( ) = 'XMBWS.TargetURL'.
*            ls_line-rcvurl = lr_attribute->get_children( )->get_item( 2 )->get_value( ).
*          endif.
*        endif.
*      enddo.
    catch cx_root.

  endtry.
endform.


form read_rcv_channel_details changing ls_line type ty_report.
  try.
      data(lr_irdet) = new post_http(
        username  = pa_usern
        password  = pa_passw
        url       = pa_host && '/CommunicationChannelInService/CommunicationChannelInImplBean'
      ).

      data(lv_payloadresp)  = lr_irdet->post_xml( pi_requests=>get_channel_req(
        partyid     = ls_line-rcvpar
        componentid = ls_line-rcvcomp
        channelid   = ls_line-rcvchannel
      ) ).

      data(lr_xmldoc) = new xml2doc( )->prep( lv_payloadresp ).

      data(lr_element) = lr_xmldoc->find_from_name_ns(
        name = 'AdapterMetadata'
        uri  = ''
      ).

      if lr_element is bound.
        ls_line-rcvchantyp = lr_element->get_children( )->get_item( 0 )->get_value( ).
      endif.

      data(lr_communicationchannel) = lr_xmldoc->find_from_name_ns(
        name = 'CommunicationChannel'
        uri  = ''
      ).

      data(lr_attributes) = lr_communicationchannel->get_children(  )->create_iterator( ).
      do.
        data(lr_attribute) = lr_attributes->get_next( ).
        if lr_attribute is not bound.
          exit.
        endif.

        if lr_attribute->get_name( ) = 'AdapterSpecificAttribute'.
          if lr_attribute->get_children( )->get_item( 0 )->get_value( ) = 'XMBWS.TargetURL'.
            ls_line-rcvurl = lr_attribute->get_children( )->get_item( 2 )->get_value( ).
          endif.
        endif.
      enddo.
    catch cx_root.

  endtry.
endform.

form show_grid.
  try.
      cl_salv_table=>factory(
        importing r_salv_table = data(lr_grid)
        changing  t_table = lt_report
      ).
      lr_grid->get_display_settings( )->set_striped_pattern( abap_true ).
      lr_grid->display( ).
    catch cx_salv_msg into data(gr_error).
      data(gv_str_text) = gr_error->if_message~get_text( ).
      message gv_str_text type 'E'.
  endtry.
endform.
