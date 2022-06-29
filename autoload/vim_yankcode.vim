function! s:strip_control_chars(str) "{{{
    return substitute(a:str, "[[:cntrl:]]", "", "")
endfunction "}}}

function! vim_yankcode#with_context(with_git) "{{{
    let curdir=getcwd()
    redir @n | silent! :'<,'>number | redir END
    let filename=expand("%")
    exec "cd " . expand("%:p:h")
    let giturl=""
    let commit=""
    if a:with_git
        let gitrepo=fugitive#RemoteUrl()
        let gitrepo=substitute(l:giturl, "^git@", "", "")
        let gitrepo=substitute(l:gitrepo, ":", "/", "")
        let gitrepo=s:strip_control_chars(l:gitrepo)
        let commit=s:strip_control_chars(system("git log --format=oneline -n1 | cut -d' ' -f1"))
        let giturl=join([l:gitrepo, 
                    \ "tree", 
                    \ l:commit, 
                    \ resolve(l:filename)], "/") . "\n"
    endif
    let decoration=repeat('-', len(filename)+1)
    let @*=decoration . "\n" . filename . ':' . "\n" . giturl . decoration . "\n" . @n
    exec "cd " . l:curdir
endfunction  "}}}

