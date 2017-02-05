**************************************************************************************************************************************************
ZBPM_EXPORT_DATA                             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*&---------------------------------------------------------------------*
*& Report  ZBPM_EXPORT_DATA
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report zbpm_export_data.
parameters: cont_obj as checkbox.
parameters: cont_dat as checkbox.
parameters: task_lst as checkbox.
parameters: proc_hea as checkbox.
parameters: proc_itm as checkbox.
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
endclass.                    "download IMPLEMENTATION
start-of-selection.
  data: lt_zpri_contain_obj type table of zpri_contain_obj,
        lt_zpri_contain_dat type table of zpri_contain_dat,
        lt_zbpm_task_list   type table of zbpm_task_list,
        lt_zprxi_process    type table of zprxi_process,
        lt_zprxi_step       type table of zprxi_step,
        ls_xmlx             type xstring.
  if cont_obj is not initial.
    select * from   zpri_contain_obj into table   lt_zpri_contain_obj.
    write : / 'records read from zpri_contain_obj:', sy-dbcnt.
    call transformation id
      source data =  lt_zpri_contain_obj
      result xml  ls_xmlx.
    download=>now( exporting filename = 'zpri_contain_obj'
                             xstream  = ls_xmlx ).
  endif.
  if cont_dat is not initial.
    select * from   zpri_contain_dat into table   lt_zpri_contain_dat.
    write : / 'records read from zpri_contain_dat:', sy-dbcnt.
    call transformation id
      source data =  lt_zpri_contain_dat
      result xml  ls_xmlx.
    download=>now( exporting filename = 'zpri_contain_dat'
                             xstream  = ls_xmlx ).
  endif.
  if task_lst is not initial.
    select * from   zbpm_task_list into table   lt_zbpm_task_list.
    write : / 'records read from zbpm_task_list:', sy-dbcnt.
    call transformation id
      source data =  lt_zbpm_task_list
      result xml  ls_xmlx.
    download=>now( exporting filename = 'zbpm_task_list'
                             xstream  = ls_xmlx ).
  endif.
  if proc_hea is not initial.
    select * from   zprxi_process into table   lt_zprxi_process.
    write : / 'records read from zprxi_process:', sy-dbcnt.
    call transformation id
      source data =  lt_zprxi_process
      result xml  ls_xmlx.
    download=>now( exporting filename = 'zprxi_process'
                             xstream  = ls_xmlx ).
  endif.
  if proc_itm is not initial.
    select * from   zprxi_step into table   lt_zprxi_step.
    write : / 'records read from zprxi_step:', sy-dbcnt.
    call transformation id
      source data =  lt_zprxi_step
      result xml  ls_xmlx.
    download=>now( exporting filename = 'zprxi_step'
                             xstream  = ls_xmlx ).
  endif.
**************************************************************************************************************************************************
