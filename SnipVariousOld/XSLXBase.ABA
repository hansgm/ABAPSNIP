class ZCL_XLSX definition
  public
  create public .

public section.

  types:
    begin of tt_cell,
           lin        type i,
           col        type i,
           cell_name  type string,
           cell_value type string,
           cell_satt  type string,
           cell_tatt  type string,
           cell_ststr type string,
         end of tt_cell .
  types:
    ttab_cell type standard table of tt_cell .

  data GR_XLSX type ref to CL_OPENXML_PACKAGE .
  constants CO_URI_SHAREDSTRING type STRING value '/xl/sharedstrings.xml'. "#EC NOTEXT
  constants CO_URI_WORKBOOK type STRING value '/xl/workbook.xml'. "#EC NOTEXT
  constants CO_URI_WORKSHEET type STRING value '/xl/worksheets/sheet1.xml'. "#EC NOTEXT
  data GV_XMLSHAREDST type XSTRING .
  data GV_XMLSHEET1 type XSTRING .
  data GT_CELLS type TTAB_CELL .

  methods CONSTRUCTOR
    importing
      !IV_EXCEL type XSTRING
    raising
      CX_OPENXML_FORMAT .
  methods PARSE_XLSX
    raising
      CX_OPENXML_FORMAT
      ZCX_FI_POST_EXC .
  methods PARSE_XML_DATA
    raising
      ZCX_FI_POST_EXC .
protected section.
private section.
ENDCLASS.



CLASS ZCL_XLSX IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_XLSX->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_EXCEL                       TYPE        XSTRING
* | [!CX!] CX_OPENXML_FORMAT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CONSTRUCTOR.
  gr_xlsx =  cl_xlsx_document=>load_package( iv_excel ).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_XLSX->PARSE_XLSX
* +-------------------------------------------------------------------------------------------------+
* | [!CX!] CX_OPENXML_FORMAT
* | [!CX!] ZCX_FI_POST_EXC
* +--------------------------------------------------------------------------------------</SIGNATURE>
method PARSE_XLSX.
  data: lr_parts      type ref to cl_openxml_partcollection,
        lv_partcount  type i,
        lr_part       type ref to cl_openxml_part,
        lr_workbook   type ref to cl_openxml_part,
        lr_worksheet1 type ref to cl_openxml_part,
        lv_uri        type string,
        sv_index      type i.

  lr_parts = gr_xlsx->get_parts( ).
  lv_partcount = lr_parts->get_count( ).

  do lv_partcount times.
    sv_index = sy-index - 1.
    lv_uri = lr_parts->get_part( sv_index )->get_uri( )->get_uri( ).
    if lv_uri = co_uri_workbook.
      lr_workbook = lr_parts->get_part( sv_index ).
    endif.
  enddo.

  if lr_workbook is not bound.
     raise exception type zcx_fi_post_exc.
  else.
*    Ok, proceed
  endif.

  lv_partcount = lr_workbook->get_parts( )->get_count( ).
  do lv_partcount times.
    sv_index = sy-index - 1.
    lv_uri = lr_workbook->get_parts( )->get_part( sv_index )->get_uri( )->get_uri( ).

    if lv_uri = co_uri_worksheet.
      gv_xmlsheet1   = lr_workbook->get_parts( )->get_part( sv_index )->get_data( ).

    elseif lv_uri = co_uri_sharedstring.
      gv_xmlsharedst = lr_workbook->get_parts( )->get_part( sv_index )->get_data( ).

    endif.
  enddo.

  if gv_xmlsheet1 is initial or gv_xmlsharedst is initial.
     raise exception type zcx_fi_post_exc.
  else.
*    Ok, proceed
  endif.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_XLSX->PARSE_XML_DATA
* +-------------------------------------------------------------------------------------------------+
* | [!CX!] ZCX_FI_POST_EXC
* +--------------------------------------------------------------------------------------</SIGNATURE>
method parse_xml_data.
  data: lr_ixml                type ref to if_ixml,
        lr_ixml_document       type ref to if_ixml_document,
        lr_ixml_stream_factory type ref to if_ixml_stream_factory,
        lr_ixml_istream        type ref to if_ixml_istream,
        lr_ixml_parser         type ref to if_ixml_parser,
        lr_ixml_node_sst       type ref to if_ixml_node,
        lr_ixml_node_silist    type ref to if_ixml_node_list,
        lv_nrof_sinodes        type i,
        lr_ixml_node_si        type ref to if_ixml_node,
        lv_value               type string,
        lt_sharedstring        type table of string,
        lv_sstidx              type i.

* Fetch data from shared strings, and put it into a stringtable (Note! Index = tabix - 1)

  lr_ixml                = cl_ixml=>create( ).
  lr_ixml_document       = lr_ixml->create_document( ).
  lr_ixml_stream_factory = lr_ixml->create_stream_factory( ).
  lr_ixml_istream        = lr_ixml_stream_factory->create_istream_xstring( gv_xmlsharedst ).
  lr_ixml_parser         = lr_ixml->create_parser(
          document       = lr_ixml_document
          istream        = lr_ixml_istream
          stream_factory = lr_ixml_stream_factory ).

  lr_ixml_parser->parse( ).
**  if lr_ixml_parser->parse( ) = 0.
**    raise exception type zcx_fi_post_exc exporting text = 'Parse error standard strings'.
**  endif.

  lr_ixml_istream->close( ).

  lr_ixml_node_sst = lr_ixml_document->find_from_name( name = 'sst' ).

  if lr_ixml_node_sst is bound.
    lr_ixml_node_silist = lr_ixml_node_sst->get_children( ).
    if lr_ixml_node_silist is bound.
      lv_nrof_sinodes = lr_ixml_node_silist->get_length( ).
      do lv_nrof_sinodes times.
        lv_sstidx = sy-index - 1.
        try.
            lv_value = lr_ixml_node_silist->get_item( lv_sstidx )->get_first_child( )->get_value( ).
            append lv_value to lt_sharedstring.
          catch cx_root.
        endtry.
      enddo.
    endif.
  endif.


**** Now almost exactly the same for the sheet itself
**** Now almost exactly the same for the sheet itself


* Fetch data from worksheet, reinitialize iXML data
  data: lr_ixml_node_sheetdta type ref to if_ixml_node,
        lr_sheetnode          type ref to if_ixml_node,
        lr_rowcell            type ref to if_ixml_node,
        lv_nodename           type string.

  data:  lr_ixml_node type ref to if_ixml_node,
         lr_nodeatts type ref to if_ixml_named_node_map,
         lv_rowindex type i,
         lv_celindex type i,
         lv_ststridx type i,

         lv_lin type i,
         lv_col type i,
         ls_cell type tt_cell.

  lr_ixml                = cl_ixml=>create( ).
  lr_ixml_document       = lr_ixml->create_document( ).
  lr_ixml_stream_factory = lr_ixml->create_stream_factory( ).
  lr_ixml_istream        = lr_ixml_stream_factory->create_istream_xstring( gv_xmlsheet1 ).
  lr_ixml_parser         = lr_ixml->create_parser(
          document       = lr_ixml_document
          istream        = lr_ixml_istream
          stream_factory = lr_ixml_stream_factory ).


  lr_ixml_parser->parse( ).
**  if lr_ixml_parser->parse( ) = 0.
**    raise exception type zcx_fi_post_exc exporting text = 'Parse Error Sheet'.
**  endif.

  lr_ixml_istream->close( ).

* Start from sheetData
  lr_ixml_node_sheetdta = lr_ixml_document->find_from_name( name = 'sheetData' ).
  if lr_ixml_node_sheetdta is not bound.
    raise exception type zcx_fi_post_exc exporting text = 'Cannot find node sheetData'.
  endif.

  lr_sheetnode = lr_ixml_node_sheetdta->get_first_child( ).

  while lr_sheetnode is bound.
*   lv_nodename = lr_sheetnode->get_name( ).             should be row
    lr_rowcell = lr_sheetnode->get_first_child( ).
    add 1 to lv_lin.
    lv_col = 0.

    while lr_rowcell is bound.
*     lv_nodename = lr_rowcell->get_name( ).             should be c
      lr_nodeatts = lr_rowcell->get_attributes( ).

      add 1 to lv_col.

      clear : ls_cell.
      ls_cell-lin = lv_lin.
      ls_cell-col = lv_col.

      try. ls_cell-cell_name   = lr_nodeatts->get_named_item( 'r' )->get_value( ).         catch cx_root. endtry.
      try. ls_cell-cell_tatt   = lr_nodeatts->get_named_item( 't' )->get_value( ).         catch cx_root. endtry.
      try. ls_cell-cell_satt   = lr_nodeatts->get_named_item( 's' )->get_value( ).         catch cx_root. endtry.
      try. ls_cell-cell_value  = lr_rowcell->get_value(  ).                                catch cx_root. endtry.

      if ls_cell-cell_tatt = 's'.
        lv_ststridx = 1 + ls_cell-cell_value.
        read table lt_sharedstring into ls_cell-cell_ststr index lv_ststridx.
        if sy-subrc <> 0.
          clear ls_cell-cell_ststr.               "Quite superfluous :-)
        endif.
      endif.

      append ls_cell to gt_cells.
      lr_rowcell = lr_rowcell->get_next( ).
    endwhile.

    lr_sheetnode = lr_sheetnode->get_next( ).
  endwhile.

endmethod.
ENDCLASS.