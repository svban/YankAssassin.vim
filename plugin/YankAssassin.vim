" Don't move cursor to the start of the text, after yanking it
" Last Change: 2022 Mar 11
" Maintainer: svban

if exists("g:loaded_yankassassin")
  finish
endif
let g:loaded_yankassassin = 1

let s:save_cpo = &cpo
set cpo&vim

let g:yankassassin_use_mappings = exists("g:yankassassin_use_mappings") ? g:yankassassin_use_mappings : 0

if g:yankassassin_use_mappings == 0
    augroup s:NoMoveYank
        autocmd!
        autocmd VimEnter * let s:NoMapPreYankPos = getpos('.')
        autocmd CursorMoved * let s:NoMapPreYankPos = getpos('.')
        autocmd TextYankPost * call s:YankAssassin()
    augroup END
    function! s:YankAssassin() abort
        if get(g:, 'MoveYankMappings', 1) && v:event.operator=="y" && !empty(s:NoMapPreYankPos)
                call setpos('.', s:NoMapPreYankPos)
        endif
        let g:MoveYankMappings=1
    endfunction
    nnoremap <expr><silent> <Plug>YADefault ':<C-u>let g:MoveYankMappings=0<CR>' . v:count1 . '"' . v:register . 'y'
    xnoremap <expr><silent> <Plug>YADefault ':<C-u>let g:MoveYankMappings=0<CR>' . 'gv' . '"' . v:register . 'y'
elseif g:yankassassin_use_mappings == 1
    function! s:PreYankMotion() abort
        let s:PreYankPos = getpos('.')
        let s:MyRegister = empty(v:register) ? '"' : v:register
    endfunction
    function! s:YankAssassinMapping(type, ...) abort
        if &selection ==# 'exclusive'
            let excl = "\<right>"
        else
            let excl = ""
        endif
        let s:MyRegister = empty(s:MyRegister) ? '"' : s:MyRegister
        if     a:type==#'char' | let expr = "`[v`]"
        elseif a:type==#'line' | let expr = "'[v']"
        elseif a:type==#'v'    | let expr = "`<v`>"
        elseif a:type==#'V'    | let expr = "'<V'>"
        else | return | end
        exe 'keepjumps norm! ' . expr . excl . '"' . s:MyRegister . 'y'
        call setpos('.', s:PreYankPos)
    endfunction
    nnoremap <expr><silent> <Plug>YAMotion ':<C-u>call <SID>PreYankMotion()<CR>' . ':set operatorfunc=<SID>YankAssassinMapping<CR>' . v:count1 . 'g@'
    nnoremap <Plug>YALine yy
    vnoremap <expr><silent> <Plug>YAVisual "my\"" . v:register . "y`y"
    nnoremap <Plug>YADefault y
    xnoremap <Plug>YADefault y
endif


let &cpo = s:save_cpo
unlet s:save_cpo
