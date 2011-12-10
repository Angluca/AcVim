" FlipLR -- Flips left hand side and right hand side.
"
" Maintainer: Shuhei Kubota <kubota.shuhei@gmail.com>
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

command! -range -nargs=1 FlipLR call <SID>FlipLR_execute(<SID>FlipLR__getSelectedText(), <f-args>)


let s:REGEXP_SPACE = '[ \t\e\r\b\n]'

function! s:FlipLR_execute(entire, ...) " only a:000[0] is used
    "[sp_l1][lhs][sp_l2][pivot][sp_r1][rhs][sp_r2]
    "[sp_l1][rhs][sp_l2][pivot][sp_r1][lhs][sp_r2]
    "lhs   : left hand side
    "rhs   : right hand side
    "sp_l1 : spaces befoer the lhs
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

    normal gv
    let old_dq = @"
    let @" = new_entire
    normal p
    let @" = old_dq
endfunction

function! g:FlipLR_detectPivot()
    normal gv
    let old_dq = @"
    normal y
    let str = @"
    let @" = old_dq

    let elems = split(str, s:REGEXP_SPACE)
    if len(elems) < 3
        let elems = split(str, s:REGEXP_SPACE . '\|\<\|\>')
    endif
    return elems[len(elems)/2]
endfunction

function! s:FlipLR__getSelectedText()
    let old_a = @a

    normal gv"ay
    let result = @a

    let @a = old_a

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
" a ~= b
" a \= b

" vim: set et ft=vim sts=4 sw=4 ts=4 tw=0 : 
