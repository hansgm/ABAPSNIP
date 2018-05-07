*&---------------------------------------------------------------------*
*&  Include           ZZHP_PI_CLASS_INCL
*&---------------------------------------------------------------------*


class post_http definition.
  public section.
    data : r_client type ref to if_http_client.

    methods:
      constructor importing username type string
                            password type string
                            url      type string
                  raising   zcx_pam,
      post_xml    importing payloadsend           type string
                  returning value(payloadreceive) type xstring
                  raising   zcx_pam.
endclass.

class xml2doc definition.
  public section.
    methods: prep importing xml           type xstring
                  returning value(xmldoc) type ref to if_ixml_document.
endclass.

class pi_requests definition.
  public section.
    class-methods:
      get_soap_envelope returning value(request) type string,
      get_intfdet_query_req     returning value(request) type string,
      get_intfdet_details_req
        importing senderpartyid       type string
                  sendercomponentid   type string
                  interfacename       type string
                  interfacenamespace  type string
                  receiverpartyid     type string
                  receivercomponentid type string
        returning value(request)      type string,

      get_ra_details_req
        importing senderpartyid       type string
                  sendercomponentid   type string
                  interfacename       type string
                  interfacenamespace  type string
                  receiverpartyid     type string
                  receivercomponentid type string
        returning value(request)      type string,

      get_sa_details_req
        importing senderpartyid       type string
                  sendercomponentid   type string
                  interfacename       type string
                  interfacenamespace  type string
        returning value(request)      type string,

      get_channel_req
        importing partyid             type string
                  componentid         type string
                  channelid           type string
        returning value(request)      type string.
endclass.

class pi_requests implementation.
  method get_soap_envelope.
    request =
      '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:bas="http://sap.com/xi/BASIS">' &&
        '<soapenv:Header/>' &&
        '<soapenv:Body><!-- PAYLOAD --></soapenv:Body>' &&
      '</soapenv:Envelope>' .
  endmethod.

  method get_intfdet_query_req.
    request = get_soap_envelope( ).
    replace all occurrences of '<!-- PAYLOAD -->' in request with '<bas:InterfaceDeterminationQueryRequest/>'.
  endmethod.

  method get_intfdet_details_req.
    request = get_soap_envelope( ).
    replace all occurrences of '<!-- PAYLOAD -->' in request with
          '<bas:InterfaceDeterminationReadRequest>' &&
          '<ReadContext>User</ReadContext>' &&
          '<InterfaceDeterminationID>' &&
          '<SenderPartyID>' && senderpartyid && '</SenderPartyID>' &&
          '<SenderComponentID>' && sendercomponentid && '</SenderComponentID>' &&
          '<InterfaceName>' && interfacename && '</InterfaceName>' &&
          '<InterfaceNamespace>' && interfacenamespace && '</InterfaceNamespace>' &&
          '<ReceiverPartyID>' && receiverpartyid && '</ReceiverPartyID>' &&
          '<ReceiverComponentID>' && receivercomponentid && '</ReceiverComponentID>' &&
          '</InterfaceDeterminationID>' &&
          '</bas:InterfaceDeterminationReadRequest>'.

  endmethod.

  method get_ra_details_req.
    request = get_soap_envelope( ).
    replace all occurrences of '<!-- PAYLOAD -->' in request with
          '<bas:ReceiverAgreementReadRequest>' &&
          '<ReceiverAgreementID>' &&
          '<SenderPartyID>' && senderpartyid && '</SenderPartyID>' &&
          '<SenderComponentID>' && sendercomponentid && '</SenderComponentID>' &&
          '<InterfaceName>' && interfacename && '</InterfaceName>' &&
          '<InterfaceNamespace>' && interfacenamespace && '</InterfaceNamespace>' &&
          '<ReceiverPartyID>' && receiverpartyid && '</ReceiverPartyID>' &&
          '<ReceiverComponentID>' && receivercomponentid && '</ReceiverComponentID>' &&
          '</ReceiverAgreementID>' &&
          '</bas:ReceiverAgreementReadRequest>'.
  endmethod.

  method get_sa_details_req.
    request = get_soap_envelope( ).
    replace all occurrences of '<!-- PAYLOAD -->' in request with
          '<bas:SenderAgreementReadRequest>' &&
          '<SenderAgreementID>' &&
          '<SenderPartyID>' && senderpartyid && '</SenderPartyID>' &&
          '<SenderComponentID>' && sendercomponentid && '</SenderComponentID>' &&
          '<InterfaceName>' && interfacename && '</InterfaceName>' &&
          '<InterfaceNamespace>' && interfacenamespace && '</InterfaceNamespace>' &&
          '<ReceiverPartyID>*</ReceiverPartyID>' &&
          '<ReceiverComponentID>*</ReceiverComponentID>' &&
          '</SenderAgreementID>' &&
          '</bas:SenderAgreementReadRequest>'.
  endmethod.

  method get_channel_req.
    request = get_soap_envelope( ).
    replace all occurrences of '<!-- PAYLOAD -->' in request with
          '<bas:CommunicationChannelReadRequest>' &&
          '<CommunicationChannelID>' &&
          '<PartyID>' && partyid && '</PartyID>' &&
          '<ComponentID>' && componentid && '</ComponentID>' &&
          '<ChannelID>' && channelid && '</ChannelID>' &&
          '</CommunicationChannelID>' &&
          '</bas:CommunicationChannelReadRequest>' .
  endmethod.

endclass.

class post_http implementation.
  method constructor.
    call method cl_http_client=>create_by_url
      exporting
        url                = url
      importing
        client             = r_client
      exceptions
        argument_not_found = 1
        internal_error     = 2
        plugin_not_active  = 3
        others             = 4.

    if sy-subrc <> 0.
      raise exception type zcx_pam exporting v_shorttext = |Exc create_by_url. RC:{ sy-subrc } |.
    endif.

    r_client->authenticate(
      exporting
       username = username
       password = password  ).

    r_client->request->set_header_field(
      exporting
        name  = 'Content-Type'
        value = 'text/xml' ).

  endmethod.

  method post_xml.
    r_client->request->set_cdata(
     exporting
       data = payloadsend
     exceptions
       others = 2 ).

    if sy-subrc <> 0.
      raise exception type zcx_pam exporting v_shorttext = |Exc set_cdata |.
    endif.


    r_client->send(
      exceptions
        others = 1  ).

    if sy-subrc <> 0.
      raise exception type zcx_pam exporting v_shorttext = |Exc send |.
    endif.

    r_client->receive(
      exceptions
        others = 1  ).

    if sy-subrc <> 0.
      raise exception type zcx_pam exporting v_shorttext = |Exc receive |.
    endif.

    payloadreceive =  r_client->response->get_data( ).
    clear r_client.
  endmethod.
endclass.



class xml2doc implementation.
  method prep.
    data(lr_ixml) = cl_ixml=>create( ).
    data(lr_streamfactory) = lr_ixml->create_stream_factory( ).
    data(lr_istream) = lr_streamfactory->create_istream_xstring( string = xml ).
    xmldoc = lr_ixml->create_document( ).
    data(lr_parser) = lr_ixml->create_parser(
                         stream_factory = lr_streamfactory
                         istream        = lr_istream
                         document       = xmldoc ).
    lr_parser->parse( ).
  endmethod.
endclass.
