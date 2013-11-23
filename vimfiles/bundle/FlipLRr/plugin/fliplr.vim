" FlipLR -- Flips left hand side and right hand side.
"
" Maintainer: Shuhei Kubota <kubota.shuhei+vim@gmail.com>
" Description:
"   This script flips left hand side and right hand side.
"   'lhs {operator} rhs' => 'rhs {operator} lhs'
"
" Usage:
"   1. In visual mode, select left hand side, operator and right hand side.
"   2. execute ':FlipLR operator'
"   2'. execute ':FlipLR /operator/' to flip with regexp
"
"   This mapping may help you.
"       noremap \f :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
"   This mapping highlights an operator. (add to your gvimrc)
"       noremap \f :call g:FlipLR_startHighlightingPivot()<CR><ESC>:FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
"
" Variables:
"   g:FlipLR_resultHighlightDelay = 1000
"       an interval until clearing highlights. (in milliseconds)

command! -range -nargs=1 FlipLR call <SID>FlipLR_execute(<SID>FlipLR__getSelectedText(), <f-args>)

if !exists('g:FlipLR_resultHighlightDelay')
    let g:FlipLR_resultHighlightDelay = 1000
endif

let s:REGEXP_SPACE = '[ \t\e\r\b\n]'

function! s:FlipLR_execute(entire, ...) " only a:000[0] is used
    "[sp_l1][lhs][sp_l2][pivot][sp_r1][rhs][sp_r2]
    "[sp_l1][rhs][sp_l2][pivot][sp_r1][lhs][sp_r2]
    "lhs   : left hand side
    "rhs   : right hand side
    "sp_l1 : spaces before the lhs
    "sp_l2 : spaces after the lhs
    "sp_r1 : spaces before the rhs
    "sp_r2 : spaces after the rhs

    if len(a:000) == 0 | return | endif

    let pivotRegexp = a:000[0]
    if strlen(pivotRegexp) == 0 | return | endif

    " getting pivot
    if match(pivotRegexp, '\v/.+/') != -1 " regexp
        let pivotRegexp = pivotRegexp[1:-2] " /hoge/ => hoge
    else
        let pivotRegexp = '\V' . s:FlipLR__substituteSpecialChars(pivotRegexp)
    endif
    "echom '"' . pivotRegexp . '"'
    let pivot = matchstr(a:entire, pivotRegexp)
    "echom '"' . pivot . '"'

    let pos = stridx(a:entire, pivot)
    if pos == -1 | return | endif

    " build text

    "echom pos
    let left_sides = strpart(a:entire, 0, pos)
    "echom '"' . left_sides . '"'
    let right_sides = strpart(a:entire, pos + strlen(pivot))
    "echom '"' . right_sides . '"'

    let sp_l1 = matchstr(left_sides, '^' . s:REGEXP_SPACE . '*')
    "echom '"'.sp_l1.'"'
    let sp_l2 = matchstr(left_sides, '' . s:REGEXP_SPACE . '*$')
    "echom '"'.sp_l2.'"'
    let sp_r1 = matchstr(right_sides, '^' . s:REGEXP_SPACE . '*')
    "echom '"'.sp_r1.'"'
    let sp_r2 = matchstr(right_sides, '' . s:REGEXP_SPACE . '*$')
    "echom '"'.sp_r2.'"'

    let lhs = strpart(left_sides, strlen(sp_l1), strlen(left_sides) - strlen(sp_l1) - strlen(sp_l2))
    "echom '"'.lhs.'"'
    let rhs = strpart(right_sides, strlen(sp_r1), strlen(right_sides) - strlen(sp_r1) - strlen(sp_r2))
    "echom '"'.rhs.'"'

    let new_entire = sp_l1 . rhs . sp_l2 . pivot . sp_r1 . lhs . sp_r2
    "echom '['.sp_l1 .']['. lhs .']['. sp_l2 .']['. pivot .']['. sp_r1 .']['. rhs .']['. sp_r2 .']'
    "echom '['.sp_l1 .']['. rhs .']['. sp_l2 .']['. pivot .']['. sp_r1 .']['. lhs .']['. sp_r2 .']'
    "return

    " replace

    let old_t = @t
    let @t = old_t

    let old_t = @t
    let @t = new_entire
    normal gv
    normal "tp
    let @t = old_t

    normal gv
    let l1 = line('.')
    let c1 = col('.')
    normal gvo
    let l2 = line('.')
    let c2 = col('.')
    execute "normal \<Esc>"

    "call s:FlipLR__beginHighlighting(new_entire, pivot, line('.'), c1, c2)
    call s:FlipLR__beginHighlightingByPos(new_entire, l1, c1, l2, c2, pivot)
    call s:FlipLR__endHighlightingLater()

    "echom 'stridx:' . string(stridx(sp_r2, "\n"))
    "echom 'strlen:' . string(strlen(sp_r2) - 1)
    "if stridx(sp_r2, "\n") == strlen(sp_r2) - 1
    "    normal kJ
    "endif
endfunction

function! g:FlipLR_startHighlightingPivot()
    let pivot = s:FlipLR__substituteSpecialChars(g:FlipLR_detectPivot())

    normal gv
    let old_t = @t
    normal "ty
    let entire = s:FlipLR__substituteSpecialChars(@t)
    let @t = old_t

    normal gv
    let l1 = line('.')
    let c1 = col('.')
    normal gvo
    let l2 = line('.')
    let c2 = col('.')

    "call s:FlipLR__beginHighlighting(entire, pivot, line('.'), c1, c2)
    call s:FlipLR__beginHighlightingByPos(entire, l1, c1, l2, c2, pivot)
    call s:FlipLR__endHighlightingLater()
endfunction

function! g:FlipLR_detectPivot()
    normal gv
    let old_t = @t
    normal "ty
    let str = @t
    let @t = old_t

    let elems = split(str, '^\|\<\|\>\|$\|\zs' . s:REGEXP_SPACE)
    let c = len(elems)

    " init
    let ranks = map(copy(elems), '0')

    " gain centers' ranks
    if c % 2 == 1
        let ranks[c / 2] += 1
    else
        let ranks[c / 2 - 1] += 1
        let ranks[c / 2] += 1
    endif

    " gain non-word parts' ranks
    " gain equal sign's rank
    let i = 0
    while i < c
        if match(elems[i], '^\W\+$') != -1
            let ranks[i] += 1
            if stridx(elems[i], '=') != -1
                let ranks[i] += 2
            endif
        endif
        "echom i . ' ' . elems[i] . ' ' . ranks[i]
        let i += 1
    endwhile

    let max_rank = -1
    let max_idx = 0
    let i = 0
    while i < c
        if max_rank < ranks[i]
            let max_rank = ranks[i]
            let max_idx = i
        endif
        let i += 1
    endwhile

    "echom join(elems, ', ')
    "echom join(ranks, ', ')
    let pivot = elems[max_idx]

    return pivot
endfunction

function! s:FlipLR__beginHighlighting(entire, pivot, linenr, c1, c2)
    highlight FlipLREntire term=underline gui=underline
    highlight FlipLRPivot term=reverse,bold gui=reverse,bold

    let sttc = a:c1
    let endc = a:c2
    if endc < sttc
        let tmpc = endc
        let endc = sttc
        let sttc = tmpc
    endif

    syntax clear FlipLREntire
    execute 'syntax match FlipLREntire /\V' . a:entire . '/ containedin=ALL'
    " highlighting all pivots is annoying
    syntax clear FlipLRPivot
    execute 'syntax match FlipLRPivot /\%' . a:linenr . 'l\%>' . string(sttc - 1) . 'c\%<' . endc . 'c\V' . a:pivot . '/ containedin=ALL'
endfunction

function! s:FlipLR__beginHighlightingByPos(entire, startLine, startCol, endLine, endCol, pivot)
    highlight FlipLREntire term=underline gui=underline
    highlight FlipLRPivot term=reverse,bold gui=reverse,bold

    let sttl = a:startLine
    let sttc = a:startCol
    let endl = a:endLine
    let endc = a:endCol

    if endl < sttl || (sttl == endl && endc < sttc)
        let tmpl = endl
        let endl = sttl
        let sttl = tmpl
        let tmpc = endc
        let endc = sttc
        let sttc = tmpc
    endif
    let sttc = sttc - 1
    let endc = endc + 1

    let expr = '\V'
    if sttl == endl
        let expr = expr.'\%'.sttl.'l\%>'.sttc.'c\%<'.endc.'c'
        let entireExpr = expr.s:FlipLR__substituteSpecialChars(a:entire)
        let pivotExpr = expr.s:FlipLR__substituteSpecialChars(a:pivot)
    elseif sttl == endl - 1
        let expr = expr.'\%'.sttl.'l\%>'.sttc.'c'
        let expr = expr.'\|\%'.endl.'l\%<'.endc.'c'
        let entireExpr = substitute(expr, '\V\\|', '\\.\\|', 'g').'\.'
        let pivotExpr = substitute(expr, '\V\\|', a:pivot.'\\|', 'g').a:pivot
    else
        let expr = expr.'\%'.sttl.'l\%>'.sttc.'c'
        let expr = expr.'\|\%>'.sttl.'l\%<'.endl.'l'
        let expr = expr.'\|\%'.endl.'l\%<'.endc.'c'
        let entireExpr = substitute(expr, '\V\\|', '\\.\\|', 'g').'\.'
        let pivotExpr = substitute(expr, '\V\\|', a:pivot.'\\|', 'g').a:pivot
    endif
    "let @/ = pivotExpr

    " highlighting all pivots is annoying
    syntax clear FlipLRPivot
    execute 'syntax match FlipLRPivot /'.pivotExpr.'/ containedin=ALL'
    "let @1 = ':syntax match FlipLRPivot /'.pivotExpr.'/ containedin=ALL'
    syntax clear FlipLREntire
    execute 'syntax match FlipLREntire /'.entireExpr.'/ containedin=ALL'
    "let @2 = ':syntax match FlipLREntire /'.entireExpr.'/ containedin=ALL'
endfunction

function! s:FlipLR__endHighlightingLater()
    let g:FlipLR__oldUpdatetime = &updatetime
    "echom g:FlipLR__oldUpdatetime
    let &updatetime = g:FlipLR_resultHighlightDelay
    augroup FlipLR
        autocmd!
        autocmd FlipLR CursorHold *
                    \ let &updatetime = g:FlipLR__oldUpdatetime | syntax clear FlipLREntire | syntax clear FlipLRPivot | autocmd! FlipLR
    augroup END
endfunction

function! s:FlipLR__getSelectedText()
    let old_t = @t

    normal gv"ty
    let result = @t

    let @t = old_t

    return result
endfunction

function! s:FlipLR__substituteSpecialChars(str)
    let result = escape(a:str, '\')
    let result = substitute(result, '/', '\\/', 'g')
    let result = substitute(result, '\r\n\|\r\|\n', '\\n', 'g')
    return result
endfunction

" :FlipLR /.\?=/
" a = b
" a != b
" a |= b
" a ~= bb ~= cccc
" a + c \= b

" vim: set et ft=vim sts=4 sw=4 ts=4 tw=0 : 
