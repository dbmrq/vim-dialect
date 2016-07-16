" dialect.vim - Project specific spellfiles
" Author:   Daniel B. Marques
" Version:  0.1
" License:  Same as ViM


if exists("g:loaded_dialect")
    finish
endif
let g:loaded_dialect = 1

let s:save_cpo = &cpo
set cpo&vim

au BufNewFile,BufRead * call SetSpellFile()

function! SetSpellFile()
    if !exists('g:dialectfile')
        let g:dialectfile = expand('%:p:h') .
                                \ '/.dialect.' . &l:fileencoding . '.add'
    endif
    if &l:spellfile == ""
        let &l:spellfile = g:dialectfile
    elseif !(&l:spellfile =~ g:dialectfile)
        let &l:spellfile .= "," . g:dialectfile
    endif
    let s:dialectcount = index(split(&l:spellfile, ","), g:dialectfile) + 1
endfunction

nnoremap <silent> zG :call LocalSpell("zG")<CR>
nnoremap <silent> zW :call LocalSpell("zW")<CR>
nnoremap <silent> zuG :call LocalSpell("zuG")<CR>
nnoremap <silent> zuW :call LocalSpell("zuW")<CR>
vnoremap <silent> zG :call LocalSpellV("zG")<CR>
vnoremap <silent> zW :call LocalSpellV("zW")<CR>
vnoremap <silent> zuG :call LocalSpellV("zuG")<CR>
vnoremap <silent> zuW :call LocalSpellV("zuW")<CR>
nnoremap <silent> zg :<C-U>call GlobalSpell(v:count . "zg")<CR>
nnoremap <silent> zw :<C-U>call GlobalSpell(v:count . "zw")<CR>
nnoremap <silent> zug :<C-U>call GlobalSpell(v:count . "zug")<CR>
nnoremap <silent> zuw :<C-U>call GlobalSpell(v:count . "zuw")<CR>
vnoremap <silent> zg :<C-U>call GlobalSpell("gv" . v:count . "zg")<CR>
vnoremap <silent> zw :<C-U>call GlobalSpell("gv" . v:count . "zw")<CR>
vnoremap <silent> zug :<C-U>call GlobalSpell("gv" . v:count . "zug")<CR>
vnoremap <silent> zuw :<C-U>call GlobalSpell("gv" . v:count . "zuw")<CR>

function! LocalSpell(cmd)
    call SetSpellFile()
    execute "normal! " . s:dialectcount . tolower(a:cmd)
endfunction

function! LocalSpellV(cmd)
    call SetSpellFile()
    execute "normal! gv" . s:dialectcount . tolower(a:cmd)
endfunction

function! GlobalSpell(cmd)
    call SetSpellFile()
    if s:dialectcount > 1 || matchstr(a:cmd, '\d') >= 1
        execute "normal! " . a:cmd
    else
        let b:spellfile = &l:spellfile
        setlocal spellfile=
        execute "normal! " . substitute(a:cmd, '0', '', '')
        let &l:spellfile = b:spellfile
    endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

