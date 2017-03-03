REPORT Z.

types: begin of ty_rec,
         key1 type string,
         key2 type string,
       end of ty_rec,

       tty_rec type hashed table of ty_rec
         with unique key key1
         with non-unique sorted key key2 components key2.

data(lt_key) = value tty_rec(
 ( key1 = 'aap' key2  = 'aab' )
 ( key1 = 'noot' key2 = 'nood' )
 ( key1 = 'mies' key2 = 'aab' )
).

data(ls_key) = lt_key[ key key2 components key2 = 'aab' ]. "Unpredictable

write ls_key-key1.

loop at lt_key
  assigning field-symbol(<ls>) using key key2 where key2 = 'aab'.
  write : / <ls>-key1, <ls>-key2.
endloop.