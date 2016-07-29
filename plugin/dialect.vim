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

au BufNewFile,BufRead * call s:setSpellFile()

function! s:setSpellFile()
    if !exists('g:dialectfile')
        let g:dialectfile = expand('%:p:h') .
                                \ '/.dialect.' . &l:fileencoding . '.add'
    else
        let g:dialectfile = expand(g:dialectfile)
    endif
    if &l:spellfile == ""
        let &l:spellfile = g:dialectfile
    elseif !(&l:spellfile =~ g:dialectfile)
        let &l:spellfile .= "," . g:dialectfile
    endif
    let s:dialectcount = index(split(&l:spellfile, ","), g:dialectfile) + 1
endfunction

nnoremap <silent> zG :call s:localSpell("zG")<CR>
nnoremap <silent> zW :call s:localSpell("zW")<CR>
nnoremap <silent> zuG :call s:localSpell("zuG")<CR>
nnoremap <silent> zuW :call s:localSpell("zuW")<CR>
vnoremap <silent> zG :call s:localSpellV("zG")<CR>
vnoremap <silent> zW :call s:localSpellV("zW")<CR>
vnoremap <silent> zuG :call s:localSpellV("zuG")<CR>
vnoremap <silent> zuW :call s:localSpellV("zuW")<CR>
nnoremap <silent> zg :<C-U>call s:globalSpell(v:count . "zg")<CR>
nnoremap <silent> zw :<C-U>call s:globalSpell(v:count . "zw")<CR>
nnoremap <silent> zug :<C-U>call s:globalSpell(v:count . "zug")<CR>
nnoremap <silent> zuw :<C-U>call s:globalSpell(v:count . "zuw")<CR>
vnoremap <silent> zg :<C-U>call s:globalSpell("gv" . v:count . "zg")<CR>
vnoremap <silent> zw :<C-U>call s:globalSpell("gv" . v:count . "zw")<CR>
vnoremap <silent> zug :<C-U>call s:globalSpell("gv" . v:count . "zug")<CR>
vnoremap <silent> zuw :<C-U>call s:globalSpell("gv" . v:count . "zuw")<CR>

function! s:localSpell(cmd)
    call s:setSpellFile()
    execute "normal! " . s:dialectcount . tolower(a:cmd)
endfunction

function! s:localSpellV(cmd)
    call s:setSpellFile()
    execute "normal! gv" . s:dialectcount . tolower(a:cmd)
endfunction

function! s:globalSpell(cmd)
    call s:setSpellFile()
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

