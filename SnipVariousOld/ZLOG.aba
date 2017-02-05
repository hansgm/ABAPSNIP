**************************************************************************************************************************************************
ZLOG==========================CCDEF          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* use this source file for any type declarations (class
*"* definitions, interfaces or data types) you need for method
*"* implementation or private method's signature
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CCIMP          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* local class implementation for public class
*"* use this source file for the implementation part of
*"* local helper classes
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CCMAC          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* use this source file for any macro definitions you need
*"* in the implementation part of the class
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CI             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* private components of class ZLOG
*"* do not include other source files here!!!
private section.
  class-data GV_STRUCDEPTH type I value -1. "#EC NOTEXT .
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM001          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method change_header.
  if iv_extnumber is supplied.
    gv_header-extnumber  = iv_extnumber.
  endif.
  if iv_object is supplied.
    gv_header-object = iv_object.
  endif.
  if iv_subobject is supplied.
    gv_header-subobject = iv_subobject.
  endif.
  call function 'BAL_LOG_HDR_CHANGE'
    exporting
      i_log_handle = gv_loghandle
      i_s_log      = gv_header.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM002          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method open.
  gv_header-EXTNUMBER = iv_EXTNUMBER.
  gv_header-OBJECT    = iv_object.
  gv_header-subobject = iv_subobject.
  check gv_loghandle is initial.
  call function 'BAL_LOG_CREATE'
    exporting
      i_s_log                 = gv_header
    importing
      e_log_handle            = gv_loghandle
    exceptions
      log_header_inconsistent = 1
      others                  = 2.
  if sy-subrc <> 0.
    message x000(38) with 'Permanent error' 'Cannot create log'.
  endif.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM003          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method STORE.
  data: lt_handletab  type bal_t_logh,
        ls_nvp        type IHTTPNVP,
        lv_workstring type string.
  if lines( gt_header_nvp ) > 0.
    lv_workstring = gv_header-extnumber.
    if lv_workstring is not initial.
      concatenate lv_workstring '?' into lv_workstring.
    endif.
    loop at gt_header_nvp into ls_nvp.
      if sy-tabix gt 1.
        concatenate lv_workstring '&' into lv_workstring.
      endif.
      translate ls_nvp-name to upper case.
      concatenate lv_workstring
                  ls_nvp-name
                  '='
                  ls_nvp-value
                  into lv_workstring.
    endloop.
    change_header( iv_extnumber = lv_workstring ).
  endif.
  append gv_loghandle to lt_handletab.
  call function 'BAL_DB_SAVE'
    exporting
      i_client         = zcl_convert=>integration_client
      i_in_update_task = 'X'
      i_t_log_handle   = lt_handletab
    exceptions
      log_not_found    = 1
      save_not_allowed = 2
      numbering_error  = 3
      others           = 4.
  if sy-subrc <> 0.
    message x000(38) with 'Permanenent error' 'Cannot store application log'.
  endif.
  if iv_commit is not initial.
    commit work.
  endif.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM004          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method CLEAR_HEADER_NVP.
  clear gt_header_nvp[].
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM005          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method fill_bpm_object.
  data: lv_int,
        lv_balobj type string,
        lv_balsub type string.
  lv_balobj = 'Z_BPM_FRAME'.
  lv_int = iv_processname.
  case lv_int.
    when 1. lv_balsub = 'SKILLSUPDATE'.
    when 2. lv_balsub = 'JOBOFFER'.
    when 3. lv_balsub = 'OBCONTRACT'.
    when 4. lv_balsub = 'OBPARTNER'.
    when 5. lv_balsub = 'JOBOFFER'.
    when others. lv_balsub = 'UNASSGND'.
  endcase.
  change_header( iv_object   = lv_balobj
                 iv_subobject = lv_balsub ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM006          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method MESSAGE_TO_LOG.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM007          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method NVP_TO_HEADER.
  data ls_nvp type IHTTPNVP.
  ls_nvp-name  = iv_name.
  ls_nvp-value = iv_value.
  append ls_nvp to GT_HEADER_NVP.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM008          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method NVP_TO_LOG.
  data: lv_value type string,
        lv_strout type string,
        lv_eq    type c value '='.
  lv_value = iv_value.
  concatenate iv_name
              lv_eq
              lv_value
              into lv_strout.
  text_to_log( lv_strout ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM009          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method STRUCT_TO_LOG.
  data: lv_type type c length 1,
        lr_structdescr type ref to cl_abap_structdescr,
        lr_typedescr   type ref to cl_abap_typedescr,
        lv_typename    type string,
        lv_discretevalue type string,
        lv_fname type abap_abstypename,
        lr_dataref type ref to data,
        lt_components type  abap_compdescr_tab,
        ls_components like line of lt_components.
  add 1 to gv_strucdepth.
  describe field iv_datain type lv_type.
  get reference of iv_datain into lr_dataref.
  if       lv_type ne 'h'           "Internal tables
       and lv_type ne 'r'           "Object references
       and lv_type ne 'u'           "Flat structures
       and lv_type ne 'v'.          "deep structures
    lr_typedescr = cl_abap_datadescr=>describe_by_data_ref( lr_dataref ).
    if iv_fieldname is supplied.
      lv_typename = iv_fieldname.
    else.
      lv_typename = lr_typedescr->get_relative_name( ).
    endif.
    lv_discretevalue = iv_datain.
    nvP_to_log_wlevel( iv_name  = lv_typename
                         iv_value = lv_discretevalue ).
  elseif lv_type eq 'u' or lv_type eq 'v'.
    lr_structdescr ?= cl_abap_datadescr=>describe_by_data_ref( lr_dataref ).
    if iv_fieldname is supplied.
      lv_typename = iv_fieldname.
    else.
      lv_typename = lr_structdescr->get_relative_name( ).
    endif.
    nvP_to_log_wlevel( iv_name  = ''
                       iv_value = lv_typename ).
    lt_components = lr_structdescr->components.
    field-symbols <datain> type any.
    data: lv_fieldname type string.
    loop at lt_components into ls_components.
      concatenate 'IV_DATAIN-' ls_components-name into lv_fieldname.
      assign (lv_fieldname) to <datain>.
      struct_to_log(
         iv_datain    = <datain>
         iv_fieldname = ls_components-name ).
    endloop.
  elseif lv_type eq 'h'.
    field-symbols <tab> type any table.
    field-symbols <wa> type any.
    assign iv_datain to <tab>.
    loop at <tab> assigning <wa>.
      nvP_to_log_wlevel( iv_name = 'Index'
                           iv_value = sy-tabix ).
      struct_to_log(
         iv_datain    = <WA> ).
    endloop.
  endif.
  subtract 1 from gv_strucdepth.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM00A          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method TEXT_TO_LOG.
  data: lv_textc type c length 256.
  lv_textc = iv_text.
  call function 'BAL_LOG_MSG_ADD_FREE_TEXT'
    exporting
      i_log_handle              = gv_loghandle
      i_msgty                   = iv_msgty
      i_text                    = lv_textc
   exceptions
     log_not_found             = 1
     msg_inconsistent          = 2
     log_is_full               = 3
     others                    = 4
            .
  if sy-subrc <> 0.
    message x000(38) with 'Permanent error' 'writing application log'.
  endif.
  if iv_store ne space.
    store( ).
  endif.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM00B          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method STORE_AND_COMMIT.
  store( 'X' ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM00C          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method nvp_to_log_wlevel.
  data: lv_string type string.
  do gv_strucdepth times.
    concatenate lv_string '|==' into lv_string.
  enddo.
  concatenate lv_string iv_name into lv_string.
  nvp_to_log( iv_name = lv_string
              iv_value = iv_value ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CM00D          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method cx_root_to_log.
  data: lv_message  type string,
        lv_progname type syrepid,
        lv_inclname type syrepid,
        lv_srceline type i,
        lv_srclnstr type string.
  ir_cx_root->get_source_position(
    importing
      program_name = lv_progname
      include_name = lv_inclname
      source_line  = lv_srceline ).
  lv_message = ir_cx_root->if_message~get_text( ).
  lv_srclnstr = lv_srceline.
  nvp_to_header( iv_name  = 'Program'
                 iv_value = lv_progname   ).
  nvp_to_header( iv_name  = 'Include'
                 iv_value = lv_inclname   ).
  nvp_to_header( iv_name  = 'linno'
                 iv_value = lv_srclnstr   ).
  nvp_to_header( iv_name  = 'message'
                 iv_value = lv_message   ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CO             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* protected components of class ZLOG
*"* do not include other source files here!!!
protected section.
  class-data GV_LOGHANDLE type BALLOGHNDL .
  class-data GV_HEADER type BAL_S_LOG .
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CP             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
class-pool .
*"* class pool for class ZLOG
*"* local type definitions
include ZLOG==========================ccdef.
*"* class ZLOG definition
*"* public declarations
  include ZLOG==========================cu.
*"* protected declarations
  include ZLOG==========================co.
*"* private declarations
  include ZLOG==========================ci.
endclass. "ZLOG definition
*"* macro definitions
include ZLOG==========================ccmac.
*"* local class implementation
include ZLOG==========================ccimp.
class ZLOG implementation.
*"* method's implementations
  include methods.
endclass. "ZLOG implementation
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CT             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZLOG and it's users.
*"* touched if any type reference has been changed
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZLOG==========================CU             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
class ZLOG definition
  public
  create public .
public section.
*"* public components of class ZLOG
*"* do not include other source files here!!!
  class-data C_DEFAULT type BALOBJ_D read-only value 'Z_XI_COMMON'. "#EC NOTEXT .
  class-data C_DEFAULTSUB type BALSUBOBJ read-only value 'UNASSGND'. "#EC NOTEXT .
  class-data C_INFO type SYMSGTY value 'I'. "#EC NOTEXT .
  class-data C_WARN type SYMSGTY value 'W'. "#EC NOTEXT .
  class-data C_ERROR type SYMSGTY value 'E'. "#EC NOTEXT .
  class-data C_ABEND type SYMSGTY value 'A'. "#EC NOTEXT .
  class-data GT_HEADER_NVP type TIHTTPNVP read-only .
  class-methods STRUCT_TO_LOG
    importing
      !IV_DATAIN type ANY
      !IV_FIELDNAME type CSEQUENCE default '' .
  class-methods OPEN
    importing
      !IV_OBJECT type CSEQUENCE default C_DEFAULT
      !IV_SUBOBJECT type CSEQUENCE default C_DEFAULTSUB
      !IV_EXTNUMBER type CSEQUENCE default SPACE .
  class-methods TEXT_TO_LOG
    importing
      !IV_TEXT type CSEQUENCE
      !IV_MSGTY type SYMSGTY default C_INFO
      !IV_STORE type BOOLE_D default SPACE .
  class-methods MESSAGE_TO_LOG .
  class-methods CHANGE_HEADER
    importing
      !IV_EXTNUMBER type CSEQUENCE optional
      !IV_OBJECT type CSEQUENCE optional
      !IV_SUBOBJECT type CSEQUENCE optional .
  class-methods STORE
    importing
      !IV_COMMIT type C default ' ' .
  class-methods NVP_TO_HEADER
    importing
      !IV_NAME type CSEQUENCE
      !IV_VALUE type CSEQUENCE .
  class-methods CLEAR_HEADER_NVP .
  class-methods FILL_BPM_OBJECT
    importing
      !IV_PROCESSNAME type CSEQUENCE .
  class-methods NVP_TO_LOG
    importing
      !IV_NAME type CSEQUENCE
      !IV_VALUE type ANY .
  class-methods NVP_TO_LOG_WLEVEL
    importing
      !IV_NAME type CSEQUENCE
      !IV_VALUE type ANY .
  class-methods STORE_AND_COMMIT .
  class-methods CX_ROOT_TO_LOG
    importing
      !IR_CX_ROOT type ref to CX_ROOT .
**************************************************************************************************************************************************
