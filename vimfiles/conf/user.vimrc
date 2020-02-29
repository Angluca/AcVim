"=================================
"User generic
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
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-B> <Left>
cmap <C-F> <Right>

imap <C-A> <C-O>^
imap <C-E> <End>
imap <C-B> <Left>
imap <C-F> <Right>

"copy paste
"vmap <a-c> <c-insert>
"imap <a-v> <s-insert>
nmap ;yy viw"+y
vmap ;yy "+y
nmap ;pp "+gp
vmap ;pp "+gp
nmap <a-c> viw"+y
vmap <a-c> "+y
nmap <a-v> "+gp
vmap <a-v> "+gp
imap <a-v> <esc>"+gp
"file type
nmap ;ff :call FileFormatOption()<cr>
nmap ;fu :se fenc=utf-8<cr>
nmap ;fg :se fenc=GBK<cr>
"quickfix
nmap ;cl :call	ToggleQuickfix() <cr>
nmap ;cn :cn <cr>
nmap ;cp :cp <cr>
nmap ;co :cold <cr>
nmap ;ci :cnew <cr>
"visual edit mode
nmap ;ve :call	ToggleVisualEditMode() <cr>
vmap ;ve :call	ToggleVisualEditMode() <cr>
"undo list
nmap ;ul :undol<cr>

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
"nmap 0 g0

"vn <C-S-X> "+x
"vn <C-S-C> "+y
"map <C-S-V>	"+gP
"vn <C-S-V> "+gP
"cmap <C-S-V> <C-R>+
"imap <C-S-V> <C-R>+

au FileType vim nmap <buffer> ;we :w!<cr>:source %<cr>

nmap <silent> ;wss :call DeleteTrailingWS()<cr>:w<cr>
nmap <silent> ;wsf :call DeleteTrailingWS()<cr>:w!<cr>

"complete
imap <s-space> <c-x><c-o>
"generate tags
nmap \= :silent !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <cr>

"for nim language
au FileType nim nmap \= :silent !ctags -R --langdef=nim --langmap=nim:.nim --regex-nim="/^[^\#]*\s+(\w+)\*+\s*\{.*\}/\1/t,type/" --langmap=nim:.nim --regex-nim="/^[^\#]*\s+(\w+)\*+.*=/\1/t,type/" --regex-nim="/^[^\#]*proc\s+(\w+)\*+.*=/\1/f,func/" --regex-nim="/^[^\#]*method\s+(\w+)\*+.*=/\1/f,func/" --regex-nim="/^[^\#]*auto\s+(\w+)\*+.*=/\1/f,func/" --regex-nim="/^[^\#]*template\s+(\w+)\*+.*=/\1/m,macro/" --regex-nim="/^[^\#]*macro\s+(\w+)\*+.*=/\1/m,macro/" --regex-nim="/^[^\#]*iterator\s+(\w+)\*+.*=/\1/i,iterator/" -f nimtags <cr>

au FileType nim,nims set tags+=./nimtags,./../nimtags
""""""""""""""""""""
"User filetype
""""""""""""""""""""
" do not automaticlly remove trailing whitespace
au BufWrite *.nim,*.nims :call DeleteTrailingWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :call DeleteTrailingWS()
au BufWrite *.txt call DeleteTrailingWS()

au BufNewFile,BufRead README*,COPYING setlocal ft=txt
au BufNewFile,BufRead *.txt setl ft=txt
au BufNewFile,BufRead *.log setl ft=txt
au BufNewFile,BufRead *.asm setl ft=masm
au BufNewFile,BufRead *.inc setl ft=masm
au BufNewFile,BufRead *.asm setl mp=fasm\ %:p

au BufNewFile,BufRead *.mxml setl ft=mxml
au BufNewFile,BufRead *.as setl ft=actionscript
au BufNewFile,BufRead CMakeLists.txt setl ft=cmake
au BufNewFile,BufRead *.p setl ft=pawn
au BufNewFile,BufRead *.md,*.markdown setl ft=markdown
au BufNewFile,BufRead *.shd,*.sc setl ft=glsl

"squirrel script
au BufNewFile,BufRead *.nut setl ft=squirrel
au BufNewFile,BufRead *.nut setl mp=sq\ %:p
au BufNewFile,BufRead *.nut setl efm=%f:%l:%m

"godot script
au BufNewFile,BufRead *.gd setl ft=gdscript
"objc
au BufNewFile,BufRead *.mm setl ft=objc

""""""""""""""""""""
"temp settings }}}1
""""""""""""""""""""
"if has(win32")
"nmap <F10> :!dir /s /b *.c *.h *cpp *.hpp  > cscope.files <cr>
"else
"nmap <F10> :!find -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" > cscope.files <cr>
"endif
"nmap <F11> :!start cscope -Rbk <cr>

"fk air esc
"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"imap ` <c-c>
"nmap ` <c-c>
"vmap ` <c-c>
"imap <esc> <c-v>`

