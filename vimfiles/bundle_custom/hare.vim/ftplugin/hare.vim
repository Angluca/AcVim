" Vim filetype plugin
" Language:     Hare
" Maintainer:   Amelia Clarke <selene@perilune.dev>
" Last Updated: 2024-01-01
" Upstream:     https://git.sr.ht/~sircmpwn/hare.vim

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

compiler hare

" Formatting
setlocal formatoptions+=croql/ formatoptions-=t

" Miscellaneous settings
setlocal comments=://
setlocal commentstring=//\ %s
setlocal iskeyword+=@-@
setlocal suffixesadd=.ha

let b:undo_ftplugin = 'setl cms< com< fo< isk< sua<'

" Follow the Hare style guide by default.
if get(g:, 'hare_recommended_style', 1)
  setlocal noexpandtab
  "setlocal shiftwidth=8
  setlocal shiftwidth=4
  setlocal softtabstop=0
  "setlocal tabstop=8
  setlocal tabstop=4
  setlocal textwidth=80
  let b:undo_ftplugin .= ' et< sts< sw< ts< tw<'
endif

augroup hare.vim
  autocmd!

  " Highlight incorrect spacing by default.
  if get(g:, 'hare_space_error', 1)
    autocmd InsertEnter * hi link hareSpaceError NONE
    autocmd InsertLeave * hi link hareSpaceError Error
  endif
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: et sw=2 sts=2 ts=8
