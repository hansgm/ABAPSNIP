method GET_OTR_LONGTEXT.
  data: lv_alias type sotr_alias,
        ls_head  type sotr_head,
        ls_textu type sotr_textu,
        ls_otrky type sotr_key.

  lv_alias = iv_alias.

  call function 'SOTR_STRING_GET_ALIAS'
    exporting
      alias_name           = lv_alias
    importing
      header               = ls_head
    exceptions
      alias_does_not_exist = 1
      rfc_failure          = 2
      others               = 3.
  if sy-subrc <> 0.
    return.
  endif.

  ls_otrky-concept = ls_head-concept.

  call function 'SOTR_STRING_READ_TEXT_WITH_KEY'
    exporting
      langu            = iv_langu
*     CONTEXT          =
      sotr_key         = ls_otrky
*     FLAG_CONTEXT     =
    importing
      header           = ls_head
      entry            = ls_textu
    exceptions
      no_entry_found   = 1
      language_missing = 2
      others           = 3.
  if sy-subrc <> 0.
    return.
  endif.

  rv_string = ls_textu-text.
endmethod.