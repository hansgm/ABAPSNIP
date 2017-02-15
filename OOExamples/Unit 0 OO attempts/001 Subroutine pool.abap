PROGRAM  Z_SUBROUTINE_POOL.

data: global_int type i.



form set_global_int using in_int.
  global_int = in_int.
endform.

form get_global_int using in_int.
  in_int = global_int.
endform.



form set_local_int using in_int.
  data local_int type i.
  local_int = in_int.
endform.

form get_local_int using in_int.
  data local_int type i.
  in_int = local_int.
endform.