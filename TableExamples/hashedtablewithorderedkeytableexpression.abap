REPORT ZZHPTABLE2.

types: begin of ty_rec,
         key1 type string,
         key2 type string,
       end of ty_rec,

       tty_rec type hashed table of ty_rec
         with unique key key1
         with unique sorted key key2 components key2.

data(lt_key) = value tty_rec(
 ( key1 = 'aap' key2 = 'aab' )
 ( key1 = 'noot' key2 = 'nood' )
) .


data(ls_key) = lt_key[ key key2 components key2 = 'aab' ].

write ls_key-key1.