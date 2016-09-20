" dialect.vim - Project specific spellfiles
" Author:   Daniel B. Marques
" Version:  0.1
" License:  Same as Vim


if exists("g:loaded_dialect")
    finish
endif
let g:loaded_dialect = 1

let s:save_cpo = &cpo
set cpo&vim

call s:setSpellFile()

function! s:setSpellFile()
    let encoding = &l:fileencoding == '' ? &l:encoding : &l:fileencoding
    if exists('g:dialectmode') && tolower(g:dialectmode) == 'file'
        let b:dialectfile =
            \ expand('%:p:h') . '/.' . expand('%:t') . '.' . encoding . '.add'
    else
        let b:dialectfile = expand('%:p:h') . '/.dialect.' . encoding . '.add'
    endif
    if &l:spellfile == ""
        let &l:spellfile = b:dialectfile
    elseif !(&l:spellfile =~ b:dialectfile)
        let &l:spellfile .= "," . b:dialectfile
    endif
    let b:dialectcount = index(split(&l:spellfile, ","), b:dialectfile) + 1
endfunction

nnoremap <silent> zG :call <SID>localSpell("zG")<CR>
nnoremap <silent> zW :call <SID>localSpell("zW")<CR>
nnoremap <silent> zuG :call <SID>localSpell("zuG")<CR>
nnoremap <silent> zuW :call <SID>localSpell("zuW")<CR>
vnoremap <silent> zG :call <SID>localSpellV("zG")<CR>
vnoremap <silent> zW :call <SID>localSpellV("zW")<CR>
vnoremap <silent> zuG :call <SID>localSpellV("zuG")<CR>
vnoremap <silent> zuW :call <SID>localSpellV("zuW")<CR>
nnoremap <silent> zg :<C-U>call <SID>globalSpell(v:count . "zg")<CR>
nnoremap <silent> zw :<C-U>call <SID>globalSpell(v:count . "zw")<CR>
nnoremap <silent> zug :<C-U>call <SID>globalSpell(v:count . "zug")<CR>
nnoremap <silent> zuw :<C-U>call <SID>globalSpell(v:count . "zuw")<CR>
vnoremap <silent> zg :<C-U>call <SID>globalSpell("gv" . v:count . "zg")<CR>
vnoremap <silent> zw :<C-U>call <SID>globalSpell("gv" . v:count . "zw")<CR>
vnoremap <silent> zug :<C-U>call <SID>globalSpell("gv" . v:count . "zug")<CR>
vnoremap <silent> zuw :<C-U>call <SID>globalSpell("gv" . v:count . "zuw")<CR>

function! s:localSpell(cmd)
    call s:setSpellFile()
    execute "normal! " . b:dialectcount . tolower(a:cmd)
endfunction

function! s:localSpellV(cmd)
    call s:setSpellFile()
    execute "normal! gv" . b:dialectcount . tolower(a:cmd)
endfunction

function! s:globalSpell(cmd)
    call s:setSpellFile()
    if b:dialectcount > 1 || matchstr(a:cmd, '\d') >= 1
        execute "normal! " . substitute(a:cmd, '0', '', '')
    else
        let l:spellfile = &l:spellfile
        setlocal spellfile=
        execute "normal! " . substitute(a:cmd, '0', '', '')
        let &l:spellfile = l:spellfile
    endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

