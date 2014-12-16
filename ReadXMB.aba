form readxmb using indata type xstring.
  data: persist   type ref to  cl_xms_persist,
        message   type ref to  if_xms_message,
        clmessage type ref to  if_xms_message_xmb,
        payload   type ref to  if_xms_payload.
  try.
      create object persist.
      persist->read_msg_pub(
                  exporting
                    im_msgguid = lv_guid
                    im_pid     = pa_pipe
                    im_version = 000
                  importing
                    ex_message = message ).
      clmessage ?= message.
      payload = clmessage->get_payload_with_main_document( ).
      data cd type xstring.
      cd = payload->getbinarycontent( ).
    catch cx_root.
  endtry.
  check cd is not initial.
  TYPE-POOLS: ixml.
  DATA:
    lr_ixml            TYPE REF TO if_ixml,
    lr_streamfactory   TYPE REF TO if_ixml_stream_factory,
    lr_istream         TYPE REF TO if_ixml_istream,
    lr_parser          TYPE REF TO if_ixml_parser,
    lr_document        type ref to if_ixml_document,
    lv_value           type string.
  try.
* CREATE XML document
  lr_ixml = cl_ixml=>create( ).
* CREATE XML factory
  lr_streamfactory = lr_ixml->create_stream_factory( ).
* CREATE stream based on XML xstring
  lr_istream = lr_streamfactory->create_istream_xstring(
     string = cd ).
* CREATE document instance
  lr_document = lr_ixml->create_document( ).
* CREATE parser instance
  lr_parser = lr_ixml->create_parser(
                       stream_factory = lr_streamfactory
                       istream        = lr_istream
                       document       = lr_document ).
* PARSE XML stream to XML document
  lr_parser->parse( ).
  data lr_element type ref to IF_IXML_ELEMENT.
  lr_element = lr_document->find_from_name( name = pa_elt ).
  lv_value = lr_element->get_value(  ).
  indata = zcl_convert=>base64_to_xstring( lv_value ).
  catch cx_root.
    write 'Error parsing XML from payload'.
  endtry.
endform.                    "readxmb
