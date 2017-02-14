report zzhp_adbc.

try.

    data(sql) = new cl_sql_statement( ).
    data(waers) = |EUR|.

    sql->set_param( ref #( sy-mandt ) ).
    sql->set_param( ref #( waers ) ).

    data(resultset) = sql->execute_query( | SELECT * FROM T001 WHERE MANDT = ? AND WAERS = ? | ).

    data out type t001.
    data out_tab type table of t001.
    resultset->set_param_struct( ref #( out ) ).

    while resultset->next( ) > 0.
      write : / out-bukrs,
                out-butxt,
                out-waers.
    endwhile.

  catch cx_root into data(exc).
    ...
endtry.
