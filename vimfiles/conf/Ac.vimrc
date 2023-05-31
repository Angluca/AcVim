"=================================
" General: \ee \pp \aa \uu 
"=================================
"---------------------------------
"load plugins conf {{{
so $VIMCONF/plugins.vimrc
"call pathogen#helptags()
execute pathogen#infect()
execute pathogen#infect('bundle_custom/{}')
"call pathogen#runtime_append_all_bundles()
"}}}
"--------------------------------------------
" Ignore these filenames during enhanced command line completion. {{{
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.a,*.dylib " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
"}}}
""""""""""""""""""""
"Functions {{{
""""""""""""""""""""
com! -nargs=+ AcCreateMaps call AcCreateMaps<args> "{{{
fu! AcCreateMaps(target, combo)
	if !hasmapto(a:target, 'n')
		exec 'nmap ' . a:combo . ' ' . a:target
	endif
	if !hasmapto(a:target, 'v')
		exec 'vmap ' . a:combo . ' ' . a:target
	endif
endf "}}}


fu! AcCreateDir(ds) "{{{
	if finddir(a:ds) == ''
		silent call mkdir(a:ds)
	endif
endf "}}}

com! AcClearUndo call AcClearUndo() "{{{
fu! AcClearUndo()
	if AcIsOK(-1, "Do you want clear all undo? [Y]: ", 0, "Cancel") != 0
		let ul_bak = &undolevels
		let md_bak = &modified
		let &undolevels=-1
		exe "normal I \<BS>\<Esc>"
		let &undolevels = ul_bak
		let &modified = md_bak
		"exe ":cle"
		call AcIsOK(1, 0, "Clear finish", 0 )
	endif
endf "}}}

com! -nargs=+ AcIsOK call AcIsOK<args> "{{{
fu! AcIsOK(yn, emsg, ymsg, nmsg) "sny:-1/0/1
	echoh WarningMsg
	if len(a:emsg) > 1
		echo a:emsg 
	endif
	let l:ret = a:yn
	let l:rmsg = a:nmsg
	if a:yn == -1
		let l:ret = getchar() == 89 ? 1:0 "Y89y121
	endif
	if l:ret > 0
		let l:rmsg = a:ymsg
		echoh Question
	endif
	if len(l:rmsg) > 1
		redraw
		echo l:rmsg
	endif
	echoh None
	return l:ret
endf "}}}

com! -nargs=? Ftags call s:formatTags(<args>) "{{{
fu! s:formatTags(rd='')
	"exe ':g/^\(\k\+\t\).*$\n\1.*/d'
	"exe ':g/^\(\k\+\t\).*=\scint(\d*).*$\n\1.*/d'
	exe ':g/^\(\k\+\t.*\.\k\+\t\).*$\n\1.*/d'
	exe ':%s/^\k\t.*\n//ge'
	exe ':%s/^!_.*\n//ge'
	if a:rd !=''
		exe ':%s/\t\(.*\.\w\+\)\t/\t'.a:rd.'\/\1\t/ge'
	else
		exe ':g/^\(\k\+\t\).*$\n\1.*/d'
	endif
endf
nmap \0 :Ftags<cr> 
nmap \- :Ftags '$NIMLIB'<cr> 
"nmap \- :Ftags '$NIM'<cr> 
"}}}

com! -nargs=+ Mtags call s:makeTags(<f-args>) "{{{
fu! s:makeTags(f, opt='')
	if a:f != ''
		let l:opt = a:opt==''?'':'--options='.a:opt
		exe ':silent !ctags '.l:opt.' -R -f '.a:f
	endif
endf
"}}}

com -nargs=+ SetFiletype call s:setFiletype<args> "{{{
fu! s:setFiletype(fn, ft, bop=0,bc='BufEnter')
	let l:opt = a:bop == v:false ? ('setl ft='.a:ft) : (a:ft)
	exe $"au {a:bc} {a:fn} {l:opt}"
endf "}}}

com -nargs=+ SetFtCmd call s:setFtCmd<args> "{{{
fu! s:setFtCmd(ft, cmd, bc='FileType')
	exe $"au {a:bc} {a:ft} {a:cmd}"
endf "}}}

com! -nargs=+ SetAcpDict call s:setAcpDict<args> "{{{
fu! s:setAcpDict(ft, ...)
  let l:opt = ''
  for l:file in a:000
    let l:opt = l:opt.','.$VIMDICT.l:file
  endfor
  exe 'au FileType '.a:ft.' setl dict='.l:opt
endf

com! ToggleVE call ToggleVirtualEditMode() "{{{
fu! ToggleVirtualEditMode()
	if !exists('s:vem')
		let		s:vem = 1
		set		ve=all
		echo	'virtual edit on'
	else
		unlet	s:vem
		set		ve=
		echo	'virtual edit off'
	endif
endf "}}}

com! ToggleQuickfix call ToggleQuickfix() "{{{
fu! ToggleQuickfix()
	redir => ls_output
	execute ':silent! ls'
	redir END
	let exists = match(ls_output, "Quickfix")
	if exists == -1
		execute ':copen'
	else
		execute ':cclose'
	endif
endf "}}}

fu! QfMakeConv() "{{{
	let l:qflist = getqflist()
	for i in l:qflist
		let l:i.text = iconv(l:i.text, "cp936", "utf-8")
	endfor
	call setqflist(l:qflist)
endf "}}}

com! -nargs=1 SwitchToBuf call SwitchToBuf(<args>) "{{{
fu! SwitchToBuf(filename)
	" find in current tab
	let l:bufwinnr = bufwinnr(a:filename)
	if l:bufwinnr != -1
		exec l:bufwinnr . "wincmd w"
		return
	else
		" find in each tab
		tabfirst
		let l:tab = 1
		while l:tab <= tabpagenr("$")
			let l:bufwinnr = bufwinnr(a:filename)
			if l:bufwinnr != -1
				exec "normal " . l:tab . "gt"
				exec l:bufwinnr . "wincmd w"
				return
			endif
			tabnext
			let l:tab = tab + 1
		endwhile
		" not exist, new tab
		exec "e " . a:filename
	endif
endf "}}}

com! FmtOpt call FileFormatOption() "{{{
fu! FileFormatOption()
	if !exists("g:menutrans_fileformat_dialog")
		let g:menutrans_fileformat_dialog = "Select format for writing the file"
	endif
	if !exists("g:menutrans_fileformat_choices")
		let g:menutrans_fileformat_choices = "&Unix\n&Dos\n&Mac\n&Cancel"
	endif
	if &ff == "dos"
		let l:def = 2
	elseif &ff == "mac"
		let l:def = 3
	else
		let l:def = 1
	endif
	let l:n = confirm(g:menutrans_fileformat_dialog, g:menutrans_fileformat_choices, l:def, "Question")
	if l:n == 1
		set ff=unix
	elseif l:n == 2
		set ff=dos
	elseif l:n == 3
		set ff=mac
	endif
endfun "}}}

com! Bclose call <SID>BufCloseIt() "{{{
fu! <SID>BufCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")
	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif
	if bufnr("%") == l:currentBufNum
		new
	endif
	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endf "}}}

com! -nargs=? DelTWS call DeleteTrailingWS(<args>) "{{{
fu! DeleteTrailingWS(bb=0)
	if a:bb != 0 
		if AcIsOK(-1, "Clear all trailing space? [Y]: ", "Clear finish", "Cancel") == 0
			return
		endif
	endif
	exe "normal mz"
	%s/\s*\r\?$//ge
	nohl
	exe "normal `z"
endf "}}}
"-------------------
"}}}
""""""""""""""""""""
"Create directory {{{
""""""""""""""""""""
call AcCreateDir($VIMDATA)
call AcCreateDir($VIMDATA.'backup')
call AcCreateDir($VIMDATA.'swap')
call AcCreateDir($VIMDATA.'cache')
set backupdir=$VIMDATA/backup " where to put backup file
set directory=$VIMDATA/swap " where to put swap file
"}}}
""""""""""""""""""""
"Base settings {{{
""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible
"Sets how many lines of history VIM har to remember
set history=20
"utf-8 , ANSI, UNICODE
set encoding=utf-8
if has("win32")
	set termencoding=utf-8
	set fileencoding=utf-8
else
	set termencoding=utf-8
	set fileencoding=utf-8
endif

set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

"chinese=zh_CN.UTF-8 english=en_US.UTF-8
if v:lang == "zh_CN"
	set langmenu=zh_CN.UTF-8
  set helplang=cn
	if has("gui_running")
		language messages zh_CN.utf-8
	else
		language messages en_US.UTF-8
	endif
endif

"Remove menu garbled
so $VIMRUNTIME/delmenu.vim
so $VIMRUNTIME/menu.vim

"Enable filetype plugin
"dont move it to top if you set unicode menu :)
filetype plugin indent on
"Set to auto read when a file is changed from the outside
set autoread
"Have the mouse enabled all the time:
set mouse=a

if	has("win32")
	au QuickfixCmdPost make call QfMakeConv()
endif

"set path in current dir
if has("unix")
	if has("gui_running")
		"au	BufEnter	*	cd	%:h
		au	BufEnter	*	set	autochdir
	endif
endif

if has("mac")
	if has("gui_running")
		set macmeta
	endif
	set guifont=Menlo:h14
endif

"Set mapleader
let g:mapleader = ","
"Fast editing of _vimrc
"When _vimrc is edited, reload it
"au! bufwritepost Ac.vimrc so $VIMCONF/Ac.vimrc
"}}}
""""""""""""""""""""
"Colors and Fonts {{{
""""""""""""""""""""
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
	"Set font
	"if has("unix")
	"set gfn=Monospace\ 11
	"endif
	"Enable syntax hl
	syntax enable
	" color scheme
	if has("gui_running")
		"start gvim maximized
		"if has("au")
		"au GUIEnter * simalt ~x
		"endif
		set guioptions-=T
		set guioptions-=m
		set guioptions-=L
		"set guioptions-=r
		"hi normal guibg=#294d4a
	else
		set t_Co=256
	endif " has
endif " exists(...)
colorscheme maroloccio
"}}}
""""""""""""""""""""
"VIM userinterface {{{
""""""""""""""""""""
"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"nmap ;$ :syntax sync fromstart<cr>
au BufEnter * :syntax sync fromstart
"Favorite filetypes
set ffs=unix,dos
"set ffs=unix
"Set 7 lines to the curors - when moving vertical..
"set so=7
"set autochdir "auto set dir
set tags=./tags,./../tags
au BufNewFile,BufRead *tags setlocal ft=tags
"set guifont=Consolas:h11
"Turn on WiLd menu
set wildmenu
"Always show current position
set ruler
"The commandbar is 2 high
set cmdheight=1
"Show line number
set nu
"Do not redraw, when running macros.. lazyredraw
set lz
"Change buffer - without saving
set hid
"Set backspace
set backspace=eol,start,indent
"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l
set whichwrap+=<,>
"Ignore case when searching
set ignorecase
set smartcase
"Include search
set incsearch
"Highlight search things
set hlsearch
"Set magic on
set magic
set noerrorbells
set novisualbell
"show matching bracets
set showmatch
"show all
"set conceallevel=0
"How many tenths of a second to blink
"set mat=1
"set shortmess+=c    " Shut off completion messages
set shortmess=aoOtTcCS
set cot=menu,menuone,noselect
"set cot-=preview
"set cot+=menuone,noselect
"No sound on errors and clear jumplist.
au vimEnter * set vb t_vb=
au vimEnter * :clearjumps
"}}}
""""""""""""""""""""
"Statusline {{{
""""""""""""""""""""
"Always hide the statusline
"set laststatus=2

"Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"Actually, the tab does not switch buffers, but my arrows
try
	set switchbuf=useopen
	set stal=1
catch
endtry
"}}}
""""""""""""""""""""
"Buffer realted {{{
""""""""""""""""""""
"set viminfo='10,\"30,!,:10,n~/vimdata/cache/_viminfo
set viminfo='10,<10,s100,@0,f0,!,h,/10,:10,n$VIMDATA/cache/_viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"Don't close window, when deleting a buffer
"Bclose function can be found in "Buffer related" section
nmap ;bd :Bclose<cr>
nmap ;bw :silent bw<cr>
nmap ;bW :silent bw!<cr>
"}}}
""""""""""""""""""""
"Session options {{{
""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir
"}}}
""""""""""""""""""""
"Files and backups {{{
""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile
"}}}
""""""""""""""""""""
"Folding {{{
""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
	set fen
endif
if exists("&foldlevel")
	set fdl=0
endif
"}}}
""""""""""""""""""""
"Text options {{{
""""""""""""""""""""
set cindent shiftwidth=2 " Set cindent on to autoinent when editing C/C++ file, with 4 shift width
set softtabstop=2
set tabstop=2 " Set tabstop to 4 characters
"au FileType c,cpp,h,hpp,cc,cxx set expandtab
set expandtab " Set expandtab on, the tab will be change to space automaticaly
"}}}
""""""""""""""""""""
"Indent {{{
""""""""""""""""""""
"Auto indent
set ai
"Smart indet
set si
"C-style indeting
set cindent
"Wrap lines
set wrap
"}}}
""""""""""""""""""""
"cscope setting {{{
""""""""""""""""""""
if has("cscope")
	set csto=1
	set cscopequickfix=s-,c-,d-,i-,t-,e-
endif
"}}}
""""""""""""""""""""
"HTML related {{{
""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1
"To HTML
let html_use_css = 1
let html_number_lines = 0
let use_xhtml = 1
au FileType html set ft=xml
au FileType html set syntax=html
"}}}
""""""""""""""""""""
"Netrw {{{
""""""""""""""""""""
let g:netrw_winsize = 30
let g:netrw_home = $VIMDATA.'cache'
let g:netrw_nogx = 1
"}}}
""""""""""""""""""""
"User options {{{
""""""""""""""""""""
"time
"iab xt <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"edit vimrc enable fold
set fdm=marker
"au BufRead,BufNewFile Ac.vimrc setl fdm=marker fen

"window move
let g:wm_move_up = '<m-s-Up>'
let g:wm_move_down = '<m-s-Down>'
let g:wm_move_left = '<m-s-Left>'
let g:wm_move_right = '<m-s-Right>'
let g:wm_move_x = 20
let g:wm_move_y = 15

nmap <s-up> <C-W>+
nmap <s-down> <C-W>-
nmap <s-left> <C-W><
nmap <s-right> <C-W>>

"Bash like
map! <c-a> <home>
map! <c-e> <end>
map! <c-f> <right>
map! <c-b> <left>

map! <m-H> <Home>
map! <m-L> <End>
map! <m-h> <Left>
map! <m-l> <Right>
imap <m-j> <down>
imap <m-k> <up>
cmap <m-j> <c-n>
cmap <m-k> <c-p>

"Smart way to move btw. windows
map <m-j> <C-W>j
map <m-k> <C-W>k
map <m-h> <C-W>h
map <m-l> <C-W>l
tmap <m-j> <C-W>j
tmap <m-k> <C-W>k
tmap <m-h> <C-W>h
tmap <m-l> <C-W>l

map <m-tab> <c-w>gt
map <m-s-tab> <c-w>gT
tmap <m-tab> <c-w>gt
tmap <m-s-tab> <c-w>gT

nmap j gj
nmap k gk
nmap ^ g^
nmap $ g$
xno < <gv
xno > >gv

"nmap <silent> <m-t> :tabnew<cr>
"nmap 0 g0

"vn <C-S-X> "+x
"vn <C-S-C> "+y
"map <C-S-V>	"+gP
"vn <C-S-V> "+gP
"cmap <C-S-V> <C-R>+
"imap <C-S-V> <C-R>+
"au FileType vim nmap <buffer> ;we :w!<cr>:source %<cr>
nmap <silent> ;ds :DelTWS(1)<cr>
"complete
"imap <s-space> <cr>

"cut, copy & paste
"vmap <a-c> <c-insert>
"imap <a-v> <s-insert>
nmap ;yy "+Y
vmap ;yy "+y
nmap ;yx V"+x
vmap ;yx "+x
nmap ;pp "*gP
vmap ;pp "*gP
nmap <m-c> "+y
vmap <m-c> "+y
nmap <m-v> "*gP
vmap <m-v> "*gP
imap <m-v> <c-r>+
"file format
nmap \ff :FmtOpt<cr>
nmap \fu :se fenc=utf-8<cr>
nmap \fg :se fenc=GBK<cr>
"quickfix
"nmap ,cc :ToggleQuickfix<cr>
"nmap ,cn :cn <cr>
"nmap ,cp :cp <cr>
"nmap ,co :cold <cr>
"nmap ,ce :cnew <cr>
"virtual edit mode
AcCreateMaps(':ToggleVE<cr>', ';ve')
"select find
vnoremap * y/<c-r>"<cr>
"undo list
nmap ;uc :AcClearUndo<cr>

"Fast saving
nmap ;ww :update<cr>
nmap ;wf :update!<cr>
"Fast quiting
nmap <silent> ,q <esc>
nmap <silent> ;q <esc>
nmap <silent> ;qw :wq<cr>
nmap <silent> ;qf :q!<cr>
nmap <silent> ;qq :q<cr>
nmap <silent> ;qa :qa<cr>
"Fast remove highlight search
nmap <silent> ;<cr> :noh<cr>
nmap <silent> ; <esc>
nmap <silent> , <esc>
"nmap <space><space> \<space>
nmap <space><space> <esc>

"not use
map ZZ <esc>
map ZQ <esc>
"set nomore

"}}}
"---------------------------------
"load filetype and complete conf {{{
so $VIMCONF/autocomplete.vimrc
"load user conf
so $VIMCONF/user.vimrc

nmap <silent> \ee :SwitchToBuf("$VIMCONF/Ac.vimrc")<cr>
nmap <silent> \pp :SwitchToBuf("$VIMCONF/plugins.vimrc")<cr>
nmap <silent> \aa :SwitchToBuf("$VIMCONF/autocomplete.vimrc")<cr>
nmap <silent> \uu :SwitchToBuf("$VIMCONF/user.vimrc")<cr>
"}}}
"---------------------------------
" %s/u+\(.*\)/\=nr2char("0x"..submatch(1))/ge " u+n2unicode
