*&---------------------------------------------------------------------*
*& Report ZZHP_CREATE_XLSX
*&---------------------------------------------------------------------*
*& Most simple example to create XLSX file
*  with out any additional transformations or whatever
* tb honest, wrapper is not that necessary when using cl_srt_wsp_excel_2007
*&---------------------------------------------------------------------*
report zzhp_create_xlsx.

class buildexcel definition.
  public section.
    methods: constructor.
    methods: set_cell importing row type i
                                col type i
                                val type any.
    methods: get_binary returning value(xbin) type xstring.


  private section.
    constants: co_sheetname type string value 'MySheet'.
    data: r_exceldocument type ref to cl_srt_wsp_excel_2007.
endclass.

start-of-selection.
  try.
      data(lr) = new buildexcel( ).

      lr->set_cell( row = 1 col = 1 val = 'PIET' ).
      lr->set_cell( row = 1 col = 2 val = 'JAN' ).
      lr->set_cell( row = 1 col = 3 val = 'JORIS' ).
      " en ...
      lr->set_cell( row = 1 col = 4 val = 'CORNEEL' ).

      lr->set_cell( row = 2 col = 1 val = 'VL' ).
      lr->set_cell( row = 2 col = 2 val = 'CD' ).
      lr->set_cell( row = 2 col = 3 val = 'DD' ).
      lr->set_cell( row = 2 col = 4 val = 'MP' ).

      lr->set_cell( row = 3 col = 1 val = 'MPEG' ).
      lr->set_cell( row = 3 col = 2 val = 'JEG' ).
      lr->set_cell( row = 3 col = 3 val = 'GIF' ).
      lr->set_cell( row = 3 col = 4 val = 'PNG' ).

      data(xbin) = lr->get_binary( ).
      " Do what you like with the binary

    catch cx_root into data(lx).
      " Any error handling
  endtry.

  


class buildexcel implementation.
  method constructor.
    r_exceldocument = new cl_srt_wsp_excel_2007( ).
    r_exceldocument->add_sheet( co_sheetname ).
  endmethod.

  method set_cell.
    r_exceldocument->set_cell(
      exporting
        i_row_index = row
        i_col_index = col
        i_sheetname = co_sheetname
        i_data      = val
    ).
  endmethod.

  method get_binary.
    xbin = r_exceldocument->transform( ).
  endmethod.
endclass.
