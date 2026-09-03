vim9script
# Name: LiteTabPage (vim9)
# copy AyuanX v1.2
# Author: Angluca: v2.0
# Description:
# Features:
# 1. ":E filename"	Open the file in a new tab page instead of in current window.
# 2. "<ALt-1>, <Alt-2> to <Alt-8>"	Switch to tab page 1/2/3/4/5/6/7/8/9/10.
# 3. "<Alt-9> / <Alt-0>"	Switch to previous/next tab page.
# 4. "<Alt-(> / <Alt-)>"	Move current tab page left/right.
# 5. Show GUI Tab Labels in format: "[Tab Number]:[+][Buffer Name]"
# PS: [+] stands for one or more buffer in that tab page has been modified.

set winaltkeys=no
com! -nargs=* -complete=file E tabnew <args>

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
noremap <silent> <a-(> <Cmd>call g:LiteTabMove(0)<CR>
noremap <silent> <a-)> <Cmd>call g:LiteTabMove(1)<CR>

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
tnoremap <silent> <a-(> <Cmd>call g:LiteTabMove(0)<CR>
tnoremap <silent> <a-)> <Cmd>call g:LiteTabMove(1)<CR>

# left=0, right!=0
def g:LiteTabMove(lr: number)
  var tmlr = lr == 0 ? '-' : '+'
  var idx = tabpagenr()
  if lr == 0
    if idx < 2
      return
    endif
  else
    if idx > tabpagenr('$') - 1
      return
    endif
  endif
  silent exe tmlr .. 'tabmove'
enddef

def g:LiteTabLabel(): string
  var label = tabpagenr() .. ':'
  var bufnrlist = tabpagebuflist(v:lnum) ?? []
  
  # Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      label ..= '+ '
      break
    endif
  endfor
  
  # Append the buffer name
  var winnr = tabpagewinnr(v:lnum)
  if winnr > 0 && winnr <= len(bufnrlist)
    return label .. fnamemodify(bufname(bufnrlist[winnr - 1]), ":t")
  endif
  
  return label
enddef

set guitablabel=%{g:LiteTabLabel()}

