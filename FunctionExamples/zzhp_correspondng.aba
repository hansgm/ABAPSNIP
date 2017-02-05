report zzhp_corresponding.

types: begin of tt_small_line,
         progname type progname,
         data     type xstring,
       end of tt_small_line.

select single * from reposrc
  into @data(st_repo)
  where progname = @sy-repid.

data(small_line) = corresponding tt_small_line( st_repo ).
