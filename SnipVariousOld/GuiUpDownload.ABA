*&---------------------------------------------------------------------*
*& Report  ZZHP_UPDOWNLOAD
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report zzhp_updownload.

types : zxline1024 type x length 1024,
        zxtab1024  type standard table of zxline1024 with default key.





*----------------------------------------------------------------------*
*       CLASS zcl_convert DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class zcl_convert definition.
  public section.
    class-methods : xtab_to_xstring importing in type zxtab1024
                                              len type i
                                    returning value(rv) type xstring,
                    xstring_to_xtab importing value(in) type xstring
                                    returning value(rv) type zxtab1024.
endclass.                    "zcl_convert DEFINITION

*----------------------------------------------------------------------*
*       CLASS zcl_convert IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class zcl_convert implementation.
  method xtab_to_xstring.
    data: inline like line of in.
    loop at in into inline.
      concatenate rv inline into rv in byte mode.
    endloop.

    rv = rv(len).
  endmethod.                    "xtab_to_xstring



  method xstring_to_xtab.
    data: outline like line of rv.
    outline = in.
    if xstrlen( in ) > 1024.
      in = in+1024.
    endif.
  endmethod.                    "xstring_to_xtab
endclass.                    "zcl_convert IMPLEMENTATION


*----------------------------------------------------------------------*
*       CLASS upload DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class upload definition.
  public section.
    class-methods: now importing filename type string
                       returning value(xstream)  type xstring.
endclass.                    "download DEFINITION

*----------------------------------------------------------------------*
*       CLASS upload IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class upload implementation.
  method now.

    data: files type filetable,
          filel like line of files,
          file  type string,
          path type string,
          fullpath type string,
          useract type i,
          rc      type i.

    call method cl_gui_frontend_services=>file_open_dialog
      exporting
        window_title         = filename
        default_extension    = 'XML'
        default_filename     = filename
*       prompt_on_overwrite  = 'X'
      changing
        file_table           = files
        rc                   = rc
*       path                 = path
*       fullpath             = fullpath
        user_action          = useract
*       file_encoding        =
      exceptions
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        others               = 4.
    if ( sy-subrc <> 0 ) or ( useract <> 0 ).
      write : / 'upload aborted'.
      return.
    endif.


    read table files into filel index 1.
    if sy-subrc <> 0.
      return.
    endif.

    file = filel.

    data: bytecount type i,
          workxtab type zxtab1024.

    call method cl_gui_frontend_services=>gui_upload
      exporting
        filename   = file
        filetype   = 'BIN'
      importing
        filelength = bytecount
      changing
        data_tab   = workxtab
      exceptions
        others     = 1.

    xstream = zcl_convert=>xtab_to_xstring( in  = workxtab
                                            len = bytecount ).

  endmethod.                    "now
endclass.                    "upload IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS download DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class download definition.
  public section.
    class-methods: now importing filename type string
                                 xstream  type xstring.
endclass.                    "download DEFINITION

*----------------------------------------------------------------------*
*       CLASS download IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class download implementation.
  method now.

    data: file type string,
          path type string,
          fullpath type string,
          useract type i.

    call method cl_gui_frontend_services=>file_save_dialog
      exporting
        window_title         = filename
        default_extension    = 'XML'
        default_file_name    = filename
        prompt_on_overwrite  = 'X'
      changing
        filename             = file
        path                 = path
        fullpath             = fullpath
        user_action          = useract
*       file_encoding        =
      exceptions
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        others               = 4.
    if ( sy-subrc <> 0 ) or ( useract <> 0 ).
      write : / 'download aborted'.
      return.
    endif.

    data: bytecount type i,
          workxtab type zxtab1024.

    bytecount = xstrlen( xstream ).
    workxtab  = zcl_convert=>xstring_to_xtab( xstream ).

    call method cl_gui_frontend_services=>gui_download
      exporting
        bin_filesize = bytecount
        filename     = fullpath
        filetype     = 'BIN'
      changing
        data_tab     = workxtab
      exceptions
        others       = 1.
  endmethod.                    "now
endclass.                    "download


start-of-selection.
  data: lv_xlsx type xstring.
  lv_xlsx = upload=>now( '*.xlsx' ).

  data: xx type ref to zzhp_xlsx,
        lodewijk type ref to cx_root.

  try.
      create object xx
        exporting
          iv_excel = lv_xlsx.
      xx->parse_xlsx( ).
    catch cx_root into lodewijk.
      break-point.
  endtry.







  break-point.