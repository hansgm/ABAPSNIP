
private section.
****************************************************************************************************************************
method extract.
  data:
         lv_str_base64 type string,
         lv_dest       type rfcdest,
         lr_fp         type ref to if_fp,
         lr_pdfobj     type ref to if_fp_pdf_object,
         lv_pdf_bin    type xstring,
         lr_fpex       type ref to cx_fp_runtime,
         lr_root       type ref to cx_root,
         ls_faultdata  type zexchange_fault_data.
  if iv_input is initial.
    ls_faultdata-fault_text = 'No PDF data supplied'.
    raise exception type zcx_error_message
       exporting standard = ls_faultdata.
  endif.
  move cl_fp=>get_ads_connection( ) to lv_dest.
* get FP reference
  lr_fp = cl_fp=>get_reference( ).
  try.
*     Create PDF Object
      lr_pdfobj = lr_fp->create_pdf_object( connection = lv_dest ).
*     Set document
      lr_pdfobj->set_document(
        pdfdata = iv_input ).
*     Tell PDF object to extract data
      call method lr_pdfobj->set_task_extractdata( ).
*     Execute, call ADS
      call method lr_pdfobj->execute( ).
*     Get data
      call method lr_pdfobj->get_data
        importing
          formdata = ev_output.
    catch cx_fp_runtime_internal
          cx_fp_runtime_system
          cx_fp_runtime_usage    into lr_fpex.
      ls_faultdata-fault_text = lr_fpex->errmsg.
      raise exception type zcx_error_message
         exporting standard = ls_faultdata.
    catch cx_root into lr_root.
      ls_faultdata-fault_text = zcl_convert=>cx_root_2_string( lr_root ).
      raise exception type zcx_error_message
         exporting standard = ls_faultdata.
  endtry.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_PDF_DATA==========CO             AVANDEPUT    AVANDEPUT
**************************************************************************************************************************************************
*"* protected components of class ZCL_EXTRACT_PDF_DATA
*"* do not include other source files here!!!
protected section.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_PDF_DATA==========CP             AVANDEPUT    HGMELIGMEYLI
**************************************************************************************************************************************************
class-pool .
*"* class pool for class ZCL_EXTRACT_PDF_DATA
*"* local type definitions
include ZCL_EXTRACT_PDF_DATA==========ccdef.
*"* class ZCL_EXTRACT_PDF_DATA definition
*"* public declarations
  include ZCL_EXTRACT_PDF_DATA==========cu.
*"* protected declarations
  include ZCL_EXTRACT_PDF_DATA==========co.
*"* private declarations
  include ZCL_EXTRACT_PDF_DATA==========ci.
endclass. "ZCL_EXTRACT_PDF_DATA definition
*"* macro definitions
include ZCL_EXTRACT_PDF_DATA==========ccmac.
*"* local class implementation
include ZCL_EXTRACT_PDF_DATA==========ccimp.
class ZCL_EXTRACT_PDF_DATA implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_EXTRACT_PDF_DATA implementation
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_PDF_DATA==========CT             AVANDEPUT   
**************************************************************************************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZCL_EXTRACT_PDF_DATA and it's users.
*"* touched if any type reference has been changed
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_PDF_DATA==========CU             AVANDEPUT    
**************************************************************************************************************************************************
class ZCL_EXTRACT_PDF_DATA definition
  public
  create public .
*"* public components of class ZCL_EXTRACT_PDF_DATA
*"* do not include other source files here!!!
public section.
  class-methods EXTRACT
    importing
      value(IV_INPUT) type XSTRING
    exporting
      value(EV_OUTPUT) type XSTRING
    raising
      ZCX_ERROR_MESSAGE .
**************************************************************************************************************************************************
