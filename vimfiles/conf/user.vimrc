"=================================
"User generic {{{1
"=================================
""""""""""""""""""""
"User base setting
""""""""""""""""""""
"My information
iab actime <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"edit vimrc enable fold
set fdm=marker
"au BufRead,BufNewFile Ac.vimrc setl fdm=marker fen
""""""""""""""""""""
"User mappings
""""""""""""""""""""
"Bash like
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

inoremap <C-A> <C-O>^
inoremap <C-E> <End>
inoremap <C-B> <Left>
inoremap <C-F> <Right>

"file type
nmap ;ff :call <SID>FileFormat()<cr>
nmap ;fu :se fenc=utf-8<cr>
nmap ;fw :se fenc=GBK<cr>
"quickfix
nmap ;cl :call	ToggleQuickfix() <CR>
nmap ;cn :cn <CR>
nmap ;cp :cp <CR>
nmap ;co :cold <CR>
nmap ;ci :cnew <CR>
"visual edit mode
nmap ;ve :call	ToggleVisualEditMode() <CR>
vmap ;ve :call	ToggleVisualEditMode() <CR>

"Fast saving
nmap <silent> ;ww :update<cr>
nmap <silent> ;wf :update!<cr>
"Fast quiting
nmap <silent> ;qw :wq<cr>
nmap <silent> ;qf :q!<cr>
nmap <silent> ;qq :q<cr>
nmap <silent> ;qa :qa<cr>
nmap <silent> ;<esc> :<esc>
"Fast remove highlight search
nmap <silent> ;<cr> :noh<cr>

nmap <silent> ;to :tabo<cr>
nmap <silent> ;tq :tabc<cr>
""Fast redraw
"nmap <silent> ;rr :redraw!<cr>
""Fast rewind
"nmap <silent> ;re :rewind<cr>

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nmap <C-UP> <C-W>+
nmap <C-DOWN> <C-W>-
nmap <C-LEFT> <C-W><
nmap <C-RIGHT> <C-W>>

nmap j gj
nmap k gk
nmap ^ g^
nmap $ g$
nmap 0 g0

"vnoremap <C-S-X> "+x
"vnoremap <C-S-C> "+y
"map <C-S-V>	"+gP
"vnoremap <C-S-V> "+gP
"cmap <C-S-V> <C-R>+
"imap <C-S-V> <C-R>+

autocmd FileType vim nmap <buffer> ;we :w!<cr>:source %<cr>

nmap <silent> ;wss :call DeleteTrailingWS()<cr>:w<cr>
nmap <silent> ;wsf :call DeleteTrailingWS()<cr>:w!<cr>

"complete
imap <s-space> <c-x><c-o>
"make cpp tags
nmap \= :!start ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <CR>
""""""""""""""""""""
"User filetype
""""""""""""""""""""
" do not automaticlly remove trailing whitespace
autocmd BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :call DeleteTrailingWS()
autocmd BufWrite *.txt :call DeleteTrailingWS()

au BufRead,BufNewFile README*,COPYING setlocal ft=txt
au BufRead,BufNewFile *.txt setl ft=txt
au BufRead,BufNewFile *.log setl ft=txt

au BufRead,BufNewFile *.asm setl ft=fasm
au BufNewFile,BufRead *.asm setl makeprg=fasm\ %:p

au BufNewFile,BufRead *.mxml setl ft=mxml
au BufNewFile,BufRead *.as setl ft=actionscript
au BufNewFile,BufRead CMakeLists.txt setl ft=cmake
au BufNewFile,BufRead *.p setl ft=pawn

"squirrel script
au BufNewFile,BufRead *.nut setl syntax=squirrel
au BufNewFile,BufRead *.nut setl makeprg=sq\ %:p
au BufNewFile,BufRead *.nut setl errorformat=%f:%l:%m

autocmd BufNewFile,BufRead *.md,*.markdown setl filetype=markdown
""""""""""""""""""""
"temp settings }}}1
""""""""""""""""""""
"if has(win32")
"nmap <F10> :!dir /s /b *.c *.h *cpp *.hpp  > cscope.files <CR>
"else
"nmap <F10> :!find -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" > cscope.files <CR>
"endif
"nmap <F11> :!start cscope -Rbk <CR>

"fk air esc
"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"imap ` <c-c>
"nmap ` <c-c>
"vmap ` <c-c>
"imap <esc> <c-v>`

