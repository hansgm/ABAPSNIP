    try.
        cl_salv_table=>factory(
          importing r_salv_table = data(lr_grid)
          changing  t_table = lt_cdperyearsort
        ).
        lr_grid->get_display_settings( )->set_striped_pattern( abap_true ).
        lr_grid->display( ).
      catch cx_salv_msg into data(gr_error).
        data(gv_str_text) = gr_error->if_message~get_text( ).
        message gv_str_text type 'E'.
    endtry.
