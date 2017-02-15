REPORT  Z_USE_SUBROUTINE_POOL.

data: global_int type i.
data: pool_int type i.
data: pool_local_int type i.

start-of-selection.
  pool_int   = 5678.
  perform set_global_int(Z_SUBROUTINE_POOL) using pool_int.

  global_int = 1234.
  pool_int   = 0.
  write : / global_int, pool_int.

  perform get_global_int(Z_SUBROUTINE_POOL) using pool_int.
  write : / global_int, pool_int.

  pool_local_int   = 9999.
  perform set_local_int(Z_SUBROUTINE_POOL) using pool_local_int.
  perform get_local_int(Z_SUBROUTINE_POOL) using pool_local_int.
  write : / pool_local_int.