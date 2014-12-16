class ZCL_FI_POST_XLSX_V2 definition
  public
  inheriting from ZCL_XLSX
  create public .

public section.

  methods GET_HEADER
    returning
      value(RS_HEADER) type ZFIPOST_WDA_HEADER .
  methods GET_ITEMS
    returning
      value(RT_ITEMS) type ZFIPOST_WDA_ITEMS_T .
protected section.
private section.

  data IS_SORTED_BY_CELLNAME type WDY_BOOLEAN .

  class-methods GET_JPTYPE
    importing
      !TEXT type STRING
    returning
      value(JPTYPE) type ZJPTYPE .
  methods GET_CELL_BY_ID
    importing
      !ID type STRING
    returning
      value(VALUE) type STRING .
  methods GET_CELL_BY_ROW_COL
    importing
      !ROW type I
      !COL type STRING
    returning
      value(VALUE) type STRING .
  methods SORT_BY_CELLNAME .
  class-methods TO_DATE
    importing
      !IV_STRING type STRING
    returning
      value(RV_DATE) type D .
  class-methods CONDENSE
    importing
      !IN type STRING
    returning
      value(OUT) type STRING .
ENDCLASS.



CLASS ZCL_FI_POST_XLSX_V2 IMPLEMENTATION.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Static Private Method ZCL_FI_POST_XLSX_V2=>CONDENSE
* 

+-----------------------------------------------------------------------------------------------

--+
* | [--->] IN                             TYPE        STRING
* | [<-()] OUT                            TYPE        STRING
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method CONDENSE.
  out = in.
  condense out.
endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Instance Private Method ZCL_FI_POST_XLSX_V2->GET_CELL_BY_ID
* 

+-----------------------------------------------------------------------------------------------

--+
* | [--->] ID                             TYPE        STRING
* | [<-()] VALUE                          TYPE        STRING
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method get_cell_by_id.
  field-symbols <cellrow> type tt_cell.

  read table gt_cells
    assigning <cellrow>
    with key cell_name = id binary search.

  if sy-subrc <> 0.
    return.
  endif.

  if <cellrow>-cell_ststr is not initial.
    value = <cellrow>-cell_ststr.
  else.
    value = <cellrow>-cell_value.
  endif.

endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Instance Private Method ZCL_FI_POST_XLSX_V2->GET_CELL_BY_ROW_COL
* 

+-----------------------------------------------------------------------------------------------

--+
* | [--->] ROW                            TYPE        I
* | [--->] COL                            TYPE        STRING
* | [<-()] VALUE                          TYPE        STRING
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method GET_CELL_BY_ROW_COL.
  data: id type string.

  if row < 1 or row is initial.
    return.
  endif.

  id = row.

  concatenate col id into id.

  translate id to upper case.
  condense id no-gaps.

  value = get_cell_by_id( ID ).
endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Instance Public Method ZCL_FI_POST_XLSX_V2->GET_HEADER
* 

+-----------------------------------------------------------------------------------------------

--+
* | [<-()] RS_HEADER                      TYPE        ZFIPOST_WDA_HEADER
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method get_header.
  sort_by_cellname( ).

  rs_header-bukrs   = condense( get_cell_by_id( 'C3' ) ).
  rs_header-waers   = 'EUR'.                                              "HARD CODED, not from 

sheet
  rs_header-zjptype = get_jptype( condense( get_cell_by_id( 'C4' ) ) ).
  rs_header-blart   = condense( get_cell_by_id( 'G4' ) ).
  rs_header-bldat   = to_date( get_cell_by_id( 'C5' ) ).
  rs_header-budat   = to_date( get_cell_by_id( 'G5' ) ).
  rs_header-gjahr   = rs_header-budat(4).
  rs_header-xblnr   = condense( get_cell_by_id( 'C6' ) ).
  rs_header-bktxt   = condense( get_cell_by_id( 'G6' ) ).
endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Instance Public Method ZCL_FI_POST_XLSX_V2->GET_ITEMS
* 

+-----------------------------------------------------------------------------------------------

--+
* | [<-()] RT_ITEMS                       TYPE        ZFIPOST_WDA_ITEMS_T
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method get_items.
  sort_by_cellname( ).

  constants: voffset type i value 11.

  data:   vcurrent    type i,
          ls_wda_item like line of rt_items,
          lv_saknrnum type n length 10,
          lv_aufnrnum type n length 12,
          lv_prctrnum type n length 10,
          any_on_row  type wdy_boolean.

  vcurrent = voffset.

  while vcurrent < 1010.                    "999 items + 11, not any magic number
    clear: any_on_row,
           ls_wda_item,
           lv_saknrnum,
           lv_aufnrnum,
           lv_prctrnum.

    try.

* GL REK
        lv_saknrnum = get_cell_by_row_col( col = 'A' row = vcurrent ).
        if lv_saknrnum is not initial.
          any_on_row = abap_true.
          ls_wda_item-saknr = lv_saknrnum.
        endif.

* DB amount
        ls_wda_item-amountdb = get_cell_by_row_col( col = 'C' row = vcurrent ).
        if ls_wda_item-amountdb is not initial.
          any_on_row = abap_true.
          call function 'CONVERSION_EXIT_ZAMNT_INPUT'
            exporting
              input  = ls_wda_item-amountdb
            importing
              output = ls_wda_item-amountdb.
        endif.

* CR amount
        ls_wda_item-amountcr = get_cell_by_row_col( col = 'D' row = vcurrent ).
        if ls_wda_item-amountcr is not initial.
          any_on_row = abap_true.
          call function 'CONVERSION_EXIT_ZAMNT_INPUT'
            exporting
              input  = ls_wda_item-amountcr
            importing
              output = ls_wda_item-amountcr.
        endif.

* VAT
        ls_wda_item-mwskz = get_cell_by_row_col( col = 'E' row = vcurrent ).
        if ls_wda_item-mwskz is not initial.
          any_on_row = abap_true.
        endif.

* PRCTR
        lv_prctrnum = get_cell_by_row_col( col = 'F' row = vcurrent ).
        if lv_prctrnum is not initial.
          any_on_row = abap_true.
          ls_wda_item-prctr = lv_prctrnum.
        endif.


* Aufnr
        lv_aufnrnum = get_cell_by_row_col( col = 'G' row = vcurrent ).
        if lv_aufnrnum is not initial.
          any_on_row = abap_true.
          ls_wda_item-aufnr = lv_aufnrnum.
        endif.

* Sgtxt
        ls_wda_item-sgtxt = get_cell_by_row_col( col = 'H' row = vcurrent ).
        if ls_wda_item-sgtxt is not initial.
          any_on_row = abap_true.
        endif.

* Zuonr
        ls_wda_item-zuonr = get_cell_by_row_col( col = 'H' row = vcurrent ).
        if ls_wda_item-zuonr is not initial.
          any_on_row = abap_true.
        endif.


        if any_on_row = abap_true.
          append ls_wda_item to rt_items.
        endif.


      catch cx_root.
*     Do not do anything, just prevent from dumping
    endtry.



    add 1 to vcurrent.
  endwhile.
endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Static Private Method ZCL_FI_POST_XLSX_V2=>GET_JPTYPE
* 

+-----------------------------------------------------------------------------------------------

--+
* | [--->] TEXT                           TYPE        STRING
* | [<-()] JPTYPE                         TYPE        ZJPTYPE
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method GET_JPTYPE.
  data: lt_07t     type table of dd07t,
        ls_07t     type dd07t,
        lv_intext  type string,
        lv_cmptext type string.

  select * from dd07t into table lt_07t
    where domname = 'ZJPTYPE'
    and   ddlanguage = sy-langu
    and   as4local   = 'A'.

  lv_intext = text.
  condense lv_intext no-gaps.
  translate lv_intext to upper case.

  loop at lt_07t into ls_07t.
    lv_cmptext = ls_07t-ddtext.
    condense  lv_cmptext no-gaps.
    translate lv_cmptext to upper case.
    if lv_cmptext = lv_intext.
      jptype = ls_07t-domvalue_l.
      return.
    endif.

  endloop.

endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Instance Private Method ZCL_FI_POST_XLSX_V2->SORT_BY_CELLNAME
* 

+-----------------------------------------------------------------------------------------------

--+
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method sort_by_cellname.
  if is_sorted_by_cellname = abap_false.
    sort gt_cells by cell_name.
    is_sorted_by_cellname = abap_true.
  endif.
endmethod.


* 

<SIGNATURE>-------------------------------------------------------------------------------------

--+
* | Static Private Method ZCL_FI_POST_XLSX_V2=>TO_DATE
* 

+-----------------------------------------------------------------------------------------------

--+
* | [--->] IV_STRING                      TYPE        STRING
* | [<-()] RV_DATE                        TYPE        D
* +--------------------------------------------------------------------------------------

</SIGNATURE>
method to_date.
* Assumed dd.mm.yyyy, or at least split by .
* if any error return empty date
  data: v1 type string,
        v2 type string,
        v3 type string,

        dd type n length 2,
        mm type n length 2,
        yyyy type n length 4.

  try.

      split iv_string at '.' into v1 v2 v3.

      dd = condense( v1 ).
      mm = condense( v2 ).
      yyyy = condense( v3 ).

      if dd is initial or mm is initial or yyyy is initial.
        return.
      else.
        rv_date(4) = yyyy.
        rv_date+4(2) = mm.
        rv_date+6(2) = dd.
      endif.

    catch cx_root.
*     Noting to be done, just leave

    endtry.
  endmethod.
ENDCLASS.