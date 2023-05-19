"
" Name: LiteTabPage, VIM plugin for GVIM 7.0 or above
" copy AyuanX v1.2
" Author: Angluca: v2.0
" Version 2.0
" Description:
"
" This is an (extremely) simple plugin, which makes VIM Tab Page functions more user-friendly. 
"
" <> Features:
" 1. ":E filename"			Open the file in a new tab page instead of in current window.
"
" 2. "<ALt-1>, <Alt-2> to <Alt-8>"	Switch to tab page 1/2/3/4/5/6/7/8/9/10.
"
" 3. "<Alt-9> / <Alt-0>"		Switch to previous/next tab page.
"
" 4. "<Alt-(> / <Alt-)>"		Move current tab page left/right.
"
" 5. Show GUI Tab Labels in format: "[Tab Number]:[+][Buffer Name]"
" 	PS: [+] stands for one or more buffer in that tab page has been modified.
"
" <> How to Install:
"    Simply put "LiteTabPage.vim" into path "~/.vim/plugin/" (unix) or "$VIM/vimfiles/plugin/" (windows).
"
" <> Feedback:
"    You are always encouraged to modify this plugin freely to suit your own needs!
"

if exists('loaded_litetabpage')
  finish
endif

let loaded_litetabpage = 1

set winaltkeys=no

com! -nargs=* -complete=file E tabnew <args>

"nnoremap <unique> <A-1> <c-w>1gt
"nnoremap <unique> <A-2> <c-w>2gt
"nnoremap <unique> <A-3> <c-w>3gt
"nnoremap <unique> <A-4> <c-w>4gt
"nnoremap <unique> <A-5> <c-w>5gt
"nnoremap <unique> <A-6> <c-w>6gt
"nnoremap <unique> <A-7> <c-w>7gt
"nnoremap <unique> <A-8> <c-w>8gt
"nnoremap <unique> <A-9> <c-w>9gt
"nnoremap <unique> <A-0> <c-w>10gt

noremap <unique> <A-1> <c-w>1gt
noremap <unique> <A-2> <c-w>2gt
noremap <unique> <A-3> <c-w>3gt
noremap <unique> <A-4> <c-w>4gt
noremap <unique> <A-5> <c-w>5gt
noremap <unique> <A-6> <c-w>6gt
noremap <unique> <A-7> <c-w>7gt
noremap <unique> <A-8> <c-w>8gt
noremap <unique> <a-9> <c-w>gT
noremap <unique> <a-0> <c-w>gt
noremap <silent> <a-(> :call <SID>LiteTabMove(0)<CR>
noremap <silent> <a-)> :call <SID>LiteTabMove(1)<CR>

tnoremap <unique> <A-1> <c-w>1gt
tnoremap <unique> <A-2> <c-w>2gt
tnoremap <unique> <A-3> <c-w>3gt
tnoremap <unique> <A-4> <c-w>4gt
tnoremap <unique> <A-5> <c-w>5gt
tnoremap <unique> <A-6> <c-w>6gt
tnoremap <unique> <A-7> <c-w>7gt
tnoremap <unique> <A-8> <c-w>8gt
tnoremap <unique> <a-9> <c-w>gT
tnoremap <unique> <a-0> <c-w>gt
tnoremap <silent> <a-(> :call <SID>LiteTabMove(0)<CR>
tnoremap <silent> <a-)> :call <SID>LiteTabMove(1)<CR>

function! s:LiteTabMove(lr) "left=0,right!=0
	let s:tmlr = a:lr == 0 ? '-' : '+'
	let s:idx = tabpagenr()
	if a:lr == 0
		if (s:idx < 2)
			return
		endif
	else
		if s:idx > tabpagenr('$') - 1
			return
		endif
	endif
    silent execute s:tmlr. 'tabmove'
endfunction

function! LiteTabLabel()
	let label = tabpagenr().':'
	let bufnrlist = tabpagebuflist(v:lnum)
	" Add '+' if one of the buffers in the tab page is modified
	for bufnr in bufnrlist
		if getbufvar(bufnr, "&modified")
			let label .= '+ '
			break
		endif
	endfor
	" Append the buffer name
	return label . fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum)-1]), ":t")
endfunction

set guitablabel=%{LiteTabLabel()}

