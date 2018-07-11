" dialect.vim - Project specific spellfiles
" Author:   Daniel B. Marques
" Version:  0.2
" License:  Same as Vim


if exists("g:loaded_dialect") | finish | endif
let g:loaded_dialect = 1

augroup Dialect
    au!
    au BufNewFile,BufRead * call DialectInit()
augroup END

function! DialectInit()
    let encoding = &l:fileencoding == '' ? &l:encoding : &l:fileencoding
    if exists('g:dialectmode') && tolower(g:dialectmode) == 'file'
        let tail = '/.' . expand('%:t') . '.' . encoding . '.add'
        let b:dialectfile = expand('%:p:h') . tail
    else
        let tail = '/.dialect.' . encoding . '.add'
        let b:dialectfile = dialect#getMainDir() . tail
    endif
    let b:dialectfile = escape(b:dialectfile, ',')
    if &l:spellfile == ""
        let &l:spellfile = b:dialectfile
    elseif !(&l:spellfile =~ tail)
        let &l:spellfile .= "," . b:dialectfile
    endif
    let b:dialectcount = index(split(&l:spellfile, ","), b:dialectfile) + 1
endfunction

nnoremap <silent> zG :call dialect#localSpell("zG")<CR>
nnoremap <silent> zW :call dialect#localSpell("zW")<CR>
nnoremap <silent> zuG :call dialect#localSpell("zuG")<CR>
nnoremap <silent> zuW :call dialect#localSpell("zuW")<CR>
vnoremap <silent> zG :call dialect#localSpellV("zG")<CR>
vnoremap <silent> zW :call dialect#localSpellV("zW")<CR>
vnoremap <silent> zuG :call dialect#localSpellV("zuG")<CR>
vnoremap <silent> zuW :call dialect#localSpellV("zuW")<CR>
nnoremap <silent> zg :<C-U>call dialect#globalSpell(v:count . "zg")<CR>
nnoremap <silent> zw :<C-U>call dialect#globalSpell(v:count . "zw")<CR>
nnoremap <silent> zug :<C-U>call dialect#globalSpell(v:count . "zug")<CR>
nnoremap <silent> zuw :<C-U>call dialect#globalSpell(v:count . "zuw")<CR>
vnoremap <silent> zg :<C-U>call dialect#globalSpell("gv" . v:count . "zg")<CR>
vnoremap <silent> zw :<C-U>call dialect#globalSpell("gv" . v:count . "zw")<CR>
vnoremap <silent> zug :<C-U>call dialect#globalSpell("gv" . v:count . "zug")<CR>
vnoremap <silent> zuw :<C-U>call dialect#globalSpell("gv" . v:count . "zuw")<CR>

