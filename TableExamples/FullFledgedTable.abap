report x.

types: begin of ty_stru,
         nickname   type string,
         familyname type string,
         bsn        type string,
         birthyear  type i,
         birthmonth type i,
         birthday   type i,
       end of ty_stru,

       tty_stru type hashed table of ty_stru
         with unique key familyname nickname
         with non-unique sorted key family components familyname
         with unique hashed key bsn components bsn
         with non-unique sorted key birthdate components birthyear birthmonth birthday.

types: begin of ty_client,
         mandt type i,
       end of ty_client,
       tty_client type standard table of ty_client with empty key.

data: lt_person type tty_stru.



start-of-selection.
  select * from t000 into table @data(lt_clients).
  select * from t000 appending table lt_clients.
  data(ls_t000) = value t000( mandt = '077').
  insert ls_t000 into lt_clients index 3.

  data(lt_clients2) = lt_clients.
  loop at lt_clients2 assigning field-symbol(<client>).
    write : / <client>-mandt.
  endloop.

  data: clientsint type tty_client.
  move-corresponding lt_clients to clientsint.
  loop at clientsint assigning field-symbol(<int>).
    write : / <int>-mandt.
  endloop.



  data(lr_descriptor) = cl_abap_typedescr=>describe_by_data( lt_person ).

  lt_person = value tty_stru(
    ( nickname = 'Robert' familyname = 'Lodewijk' bsn = '1234567' birthyear = 1997 birthmonth = 2 birthday = 12 )
    ( nickname = 'Flip' familyname = 'Parser' bsn = '2234567' birthyear = 1996 birthmonth = 1 birthday = 27 )
    ( nickname = 'Miranda' familyname = 'Buizerd' bsn = '3234567' birthyear = 1989 birthmonth = 12 birthday = 31 )
    ( nickname = 'Josephine' familyname = 'Baker' bsn = '4234567' birthyear = 2001 birthmonth = 5 birthday = 31 )
  ).

  try.
      data(ls_person) = value ty_stru(
         nickname = 'Eline' familyname = 'Mordegaay' bsn = '5234567' birthyear = 1997 birthmonth = 2 birthday = 12
      ).
      insert ls_person into table lt_person.
    catch cx_root into data(lx).
      break-point.
  endtry.

  loop at lt_person assigning field-symbol(<person>).
    write : / <person>-familyname, <person>-nickname, <person>-birthyear.
  endloop.

  skip.
  loop at lt_person assigning <person> using key birthdate from 3.
    write : / <person>-familyname, <person>-nickname, <person>-birthyear.
  endloop.

  "  <person> = lt_person[ key bsn component bsn = '3234567' ].
  "  Not possible >> Hashed table

*  read table lt_person assigning <person> with key bsn = '3234567' .
  "uses primary key, takes longer

  read table lt_person assigning <person> with key bsn components bsn = '1234567' .
  "uses alternative key

  skip.

  types: begin of ty_yearcount,
           year type c length 10,
           count type i,
         end of ty_yearcount,
         tty_yearcount type hashed table of ty_yearcount with unique key year.

  data: lt_yearcount type tty_yearcount.

  loop at lt_person into ls_person.
    data(ls_yearcount) = value ty_yearcount(
      year = ls_person-birthyear
      count = 1
    ).
    collect ls_yearcount into lt_yearcount.
  endloop.

  loop at lt_yearcount into ls_yearcount.
    write : / ls_yearcount-year,
              ls_yearcount-count.
  endloop.