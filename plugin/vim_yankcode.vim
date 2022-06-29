if exists("g:loaded_vim_yankcode")
    finish
endif
let g:loaded_vim_yankcode = 1

command! -nargs=? YankCode call vim_yankcode#with_context(<q-args>)
