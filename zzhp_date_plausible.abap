*&---------------------------------------------------------------------*
*& Report ZZHP_DATE_PLAUSIBLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zzhp_date_plausible.

* data plausibility with convert into timestamp considerably faster then fm DATE_CHECK_PLAUSIBILITY
* Especially when result is negative (e.q. 00000000) and when date do not reach the 85 century, 
* at least when tested at my SAP system. 
* Outcome DATE_CHECK_PLAUSIBILITY and check on convert to time stamp equal for the testcases I used

parameters pa_date type c length 8.

types : begin of c_date,
          d_date type d,
        end of c_date.

start-of-selection.
  data ts type timestamp.
  data ds type d.
  ds = pa_date.
  data t1 type i.
  data t2 type i.


  do 10000 times.

*    add sy-index to ds.

    get run time field data(r1s).
    try.
        convert date  ds into time stamp ts time zone sy-zonlo.
        if ts is not initial.
*          write : 'plausible'.
        else.
*          write : 'invalid date'.
        endif.

*      write ts.
      catch cx_root into data(lx).
*        write : 'invalide date'.
    endtry.
    get run time field data(r1e).
    t1 = t1 + r1e - r1s.

    get run time field data(r2s).
    call function 'DATE_CHECK_PLAUSIBILITY'
      exporting
        date                      = ds
      exceptions
        plausibility_check_failed = 1
        others                    = 2.
    if sy-subrc eq 0.
*      write : / 'plausible'.
    else.
*      write : / 'invalid date'.
    endif.

    get run time field data(r2e).
    t2 = t2 + r2e - r2s.

  enddo.

  write : / t1, t2.
