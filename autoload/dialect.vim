" dialect.vim - Project specific spellfiles
" Author:   Daniel B. Marques
" Version:  0.2
" License:  Same as Vim


if exists("g:autoloaded_dialect") | finish | endif
let g:autoloaded_dialect = 1

function! dialect#getMainDir()
    let l:path = expand('%:p:h')
    while l:path != fnamemodify(l:path, ':h')
        if !empty(glob(l:path . '/.dialectmain'))
            return l:path
        endif
        let l:path = fnamemodify(l:path, ':h')
    endwhile
    return expand('%:p:h')
endfunction

function! dialect#localSpell(cmd)
    call DialectInit()
    let l:count = b:dialectcount > 0 ? b:dialectcount : ''
    execute "normal! " . l:count . tolower(a:cmd)
endfunction

function! dialect#localSpellV(cmd)
    call DialectInit()
    let l:count = b:dialectcount > 0 ? b:dialectcount : ''
    execute "normal! gv" . l:count . tolower(a:cmd)
endfunction

function! dialect#globalSpell(cmd)
    call DialectInit()
    if b:dialectcount > 1 || matchstr(a:cmd, '\d') >= 1
        execute "normal! " . substitute(a:cmd, '0', '', '')
    else
        let l:spellfile = &l:spellfile
        setlocal spellfile=
        execute "normal! " . substitute(a:cmd, '0', '', '')
        let &l:spellfile = l:spellfile
    endif
endfunction

