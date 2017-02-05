**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CCDEF          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CCIMP          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CCMAC          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* use this source file for any macro definitions you need
*"* in the implementation part of the class
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CI             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
private section.
*"* private components of class ZISCL_IA_WIN_MAIL_SPLIT
*"* do not include other source files here!!!
  class-data TNEFPREAMBLE type BYTE4 .
  class-data STARTATTACHMENT type BYTE4 .
  class-data STARTATTDATA type BYTE4 .
  class-data STARTATTNAME type BYTE4 .
  data INST_TNEV type XSTRING .
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CM001          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method CLASS_CONSTRUCTOR.
  tnefpreamble    = le( '223E9F78' ).
  startattachment = le( '00069002' ).
  startattname    = le( '00018010' ).
  startattdata    = le( '0006800F' ).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CM002          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method get_attachments.
  data: workx4  type x length 4,
        lentnef type i,
        offset type i,
        offsetname type i,
        namelength type i,
        namex      type xstring,
        offsetdata type i,
        x2c        type ref to cl_abap_conv_in_ce,
        attline    like line of att_return.
  if xstrlen( tnev ) < 4.
*   Exception
  endif.
  if tnev(4) <> tnefpreamble.
*   Exception.
  endif.
  lentnef = xstrlen( tnev ).
  x2c = cl_abap_conv_in_ce=>create( ).
  do.
    if sy-index > 10000. exit. endif. "Noodrem
    if tnev+offset byte-cs startattachment.
      if sy-fdpos >= lentnef.
        exit.
      endif.
      offset = offset + sy-fdpos + 4.
      if tnev+offset byte-cs startattname.
        offsetname     = offset + sy-fdpos + 4.                      "+ string start attachment
        workx4         = tnev+offsetname(4).                    "Length filename
        workx4         = le( workx4 ).                               "convert le to be
        namelength     = workx4 - 1.                                 "Minus 1 (Hex00 string termination)
        offsetname     = offsetname + 4.                             "+ length
        namex          = tnev+offsetname(namelength).
        x2c->convert( exporting input = namex
                      importing data  = attline-filename ).
      else.
        exit.
      endif.
      if tnev+offset byte-cs startattdata.
        offsetdata     = offset + sy-fdpos + 4.                       "+ string start attachmentdata
        workx4         = tnev+offsetdata(4).                     "Length filename
        workx4         = le( workx4 ).                                "convert le to be
        attline-length = workx4.                                      "
        offsetdata     = offsetdata + 4.                              "Add length
        attline-raw    = tnev+offsetdata(attline-length).
      else.
        exit.
      endif.
      offset = offsetdata + attline-length.                           "Continue with next part of stream
    else.
      exit.
    endif.
    append attline to att_return.
  enddo.
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CM003          HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
method LE.
* Big endian to little endian for 4 bytes
  return+0(1)  = in+3(1).
  return+1(1)  = in+2(1).
  return+2(1)  = in+1(1).
  return+3(1)  = in+0(1).
endmethod.
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CO             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
protected section.
*"* protected components of class ZISCL_IA_WIN_MAIL_SPLIT
*"* do not include other source files here!!!
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CP             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
class-pool .
*"* class pool for class ZCL_EXTRACT_WINMAIL
*"* local type definitions
include ZCL_EXTRACT_WINMAIL===========ccdef.
*"* class ZCL_EXTRACT_WINMAIL definition
*"* public declarations
  include ZCL_EXTRACT_WINMAIL===========cu.
*"* protected declarations
  include ZCL_EXTRACT_WINMAIL===========co.
*"* private declarations
  include ZCL_EXTRACT_WINMAIL===========ci.
endclass. "ZCL_EXTRACT_WINMAIL definition
*"* macro definitions
include ZCL_EXTRACT_WINMAIL===========ccmac.
*"* local class implementation
include ZCL_EXTRACT_WINMAIL===========ccimp.
class ZCL_EXTRACT_WINMAIL implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_EXTRACT_WINMAIL implementation
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CT             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZCL_EXTRACT_WINMAIL and it's users.
*"* touched if any type reference has been changed
**************************************************************************************************************************************************
**************************************************************************************************************************************************
ZCL_EXTRACT_WINMAIL===========CU             HGMELIGMEYLI HGMELIGMEYLI
**************************************************************************************************************************************************
class ZCL_EXTRACT_WINMAIL definition
  public
  final
  create public .
public section.
*"* public components of class ZCL_EXTRACT_WINMAIL
*"* do not include other source files here!!!
  types:
    byte4 type x length 4 .
  types:
    begin of attachment,
      filename type string,
      raw      type xstring,
      length   type i,
    end of attachment .
  types:
    attachments type table of attachment .
  class-methods CLASS_CONSTRUCTOR .
  class-methods LE
    importing
      !IN type BYTE4
    returning
      value(RETURN) type BYTE4 .
  class-methods GET_ATTACHMENTS
    importing
      value(TNEV) type XSTRING
    exporting
      value(ATT_RETURN) type ZCL_EXTRACT_WINMAIL=>ATTACHMENTS .
**************************************************************************************************************************************************
