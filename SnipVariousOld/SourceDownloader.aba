*&---------------------------------------------------------------------*
*& Report  ZZHP0004
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZZHP0004.


data reponame type PROGNAME.

select-options so_name for reponame.

data: lt_repo type table of reposrc.
data: ls_repo like line of lt_repo.
select * from reposrc into table lt_repo where PROGNAME in so_name.

data lines type string value '**************************************************************************************************************************************************'.

data: lt_source type table of string.
data: ls_source type string.

loop at lt_repo into ls_repo.
  write : / lines.
  write : / ls_repo-PROGNAME,
            ls_repo-TYPE,
            ls_repo-cnam,
            ls_repo-unam.
  write : / lines.

  read report ls_repo-PROGNAME into lt_source.
  loop at lt_source into ls_source.
    write : / ls_source.
  endloop.
  write : / lines.
endloop.