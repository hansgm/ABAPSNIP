REPORT  Z_USE_CLASS_SUBROUTINE_POOL.

data: local_int type i value 22.

perform create_obj(Z_SUBROUTINE_POOL_W_CLASS) using local_int.

local_int = 33.

perform read_obj(Z_SUBROUTINE_POOL_W_CLASS) using local_int.

write : local_int.