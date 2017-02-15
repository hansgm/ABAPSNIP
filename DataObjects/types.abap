report x.

types: ty_type1 type t000-mandt.
types: ty_type2 type symandt.
types: ty_type3 type n length 3. 

types: begin of ty_stru1,
         field1 type string,      "Elementary
         field2 type n,           "Elementary not fully specified
         field3 type symandt,      "Using DDIC type
       end of ty_stru1,
       
       tty_stru1 type table of ty_stru1 with empty key,
       
       begin of ty_stru2,
         client type t000,
         otherclient type ty_stru1,
         otherclients type tty_stru1,
       end of ty_stru2,
       
       tty_stru2 type table of ty_stru2 with empty key.      