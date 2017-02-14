**************************************************************************************************************************************************
ZBPM_IMPORT_DATA                             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*&---------------------------------------------------------------------*
*& Report  ZBPM_IMPORT_DATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report zbpm_import_data.
parameters: cont_obj as checkbox.
parameters: cont_dat as checkbox.
parameters: task_lst as checkbox.
parameters: proc_hea as checkbox.
parameters: proc_itm as checkbox.
parameters: dodelete as checkbox.
parameters: doupdate as checkbox.
*----------------------------------------------------------------------*
*       CLASS download DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class upload definition.
  public section.
    class-methods: now importing filename type string
                       exporting xstream  type xstring.
endclass.                    "download DEFINITION
*----------------------------------------------------------------------*
*       CLASS download IMPLEMENTATION
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
endclass.                    "download IMPLEMENTATION
start-of-selection.
  data: lt_zpri_contain_obj type table of zpri_contain_obj,
        lt_zpri_contain_dat type table of zpri_contain_dat,
        lt_zbpm_task_list   type table of zbpm_task_list,
        lt_zprxi_process    type table of zprxi_process,
        lt_zprxi_step       type table of zprxi_step,
        lv_lines            type i,
        ls_xmlx             type xstring.
  if cont_obj is not initial.
    skip.
    upload=>now( exporting filename = 'zpri_contain_obj'
                 importing xstream  = ls_xmlx ).
    try.
        call transformation id
          source xml     ls_xmlx
          result data =  lt_zpri_contain_obj.
      catch cx_root.
        write :/ 'Exception with parsing'.
        stop.
    endtry.
    lv_lines = lines( lt_zpri_contain_obj ).
    write : / 'records read for zpri_contain_obj:', lv_lines.
    if dodelete is not initial.
      delete from zpri_contain_obj where name like '%'.
      write : / 'records deleted from zpri_contain_obj:', sy-dbcnt.
    endif.
    if doupdate is not initial.
      insert zpri_contain_obj from table lt_zpri_contain_obj.
      write : / 'records inserted into zpri_contain_obj:', sy-dbcnt.
    endif.
  endif.
  if cont_dat is not initial.
    skip.
    upload=>now( exporting filename = 'zpri_contain_dat'
                 importing xstream  = ls_xmlx ).
    try.
        call transformation id
          source xml     ls_xmlx
          result data =  lt_zpri_contain_dat.
      catch cx_root.
        write :/ 'Exception with parsing'.
        stop.
    endtry.
    lv_lines = lines( lt_zpri_contain_dat ).
    write : / 'records read for zpri_contain_dat:', lv_lines.
    if dodelete is not initial.
      delete from zpri_contain_dat where name like '%'.
      write : / 'records deleted from zpri_contain_dat:', sy-dbcnt.
    endif.
    if doupdate is not initial.
      insert zpri_contain_dat from table lt_zpri_contain_dat.
      write : / 'records inserted into zpri_contain_dat:', sy-dbcnt.
    endif.
  endif.
  if task_lst is not initial.
    skip.
    upload=>now( exporting filename = 'zbpm_task_list'
                 importing xstream  = ls_xmlx ).
    try.
        call transformation id
          source xml     ls_xmlx
          result data =  lt_zbpm_task_list.
      catch cx_root.
        write :/ 'Exception with parsing'.
        stop.
    endtry.
    lv_lines = lines( lt_zbpm_task_list ).
    write : / 'records read for zbpm_task_list:', lv_lines.
    if dodelete is not initial.
      delete from zbpm_task_list where resp_srv_name like '%'.
      write : / 'records deleted from zbpm_task_list:', sy-dbcnt.
    endif.
    if doupdate is not initial.
      insert zbpm_task_list from table lt_zbpm_task_list.
      write : / 'records inserted into zbpm_task_list:', sy-dbcnt.
    endif.
  endif.
  if proc_hea is not initial.
    skip.
    upload=>now( exporting filename = 'zprxi_process'
                 importing xstream  = ls_xmlx ).
    try.
        call transformation id
          source xml     ls_xmlx
          result data =  lt_zprxi_process.
      catch cx_root.
        write :/ 'Exception with parsing'.
        stop.
    endtry.
    lv_lines = lines( lt_zprxi_process ).
    write : / 'records read for zprxi_process:', lv_lines.
    if dodelete is not initial.
      delete from zprxi_process where description like '%'.
      write : / 'records deleted from zprxi_process:', sy-dbcnt.
    endif.
    if doupdate is not initial.
      insert zprxi_process from table lt_zprxi_process.
      write : / 'records inserted into zprxi_process:', sy-dbcnt.
    endif.
  endif.
  if proc_itm is not initial.
    skip.
    upload=>now( exporting filename = 'zprxi_step'
                 importing xstream  = ls_xmlx ).
    try.
        call transformation id
          source xml     ls_xmlx
          result data =  lt_zprxi_step.
      catch cx_root.
        write :/ 'Exception with parsing'.
        stop.
    endtry.
    lv_lines = lines( lt_zprxi_step ).
    write : / 'records read for zprxi_step:', lv_lines.
    if dodelete is not initial.
      delete from zprxi_step where stepid like '%'.
      write : / 'records deleted from zprxi_step:', sy-dbcnt.
    endif.
    if doupdate is not initial.
      insert zprxi_step from table lt_zprxi_step.
      write : / 'records inserted into zprxi_step:', sy-dbcnt.
    endif.
  endif.
**************************************************************************************************************************************************
