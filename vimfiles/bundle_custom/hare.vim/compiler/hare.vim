" Vim compiler file
" Compiler:    Hare Compiler
" Maintainer:  Amelia Clarke <selene@perilune.dev>
" Last Change: 2024-01-01
" Upstream:    https://git.sr.ht/~sircmpwn/hare.vim

if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "hare"

let s:cpo_save = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

if filereadable("Makefile") || filereadable("makefile")
  CompilerSet makeprg=make
else
  CompilerSet makeprg=hare\ build
endif

CompilerSet errorformat=
  \%f:%l:%c:\ syntax\ error:\ %m,
  \%f:%l:%c:\ error:\ %m,
  \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: et sw=2 sts=2 ts=8
