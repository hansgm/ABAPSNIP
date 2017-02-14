**************************************************************************************************************************************************
ZBPM_PARSE_PDF                               HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*&---------------------------------------------------------------------*
*& Report  Z_MI_MAIL_PARSE_PDF
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report  zbpm_parse_pdf.
data: ls_pdf type xstring,
      ls_xml type xstring,
      lv_guid type sxmsmguid.
parameters: pa_fil as checkbox,
            pa_pipe type sxmspid,
            pa_guid type c length 40,
            pa_elt  type string lower case.
start-of-selection.
  if pa_fil is not initial.
    perform upload using ls_pdf.
  else.
    translate pa_guid using '- _ '.
    condense pa_guid no-gaps.
    lv_guid = pa_guid.
    perform readxmb using ls_pdf.
  endif.
  if ls_pdf is initial.
    message s000(38) with 'No PDF selected' 'or PDF has unexpected filelength'.
    exit.
  endif.
  try.
  zcl_extract_pdf_data=>extract(
    exporting
      iv_input  = ls_pdf
    importing
      ev_output = ls_xml ).
  catch cx_root.
    ls_xml = ls_pdf.
  endtry.
  if ls_xml is initial.
    write : / 'Error extracting data from PDF'.
    return.
  endif.
  TYPE-POOLS: ixml.
  DATA:
    lr_ixml            TYPE REF TO if_ixml,
    lr_streamfactory   TYPE REF TO if_ixml_stream_factory,
    lr_istream         TYPE REF TO if_ixml_istream,
    lr_parser          TYPE REF TO if_ixml_parser.
* CREATE XML document
  lr_ixml = cl_ixml=>create( ).
* CREATE XML factory
  lr_streamfactory = lr_ixml->create_stream_factory( ).
* CREATE stream based on XML xstring
  lr_istream = lr_streamfactory->create_istream_xstring(
     string = ls_xml ).
* CREATE document instance
  data lr_document type ref to if_ixml_document.
  lr_document = lr_ixml->create_document( ).
* CREATE parser instance
  lr_parser = lr_ixml->create_parser(
                       stream_factory = lr_streamfactory
                       istream        = lr_istream
                       document       = lr_document ).
* PARSE XML stream to XML document
  lr_parser->parse( ).
  data:  lr_iterator type ref to if_ixml_node_iterator,
         lr_node     type ref to if_ixml_node,
         lv_name     type string,
         lv_value    type string,
         lv_cseq     type string.
  lr_iterator = lr_document->if_ixml_node~create_iterator( ).
*  dump_element_to_log( lr_element ).
  do.
    lr_node = lr_iterator->get_next(  ).
    if not lr_node is bound.
      exit.
    endif.
    lv_name = lr_node->get_name( ).
    check lv_name <> '#text'.
    lv_value = lr_node->get_value(  ).
    skip.
    write : / lv_name.
    write : / lv_value.
  enddo.
  .
*&---------------------------------------------------------------------*
*&      Form  upload
*&---------------------------------------------------------------------*
form upload using indata type xstring.
  data: lt_file type filetable,
        lc_file like line of lt_file,
        ls_file type string,
        lv_rc   type i,
        lv_len  type i,
        useract type i,
        workxrec    type x length 1024,
        workxtab    like table of workxrec.
  call method cl_gui_frontend_services=>file_open_dialog
    exporting
      window_title         = 'Select PDF file'
      default_extension    = 'PDF'
      default_filename     = '*.pdf'
      initial_directory    = 'C:\'
    changing
      file_table           = lt_file
      user_action          = useract
      rc                   = lv_rc
    exceptions
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      others               = 4.
  check lines( lt_file[] ) > 0.
  read table lt_file into lc_file index 1.
  ls_file = lc_file.
  call method cl_gui_frontend_services=>gui_upload
    exporting
      filename   = ls_file
      filetype   = 'BIN'
    importing
      filelength = lv_len
    changing
      data_tab   = workxtab
    exceptions
      others     = 1.
  clear indata.
  loop at workxtab into workxrec.
    concatenate indata workxrec into indata in byte mode.
  endloop.
  indata = indata(lv_len).
endform.                    "download
*&---------------------------------------------------------------------*
*&      Form  readxmb
*&---------------------------------------------------------------------*
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
**************************************************************************************************************************************************
